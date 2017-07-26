Received: from eggs.gnu.org ([2001:4830:134:3::10]:58675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daBeV-0008N9-75
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 22:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daBeS-0004pz-4u
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 22:02:19 -0400
Date: Wed, 26 Jul 2017 12:02:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726020204.GK8978@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-15-git-send-email-clg@kaod.org>
	<20170724063534.GM17228@umbus.fritz.box>
	<fa7a0b3f-89d5-b1ef-238d-0bda41beee9f@kaod.org>
	<20170725042027.GC8978@umbus.fritz.box>
	<1d7d50ee-7559-2e6b-4ed0-741d810052d0@kaod.org>
	<20170725132129.GH8978@umbus.fritz.box>
	<e579aef2-d8b3-180a-5250-2016060a6a05@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline
In-Reply-To: <e579aef2-d8b3-180a-5250-2016060a6a05@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH 14/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt presenter model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 05:01:48PM +0200, C=E9dric Le Goater wrote:
> On 07/25/2017 03:21 PM, David Gibson wrote:
> > On Tue, Jul 25, 2017 at 11:08:46AM +0200, C=E9dric Le Goater wrote:
> >> On 07/25/2017 06:20 AM, David Gibson wrote:
> >>> On Mon, Jul 24, 2017 at 04:44:00PM +0200, C=E9dric Le Goater wrote:
> >>>> On 07/24/2017 08:35 AM, David Gibson wrote:
> >>>>> On Wed, Jul 05, 2017 at 07:13:27PM +0200, C=E9dric Le Goater wrote:
> >>>>>> The Thread Interrupt Management Area for the OS is mostly used to
> >>>>>> acknowledge interrupts and set the CPPR of the CPU.
> >>>>>>
> >>>>>> The TIMA is mapped at the same address for each CPU. 'current_cpu'=
 is
> >>>>>> used to retrieve the targeted interrupt presenter object.
> >>>>>>
> >>>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>>>
> >>>>> Am I right in thinking that this shoehorns the XIVE TIMA state into
> >>>>> the existing XICS ICP object.  That.. doesn't seem like a good idea.
> >>>>
> >>>> The TIMA memory region is under the XIVE object because it is=20
> >>>> unique for the system. The lookup of the ICP is simply done using=20
> >>>> 'current_cpu'. The TIMA state is under the ICPState, yes, but this=
=20
> >>>> model does not seem incorrect to me as this state contains the=20
> >>>> interrupt information presented to a CPU.
> >>>
> >>> Yeah, that's not the point I'm making.  My point is that the TIMA
> >>> state isn't really the same as xics ICP state.  You're squeezing one
> >>> into the other in a pretty ugly way.
> >>
> >> yes, well, we need to have compatible objects between the XICS and XIV=
E=20
> >> mode because of the CAS negotiation. for migration compatibility, it i=
s=20
> >> much easier to extend existing objects. This approach I am taking toda=
y.
> >=20
> > Yeah, I really don't think this approach is workable.
> >=20
> > Roughly speaking, you're keeping the same structures between xics and
> > xive, but with mostly different code.  I can't see any way that's not
> > going to be horribly fragile, with any update to xics OR xive
> > requiring enormous caution not to break the other.
> >=20
> > I really think we have to go one of two ways:
> >=20
> > 1) Abstract the notion of interrupt source and interrupt presenter, so
> > we can use a truly common model between xics and xive.
> >=20
> > Given the differences between the two, I don't know this is even
> > possible.
> >=20
> > 2) Separate the objects entirely.  ICPs are entirely separate from
> > TIMAs, like wise ICSes and xive interrupt sources.
> >=20
> > I think this is probably the way to go.  To make this work with CAS
> > switching will require different methods, but I don't think it's
> > impossible.
> >
> > For example, we could (on the new machine type) create both xics ICSes
> > and ICPs and xive sources and TIMAs.  We'd have a (migrated) flag in
> > the machine saying which is currently active.  All the objects would
> > hang around, but only the active ones would do anything.
>=20
> ok. There is still the question of sharing the IRQ numbers unless we=20
> find away to allocate them after the CAS negotiation.=20

Right.  As I said, I think allocating after CAS is probably possible,
but it may not be necessary.

Merely lining up the irq numbers should be much simpler than actually
fusing the source and presenter structures.  Especially since both
xics and xive are flexible enough that we can map the irqs almost
however we want.

This definitely does mean the irq mapping / allocation should sit
inside the machine type, rather than the xics *or* the xive code, and
preferably be entirely common.  Then it's just a matter of setting up
both the xics and xive components so they can back that irq allocation.

> I will take a look at KVM support now before reworking the patchset.
>=20
> Thanks,
>=20
> C.
>=20
> > Now obviously that means we'd be migrating a bunch of redundant state,
> > but I still think it's preferable to a Frankenstinian fusion of
> > xics-ish and xive-ish state.  I think there's a good chance we can
> > improve on the basic idea to remove most or all of that redundant
> > state.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll3+BwACgkQbDjKyiDZ
s5IZiQ//WK+vMj8vjofcTNi5eXBevHHzkoEHpMTrzsMBYtSdakmLPv3/Yd4YvrCZ
eQJ1hHr9Nk5fUQiUsjM7zb6VXAO2lDZzAV637/wro1DNbZxn+nX5VEhM3/FV7Fr3
mUY/aH4R3HkdNdLQ/ka4Nq8kZ0+IJdNROsqMoJfNkL6cYvVrQ836lhffDzlaVXaH
3z8fseaYGBEMQJpHfBEHPZK8XQBn4WCajHkzI7DLmrP4riIiQfh54Ed8H+FS8CJE
CbpH/8n8WHNeZ4BGH3AJE5dMhFkNwl9nc3bwlObXdlCF5JXFxavaA+h6ih8DO+bk
iOjpWPLJ3KpIgPK6xbcbLwJc8ROJwI0XFA1JcoZIYWUnd0YEPWJqfVzv+ICmAsqR
ieG192REnewGGrZv0zbuld/+xYVP3sxXTjb1xDlhRW50RZU/1zDVfKeyACWS4lO6
1tUAfykT+vTy7tjktD7IzRempgQpF/sH+9uY2KdqUWDQXD+bVJV0/O/BU6ePVhN9
N9MoyX56SeiIhzcn4kCquQjDi3ovNVPDsQQmeGZCl/LUMIjB+icxgONo2128F+zp
nBTWcge4e1f091kzGVTaV8enW1lCvr5Qz0Ts+JVHHI5LwTTzIh4OLR7IkZ/6RVwO
7UtzJzUuYpklWSEaPh0P5aGLDdV5ESv/SfPUNu1x83NENXQUukk=
=/w21
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--
