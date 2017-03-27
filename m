Received: from eggs.gnu.org ([2001:4830:134:3::10]:36452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csXYu-0008R8-SJ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:32:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1csXYq-0007Dq-Sz
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:32:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1csXYq-0007DE-JZ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:32:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5EFAC050069
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:32:03 +0000 (UTC)
Date: Mon, 27 Mar 2017 17:31:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170327163157.GA5424@work-vm>
References: <CANHSq5DhUak9fVpvjG=VyeetP7VQudHwyEa4VevC21BuieSstw@mail.gmail.com>
	<20170303103919.GA2439@work-vm> <87o9xizhs1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o9xizhs1.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Germano Veit Michel <germano@redhat.com>, jasowang@redhat.com, qemu-devel@nongnu.org, Juan Jose Quintela Carreira <quintela@redhat.com>

* Markus Armbruster (armbru@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:
> 
> > * Germano Veit Michel (germano@redhat.com) wrote:
> >> qemu_announce_self() is triggered by qemu at the end of migrations
> >> to update the network regarding the path to the guest l2addr.
> >> 
> >> however it is also useful when there is a network change such as
> >> an active bond slave swap. Essentially, it's the same as a migration
> >> from a network perspective - the guest moves to a different point
> >> in the network topology.
> >> 
> >> this exposes the function via qmp.
> >
> > Markus: Since you're asking for tests for qmp commands; how would you
> > test this?
> 
> Good question, as tests/ isn't exactly full of examples you could crib.
> 
> Let me look at the patch...
> 
> > Jason: Does this look OK from the networking side of things?
> >
> >> Signed-off-by: Germano Veit Michel <germano@redhat.com>
> >> ---
> >>  include/migration/vmstate.h |  5 +++++
> >>  migration/savevm.c          | 30 +++++++++++++++++++-----------
> >>  qapi-schema.json            | 18 ++++++++++++++++++
> >>  3 files changed, 42 insertions(+), 11 deletions(-)
> >> 
> >> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> >> index 63e7b02..a08715c 100644
> >> --- a/include/migration/vmstate.h
> >> +++ b/include/migration/vmstate.h
> >> @@ -1042,6 +1042,11 @@ int64_t self_announce_delay(int round)
> >>      return 50 + (SELF_ANNOUNCE_ROUNDS - round - 1) * 100;
> >>  }
> >> 
> >> +struct AnnounceRound {
> >> +    QEMUTimer *timer;
> >> +    int count;
> >> +};
> >> +
> >>  void dump_vmstate_json_to_file(FILE *out_fp);
> >> 
> >>  #endif
> >> diff --git a/migration/savevm.c b/migration/savevm.c
> >> index 5ecd264..44e196b 100644
> >> --- a/migration/savevm.c
> >> +++ b/migration/savevm.c
> >> @@ -118,29 +118,37 @@ static void qemu_announce_self_iter(NICState
> >> *nic, void *opaque)
> >>      qemu_send_packet_raw(qemu_get_queue(nic), buf, len);
> >>  }
> >> 
> >> -
> >>  static void qemu_announce_self_once(void *opaque)
> >>  {
> >> -    static int count = SELF_ANNOUNCE_ROUNDS;
> >> -    QEMUTimer *timer = *(QEMUTimer **)opaque;
> >> +    struct AnnounceRound *round = opaque;
> >> 
> >>      qemu_foreach_nic(qemu_announce_self_iter, NULL);
> >> 
> >> -    if (--count) {
> >> +    round->count--;
> >> +    if (round->count) {
> >>          /* delay 50ms, 150ms, 250ms, ... */
> >> -        timer_mod(timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> >> -                  self_announce_delay(count));
> >> +        timer_mod(round->timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
> >> +                  self_announce_delay(round->count));
> >>      } else {
> >> -            timer_del(timer);
> >> -            timer_free(timer);
> >> +            timer_del(round->timer);
> >> +            timer_free(round->timer);
> >> +            g_free(round);
> >>      }
> >>  }
> >> 
> >>  void qemu_announce_self(void)
> >>  {
> >> -    static QEMUTimer *timer;
> >> -    timer = timer_new_ms(QEMU_CLOCK_REALTIME, qemu_announce_self_once, &timer);
> >> -    qemu_announce_self_once(&timer);
> >> +    struct AnnounceRound *round = g_malloc(sizeof(struct AnnounceRound));
> >
> > I prefer g_new0 - i.e.
> >    struct AnnounceRound *round = g_new0(struct AnnounceRound, 1)
> >
> >> +    if (!round)
> >> +        return;
> >> +    round->count = SELF_ANNOUNCE_ROUNDS;
> >> +    round->timer = timer_new_ms(QEMU_CLOCK_REALTIME,
> >> qemu_announce_self_once, round);
> >
> > An odd line break?
> >
> >> +    qemu_announce_self_once(round);
> >> +}
> >> +
> >> +void qmp_announce_self(Error **errp)
> >> +{
> >> +    qemu_announce_self();
> >>  }
> >> 
> >>  /***********************************************************/
> >> diff --git a/qapi-schema.json b/qapi-schema.json
> >> index baa0d26..0d9bffd 100644
> >> --- a/qapi-schema.json
> >> +++ b/qapi-schema.json
> >> @@ -6080,3 +6080,21 @@
> >>  #
> >>  ##
> >>  { 'command': 'query-hotpluggable-cpus', 'returns': ['HotpluggableCPU'] }
> >> +
> >> +##
> >> +# @announce-self:
> >> +#
> >> +# Trigger generation of broadcast RARP frames to update network switches.
> >> +# This can be useful when network bonds fail-over the active slave.
> >> +#
> >> +# Arguments: None.
> 
> Please drop this line.
> 
> >> +#
> >> +# Example:
> >> +#
> >> +# -> { "execute": "announce-self" }
> >> +# <- { "return": {} }
> >> +#
> >> +# Since: 2.9
> >> +##
> >> +{ 'command': 'announce-self' }
> >> +
> 
> From QMP's point of view, this command is as simple as they get: no
> arguments, no return values, no errors.
> 
> I think a basic smoke test would do: try the command, check no magic
> smoke comes out.  Untested sketch adapted from qmp-test.c:
> 
>     /*
>      * Test cases for network-related QMP commands
>      *
>      * Copyright (c) 2017 Red Hat Inc.
>      *
>      * Authors:
>      *  Markus Armbruster <armbru@redhat.com>,
>      *
>      * This work is licensed under the terms of the GNU GPL, version 2 or later.
>      * See the COPYING file in the top-level directory.
>      */
> 
>     #include "qemu/osdep.h"
>     #include "libqtest.h"
>     #include "qapi/error.h"
> 
>     const char common_args[] = "-nodefaults -machine none";
> 
>     static void test_qmp_announce_self(void)
>     {
>         QDict *resp, *ret;
> 
>         qtest_start(common_args);
> 
>         resp = qmp("{ 'execute': 'qmp_capabilities' }");
>         ret = qdict_get_qdict(resp, "return");
>         g_assert(ret && !qdict_size(ret));
>         QDECREF(resp);
> 
>         qtest_end();
>     }
> 
>     int main(int argc, char *argv[])
>     {
>         g_test_init(&argc, &argv, NULL);
> 
>         qtest_add_func("qmp/net/announce_self", test_qmp_announce_self);
> 
>         return g_test_run();
>     }
> 
> If you want to go the extra mile: is there a way to set up networking so
> you can observe the RARPs this should trigger?

I've been fiddling with the RARP code for other changes and noticed you
can do:

./x86_64-softmmu/qemu-system-x86_64 -nographic -nodefaults -netdev user,id=netuser -object filter-dump,id=dump,netdev=netuser,file=foo2 -device e1000,netdev=netuser,mac=00:11:22:33:44:55 -monitor stdio

(Thanks to Thomas for helping explain filter-dump).

So those land in foo2 as a pcap file.

Dave

> I'd call this qmp-net-test.  Add to Makefile.include exactly like
> qmp-test.
> 
> Test cases for existing networking-related QMP commands should be added,
> but not in this patch, and not necessarily by you.
> 
> Alternatively, have a more general test program for networking stuff,
> and make this one of its test cases.  Your choice.
> 
> Hope this helps!
> 
> >
> > Please wire hmp up as well (see hmp-commands.hx).
> >
> > Dave
> >
> >> -- 
> >> 2.9.3
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
