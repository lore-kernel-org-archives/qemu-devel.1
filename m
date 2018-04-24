Received: from eggs.gnu.org ([2001:4830:134:3::10]:42766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAmha-00064K-HE
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 21:25:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fAmhX-0007QV-C2
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 21:25:02 -0400
Date: Tue, 24 Apr 2018 11:24:07 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180424012407.GL19804@umbus.fritz.box>
References: <20180419124331.3915-1-clg@kaod.org>
	<20180419124331.3915-2-clg@kaod.org>
	<20180420071042.GO2434@umbus.fritz.box>
	<d2a521aa-a574-0bf8-332d-9521f2f59895@kaod.org>
	<20180423035915.GE19804@umbus.fritz.box>
	<400c9fe1-e64a-2341-80a4-dee057fa2433@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DN8g+DOX2TxGxleI"
Content-Disposition: inline
In-Reply-To: <400c9fe1-e64a-2341-80a4-dee057fa2433@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v3 01/35] ppc/xive: introduce a XIVE
 interrupt source model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--DN8g+DOX2TxGxleI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 09:11:28AM +0200, C=E9dric Le Goater wrote:
> On 04/23/2018 05:59 AM, David Gibson wrote:
> > On Fri, Apr 20, 2018 at 10:27:21AM +0200, C=E9dric Le Goater wrote:
> >> On 04/20/2018 09:10 AM, David Gibson wrote:
> >>> On Thu, Apr 19, 2018 at 02:42:57PM +0200, C=E9dric Le Goater wrote:
> >>>> Each XIVE interrupt source is associated with a two bit state machine
> >>>> called an Event State Buffer (ESB) : the first bit "P" means that an
> >>>> interrupt is "pending" and waiting for an EOI and the bit "Q" (queue=
d)
> >>>> means a new interrupt was triggered while another was still pending.
> >>>>
> >>>> When an event is triggered, the associated interrupt state bits are
> >>>> fetched and modified and forwarded to the virtualization engine of t=
he
> >>>> controller doing the routing. These can also be controlled by MMIO, =
to
> >>>> trigger events or turn off the sources for instance. See code for mo=
re
> >>>> details on the states and transitions.
> >>>>
> >>>> On a sPAPR machine, the OS will obtain the address of the MMIO page =
of
> >>>> the ESB entry associated with a source and its characteristic using
> >>>> the H_INT_GET_SOURCE_INFO hcall. On PowerNV, a similar OPAL call is
> >>>> used.
> >>>>
> >>>> The xive_source_notify() routine is in charge forwarding the source
> >>>> event notification to the routing engine. It will be filled later on.
> >>>>
> >>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >>>> ---
> >>>>  Changes since v2:
> >>>>
> >>>>  - added support for Store EOI
> >>>>  - added support for two page MMIO setting like on KVM
> >>>
> >>> Looks generally sane to me, though I have a few queries.
[snip]
> >>>> + * The default XIVE interrupt source setting for ESB MMIO is two 64k
> >>>> + * pages without Store EOI. This is in sync with KVM.
> >>>> + */
> >>>> +static Property xive_source_properties[] =3D {
> >>>> +    DEFINE_PROP_UINT64("flags", XiveSource, esb_flags, 0),
> >>>> +    DEFINE_PROP_UINT32("nr-irqs", XiveSource, nr_irqs, 0),
> >>>> +    DEFINE_PROP_UINT64("bar", XiveSource, esb_base, 0),
> >>>
> >>> Isn't this redundant with however the base address is handled through
> >>> the SysBusDevice stuff (I forget the details)?
> >>
> >> Storing the ESB MMIO base address under the XiveSource object is=20
> >> convenient later on in the h_int_get_source_info hcall which make
> >> use of the helpers :=20
> >>
> >> 	hwaddr xive_source_esb_trigger(XiveSource *xsrc, uint32_t srcno)
> >> 	hwaddr xive_source_esb_mgmt(XiveSource *xsrc, int srcno)
> >>
> >> But it is only used in that place. So we could just store the ESB=20
> >> MMIO base address under the sPAPRXive controller. This makes some
> >> sense in the design, as we have to inform KVM of this address with
> >> a KVM device ioctl.
> >=20
> > Well.. I really dislike the idea that you could change the actual MMIO
> > mapping address in one place, but other bits of code would still think
> > it was mapped somewhere else.
>=20
> OK. I think that my last proposal of removing the ESB MMIO address=20
> from the source and letting the owning device, the sPAPR Xive controller=
=20
> in this case, but this is the same for PoweNV or PSI HB, handle the
> mapping goes in the direction you want to take ? =20
>=20
> It does looks better in the overall XIVE model and the XiveSource
> object have no need of this address.

Yes, I think that's the way to go.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--DN8g+DOX2TxGxleI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrehzUACgkQbDjKyiDZ
s5IQihAAgmHBjLm5eE+cDd137J/tLFFKqAhXtzIX7KHj5lUI7DfvN6xWEegvYqqQ
vAfCLEgMIggL57DjZ7ndDLrCbGRC5ocSWbiPBe9NQCkv2zn2gNa7LPhKQvFAYxrk
s1PYbH7na/ngSnh2Y0iD1ssPcx4c3iIBipH5bwz8W/328gawVe3WNxvfEcIFfFie
YxTEG67y/yw/E0fcllkKHAFwP9TQImo1hIxCdWVBthc4F50aGxmEfrI+NbDR0TMA
omgp9xCGIvYHf+s6VyEsRvOm59/7NUE3lKxqer/nthmponVSL00+91OVyfuf96lc
jrAY6tFsEDy5RaDO+JS1S+GbUhOmfjIv35zqazdbF9kYIZtlsCSsOs54wk8AT1v4
UnN+CN1jhoOfdXnsDWIwn6GeABr8Fu0IQ9BI5f7FZZWoO5M7r5HBKVRGLdd9t2bN
/W16FI1OWUX6VLpK8cUm7tYEoZ/27xQ/lC0Rs4U9Fe5vxpLwbHl8STGtIO5KStbq
BkikgpeKvqZ39L5p4MbTpMpTXPtzGYYSAU5Bg4IXvYOHYElgjbULd1wF2RGQecHM
tJFEwOlRwtJVYcvJM4WiDs/RBvkBp2DI00gQ75hbnArdKtA63R/odu2fiqKty5qn
NZKIShh7C+58MDoxAywKxZ32E3Rs1oViFLwUiFlPx7+uIJkXKPY=
=nTfC
-----END PGP SIGNATURE-----

--DN8g+DOX2TxGxleI--
