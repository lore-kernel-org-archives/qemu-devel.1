Received: from eggs.gnu.org ([2001:4830:134:3::10]:40851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fvDod-0000Ky-BI
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 23:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fvDfz-0002tE-Sp
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 23:31:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34134 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fvDfz-0002t4-L1
	for qemu-devel@nongnu.org; Wed, 29 Aug 2018 23:31:19 -0400
Date: Thu, 30 Aug 2018 11:31:11 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180830033111.GC9942@xz-x1>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
	<20180827045602.GF3020@xz-x1> <87a7p6mr3e.fsf@dusky.pond.sub.org>
	<20180829004237.GG4446@xz-x1> <87r2ihh7qg.fsf@dusky.pond.sub.org>
	<20180829102102.GA9942@xz-x1> <87ftyx9whk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ftyx9whk.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Aug 29, 2018 at 02:40:39PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Wed, Aug 29, 2018 at 10:55:51AM +0200, Markus Armbruster wrote:
> >> Peter Xu <peterx@redhat.com> writes:
> >>=20
> >> > On Tue, Aug 28, 2018 at 05:46:29PM +0200, Markus Armbruster wrote:
> >> >> Peter Xu <peterx@redhat.com> writes:
> >> >>=20
> >> >> > On Sat, Aug 25, 2018 at 03:57:19PM +0200, Marc-Andr=C3=A9 Lurea=
u wrote:
> >> >> >> There is no need for per-command need_resume granularity, it s=
hould
> >> >> >> resume after running an non-oob command on oob-disabled monito=
r.
> >> >> >>=20
> >> >> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat=
.com>
> >> >> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >> >> >
> >> >> > Note that this series/patch still conflict with the "enable
> >> >> > out-of-band by default" series.
> >> >> >
> >> >> >   [PATCH v6 00/13] monitor: enable OOB by default
> >> >>=20
> >> >> Yes.
> >> >>=20
> >> >> > I'm not against this patch to be merged since it has its r-b, b=
ut I
> >> >> > feel like we'd better judge on whether we still like the respon=
se
> >> >> > queue first, in case one day we'll need to add these things bac=
k.
> >> >>=20
> >> >> Let's not worry about things that may or may not happen at some
> >> >> indeterminate time in the future.
> >> >
> >> > It might not be that "far future"...  Please see below.
> >> >
> >> >>=20
> >> >> However:
> >> >>=20
> >> >> > When there could be functional changes around the code path I w=
ould
> >> >> > think we'd better keep the cleanup patches postponed a bit unti=
l those
> >> >> > functional changes are settled.  For now the functional part is=
 decide
> >> >> > how to fix up the rest of out-of-band issues (my proposal is in=
 the
> >> >> > series above which should solve everything that is related to
> >> >> > out-of-band to be fixed; if there is more, I'll continue to wor=
k on
> >> >> > it), whether we should enable it by default for 3.1 (my answer
> >> >> > is... yes...), and what to do with it.
> >> >>=20
> >> >> I agree the important job is to finish OOB.
> >> >>=20
> >> >> Sometimes, it's better to clean up first.  Sometimes, it's not.
> >> >>=20
> >> >> Right now, the response queue is a useless complication, and
> >> >> Marc-Andr=C3=A9's PATCH 3+4 get rid of it.  Lovely.  I understand=
 this
> >> >> conflicts with your OOB work.  The question is whether your work
> >> >> fundamentally needs the response queue or not.
> >> >
> >> > Just to clarify a bit... I prefer to keep the response queue not
> >> > because it's conflicting my existing work but because I think we m=
ight
> >> > get use of it even in the near future.  I stated it here on the
> >> > possibility that we might use the response queue to solve the
> >> > unlimited monitor out_buf issue here:
> >> >
> >> > https://patchwork.kernel.org/patch/10511471/#22110771
> >> >
> >> > Quotes:
> >> >
> >> >         ...
> >> >         Yeah actually this reminded me about the fact that we are
> >> >         still using unlimited buffer size for the out_buf.  IMHO w=
e
> >> >         should make it a limited size after 3.0, then AFAICT if
> >> >         without current qmp response queue we'll need to introduce
> >> >         some similar thing to cache responses then when the out_bu=
f is
> >> >         full.
> >> >
> >> >         IMHO the response queue looks more like the correct place =
that
> >> >         we should do the flow control, and the out_buf could be
> >> >         majorly used to do the JSON->string convertion (so basical=
ly
> >> >         IMHO the out_buf limitation should be the size of the maxi=
mum
> >> >         JSON object that we'll have).
> >> >         ...
> >> >
> >> > Let's imagine what we need if we want to limit the out_buf: (1) To
> >> > limit the out_buf, we need somewhere to cache the responses that w=
e
> >> > want to put into out_buf but we can't when the out_buf is full -
> >> > that's mostly the response queue now.  (2) Since we will need to q=
ueue
> >> > these items onto out_buf when out_buf is not full, we'll possibly =
need
> >> > something like a bottom half to kickoff when out_buf is able to ha=
ndle
> >> > more data - that's mostly the bottom half of the response queue.
> >> >
> >> > AFAIU the rest to do is very possible only that we set a limit to =
the
> >> > out_buf but only if response queue is there...
> >>=20
> >> Limiting outbuf only to have the same data pile up earlier in the
> >> pipeline doesn't seem helpful.  We need to throttle production of
> >> output.  A simple way to do that is throttling input.  See below.
> >>=20
> >> > I didn't really work on the out_buf since I didn't want to further
> >> > expand the out-of-band work (since it's already going far away bef=
ore
> >> > it settles down first...), and after all the out_buf issue is noth=
ing
> >> > related to the out-of-band work and it's there for a long time.
> >> > However that's the major reason that I might prefer to keep the qu=
eue
> >> > now.
> >> >
> >> > [1]
> >>=20
> >> Let's review what we have.
> >>=20
> >> QMP flow control is about limiting the amount of data QEMU buffers o=
n
> >> behalf of a QMP client.
> >>=20
> >> This is about robustness, not security.  There are countless ways a =
QMP
> >> client can make QEMU use more memory.  We want to cope with accident=
s,
> >> not stop attacks.
> >>=20
> >> A common and simple way to do flow control is to throttle receiving.
> >> Unless the transport buffers way too much (which would be insane), t=
he
> >> peer will soon notice, and can adapt.
> >>=20
> >> QMP input flows from the character device to commands.  It is conver=
ted
> >> from text to QObject along the way.  Output flows from commands to t=
he
> >> character device.  It is converted from QObject to text along the wa=
y.
> >>=20
> >> When the client sends input faster than QEMU can execute them, flow
> >> control should kick in to stop adding more input to the pileup.  Whe=
n
> >> QEMU produces output faster than the client can receive it, flow con=
trol
> >> should kick in to stop adding more output to the pileup.  We can do =
that
> >> indirectly, by stopping input.
> >>=20
> >> Input buffering:
> >>=20
> >> * The chardev buffers 4KiB (I think).  Small enough to be ignored.
> >>=20
> >> * The JSON parser buffers one partial JSON value as a token list, up=
 to
> >>   a limit in the order of 64MiB.  Weasel words "in the order", becau=
se
> >>   it measures memory consumption only indirectly.  The limit is
> >>   ridicilously generous for a control plane purpose like QMP.
> >>=20
> >> * When the partial JSON value becomes complete, the JSON parser conv=
erts
> >>   it to a QObject, then frees the token list.
> >>=20
> >> * Without OOB, the QMP core buffers one complete QObject (the comman=
d)
> >>   until we're done with the command.  The JSON parser's buffer shoul=
d be
> >>   empty then, because the QMP core suspends reading from the char de=
vice
> >>   while it deals with a command.
> >>=20
> >> * With OOB, the QMP core buffers up to 8 in-band commands and one
> >>   out-of-band command.
> >>=20
> >>   When the in-band command buffer is full, we currently drop further
> >>   in-band commands, but that's a bad idea, and we're going to suspen=
d
> >>   reading from the char device instead.  Once we do, the JSON parser=
's
> >>   buffer should be empty when the in-band command buffer is full.  T=
he
> >>   remainder of my analysis assumes we suspend rather than drop.
> >>=20
> >> Output buffering:
> >>=20
> >> * Traditionally, the QMP core buffers one QObject while it converts =
it
> >>   to text.  It buffers an unlimited amount of text in mon->outbuf.
> >>=20
> >> * Adding a request queue doesn't by itself change how much data is
> >>   buffered, only when it's converted from QObject to text.  If the
> >>   bottom half doing the conversion runs quickly, nothing changes.  I=
f it
> >>   gets delayed for some reason, QObjects can pile up in the response
> >>   queue before they get converted and moved to mon->outbuf.
> >>=20
> >> Summary of flow control:
> >>=20
> >> * We limit input buffers and stop reading input when the limit is
> >>   exceeded.  This stops input piling up.
> >>=20
> >> * We do not limit output at all.
> >>=20
> >> Ideally, we'd keep track of combined input and output buffer size, a=
nd
> >> throttle input to keep it under control.  But separate limits for
> >> individual buffers could be good enough, and might be simpler.
> >
> > (thanks for the summary)
> >
> >>=20
> >> >> If your OOB work happens to be coded for the response queue, but =
the
> >> >> problem could also be solved without the response queue, then the=
 OOB
> >> >> job doesn't fundamentally need the response queue.
> >> >
> >> > Yes, I think the OOB work itself does not need the response queue =
now.
> >>=20
> >> Understood.
> >>=20
> >> >> Unless that's the case, getting rid of the response queue is unne=
cessary
> >> >> churn.
> >> >>=20
> >> >> If it is the case, we still need to consider effort.  Which order=
 is
> >> >> less total work?  Which order gets us to the goal faster?
> >> >>=20
> >> >> Can you guys agree on answers to these questions, or do you need =
me to
> >> >> answer them?
> >> >>=20
> >> >> Restating the questions:
> >> >>=20
> >> >> 1. Can you think of a way to do what Peter's OOB series does, but
> >> >> without the response queue?
> >> >>=20
> >> >> 2. If you can, what's easier / cheaper / faster:
> >> >>=20
> >> >>    a. Merge Marc-Andr=C3=A9's patches to get rid of response queu=
e, rewrite
> >> >>       OOB series without response queue on top.
> >> >>=20
> >> >>    b. Merge Peter's OOB series with response queue, rewrite patch=
es to
> >> >>       get rid of response queue on top.
> >> >
> >> > Let's have a quick look at above [1], if it's not a good reason (o=
r
> >> > even it's still unclear) then let's drop the queue.  It'll be
> >> > perfectly fine I rebase my work upon Marc-Andr=C3=A9's.  After all=
 the only
> >> > reason to keep the response queue for me is to save time (for anyo=
ne
> >> > who will be working with monitors).  If we spend too much time on
> >> > judging whether we should keep the queue (we've already spent some=
)
> >> > then it's already a waste of time...  It does not worth it IMO.
> >>=20
> >> Time spent on coming up with a high-level plan for flow control is t=
ime
> >> well spent.
> >>=20
> >> Sometimes, you have to explore and experiment before you can come up
> >> with a high-level plan that has a reasonable chance of working.  No
> >> license to skip the "think before you hack" step entirely.
> >>=20
> >> Here's the simplest (and possibly naive) plan I can think of: if
> >> mon->outbuf exceeds a limit, suspend reading input.  No response que=
ue.
> >> Would it have a reasonable chance of working?
> >
> > Hmm I think it works...  Let's assume:
> >
> > - M: threshold size for outbuf
> > - A: size of current outbuf
> > - B: size of a new response message (and assume A+B>M, so the flow
> >      control will trigger)
> >
> > I think that queue is not a must if we don't restrict the buffer that
> > much - for example we can just queue the JSON object into outbuf when
> > we receive the new message with size B (after queuing, we might get
> > A+B>M, then it's slightly bigger than the limit threshold), now we
> > suspend the monitor.
>=20
> Yes.
>=20
> M is a threshold for suspending the monitor, not a hard size limit.
>=20
> Since the response QObjects has to go *somewhere*, we can just as well
> stuff it into mon->outbuf.
>=20
> The actual mon-outbuf size A may exceed the threshold M, but only while
> the monitor is suspended.
>=20
> > If we want to have a very strict buffer size limitation for outbuf so
> > the outbuf never use more than M, we can't just queue it since it wil=
l
> > overflow, then we need to stop the input and cache the object
> > somewhere (e.g., the response queue).
>=20
> Yes, but that doesn't actually limit memory use: instead of mon->outbuf
> growing without bound, we now have response queue growing without bound=
.
> Actual memory use changes only if one of the two representations QObjec=
t
> and text is more compact.
>=20
> Unscientific experiment: I instrumented qobject_to_json() to measure
> size of its QObject input and text output (patch appended).  For
> query-qmp-schema's output, I measure ~9.8MiB for QObject, and ~119KiB
> for text:
>=20
>     ### qobject_to_json(0x556653e7ac30)
>     ###    #objs   #bytes QType
>     ###        0        0 none
>     ###      568        0 qnull
>     ###        0        0 qnum
>     ###    11876   540253 qstring
>     ###     2301  9677496 qdict
>     ###      509    86344 qlist
>     ###        2       48 qbool
>     ### 0x556653e7ac30 uses 10304141 vs. 121759
>=20
> Most of the QObject's memory is occupied by QDicts.  The way they're
> implemented is wasteful (known issue).  But even with a magical QDict
> implementation that uses no memory at all, the QObject would still use
> five times the memory of text.
>=20
> My experiment suggests that to conserve memory, we should convert
> responses to text right away.

>From memory saving POV, yes.  But keeping them as objects bring us
flexibility and isolation, e.g., we can simply drop one event as we
want (rather than dropping the whole outbuf), or suddenly we want to
insert a new key due to some reason.  But these requirements have no
real usage so far.  So I admit it's possibly me that have thought too
much and I decided to not struggle. :)

(I never consider perf for QMP yet... so actually spending more memory
 is not a problem to me; however possibility to use up the memory is
 of course another thing...)

Now I only hope we won't have other bug triggered due to start using
the multi-threading of output buffer after we remove the queue.

>=20
> > So I think now I agree with you that the response queue is not
> > required if we think the first solution is okay for us.
>=20
> Cool.  Can you explore that and post patches?

I think what I can do here is rebasing my work after Marc-Andre's
patches merged.  Please let me know if there's anything else I can do.

Thanks,

--=20
Peter Xu
