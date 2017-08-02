Received: from eggs.gnu.org ([2001:4830:134:3::10]:40943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcjZF-0004jA-4x
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:39:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dcjZD-0005lS-O9
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 22:39:25 -0400
Date: Wed, 2 Aug 2017 12:35:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170802023531.GC2838@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
	<20170728040257.GI3098@umbus.fritz.box>
	<c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
	<20170731045821.GE2652@umbus.fritz.box>
	<a9d88270-94ec-84a1-a664-4e6df3f2af31@ozlabs.ru>
	<20170801132615.7f7664e4@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
Content-Disposition: inline
In-Reply-To: <20170801132615.7f7664e4@bahia.lan>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 24/26] spapr: allow guest to
 update the XICS phandle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 01:26:15PM +0200, Greg Kurz wrote:
> On Tue, 1 Aug 2017 12:20:56 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On 31/07/17 14:58, David Gibson wrote:
> > > On Fri, Jul 28, 2017 at 08:20:57AM +0200, Thomas Huth wrote: =20
> > >> On 28.07.2017 06:02, David Gibson wrote: =20
> > >>> On Tue, Jul 25, 2017 at 08:03:06PM +0200, Greg Kurz wrote: =20
> > >>>> The "phandle" property of the XICS node is referenced by the "inte=
rrupt-map"
> > >>>> property of each PHB node. This is used by the guest OS to setup I=
RQs for
> > >>>> all PCI devices.
> > >>>>
> > >>>> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF c=
onverts
> > >>>> this value to a SLOF specific one, which is then presented to the =
guest OS.
> > >>>>
> > >>>> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, whi=
ch is used
> > >>>> by SLOF to communicate the patched phandle value back to QEMU. Thi=
s value
> > >>>> is then cached and preserved accross migration until machine reset.
> > >>>>
> > >>>> This is required to be able to support PHB hotplug.
> > >>>>
> > >>>> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE=
, so we
> > >>>> have to introduce its number even if QEMU currently doesn't implem=
ent it.
> > >>>>
> > >>>> Suggested-by: Thomas Huth <thuth@redhat.com>
> > >>>> Signed-off-by: Greg Kurz <groug@kaod.org> =20
> > >>>
> > >>> Ugh.  I really, really hope we can avoid this, though I don't
> > >>> immediately see how.  Having to have two way communication between
> > >>> qemu and SLOF about the device tree contents just seems like opening
> > >>> the door to endless complexities.
> > >>>
> > >>> This is basically a consequence of the fact that both qemu and part=
ly
> > >>> responsible for constructing the device tree for the guest, and tha=
t's
> > >>> not easy to avoid.
> > >>>
> > >>> Hrm.. Thomas, I know it's not really the OF way, but would it be
> > >>> feasible to change SLOF to use the phandles as supplied by qemu rat=
her
> > >>> than creating its own? =20
> > >>
> > >> I don't see a way to do this in an easy, clean, reasonable way. SLOF
> > >> uses pointers to internal structures as phandles all over the place.=
 You
> > >> likely can't replace that so easily without rewriting half of the wh=
ole
> > >> device tree related code in SLOF, I guess... =20
> > >=20
> > > Dang, that's what I suspected.
> > >=20
> > > Just to be clear the phandles are used directly as raw pointers?
> > > There's not even some lookup macro we could change?
> > >  =20
> >=20
> > We would need to rewrite
> > https://github.com/aik/SLOF/blob/master/slof/fs/node.fs
> >=20
> > Since SLOF does not seem to use phandles as pointers directly anywhere =
but
> > in nofe.fs, this should be doable. Easier said than done though.
> >=20
>=20
> Yikes... If we go that way, I'll definitely need some assistance and time.
>=20
> Cc'ing Nikunj for some extra advices.

Yeah, I hope we could get a feasibility idea from someone who knows
Forth - Thomas or Nikunj, maybe.

I'd be thinking of replacing the direct pointer dereferences for
phandles with a simple lookup table of phandle to pointer, populated
as we unflatten the tree.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmBOnIACgkQbDjKyiDZ
s5K97xAAuf1EplGCtCRkkirJzEi89SOBd0UilOznB94H10r9mVhdWvFmFnlAOz9J
n5VP5iFX+lEjINc4pMhYF1XI54AWlp+OI+7JjGMNfi5nKsIbiiwtLHL7Y7NEBROf
rDnNYkL9l8OS0VMn0JAGo4B49KsWraZek25VLoOjHy+3KnKmd3rDTt9j4663gUxh
W5rEnNPzuIfrMlda76s2j3heW4gxWLXq4mbBDLArCVmh78tl9ly87vtMTt8nN/DV
ovzXjN2w68QcAff1GHIzBHhJygqF9Z8hSI1hkQ6E7jHqxHz3OMmn8txl+YkgumYe
5F1zGcmSdVcSsTs02BBfpGL8tk7gbNipE0tmzpqTea1mco4t27erkSiQnvSI6VxQ
PkF5JHQ+2XCPEE0eZVNM5JBFKwuR5/s0BCs5TQepqf8hnnHZwf+4pJd6meAdd8Bm
WhK014vKiwGnNYOF173zkbDi0UkR9gqYrR2XImOQ7ryxtwCQt5kIUnc+uQUo5Cmb
Hvxggrk/zYJTzrQlDF15ny3eOAwdK49tWAd7XfIHk2Clh/nQFFmi1LSLvmHQ8orr
ZoMBUMCnYnDA+fbXLu4nAshOQnDRMQxG6Ie/WijDtkWoLyDr7/G+2W7sDUJ7MYGK
NzvrWBaXp3cLcnVXvqUD73aUJLR9xXfxUDeJgzMS6GG1giMRazY=
=MrsJ
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
