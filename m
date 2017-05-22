Received: from eggs.gnu.org ([2001:4830:134:3::10]:38915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1dCwfM-0003TH-1b
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gveitmic@redhat.com>) id 1dCwfI-0004su-RF
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:23:08 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gveitmic@redhat.com>) id 1dCwfI-0004sm-Ky
	for qemu-devel@nongnu.org; Mon, 22 May 2017 19:23:04 -0400
Received: by mail-yw0-f171.google.com with SMTP id l14so67160651ywk.1
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 16:23:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5ee20153-8fc1-d4fc-4985-597263f93f6d@redhat.com>
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
	<ed14ac2d-1d0d-463f-fac7-49ccf33a6f57@redhat.com>
	<20170512192428.GP2069@work-vm>
	<5ee20153-8fc1-d4fc-4985-597263f93f6d@redhat.com>
From: Germano Veit Michel <germano@redhat.com>
Date: Tue, 23 May 2017 09:23:01 +1000
Message-ID: <CANHSq5DCbrqkEnX9d4SKt2vBjYs0k+Zf3GY5TasOk9N3chOvjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Vladislav Yasevich <vyasevic@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Juan Jose Quintela Carreira <quintela@redhat.com>, Amit Shah <amit.shah@redhat.com>

Ohh, sorry. I don't know how or why, but I missed all your replies (this
was archived in gmail)

Below is qmp-net-test.c, It's just a copy and paste of what Markus
suggested. I could try doing it with a socket (virtio-net-test.c) as Jason
suggested but I'm afraid I won't have time this week as support is quite
busy.

Thanks Vlad for actively working on this.

/*
>  * Test cases for network-related QMP commands
>  *
>  * Copyright (c) 2017 Red Hat Inc.
>  *
>  * Authors:
>  *  Markus Armbruster <armbru@redhat.com>,
>  *
>  * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
>  * See the COPYING file in the top-level directory.
>  */
>
> #include "qemu/osdep.h"
> #include "libqtest.h"
> #include "qapi/error.h"
>
> const char common_args[] = "-nodefaults -machine none";
>
> static void test_qmp_announce_self(void)
> {
>     QDict *resp, *ret;
>
>     qtest_start(common_args);
>
>     resp = qmp("{ 'execute': 'announce-self' }");
>     ret = qdict_get_qdict(resp, "return");
>     g_assert(ret && !qdict_size(ret));
>     QDECREF(resp);
>
>     qtest_end();
> }
>
> int main(int argc, char *argv[])
> {
>     g_test_init(&argc, &argv, NULL);
>
>     qtest_add_func("qmp/net/announce_self", test_qmp_announce_self);
>
>     return g_test_run();
> }
>


On Sat, May 13, 2017 at 7:16 AM, Vlad Yasevich <vyasevic@redhat.com> wrote:

> On 05/12/2017 03:24 PM, Dr. David Alan Gilbert wrote:
> > * Vlad Yasevich (vyasevic@redhat.com) wrote:
> >> On 02/20/2017 07:16 PM, Germano Veit Michel wrote:
> >>> qemu_announce_self() is triggered by qemu at the end of migrations
> >>> to update the network regarding the path to the guest l2addr.
> >>>
> >>> however it is also useful when there is a network change such as
> >>> an active bond slave swap. Essentially, it's the same as a migration
> >>> from a network perspective - the guest moves to a different point
> >>> in the network topology.
> >>>
> >>> this exposes the function via qmp.
> >>>
> >>> Signed-off-by: Germano Veit Michel <germano@redhat.com>
> >>> ---
> >>>  include/migration/vmstate.h |  5 +++++
> >>>  migration/savevm.c          | 30 +++++++++++++++++++-----------
> >>>  qapi-schema.json            | 18 ++++++++++++++++++
> >>>  3 files changed, 42 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >>> index 63e7b02..a08715c 100644
> >>> --- a/include/migration/vmstate.h
> >>> +++ b/include/migration/vmstate.h
> >>> @@ -1042,6 +1042,11 @@ int64_t self_announce_delay(int round)
> >>>      return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
> >>>  }
> >>>
> >>> +struct AnnounceRound {
> >>> +    QEMUTimer *timer;
> >>> +    int count;
> >>> +};
> >>> +
> >>>  void dump_vmstate_json_to_file(FILE *out_fp);
> >>>
> >>>  #endif
> >>> diff --git a/migration/savevm.c b/migration/savevm.c
> >>> index 5ecd264..44e196b 100644
> >>> --- a/migration/savevm.c
> >>> +++ b/migration/savevm.c
> >>> @@ -118,29 +118,37 @@ static void qemu_announce_self_iter(NICState
> >>> *nic, void *opaque)
> >>>      qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
> >>>  }
> >>>
> >>> -
> >>>  static void qemu_announce_self_once(void *opaque)
> >>>  {
> >>> -    static int count = SELF_ANNOUNCE_ROUNDS;
> >>> -    QEMUTimer *timer = *(QEMUTimer **)opaque;
> >>> +    struct AnnounceRound *round = opaque;
> >>>
> >>>      qemu_foreach_nic(qemu_announce_self_iter, NULL);
> >>>
> >>> -    if (--count) {
> >>> +    round->count--;
> >>> +    if (round->count) {
> >>>          /* delay 50ms, 150ms, 250ms, ... */
> >>> -        timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> >>> -                  self_announce_delay(count));
> >>> +        timer_mod(round->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME)
> +
> >>> +                  self_announce_delay(round->count));
> >>>      } else {
> >>> -            timer_del(timer);
> >>> -            timer_free(timer);
> >>> +            timer_del(round->timer);
> >>> +            timer_free(round->timer);
> >>> +            g_free(round);
> >>>      }
> >>>  }
> >>>
> >>>  void qemu_announce_self(void)
> >>>  {
> >>> -    static QEMUTimer *timer;
> >>> -    timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> qemu_announce_self_once, &timer);
> >>> -    qemu_announce_self_once(&timer);
> >>> +    struct AnnounceRound *round = g_malloc(sizeof(struct
> AnnounceRound));
> >>> +    if (!round)
> >>> +        return;
> >>> +    round->count = SELF_ANNOUNCE_ROUNDS;
> >>> +    round->timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> >>> qemu_announce_self_once, round);
> >>> +    qemu_announce_self_once(round);
> >>> +}
> >>
> >> So, I've been looking and this code and have been playing with it and
> with David's
> >> patches and my patches to include virtio self announcements as well.
> What I've discovered
> >> is what I think is a possible packet amplification issue here.
> >>
> >> This creates a new timer every time we do do a announce_self.  With
> just migration,
> >> this is not an issue since you only migrate once at a time, so there is
> only 1 timer.
> >> With exposing this as an API, a user can potentially call it in a tight
> loop
> >> and now you have a ton of timers being created.  Add in David's patches
> allowing timeouts
> >> and retries to be configurable, and you may now have a ton of long
> lived timers.
> >> Add in the patches I am working on to let virtio do self announcements
> too (to really fix
> >> bonding issues), and now you add in a possibility of a lot of packets
> being sent for
> >> each timeout (RARP, GARP, NA, IGMPv4 Reports, IGMPv6 Reports [even
> worse if MLD1 is used]).
> >>
> >> As you can see, this can get rather ugly...
> >>
> >> I think we need timer user here.  Migration and QMP being two to begin
> with.  Each
> >> one would get a single timer to play with.  If a given user already has
> a timer running,
> >> we could return an error or just not do anything.
> >
> > If you did have specific timers, then you could add to/reset the counts
> > rather than doing nothing.  That way it's less racy; if you issue the
> > command just as you reconfigure your network, there's no chance the
> > command would fail, you will send the packets out.
>
> Yes.  That's another possible way to handle this.
>
> -vlad
> >
> > Dave
> >
> >> -vlad
> >>
> >>> +
> >>> +void qmp_announce_self(Error **errp)
> >>> +{
> >>> +    qemu_announce_self();
> >>>  }
> >>>
> >>>  /***********************************************************/
> >>> diff --git a/qapi-schema.json b/qapi-schema.json
> >>> index baa0d26..0d9bffd 100644
> >>> --- a/qapi-schema.json
> >>> +++ b/qapi-schema.json
> >>> @@ -6080,3 +6080,21 @@
> >>>  #
> >>>  ##
> >>>  { 'command': 'query-hotpluggable-cpus', 'returns':
> ['HotpluggableCPU'] }
> >>> +
> >>> +##
> >>> +# @announce-self:
> >>> +#
> >>> +# Trigger generation of broadcast RARP frames to update network
> switches.
> >>> +# This can be useful when network bonds fail-over the active slave.
> >>> +#
> >>> +# Arguments: None.
> >>> +#
> >>> +# Example:
> >>> +#
> >>> +# -> { "execute": "announce-self" }
> >>> +# <- { "return": {} }
> >>> +#
> >>> +# Since: 2.9
> >>> +##
> >>> +{ 'command': 'announce-self' }
> >>> +
> >>>
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >
>
>


-- 
Germano Veit Michel <germano@redhat.com>
Senior Software Maintenance Engineer, Virtualization, Red Hat
