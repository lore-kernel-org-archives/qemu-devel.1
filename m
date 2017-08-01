Received: from eggs.gnu.org ([2001:4830:134:3::10]:43517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcVJz-0000lz-Jo
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dcVJw-0002D5-EP
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:26:43 -0400
Received: from 16.mo7.mail-out.ovh.net ([46.105.72.216]:55972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dcVJw-00027u-7o
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:26:40 -0400
Received: from player762.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 815D666BCF
	for <qemu-devel@nongnu.org>; Tue,  1 Aug 2017 13:26:30 +0200 (CEST)
Date: Tue, 1 Aug 2017 13:26:15 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170801132615.7f7664e4@bahia.lan>
In-Reply-To: <a9d88270-94ec-84a1-a664-4e6df3f2af31@ozlabs.ru>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100578691.27487.8944448515009831240.stgit@bahia>
	<20170728040257.GI3098@umbus.fritz.box>
	<c3750e7d-47af-4cd4-9121-73d8d8d0f81e@redhat.com>
	<20170731045821.GE2652@umbus.fritz.box>
	<a9d88270-94ec-84a1-a664-4e6df3f2af31@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/zL7XZb3rhz2AobMN3D5z8Fk";
	protocol="application/pgp-signature"
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
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

--Sig_/zL7XZb3rhz2AobMN3D5z8Fk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Aug 2017 12:20:56 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 31/07/17 14:58, David Gibson wrote:
> > On Fri, Jul 28, 2017 at 08:20:57AM +0200, Thomas Huth wrote: =20
> >> On 28.07.2017 06:02, David Gibson wrote: =20
> >>> On Tue, Jul 25, 2017 at 08:03:06PM +0200, Greg Kurz wrote: =20
> >>>> The "phandle" property of the XICS node is referenced by the "interr=
upt-map"
> >>>> property of each PHB node. This is used by the guest OS to setup IRQ=
s for
> >>>> all PCI devices.
> >>>>
> >>>> QEMU uses an arbitrary value (0x1111) for this phandle, but SLOF con=
verts
> >>>> this value to a SLOF specific one, which is then presented to the gu=
est OS.
> >>>>
> >>>> This patches introduces the new KVMPPC_H_UPDATE_PHANDLE hcall, which=
 is used
> >>>> by SLOF to communicate the patched phandle value back to QEMU. This =
value
> >>>> is then cached and preserved accross migration until machine reset.
> >>>>
> >>>> This is required to be able to support PHB hotplug.
> >>>>
> >>>> Note, that SLOF already has some code to call KVMPPC_H_RTAS_UPDATE, =
so we
> >>>> have to introduce its number even if QEMU currently doesn't implemen=
t it.
> >>>>
> >>>> Suggested-by: Thomas Huth <thuth@redhat.com>
> >>>> Signed-off-by: Greg Kurz <groug@kaod.org> =20
> >>>
> >>> Ugh.  I really, really hope we can avoid this, though I don't
> >>> immediately see how.  Having to have two way communication between
> >>> qemu and SLOF about the device tree contents just seems like opening
> >>> the door to endless complexities.
> >>>
> >>> This is basically a consequence of the fact that both qemu and partly
> >>> responsible for constructing the device tree for the guest, and that's
> >>> not easy to avoid.
> >>>
> >>> Hrm.. Thomas, I know it's not really the OF way, but would it be
> >>> feasible to change SLOF to use the phandles as supplied by qemu rather
> >>> than creating its own? =20
> >>
> >> I don't see a way to do this in an easy, clean, reasonable way. SLOF
> >> uses pointers to internal structures as phandles all over the place. Y=
ou
> >> likely can't replace that so easily without rewriting half of the whole
> >> device tree related code in SLOF, I guess... =20
> >=20
> > Dang, that's what I suspected.
> >=20
> > Just to be clear the phandles are used directly as raw pointers?
> > There's not even some lookup macro we could change?
> >  =20
>=20
> We would need to rewrite
> https://github.com/aik/SLOF/blob/master/slof/fs/node.fs
>=20
> Since SLOF does not seem to use phandles as pointers directly anywhere but
> in nofe.fs, this should be doable. Easier said than done though.
>=20

Yikes... If we go that way, I'll definitely need some assistance and time.

Cc'ing Nikunj for some extra advices.

Cheers,

--
Greg

--Sig_/zL7XZb3rhz2AobMN3D5z8Fk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmAZVcACgkQAvw66wEB28IyZgCfT3Cv+r+UoPJmlA1eGBBplEGW
xHcAoI/tGZFJ174TvhT645p6NoK5QPIe
=hgB1
-----END PGP SIGNATURE-----

--Sig_/zL7XZb3rhz2AobMN3D5z8Fk--
