Received: from eggs.gnu.org ([2001:4830:134:3::10]:41677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSGca-0004Q5-BV
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:48:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSGcX-00017i-8M
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:48:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43662 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fSGcX-00017W-2I
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 02:48:05 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
	<87efhiwy4e.fsf@dusky.pond.sub.org>
	<CAK3tnvJ9W7fUxYBDYLcwhtDwruSh28HVo96dHyXfrBhYB9QB9g@mail.gmail.com>
Date: Mon, 11 Jun 2018 08:48:02 +0200
In-Reply-To: <CAK3tnvJ9W7fUxYBDYLcwhtDwruSh28HVo96dHyXfrBhYB9QB9g@mail.gmail.com>
	(Zhang Chen's message of "Mon, 11 Jun 2018 01:39:06 +0800")
Message-ID: <87h8m9n7j1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Zhang Chen <zhangckid@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Zhang Chen <zhangckid@gmail.com> writes:

> On Thu, Jun 7, 2018 at 8:59 PM, Markus Armbruster <armbru@redhat.com> wrote:
>
>> Zhang Chen <zhangckid@gmail.com> writes:
>>
>> > Libvirt or other high level software can use this command query colo
>> status.
>> > You can test this command like that:
>> > {'execute':'query-colo-status'}
>> >
>> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
>> > ---
>> >  migration/colo.c    | 39 +++++++++++++++++++++++++++++++++++++++
>> >  qapi/migration.json | 34 ++++++++++++++++++++++++++++++++++
>> >  2 files changed, 73 insertions(+)
>> >
>> > diff --git a/migration/colo.c b/migration/colo.c
>> > index bedb677788..8c6b8e9a4e 100644
>> > --- a/migration/colo.c
>> > +++ b/migration/colo.c
>> > @@ -29,6 +29,7 @@
>> >  #include "net/colo.h"
>> >  #include "block/block.h"
>> >  #include "qapi/qapi-events-migration.h"
>> > +#include "qapi/qmp/qerror.h"
>> >
>> >  static bool vmstate_loading;
>> >  static Notifier packets_compare_notifier;
>> > @@ -237,6 +238,44 @@ void qmp_xen_colo_do_checkpoint(Error **errp)
>> >  #endif
>> >  }
>> >
>> > +COLOStatus *qmp_query_colo_status(Error **errp)
>> > +{
>> > +    int state;
>> > +    COLOStatus *s = g_new0(COLOStatus, 1);
>> > +
>> > +    s->mode = get_colo_mode();
>> > +
>> > +    switch (s->mode) {
>> > +    case COLO_MODE_UNKNOWN:
>> > +        error_setg(errp, "COLO is disabled");
>> > +        state = MIGRATION_STATUS_NONE;
>> > +        break;
>> > +    case COLO_MODE_PRIMARY:
>> > +        state = migrate_get_current()->state;
>> > +        break;
>> > +    case COLO_MODE_SECONDARY:
>> > +        state = migration_incoming_get_current()->state;
>> > +        break;
>> > +    default:
>> > +        abort();
>> > +    }
>> > +
>> > +    s->colo_running = state == MIGRATION_STATUS_COLO;
>> > +
>> > +    switch (failover_get_state()) {
>> > +    case FAILOVER_STATUS_NONE:
>> > +        s->reason = COLO_EXIT_REASON_NONE;
>> > +        break;
>> > +    case FAILOVER_STATUS_REQUIRE:
>> > +        s->reason = COLO_EXIT_REASON_REQUEST;
>> > +        break;
>> > +    default:
>> > +        s->reason = COLO_EXIT_REASON_ERROR;
>> > +    }
>> > +
>> > +    return s;
>> > +}
>> > +
>> >  static void colo_send_message(QEMUFile *f, COLOMessage msg,
>> >                                Error **errp)
>> >  {
>> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > index 93136ce5a0..356a370949 100644
>> > --- a/qapi/migration.json
>> > +++ b/qapi/migration.json
>> > @@ -1231,6 +1231,40 @@
>> >  ##
>> >  { 'command': 'xen-colo-do-checkpoint' }
>> >
>> > +##
>> > +# @COLOStatus:
>> > +#
>> > +# The result format for 'query-colo-status'.
>> > +#
>> > +# @mode: COLO running mode. If COLO is running, this field will return
>> > +#        'primary' or 'secodary'.
>> > +#
>> > +# @colo-running: true if COLO is running.
>> > +#
>> > +# @reason: describes the reason for the COLO exit.
>>
>> What's the value of @reason before a "COLO exit"?
>>
>
> Before a "COLO exit", we just return 'none' in this field.

Please add that to the documentation.

Please excuse my ignorance on COLO...  I'm still not sure I fully
understand how the three members are related, or even how the COLO state
machine works and how its related to / embedded in RunState.  I searched
docs/ for a state diagram, but couldn't find one.

According to runstate_transitions_def[], the part of the RunState state
machine that's directly connected to state "colo" looks like this:

    inmigrate  -+
                |
    paused  ----+
                |
    migrate  ---+->  colo  <------>  running
                |
    suspended  -+
                |
    watchdog  --+

For each of the seven state transitions: how is the state transition
triggered (e.g. by QMP command, spontaneously when a certain condition
is detected, ...), and what events (if any) are emitted then?

How is @colo-running related to the run state?

Which run states are considered to be "before a COLO exit"?  If "before
a COLO exit" doesn't map to run states, the state machine is too coarse
to fully describe COLO, and I'd like to see a suitably refined one.

If @colo-running is true, then @mode is either "primary" or "secondary".
What are the possible values when @colo-running is false?

[...]
