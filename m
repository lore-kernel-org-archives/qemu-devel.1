Received: from eggs.gnu.org ([2001:4830:134:3::10]:52324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuwGh-00022d-Bi
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fuwGd-0004N3-L1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:56:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fuwGc-0004MS-T5
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 04:55:59 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
	<20180827045602.GF3020@xz-x1> <87a7p6mr3e.fsf@dusky.pond.sub.org>
	<20180829004237.GG4446@xz-x1>
Date: Wed, 29 Aug 2018 10:55:51 +0200
In-Reply-To: <20180829004237.GG4446@xz-x1> (Peter Xu's message of "Wed, 29 Aug
	2018 08:42:37 +0800")
Message-ID: <87r2ihh7qg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/9] monitor: no need to save need_resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Tue, Aug 28, 2018 at 05:46:29PM +0200, Markus Armbruster wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Sat, Aug 25, 2018 at 03:57:19PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> >> There is no need for per-command need_resume granularity, it should
>> >> resume after running an non-oob command on oob-disabled monitor.
>> >>=20
>> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> >
>> > Note that this series/patch still conflict with the "enable
>> > out-of-band by default" series.
>> >
>> >   [PATCH v6 00/13] monitor: enable OOB by default
>>=20
>> Yes.
>>=20
>> > I'm not against this patch to be merged since it has its r-b, but I
>> > feel like we'd better judge on whether we still like the response
>> > queue first, in case one day we'll need to add these things back.
>>=20
>> Let's not worry about things that may or may not happen at some
>> indeterminate time in the future.
>
> It might not be that "far future"...  Please see below.
>
>>=20
>> However:
>>=20
>> > When there could be functional changes around the code path I would
>> > think we'd better keep the cleanup patches postponed a bit until those
>> > functional changes are settled.  For now the functional part is decide
>> > how to fix up the rest of out-of-band issues (my proposal is in the
>> > series above which should solve everything that is related to
>> > out-of-band to be fixed; if there is more, I'll continue to work on
>> > it), whether we should enable it by default for 3.1 (my answer
>> > is... yes...), and what to do with it.
>>=20
>> I agree the important job is to finish OOB.
>>=20
>> Sometimes, it's better to clean up first.  Sometimes, it's not.
>>=20
>> Right now, the response queue is a useless complication, and
>> Marc-Andr=C3=A9's PATCH 3+4 get rid of it.  Lovely.  I understand this
>> conflicts with your OOB work.  The question is whether your work
>> fundamentally needs the response queue or not.
>
> Just to clarify a bit... I prefer to keep the response queue not
> because it's conflicting my existing work but because I think we might
> get use of it even in the near future.  I stated it here on the
> possibility that we might use the response queue to solve the
> unlimited monitor out_buf issue here:
>
> https://patchwork.kernel.org/patch/10511471/#22110771
>
> Quotes:
>
>         ...
>         Yeah actually this reminded me about the fact that we are
>         still using unlimited buffer size for the out_buf.  IMHO we
>         should make it a limited size after 3.0, then AFAICT if
>         without current qmp response queue we'll need to introduce
>         some similar thing to cache responses then when the out_buf is
>         full.
>
>         IMHO the response queue looks more like the correct place that
>         we should do the flow control, and the out_buf could be
>         majorly used to do the JSON->string convertion (so basically
>         IMHO the out_buf limitation should be the size of the maximum
>         JSON object that we'll have).
>         ...
>
> Let's imagine what we need if we want to limit the out_buf: (1) To
> limit the out_buf, we need somewhere to cache the responses that we
> want to put into out_buf but we can't when the out_buf is full -
> that's mostly the response queue now.  (2) Since we will need to queue
> these items onto out_buf when out_buf is not full, we'll possibly need
> something like a bottom half to kickoff when out_buf is able to handle
> more data - that's mostly the bottom half of the response queue.
>
> AFAIU the rest to do is very possible only that we set a limit to the
> out_buf but only if response queue is there...

Limiting outbuf only to have the same data pile up earlier in the
pipeline doesn't seem helpful.  We need to throttle production of
output.  A simple way to do that is throttling input.  See below.

> I didn't really work on the out_buf since I didn't want to further
> expand the out-of-band work (since it's already going far away before
> it settles down first...), and after all the out_buf issue is nothing
> related to the out-of-band work and it's there for a long time.
> However that's the major reason that I might prefer to keep the queue
> now.
>
> [1]

Let's review what we have.

QMP flow control is about limiting the amount of data QEMU buffers on
behalf of a QMP client.

This is about robustness, not security.  There are countless ways a QMP
client can make QEMU use more memory.  We want to cope with accidents,
not stop attacks.

A common and simple way to do flow control is to throttle receiving.
Unless the transport buffers way too much (which would be insane), the
peer will soon notice, and can adapt.

QMP input flows from the character device to commands.  It is converted
from text to QObject along the way.  Output flows from commands to the
character device.  It is converted from QObject to text along the way.

When the client sends input faster than QEMU can execute them, flow
control should kick in to stop adding more input to the pileup.  When
QEMU produces output faster than the client can receive it, flow control
should kick in to stop adding more output to the pileup.  We can do that
indirectly, by stopping input.

Input buffering:

* The chardev buffers 4KiB (I think).  Small enough to be ignored.

* The JSON parser buffers one partial JSON value as a token list, up to
  a limit in the order of 64MiB.  Weasel words "in the order", because
  it measures memory consumption only indirectly.  The limit is
  ridicilously generous for a control plane purpose like QMP.

* When the partial JSON value becomes complete, the JSON parser converts
  it to a QObject, then frees the token list.

* Without OOB, the QMP core buffers one complete QObject (the command)
  until we're done with the command.  The JSON parser's buffer should be
  empty then, because the QMP core suspends reading from the char device
  while it deals with a command.

* With OOB, the QMP core buffers up to 8 in-band commands and one
  out-of-band command.

  When the in-band command buffer is full, we currently drop further
  in-band commands, but that's a bad idea, and we're going to suspend
  reading from the char device instead.  Once we do, the JSON parser's
  buffer should be empty when the in-band command buffer is full.  The
  remainder of my analysis assumes we suspend rather than drop.

Output buffering:

* Traditionally, the QMP core buffers one QObject while it converts it
  to text.  It buffers an unlimited amount of text in mon->outbuf.

* Adding a request queue doesn't by itself change how much data is
  buffered, only when it's converted from QObject to text.  If the
  bottom half doing the conversion runs quickly, nothing changes.  If it
  gets delayed for some reason, QObjects can pile up in the response
  queue before they get converted and moved to mon->outbuf.

Summary of flow control:

* We limit input buffers and stop reading input when the limit is
  exceeded.  This stops input piling up.

* We do not limit output at all.

Ideally, we'd keep track of combined input and output buffer size, and
throttle input to keep it under control.  But separate limits for
individual buffers could be good enough, and might be simpler.

>> If your OOB work happens to be coded for the response queue, but the
>> problem could also be solved without the response queue, then the OOB
>> job doesn't fundamentally need the response queue.
>
> Yes, I think the OOB work itself does not need the response queue now.

Understood.

>> Unless that's the case, getting rid of the response queue is unnecessary
>> churn.
>>=20
>> If it is the case, we still need to consider effort.  Which order is
>> less total work?  Which order gets us to the goal faster?
>>=20
>> Can you guys agree on answers to these questions, or do you need me to
>> answer them?
>>=20
>> Restating the questions:
>>=20
>> 1. Can you think of a way to do what Peter's OOB series does, but
>> without the response queue?
>>=20
>> 2. If you can, what's easier / cheaper / faster:
>>=20
>>    a. Merge Marc-Andr=C3=A9's patches to get rid of response queue, rewr=
ite
>>       OOB series without response queue on top.
>>=20
>>    b. Merge Peter's OOB series with response queue, rewrite patches to
>>       get rid of response queue on top.
>
> Let's have a quick look at above [1], if it's not a good reason (or
> even it's still unclear) then let's drop the queue.  It'll be
> perfectly fine I rebase my work upon Marc-Andr=C3=A9's.  After all the on=
ly
> reason to keep the response queue for me is to save time (for anyone
> who will be working with monitors).  If we spend too much time on
> judging whether we should keep the queue (we've already spent some)
> then it's already a waste of time...  It does not worth it IMO.

Time spent on coming up with a high-level plan for flow control is time
well spent.

Sometimes, you have to explore and experiment before you can come up
with a high-level plan that has a reasonable chance of working.  No
license to skip the "think before you hack" step entirely.

Here's the simplest (and possibly naive) plan I can think of: if
mon->outbuf exceeds a limit, suspend reading input.  No response queue.
Would it have a reasonable chance of working?

>> > If we found that it's too hard to enable it by default, I'm thinking
>> > whether we can make it a persistent flag for monitor (maybe turning
>> > the "x-oob" into a real "oob" and keep it, then we don't turn it on by
>> > default), then we can let libvirt start working with out-of-band with
>> > the flag.  After all it's actually working mostly (the pending issues
>> > are only things like flow control for malicious/buggy clients, but
>> > libvirt never had such an issue with it).
>>=20
>> The OOB job isn't complete without working flow control.  Nevertheless,
>> I'm willing to consider enabling OOB without working flow control.
>
> That'll be great.  Thanks!
>
> (Though I think the current OOB series should have addressed all but
>  the out_buf flow control issue, right?)

I hope so, but I haven't been able to review it, yet :)
