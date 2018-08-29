Received: from eggs.gnu.org ([208.118.235.92]:46352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuoce-0003Fu-J6
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:46:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fuoZU-0000B0-Rm
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:43:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fuoZN-0008Vr-3m
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 20:42:51 -0400
Date: Wed, 29 Aug 2018 08:42:37 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180829004237.GG4446@xz-x1>
References: <20180825135724.8981-1-marcandre.lureau@redhat.com>
	<20180825135724.8981-5-marcandre.lureau@redhat.com>
	<20180827045602.GF3020@xz-x1> <87a7p6mr3e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87a7p6mr3e.fsf@dusky.pond.sub.org>
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
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Aug 28, 2018 at 05:46:29PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Sat, Aug 25, 2018 at 03:57:19PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> There is no need for per-command need_resume granularity, it should
> >> resume after running an non-oob command on oob-disabled monitor.
> >>=20
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> >
> > Note that this series/patch still conflict with the "enable
> > out-of-band by default" series.
> >
> >   [PATCH v6 00/13] monitor: enable OOB by default
>=20
> Yes.
>=20
> > I'm not against this patch to be merged since it has its r-b, but I
> > feel like we'd better judge on whether we still like the response
> > queue first, in case one day we'll need to add these things back.
>=20
> Let's not worry about things that may or may not happen at some
> indeterminate time in the future.

It might not be that "far future"...  Please see below.

>=20
> However:
>=20
> > When there could be functional changes around the code path I would
> > think we'd better keep the cleanup patches postponed a bit until thos=
e
> > functional changes are settled.  For now the functional part is decid=
e
> > how to fix up the rest of out-of-band issues (my proposal is in the
> > series above which should solve everything that is related to
> > out-of-band to be fixed; if there is more, I'll continue to work on
> > it), whether we should enable it by default for 3.1 (my answer
> > is... yes...), and what to do with it.
>=20
> I agree the important job is to finish OOB.
>=20
> Sometimes, it's better to clean up first.  Sometimes, it's not.
>=20
> Right now, the response queue is a useless complication, and
> Marc-Andr=C3=A9's PATCH 3+4 get rid of it.  Lovely.  I understand this
> conflicts with your OOB work.  The question is whether your work
> fundamentally needs the response queue or not.

Just to clarify a bit... I prefer to keep the response queue not
because it's conflicting my existing work but because I think we might
get use of it even in the near future.  I stated it here on the
possibility that we might use the response queue to solve the
unlimited monitor out_buf issue here:

https://patchwork.kernel.org/patch/10511471/#22110771

Quotes:

        ...
        Yeah actually this reminded me about the fact that we are
        still using unlimited buffer size for the out_buf.  IMHO we
        should make it a limited size after 3.0, then AFAICT if
        without current qmp response queue we'll need to introduce
        some similar thing to cache responses then when the out_buf is
        full.

        IMHO the response queue looks more like the correct place that
        we should do the flow control, and the out_buf could be
        majorly used to do the JSON->string convertion (so basically
        IMHO the out_buf limitation should be the size of the maximum
        JSON object that we'll have).
        ...

Let's imagine what we need if we want to limit the out_buf: (1) To
limit the out_buf, we need somewhere to cache the responses that we
want to put into out_buf but we can't when the out_buf is full -
that's mostly the response queue now.  (2) Since we will need to queue
these items onto out_buf when out_buf is not full, we'll possibly need
something like a bottom half to kickoff when out_buf is able to handle
more data - that's mostly the bottom half of the response queue.

AFAIU the rest to do is very possible only that we set a limit to the
out_buf but only if response queue is there...

I didn't really work on the out_buf since I didn't want to further
expand the out-of-band work (since it's already going far away before
it settles down first...), and after all the out_buf issue is nothing
related to the out-of-band work and it's there for a long time.
However that's the major reason that I might prefer to keep the queue
now.

[1]

>=20
> If your OOB work happens to be coded for the response queue, but the
> problem could also be solved without the response queue, then the OOB
> job doesn't fundamentally need the response queue.

Yes, I think the OOB work itself does not need the response queue now.

>=20
> Unless that's the case, getting rid of the response queue is unnecessar=
y
> churn.
>=20
> If it is the case, we still need to consider effort.  Which order is
> less total work?  Which order gets us to the goal faster?
>=20
> Can you guys agree on answers to these questions, or do you need me to
> answer them?
>=20
> Restating the questions:
>=20
> 1. Can you think of a way to do what Peter's OOB series does, but
> without the response queue?
>=20
> 2. If you can, what's easier / cheaper / faster:
>=20
>    a. Merge Marc-Andr=C3=A9's patches to get rid of response queue, rew=
rite
>       OOB series without response queue on top.
>=20
>    b. Merge Peter's OOB series with response queue, rewrite patches to
>       get rid of response queue on top.

Let's have a quick look at above [1], if it's not a good reason (or
even it's still unclear) then let's drop the queue.  It'll be
perfectly fine I rebase my work upon Marc-Andr=C3=A9's.  After all the on=
ly
reason to keep the response queue for me is to save time (for anyone
who will be working with monitors).  If we spend too much time on
judging whether we should keep the queue (we've already spent some)
then it's already a waste of time...  It does not worth it IMO.

>=20
> > If we found that it's too hard to enable it by default, I'm thinking
> > whether we can make it a persistent flag for monitor (maybe turning
> > the "x-oob" into a real "oob" and keep it, then we don't turn it on b=
y
> > default), then we can let libvirt start working with out-of-band with
> > the flag.  After all it's actually working mostly (the pending issues
> > are only things like flow control for malicious/buggy clients, but
> > libvirt never had such an issue with it).
>=20
> The OOB job isn't complete without working flow control.  Nevertheless,
> I'm willing to consider enabling OOB without working flow control.

That'll be great.  Thanks!

(Though I think the current OOB series should have addressed all but
 the out_buf flow control issue, right?)

Regards,

--=20
Peter Xu
