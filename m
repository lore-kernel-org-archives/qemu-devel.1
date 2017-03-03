Received: from eggs.gnu.org ([2001:4830:134:3::10]:43584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cjkcU-0002yx-Ua
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:39:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cjkcR-0000cp-Rm
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:39:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39730)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cjkcR-0000ap-J1
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 05:39:27 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D85A48F285
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 10:39:26 +0000 (UTC)
Date: Fri, 3 Mar 2017 10:39:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170303103919.GA2439@work-vm>
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
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
To: Germano Veit Michel <germano@redhat.com>, armbru@redhat.com, jasowang@redhat.com
Cc: qemu-devel@nongnu.org, Juan Jose Quintela Carreira <quintela@redhat.com>

* Germano Veit Michel (germano@redhat.com) wrote:
> qemu_announce_self() is triggered by qemu at the end of migrations
> to update the network regarding the path to the guest l2addr.
> 
> however it is also useful when there is a network change such as
> an active bond slave swap. Essentially, it's the same as a migration
> from a network perspective - the guest moves to a different point
> in the network topology.
> 
> this exposes the function via qmp.

Markus: Since you're asking for tests for qmp commands; how would you
test this?

Jason: Does this look OK from the networking side of things?

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

I prefer g_new0 - i.e.
   struct AnnounceRound *round = g_new0(struct AnnounceRound, 1)

> +    if (!round)
> +        return;
> +    round->count = SELF_ANNOUNCE_ROUNDS;
> +    round->timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> qemu_announce_self_once, round);

An odd line break?

> +    qemu_announce_self_once(round);
> +}
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

Please wire hmp up as well (see hmp-commands.hx).

Dave

> -- 
> 2.9.3
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
