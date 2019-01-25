Received: from eggs.gnu.org ([209.51.188.92]:41496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gn14G-0002jU-EU
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gn14F-000503-LL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 07:58:44 -0500
Date: Fri, 25 Jan 2019 13:58:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190125135835.2d59b511.cohuck@redhat.com>
In-Reply-To: <20190125112437.2c06fac6.cohuck@redhat.com>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<2dac6201-9e71-b188-0385-d09d05071a1c@linux.ibm.com>
	<5627cb78-22b3-0557-7972-256bc9560d86@linux.ibm.com>
	<20190125112437.2c06fac6.cohuck@redhat.com>
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

On Fri, 25 Jan 2019 11:24:37 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 24 Jan 2019 21:37:44 -0500
> Eric Farman <farman@linux.ibm.com> wrote:
>=20
> > On 01/24/2019 09:25 PM, Eric Farman wrote: =20
> > >=20
> > >=20
> > > On 01/21/2019 06:03 AM, Cornelia Huck wrote:   =20
>=20
> > > [1] I think these changes are cool.=C2=A0 We end up going into (and s=
taying=20
> > > in) state=3DBUSY if we get cc=3D0 on the SSCH, rather than in/out as =
we=20
> > > bumble along.
> > >=20
> > > But why can't these be separated out from this patch?=C2=A0 It does c=
hange=20
> > > the behavior of the state machine, and seem distinct from the additio=
n=20
> > > of the mutex you otherwise add here?=C2=A0 At the very least, this be=
havior=20
> > > change should be documented in the commit since it's otherwise lost i=
n=20
> > > the mutex/EAGAIN stuff. =20
>=20
> That's a very good idea. I'll factor them out into a separate patch.

And now that I've factored it out, I noticed some more problems.

What we basically need is the following, I think:

- The code should not be interrupted while we process the channel
  program, do the ssch etc. We want the caller to try again later (i.e.
  return -EAGAIN)
- We currently do not want the user space to submit another channel
  program while the first one is still in flight. As submitting another
  one is a valid request, however, we should allow this in the future
  (once we have the code to handle that in place).
- With the async interface, we want user space to be able to submit a
  halt/clear while a start request is still in flight, but not while
  we're processing a start request with translation etc. We probably
  want to do -EAGAIN in that case.

My idea would be:

- The BUSY state denotes "I'm busy processing a request right now, try
  again". We hold it while processing the cp and doing the ssch and
  leave it afterwards (i.e., while the start request is processed by
  the hardware). I/O requests and async requests get -EAGAIN in that
  state.
- A new state (CP_PENDING?) is entered after ssch returned with cc 0
  (from the BUSY state). We stay in there as long as no final state for
  that request has been received and delivered. (This may be final
  interrupt for that request, a deferred cc, or successful halt/clear.)
  I/O requests get -EBUSY, async requests are processed. This state can
  be removed again once we are able to handle more than one outstanding
  cp.

Does that make sense?
