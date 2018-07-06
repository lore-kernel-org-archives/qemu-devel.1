Received: from eggs.gnu.org ([2001:4830:134:3::10]:52772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbLfb-0006Fx-NP
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbLfU-0000VL-Pr
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:00:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fbLfU-0000Q8-CQ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 04:00:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 98B4FE9000
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 08:00:39 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-6-peterx@redhat.com>
	<46055729-f81c-e687-4a97-b2b242b0b063@redhat.com>
	<20180706034939.GE23001@xz-mi>
Date: Fri, 06 Jul 2018 10:00:34 +0200
In-Reply-To: <20180706034939.GE23001@xz-mi> (Peter Xu's message of "Fri, 6 Jul
	2018 11:49:39 +0800")
Message-ID: <87tvpc23q5.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 5/9] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan
	Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Thu, Jul 05, 2018 at 11:47:30AM -0500, Eric Blake wrote:
>> On 07/04/2018 03:45 AM, Peter Xu wrote:
>> > When we received too many qmp commands, previously we'll send
>> > COMMAND_DROPPED events to monitors, then we'll drop the requests.  It
>> > can only solve the flow control of the request queue, however it'll not
>> > really work since we might queue unlimited events in the response queue
>> > which is a potential risk.
>
> [1]

Let's ignore events other than COMMAND_DROPPED for a minute.

The issue COMMAND_DROPPED tries to address is flow control: QMP client
sends commands faster than they can be processed, or accepts responses
slower than they're produced.  Buffers grow without bounds.

Either is unlikely to happen with a well-behaved QMP client, but
software being software, it's better not to let a misbehaving QMP client
make QEMU eat unbounded amounts of memory.  We limit memory consumption
elsewhere in QMP, e.g. the JSON parser.

COMMAND_DROPPED works fine for the input half: if the client sends
commands too quickly, the request queue gets full, and we start dropping
commands.

However, if the client accepts responses too slowly (or not at all)
without *also* sending commands too quickly, the output buffer still
grows without bounds.

We could detect this and drop commands.  Replaces swamping the output
buffer with responses by swamping it with COMMAND_DROPPED events.

We could change the meaning of COMMAND_DROPPED from "command with this
ID dropped" to "commands are being dropped, first one has this ID".
Since only in-band commands are dropped, and their responses are sent in
issue order, the next in-band reply tells us which commands were
dropped.

The simplest solution is to cork input by suspending the monitor (this
patch).  Reuses the non-OOB code.  Doesn't drop commands.  Sacrifices
monitor availability for OOB commands.

Done ignoring events other than COMMAND_DROPPED.

>> > Now instead of sending such an event, we stop consuming the client input
>> > when we noticed that the queue is reaching its limitation before hand.
>> > Then after we handled commands, we'll try to resume the monitor when
>> > needed.
>> 
>> Is this the right thing to be doing?
>> 
>> If there is some event that we forgot to rate limit, and the client isn't
>> consuming the output queue fast enough to keep up with events, we are making
>> it so the client can't even send an OOB command that might otherwise stop
>> the flood of events.

True.  This is yet another flow control scenario, only this time, it's
QEMU misbehaving.  

How much good the ability to issue commands will do in such a situation
is unclear.  We may not have a command to stop a flood, let alone an OOB
command.  But that's no excuse for ignoring the issue in our design.

>>                       Refusing to parse input when the client isn't parsing
>> output makes sense when the output is a result of the input, but when the
>> output is the result of events unrelated to the input, it might still be
>> nice to be responsive (even if with COMMAND_DROPPED events) to OOB input.

You're right, we should at least try find a way to keep the monitor
available when events beyond the client's control swamp the output
buffer.

>> Then again, if events are not being parsed quickly by the client, it's
>> debatable whether the client will parse COMMAND_DROPPED any sooner (even if
>> COMMAND_DROPPED jumps the queue ahead of other events).

The current code doesn't really support response queue jumping.  The
response queue gets drained quickly into the output buffer.  The
response queue therefore stays small (as long as bottom halves run as
they should).  It's the output buffer that grows without bound.  Jumping
there isn't as trivial as inserting at the front end of the response
queue, and probably should not be done.  If we want to jump, we should
reconsider how we drain the response queue.

>> So I don't have a strong opinion on whether this patch is right or wrong, so
>> much as voicing a potential concern to make sure I'm not overlooking
>> something.
>
> I can't say current solution is ideal, but AFAIU at least we can avoid
> one potential risk to consume all the memories of QEMU which I
> mentioned at [1], which might be triggered by a problematic client.
> So I would at least think this a better approach than before, and
> which we might consider to have for QEMU 3.0.
>
> One question that we haven't yet solved is that, what if QEMU
> generates some events internally very quickly and without stopping,
> even without any interference from client?  What should we do with
> that?  That's not yet covered by this patch.  For now, the limitation
> will not apply to those events (please see monitor_qapi_event_emit()),
> and my understanding is that we should trust QEMU that it won't do
> such thing (and also we have event rate limiting framework to ease the
> problem a bit).  However I'm not sure of that.  If we want to solve
> this finally, IMHO we might need a separate patch (or patchset),
> though that should be for internal events only, not really related to
> the clients any more.

monitor_qapi_event_queue() implements event rate limiting.  It's
controlled by monitor_qapi_event_conf[].  monitor_qapi_event_emit() is
the helper for monitor_qapi_event_queue() & friends that that does the
actual emission, without a rate limit.

Rate limiting assumes we can safely drop excess events.  Care has to be
taken not to lump events together that should remain separate.  For an
example, see commit 6d425eb94d3.

Any event an untrusted source (the guest, basically) can trigger must be
rate limited.

Trusted sources must not cause event floods.  Rate limiting is one way
to prevent floods.  We currently don't use it for that.  Instead, we put
the burden on the trusted sources.

We can talk about a second line of defense against event floods from
trusted sources.  We haven't felt enough of a need so far.

The question remains how to design for QMP OOB availability.  Perhaps we
can ignore events (other than COMMAND_DROPPED, if we keep that) when
deciding whether a QMP connection has exceeded its buffer allowance.
That way, OOB doesn't create a new way to eat memory without bounds.
The existing way "QMP client can't keep up with an event flood" remains
unaddressed.
