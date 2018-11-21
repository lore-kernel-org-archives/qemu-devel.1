Received: from eggs.gnu.org ([2001:4830:134:3::10]:54206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPMbM-0006VJ-OQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:07:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gPMVN-0000qV-0z
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:01:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47656)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gPMVM-0000pc-OY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:00:56 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <CAFEAcA8RdNrbCLL7tXY=e95N2Y0LcZdCPr3EuQo1_hu08qJuaQ@mail.gmail.com>
	<87sh0eyzb0.fsf@dusky.pond.sub.org> <20181107025628.GB17134@xz-x1>
	<CAFEAcA_FhkA_1DiDM2PWDw27dupsAdP==kBUxRrw5rGDnLzMwg@mail.gmail.com>
	<20181108024406.GB3170@xz-x1> <20181119061727.GA1901@xz-x1>
	<20181119070558.GB1901@xz-x1> <87ftvxlz3m.fsf@dusky.pond.sub.org>
	<20181120063143.GB24163@xz-x1> <874lcbbq4k.fsf@dusky.pond.sub.org>
	<20181121032819.GC24163@xz-x1>
Date: Wed, 21 Nov 2018 08:00:53 +0100
In-Reply-To: <20181121032819.GC24163@xz-x1> (Peter Xu's message of "Wed, 21
	Nov 2018 11:28:19 +0800")
Message-ID: <8736ru6hju.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 0/8] Monitor patches for 2018-10-30
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Tue, Nov 20, 2018 at 06:44:27PM +0100, Markus Armbruster wrote:
>> 
>> We want the test to drive QEMU into the "queue full" state with an
>> out-of-band command unreceived, then watch the queue drain and the
>> out-of-band command overtaking part of it.
>> 
>> Driving QEMU into this state is easy enough: we can use a blocking
>> in-band command to plug the queue's drain.
>> 
>> Once we have QEMU in this state, we can unblock that command and watch
>> the show.  But we really have to wait until QEMU reaches this state
>> before we unblock.
>> 
>> Our problem is the test can't easily observe when QEMU reaches this
>> state.
>> 
>> You mentioned sending a "queue full" event, and that adding such an
>> event just for testing is hard to justify.  I agree.  Could such an
>> event have a non-testing use?  All I can think of is letting the
>> management application detect "we mismanaged the queue and compromised
>> monitor availability for out-of-band commands".  Doesn't sound
>> particularly convincing to me, but we can talk with libvirt guys to see
>> whether they want it.
>> 
>> Can the test observe the monitor is suspended just from the behavior of
>> its monitor socket?  Not reliably: sending lots of input eventually
>> fails with EAGAIN when the monitor is suspended, but it can also fail
>> when the monitor reads the input too slowly.
>> 
>> Can the test observe the monitor_suspend trace point?  Awkward, because
>> the trace backends are configurable.  We could have the test monitor the
>> "simple" backend's output file, skipping the test when "simple" isn't
>> available.  Hmm.
>> 
>> Here comes the heavy hammer: extend the qtest protocol.  When the
>> monitor suspends / resumes, send a suitable asynchronous message to the
>> qtest socket.  Have libqtest use that to track monitor suspend state.
>> The test can then busy-wait for the state to flip to suspended.
>> 
>> Other ideas?
>
> I don't have more to add (already a lot of ideas! :-).  I'd say I
> would prefer to start with the queue full event and we can discuss
> with libvirt on that after 3.1 when proper.  And besides libvirt
> (which I am not quite sure whether this event could be really useful
> in the near future) maybe it can also be used as a hint for any new
> QMP client when people want to complain about "hey, why my QMP client
> didn't get any respond from QEMU" - if the client didn't get any
> response but however it sees this event then we know the answer even
> before debugging more.

Good point.

Say we implement full flow control, i.e. we also suspend when the output
buffer becomes too large.  Then the event won't really help, because the
client won't see it until it fixed the situation by draining the output
buffer.  But it won't really hurt, either: even a client that misbehaves
in a really unfortunate way can't trigger many events without also
generating much more other output.  Orders of magnitude more.

>> >> > Markus, do you want me to repost a new version with this change?  Is
>> >> > it still possible to have the oob-default series for 3.1?
>> >> 
>> >> We're trying to, but we need to get the test to work.
>> >> 
>> >> Two problems:
>> >> 
>> >> 1. The test doesn't seem to succed at testing "queue full".
>> >> 
>> >> 2. The test might still be racy.
>> >> 
>> >> I suspect the code we test is solid, and it's "only" the test we screwed
>> >> up.
>> >
>> > I agree.  Do you have better idea to test queue full?  I'd be more
>> > than glad to try any suggestions here, otherwise I am thinking whether
>> > we can just simply drop the queue full test (which is the last patch
>> > of the oob series) for now but merge the rest.  We can introduce new
>> > queue full test after 3.1 if we want, though again I really doubt
>> > whether we can without new things introduced into the procedure.
>> >
>> > Thoughts?
>> 
>> I'm afraid dropping the test (for now?) is what we have to do.
>
> Agreed.

Okay, I'll prepare the pull request later today.
