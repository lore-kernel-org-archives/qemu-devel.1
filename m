Received: from eggs.gnu.org ([2001:4830:134:3::10]:45551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fSOph-0007Dg-LY
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1fSOpg-0008Gz-1h
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:34:13 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:37368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1fSOpf-0008GR-Mg
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 11:34:11 -0400
Received: by mail-wr0-x242.google.com with SMTP id d8-v6so20895462wro.4
	for <qemu-devel@nongnu.org>; Mon, 11 Jun 2018 08:34:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87h8m9n7j1.fsf@dusky.pond.sub.org>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
	<87efhiwy4e.fsf@dusky.pond.sub.org>
	<CAK3tnvJ9W7fUxYBDYLcwhtDwruSh28HVo96dHyXfrBhYB9QB9g@mail.gmail.com>
	<87h8m9n7j1.fsf@dusky.pond.sub.org>
From: Zhang Chen <zhangckid@gmail.com>
Date: Mon, 11 Jun 2018 23:34:09 +0800
Message-ID: <CAK3tnv+5i-C5vhkA6BNa=PWVgJY8ikonELB7EQ=nNz2LsbtmMA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V8 11/17] qapi: Add new command to query
 colo status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, Jun 11, 2018 at 2:48 PM, Markus Armbruster <armbru@redhat.com>
wrote:

> Zhang Chen <zhangckid@gmail.com> writes:
>
> > On Thu, Jun 7, 2018 at 8:59 PM, Markus Armbruster <armbru@redhat.com>
> wrote:
> >
> >> Zhang Chen <zhangckid@gmail.com> writes:
> >>
> >> > Libvirt or other high level software can use this command query colo
> >> status.
> >> > You can test this command like that:
> >> > {'execute':'query-colo-status'}
> >> >
> >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> >> > ---
> >> >  migration/colo.c    | 39 +++++++++++++++++++++++++++++++++++++++
> >> >  qapi/migration.json | 34 ++++++++++++++++++++++++++++++++++
> >> >  2 files changed, 73 insertions(+)
> >> >
> >> > diff --git a/migration/colo.c b/migration/colo.c
> >> > index bedb677788..8c6b8e9a4e 100644
> >> > --- a/migration/colo.c
> >> > +++ b/migration/colo.c
> >> > @@ -29,6 +29,7 @@
> >> >  #include "net/colo.h"
> >> >  #include "block/block.h"
> >> >  #include "qapi/qapi-events-migration.h"
> >> > +#include "qapi/qmp/qerror.h"
> >> >
> >> >  static bool vmstate_loading;
> >> >  static Notifier packets_compare_notifier;
> >> > @@ -237,6 +238,44 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
> >> >  #endif
> >> >  }
> >> >
> >> > +COLOStatus *qmp_query_colo_status(Error **errp)
> >> > +{
> >> > +    int state;
> >> > +    COLOStatus *s = g_new0(COLOStatus, 1);
> >> > +
> >> > +    s->mode = get_colo_mode();
> >> > +
> >> > +    switch (s->mode) {
> >> > +    case COLO_MODE_UNKNOWN:
> >> > +        error_setg(errp, "COLO is disabled");
> >> > +        state = MIGRATION_STATUS_NONE;
> >> > +        break;
> >> > +    case COLO_MODE_PRIMARY:
> >> > +        state = migrate_get_current()->state;
> >> > +        break;
> >> > +    case COLO_MODE_SECONDARY:
> >> > +        state = migration_incoming_get_current()->state;
> >> > +        break;
> >> > +    default:
> >> > +        abort();
> >> > +    }
> >> > +
> >> > +    s->colo_running = state == MIGRATION_STATUS_COLO;
> >> > +
> >> > +    switch (failover_get_state()) {
> >> > +    case FAILOVER_STATUS_NONE:
> >> > +        s->reason = COLO_EXIT_REASON_NONE;
> >> > +        break;
> >> > +    case FAILOVER_STATUS_REQUIRE:
> >> > +        s->reason = COLO_EXIT_REASON_REQUEST;
> >> > +        break;
> >> > +    default:
> >> > +        s->reason = COLO_EXIT_REASON_ERROR;
> >> > +    }
> >> > +
> >> > +    return s;
> >> > +}
> >> > +
> >> >  static void colo_send_message(QEMUFile *f, COLOMessage msg,
> >> >                                Error **errp)
> >> >  {
> >> > diff --git a/qapi/migration.json b/qapi/migration.json
> >> > index 93136ce5a0..356a370949 100644
> >> > --- a/qapi/migration.json
> >> > +++ b/qapi/migration.json
> >> > @@ -1231,6 +1231,40 @@
> >> >  ##
> >> >  { 'command': 'xen-colo-do-checkpoint' }
> >> >
> >> > +##
> >> > +# @COLOStatus:
> >> > +#
> >> > +# The result format for 'query-colo-status'.
> >> > +#
> >> > +# @mode: COLO running mode. If COLO is running, this field will
> return
> >> > +#        'primary' or 'secodary'.
> >> > +#
> >> > +# @colo-running: true if COLO is running.
> >> > +#
> >> > +# @reason: describes the reason for the COLO exit.
> >>
> >> What's the value of @reason before a "COLO exit"?
> >>
> >
> > Before a "COLO exit", we just return 'none' in this field.
>
> Please add that to the documentation.
>

OK.


>
> Please excuse my ignorance on COLO...  I'm still not sure I fully
> understand how the three members are related, or even how the COLO state
> machine works and how its related to / embedded in RunState.  I searched
> docs/ for a state diagram, but couldn't find one.
>
> According to runstate_transitions_def[], the part of the RunState state
> machine that's directly connected to state "colo" looks like this:
>
>     inmigrate  -+
>                 |
>     paused  ----+
>                 |
>     migrate  ---+->  colo  <------>  running
>                 |
>     suspended  -+
>                 |
>     watchdog  --+
>
> For each of the seven state transitions: how is the state transition
> triggered (e.g. by QMP command, spontaneously when a certain condition
> is detected, ...), and what events (if any) are emitted then?
>
>
When you start COLO, the VM always running in "MIGRATION_STATUS_COLO" still
occur failover.
And in the flow diagram, you can think COLO always running in migrate state.
Because into COLO mode, we will control VM state in COLO code itself, for
example:
When we start COLO, it will do the first migration as normal live
migration, after that we will enter
the COLO process, at that time COLO think the primary VM state is same with
secondary VM(the first checkpoint),
so we will use vm_start() start the primary VM(unlike to normal migration)
and secondary VM.
In this time, primary VM and secondary VM will parallel running, and if
COLO found two VM state are
not same, it will trigger checkpoint(like another migration). Finally, if
occurred some fault that will trigger
failover, after that primary VM maybe return to normal running
mode(secondary dead).
So, if we just see the primary VM state, may be it has out of the RunState
state
machine or it still in migrate state.




> How is @colo-running related to the run state?
>

Not related, as I say above.


>
> Which run states are considered to be "before a COLO exit"?  If "before
> a COLO exit" doesn't map to run states, the state machine is too coarse
> to fully describe COLO, and I'd like to see a suitably refined one.
>
>
COLO just is a special case. It's worthy to refined one?
CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Any comments?



> If @colo-running is true, then @mode is either "primary" or "secondary".
> What are the possible values when @colo-running is false?
>

The @mode will in "unknown" state.


Thanks
Zhang Chen



>
> [...]
>
