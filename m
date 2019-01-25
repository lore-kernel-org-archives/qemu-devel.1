Received: from eggs.gnu.org ([209.51.188.92]:52329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn230-0004Hs-NW
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:01:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1gn22q-00019M-Gm
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:01:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40014
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1gn22i-00016r-W5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:01:14 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x0PE06g6082323
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 09:01:11 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2q8328am6m-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 09:01:10 -0500
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Fri, 25 Jan 2019 14:01:09 -0000
Date: Fri, 25 Jan 2019 15:01:01 +0100
From: Halil Pasic <pasic@linux.ibm.com>
In-Reply-To: <20190125135835.2d59b511.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <20190125150101.3b61f0a1@oc2783563651>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 25 Jan 2019 13:58:35 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Fri, 25 Jan 2019 11:24:37 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>=20
> > On Thu, 24 Jan 2019 21:37:44 -0500
> > Eric Farman <farman@linux.ibm.com> wrote:
> >=20
> > > On 01/24/2019 09:25 PM, Eric Farman wrote: =20
> > > >=20
> > > >=20
> > > > On 01/21/2019 06:03 AM, Cornelia Huck wrote:   =20
> >=20
> > > > [1] I think these changes are cool.=C2=A0 We end up going into (and=
 staying=20
> > > > in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out a=
s we=20
> > > > bumble along.
> > > >=20
> > > > But why can't these be separated out from this patch?=C2=A0 It does=
 change=20
> > > > the behavior of the state machine, and seem distinct from the addit=
ion=20
> > > > of the mutex you otherwise add here?=C2=A0 At the very least, this =
behavior=20
> > > > change should be documented in the commit since it's otherwise lost=
 in=20
> > > > the mutex/EAGAIN stuff. =20
> >=20
> > That's a very good idea. I'll factor them out into a separate patch.
>=20
> And now that I've factored it out, I noticed some more problems.
>=20
> What we basically need is the following, I think:
>=20
> - The code should not be interrupted while we process the channel
>   program, do the ssch etc. We want the caller to try again later (i.e.
>   return -EAGAIN)

We could also interrupt it e.g. by a TRANSLATE -> REQ_ABORT_TRANSLATE
state transition. The thread doing the translation could pick that up
and make sure we don't do the ssch(). Would match the architecture
better, but would be more complicated. And can be done any time later.

> - We currently do not want the user space to submit another channel
>   program while the first one is still in flight. As submitting another
>   one is a valid request, however, we should allow this in the future
>   (once we have the code to handle that in place).

I don't agree. There is at most one channel program processed by a
subchannel at any time. I would prefer an early error code if channel
programs are issued on top of each other (our virtual subchannel
is channel pending or FC start function bit set or similar).

Of course the interface exposed by the vfio-ccw module does not need to
look like the architecture interface. But IMHO any
unjustified deviation from the good old architecure ways of things will
just make it harder to reason about stuff. In the end you have that
interface both as input (guests passed-thorough subchannel) and as
output (the subchannel in the host that's being passed-thorough).


> - With the async interface, we want user space to be able to submit a
>   halt/clear while a start request is still in flight, but not while
>   we're processing a start request with translation etc. We probably
>   want to do -EAGAIN in that case.

This reads very similar to your first point.

>=20
> My idea would be:
>=20
> - The BUSY state denotes "I'm busy processing a request right now, try
>   again". We hold it while processing the cp and doing the ssch and
>   leave it afterwards (i.e., while the start request is processed by
>   the hardware). I/O requests and async requests get -EAGAIN in that
>   state.
> - A new state (CP_PENDING?) is entered after ssch returned with cc 0
>   (from the BUSY state). We stay in there as long as no final state for
>   that request has been received and delivered. (This may be final
>   interrupt for that request, a deferred cc, or successful halt/clear.)
>   I/O requests get -EBUSY, async requests are processed. This state can
>   be removed again once we are able to handle more than one outstanding
>   cp.
>=20
> Does that make sense?
>=20

AFAIU your idea is to split up the busy state into two states: CP_PENDING
and of busy without CP_PENDING called BUSY. I like the idea of having a
separate state for CP_PENDING but I don't like the new semantic of BUSY.

Hm mashing a conceptual state machine and the jumptabe stuff ain't
making reasoning about this simpler either. I'm taking about the
conceptual state machine. It would be nice to have a picture of it and
then think about how to express that in code.

Regards,
Halil
