Received: from eggs.gnu.org ([2001:4830:134:3::10]:41005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTNq6-00047T-Se
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fTNq3-0003da-NN
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:42:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35106 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fTNq3-0003dE-Hl
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 04:42:39 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180603050546.6827-1-zhangckid@gmail.com>
	<20180603050546.6827-12-zhangckid@gmail.com>
	<87efhiwy4e.fsf@dusky.pond.sub.org>
	<CAK3tnvJ9W7fUxYBDYLcwhtDwruSh28HVo96dHyXfrBhYB9QB9g@mail.gmail.com>
	<87h8m9n7j1.fsf@dusky.pond.sub.org>
	<CAK3tnv+5i-C5vhkA6BNa=PWVgJY8ikonELB7EQ=nNz2LsbtmMA@mail.gmail.com>
	<20180613165032.GO2676@work-vm>
Date: Thu, 14 Jun 2018 10:42:37 +0200
In-Reply-To: <20180613165032.GO2676@work-vm> (David Alan Gilbert's message of
	"Wed, 13 Jun 2018 17:50:32 +0100")
Message-ID: <87sh5pn4hu.fsf@dusky.pond.sub.org>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Zhang Chen (zhangckid@gmail.com) wrote:
>> On Mon, Jun 11, 2018 at 2:48 PM, Markus Armbruster <armbru@redhat.com>
>> wrote:
>> 
>> > Zhang Chen <zhangckid@gmail.com> writes:
>> >
>> > > On Thu, Jun 7, 2018 at 8:59 PM, Markus Armbruster <armbru@redhat.com> wrote:
>> > >
>> > >> Zhang Chen <zhangckid@gmail.com> writes:
>> > >>
>> > >> > Libvirt or other high level software can use this command query colo status.
>> > >> > You can test this command like that:
>> > >> > {'execute':'query-colo-status'}
>> > >> >
>> > >> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
[...]
>> > >> > diff --git a/qapi/migration.json b/qapi/migration.json
>> > >> > index 93136ce5a0..356a370949 100644
>> > >> > --- a/qapi/migration.json
>> > >> > +++ b/qapi/migration.json
>> > >> > @@ -1231,6 +1231,40 @@
>> > >> >  ##
>> > >> >  { 'command': 'xen-colo-do-checkpoint' }
>> > >> >
>> > >> > +##
>> > >> > +# @COLOStatus:
>> > >> > +#
>> > >> > +# The result format for 'query-colo-status'.
>> > >> > +#
>> > >> > +# @mode: COLO running mode. If COLO is running, this field will return
>> > >> > +#        'primary' or 'secodary'.
>> > >> > +#
>> > >> > +# @colo-running: true if COLO is running.
>> > >> > +#
>> > >> > +# @reason: describes the reason for the COLO exit.
>> > >>
>> > >> What's the value of @reason before a "COLO exit"?
>> > >>
>> > >
>> > > Before a "COLO exit", we just return 'none' in this field.
>> >
>> > Please add that to the documentation.
>> >
>> 
>> OK.
>> 
>> 
>> >
>> > Please excuse my ignorance on COLO...  I'm still not sure I fully
>> > understand how the three members are related, or even how the COLO state
>> > machine works and how its related to / embedded in RunState.  I searched
>> > docs/ for a state diagram, but couldn't find one.
>> >
>> > According to runstate_transitions_def[], the part of the RunState state
>> > machine that's directly connected to state "colo" looks like this:
>> >
>> >     inmigrate  -+
>> >                 |
>> >     paused  ----+
>> >                 |
>> >     migrate  ---+->  colo  <------>  running
>> >                 |
>> >     suspended  -+
>> >                 |
>> >     watchdog  --+
>> >
>> > For each of the seven state transitions: how is the state transition
>> > triggered (e.g. by QMP command, spontaneously when a certain condition
>> > is detected, ...), and what events (if any) are emitted then?
>> >
>> >
>> When you start COLO, the VM always running in "MIGRATION_STATUS_COLO" still
>> occur failover.
>> And in the flow diagram, you can think COLO always running in migrate state.
>> Because into COLO mode, we will control VM state in COLO code itself, for
>> example:
>> When we start COLO, it will do the first migration as normal live
>> migration, after that we will enter
>> the COLO process, at that time COLO think the primary VM state is same with
>> secondary VM(the first checkpoint),
>> so we will use vm_start() start the primary VM(unlike to normal migration)
>> and secondary VM.
>> In this time, primary VM and secondary VM will parallel running, and if
>> COLO found two VM state are
>> not same, it will trigger checkpoint(like another migration). Finally, if
>> occurred some fault that will trigger
>> failover, after that primary VM maybe return to normal running
>> mode(secondary dead).
>> So, if we just see the primary VM state, may be it has out of the RunState
>> state
>> machine or it still in migrate state.
>> 
>> 
>> 
>> 
>> > How is @colo-running related to the run state?
>> >
>> 
>> Not related, as I say above.
>
> Right; this is a different type of 'running' - it might be better to say
> 'active' rather than running.

Rename?

>   COLO has a pair of VMs in sync with a constant stream of migrations
> between them.
> The 'mode' is whether it's the source (primary) or destination (secondary) VM.
> (Also sometimes written PVM/SVM)
>
> If COLO fails for some reason (e.g. the
> secondary host fails) then I think this is saying the 'colo-running'
> would be false.
>
> Some monitoring tool would be watching this to make sure you
> really do have a redundent pair of VMs, and if one of them failed
> you'd want to know and alert.

Let me try to explain what I learned in my own words, so you can correct
my misunderstandings.

A VM doing COLO is either the primary or the secondary of a pair.  A
monitoring process watches them.

At some time, it enters MigrationStatus 'colo'.  Peeking at the code, it
looks like it enters it from state 'active', and never leaves it.  This
happens after we successfully created the secondary by migrating the
primary.

Aside: migrate_set_state() appears to do nothing when @old_state doesn't
match @state, yet callers appear to assume it works.  Feels brittle.  Am
I confused?

The monitoring process orchestrates fault tolerance:

* It initially creates the secondary by migrating the primary.  This is
  called the first checkpoint.

* If the primary goes down, the monitor sends x-colo-lost-heartbeat to
  the secondary.  The secondary becomes the primary, and we create a new
  secondary by live-migrating the primary.

* If the secondary goes down or out of sync, we abandon it and send
  x-colo-lost-heartbeat to the primary.  We can then create a new
  secondary by live-migrating the primary.  This is called another
  checkpoint.

x-colo-lost-heartbeat's doc comment:

# Tell qemu that heartbeat is lost, request it to do takeover procedures.
# If this command is sent to the PVM, the Primary side will exit COLO mode.

What does "exiting COLO mode" mean, and how is it reflected in
ColoStatus member mode?  Do we reenter COLO mode eventually?  How?

# If sent to the Secondary, the Secondary side will run failover work,
# then takes over server operation to become the service VM.

Undefined term "service VM".  Do you mean primary VM?

Cases:

(1) This VM isn't doing COLO.  ColoStatus:

    { "mode": "unknown",
      "running": false,
      "reason": "none" }

(2) This VM is a COLO primary

(2a) and it hasn't received x-colo-lost-heartbeat since it last became
     primary.  ColoStatus:

    { "mode": "primary",
      "running": true,          # I guess
      "reason": "none" }

(2b) and it has received x-colo-lost-heartbeat since it last became
     primary

    { "mode": "primary",
      "running": true,          # I guess
      "reason": "request" }

(2c) and it has run into some error condition I don't understand (but
     probably should)

    { "mode": "primary",
      "running": true,          # I guess
      "reason": "error" }

(3) This VM is a COLO secondary

(3a-c) like (2a-c)

If that's correct (and I doubt it), then @running is entirely redundant:
it's false if and only if @mode is "unknown".

Speaking of mode "unknown": that's a bad name.  "none" would be better.
Or maybe query-colo-status should fail in case (1), to get rid of it at
the interface entirely.

We really, really, really need a state diagram complete with QMP
commands and events.  COLO-FT.txt covers architecture and provides an
example, but it's entirely inadequate at explaining how the QMP commands
and events fit in, and their doc comments don't really help.  I feel
this is the reason why we're at v8 and I'm still groping in the dark,
unable to pass judgement on the proposed QAPI schema changes.

[...]
