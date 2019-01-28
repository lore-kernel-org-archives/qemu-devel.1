Received: from eggs.gnu.org ([209.51.188.92]:56490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goAeN-0003VU-2I
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:24:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1goAeL-00025g-Py
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:24:47 -0500
Date: Mon, 28 Jan 2019 18:24:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128182424.3ad3d94d.cohuck@redhat.com>
In-Reply-To: <565393ea-e9dc-4455-a22b-16d4bd2cfbb8@linux.ibm.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
	<20190125135835.2d59b511.cohuck@redhat.com>
	<565393ea-e9dc-4455-a22b-16d4bd2cfbb8@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Fri, 25 Jan 2019 10:57:38 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 01/25/2019 07:58 AM, Cornelia Huck wrote:
> > On Fri, 25 Jan 2019 11:24:37 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >  =20
> >> On Thu, 24 Jan 2019 21:37:44 -0500
> >> Eric Farman <farman@linux.ibm.com> wrote:
> >> =20
> >>> On 01/24/2019 09:25 PM, Eric Farman wrote: =20
> >>>>
> >>>>
> >>>> On 01/21/2019 06:03 AM, Cornelia Huck wrote: =20
> >> =20
> >>>> [1] I think these changes are cool.=C2=A0 We end up going into (and =
staying
> >>>> in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out as=
 we
> >>>> bumble along.
> >>>>
> >>>> But why can't these be separated out from this patch?=C2=A0 It does =
change
> >>>> the behavior of the state machine, and seem distinct from the additi=
on
> >>>> of the mutex you otherwise add here?=C2=A0 At the very least, this b=
ehavior
> >>>> change should be documented in the commit since it's otherwise lost =
in
> >>>> the mutex/EAGAIN stuff. =20
> >>
> >> That's a very good idea. I'll factor them out into a separate patch. =
=20
> >=20
> > And now that I've factored it out, I noticed some more problems. =20
>=20
> That's good!  Maybe it helps us with the circles we're on :)

:)

>=20
> >=20
> > What we basically need is the following, I think:
> >=20
> > - The code should not be interrupted while we process the channel
> >    program, do the ssch etc. We want the caller to try again later (i.e.
> >    return -EAGAIN)
> > - We currently do not want the user space to submit another channel
> >    program while the first one is still in flight.  =20
>=20
> These two seem to contradict one another.  I think you're saying is that=
=20
> we don't _want_ userspace to issue another channel program, even though=20
> its _allowed_ to as far as vfio-ccw is concerned.

What I'm trying to say is that we want to distinguish two things:
- The code is currently doing translation etc. We probably want to keep
  that atomic, in order not to make things too complicated.
- We have sent the ssch() to the hardware, but have not yet received
  the final interrupt for that request (that's what I meant with "in
  flight"). It's easier for the first shot to disallow a second ssch()
  as that would need handling of more than one cp request, but we may
  want to allow it in the future.
  A hsch()/csch() (which does not generate a new cp) should be fine.

(see also my reply to Halil's mail)

>=20
> As submitting another
> >    one is a valid request, however, we should allow this in the future
> >    (once we have the code to handle that in place).
> > - With the async interface, we want user space to be able to submit a
> >    halt/clear while a start request is still in flight, but not while
> >    we're processing a start request with translation etc. We probably
> >    want to do -EAGAIN in that case.
> >=20
> > My idea would be:
> >=20
> > - The BUSY state denotes "I'm busy processing a request right now, try
> >    again". We hold it while processing the cp and doing the ssch and
> >    leave it afterwards (i.e., while the start request is processed by
> >    the hardware). I/O requests and async requests get -EAGAIN in that
> >    state.
> > - A new state (CP_PENDING?) is entered after ssch returned with cc 0
> >    (from the BUSY state). We stay in there as long as no final state for
> >    that request has been received and delivered. (This may be final
> >    interrupt for that request, a deferred cc, or successful halt/clear.)
> >    I/O requests get -EBUSY =20
>=20
> I liked CP_PENDING, since it corresponds to the subchannel being marked=20
> "start pending" as described in POPS, but this statement suggests that=20
> the BUSY/PENDING state to be swapped, such that state=3DPENDING returns=20
> -EAGAIN and state=3DBUSY returns -EBUSY.  Not super-concerned with the=20
> terminology though.

What about s/BUSY/CP_PROCESSING/ ?

>=20
> , async requests are processed. This state can
> >    be removed again once we are able to handle more than one outstanding
> >    cp.
> >=20
> > Does that make sense?
> >  =20
>=20
> I think so, and I think I like it.  So you want to distinguish between=20
> (I have swapped BUSY/PENDING in this example per my above comment):
>=20
> A) SSCH issued by userspace (IDLE->PENDING)
> B) SSCH issued (successfully) by kernel (PENDING->BUSY)
> B') SSCH issued (unsuccessfully) by kernel (PENDING->IDLE?)

I think so.

> C) Interrupt received by kernel (no change?)
> D) Interrupt given to userspace (BUSY->IDLE)

Only if that is the final interrupt for that cp.

>=20
> If we receive A and A, the second A gets EAGAIN
>=20
> If we do A+B and A, the second A gets EBUSY (unless async, which is=20
> processed)

Nod.

> Does the boundary of "in flight" in the interrupt side (C and D) need to=
=20
> be defined, such that we go BUSY->PENDING->IDLE instead of BUSY->IDLE ?

I don't think we can go BUSY->PENDING (in your terminology), at that
would imply a retry of the ssch()?
