Received: from eggs.gnu.org ([2001:4830:134:3::10]:44296)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1d8vmZ-0000Wi-7U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:38:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vyasevic@redhat.com>) id 1d8vmW-0008TT-1L
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:37:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vyasevic@redhat.com>) id 1d8vmV-0008RH-Nh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 17:37:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7BAE3DBD2
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 21:37:53 +0000 (UTC)
Reply-To: vyasevic@redhat.com
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
From: Vlad Yasevich <vyasevic@redhat.com>
Message-ID: <ed14ac2d-1d0d-463f-fac7-49ccf33a6f57@redhat.com>
Date: Thu, 11 May 2017 17:37:47 -0400
MIME-Version: 1.0
In-Reply-To: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V2] migration: expose qemu_announce_self()
 via qmp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Germano Veit Michel <germano@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Jose Quintela Carreira <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

On 02/20/2017 07:16 PM, Germano Veit Michel wrote:
> qemu_announce_self() is triggered by qemu at the end of migrations
> to update the network regarding the path to the guest l2addr.
> 
> however it is also useful when there is a network change such as
> an active bond slave swap. Essentially, it's the same as a migration
> from a network perspective - the guest moves to a different point
> in the network topology.
> 
> this exposes the function via qmp.
> 
> Signed-off-by: Germano Veit Michel <germano@redhat.com>
> ---
>  include/migration/vmstate.h |  5 +++++
>  migration/savevm.c          | 30 +++++++++++++++++++-----------
>  qapi-schema.json            | 18 ++++++++++++++++++
>  3 files changed, 42 insertions(+), 11 deletions(-)
> 
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 63e7b02..a08715c 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -1042,6 +1042,11 @@ int64_t self_announce_delay(int round)
>      return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
>  }
> 
> +struct AnnounceRound {
> +    QEMUTimer *timer;
> +    int count;
> +};
> +
>  void dump_vmstate_json_to_file(FILE *out_fp);
> 
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 5ecd264..44e196b 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -118,29 +118,37 @@ static void qemu_announce_self_iter(NICState
> *nic, void *opaque)
>      qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
>  }
> 
> -
>  static void qemu_announce_self_once(void *opaque)
>  {
> -    static int count = SELF_ANNOUNCE_ROUNDS;
> -    QEMUTimer *timer = *(QEMUTimer **)opaque;
> +    struct AnnounceRound *round = opaque;
> 
>      qemu_foreach_nic(qemu_announce_self_iter, NULL);
> 
> -    if (--count) {
> +    round->count--;
> +    if (round->count) {
>          /* delay 50ms, 150ms, 250ms, ... */
> -        timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> -                  self_announce_delay(count));
> +        timer_mod(round->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> +                  self_announce_delay(round->count));
>      } else {
> -            timer_del(timer);
> -            timer_free(timer);
> +            timer_del(round->timer);
> +            timer_free(round->timer);
> +            g_free(round);
>      }
>  }
> 
>  void qemu_announce_self(void)
>  {
> -    static QEMUTimer *timer;
> -    timer = timer_new_ms(QEMU_CLOCK_REALTIME, qemu_announce_self_once, &timer);
> -    qemu_announce_self_once(&timer);
> +    struct AnnounceRound *round = g_malloc(sizeof(struct AnnounceRound));
> +    if (!round)
> +        return;
> +    round->count = SELF_ANNOUNCE_ROUNDS;
> +    round->timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> qemu_announce_self_once, round);
> +    qemu_announce_self_once(round);
> +}

So, I've been looking and this code and have been playing with it and with David's
patches and my patches to include virtio self announcements as well.  What I've discovered
is what I think is a possible packet amplification issue here.

This creates a new timer every time we do do a announce_self.  With just migration,
this is not an issue since you only migrate once at a time, so there is only 1 timer.
With exposing this as an API, a user can potentially call it in a tight loop
and now you have a ton of timers being created.  Add in David's patches allowing timeouts
and retries to be configurable, and you may now have a ton of long lived timers.
Add in the patches I am working on to let virtio do self announcements too (to really fix
bonding issues), and now you add in a possibility of a lot of packets being sent for
each timeout (RARP, GARP, NA, IGMPv4 Reports, IGMPv6 Reports [even worse if MLD1 is used]).

As you can see, this can get rather ugly...

I think we need timer user here.  Migration and QMP being two to begin with.  Each
one would get a single timer to play with.  If a given user already has a timer running,
we could return an error or just not do anything.

-vlad

> +
> +void qmp_announce_self(Error **errp)
> +{
> +    qemu_announce_self();
>  }
> 
>  /***********************************************************/
> diff --git a/qapi-schema.json b/qapi-schema.json
> index baa0d26..0d9bffd 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -6080,3 +6080,21 @@
>  #
>  ##
>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
> +
> +##
> +# @announce-self:
> +#
> +# Trigger generation of broadcast RARP frames to update network switches.
> +# This can be useful when network bonds fail-over the active slave.
> +#
> +# Arguments: None.
> +#
> +# Example:
> +#
> +# -> { "execute": "announce-self" }
> +# <- { "return": {} }
> +#
> +# Since: 2.9
> +##
> +{ 'command': 'announce-self' }
> +
> 
