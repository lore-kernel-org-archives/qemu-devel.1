Received: from eggs.gnu.org ([2001:4830:134:3::10]:43095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drPAV-0004Cy-Uf
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1drPAR-0004Dr-UH
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:54:32 -0400
Received: from 16.mo1.mail-out.ovh.net ([178.33.104.224]:38209)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1drPAR-0004Cz-NJ
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 09:54:27 -0400
Received: from player169.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id CA3C39359C
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 15:54:25 +0200 (CEST)
Date: Mon, 11 Sep 2017 15:54:16 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170911155416.0e4596b8@bahia.lan>
In-Reply-To: <20170911125045.GD2784@umbus.fritz.box>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
	<150456162500.17000.8195671755736683016.stgit@bahia.lan>
	<20170910034141.GC2735@umbus.fritz.box>
	<20170911140437.1124ddfe@bahia.lan>
	<20170911125045.GD2784@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/NXmNHS6lA5gKBdnCL5.oeKc";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/4] spapr: introduce a helper
 to compute the address of the HPT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

--Sig_/NXmNHS6lA5gKBdnCL5.oeKc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Sep 2017 22:50:45 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Sep 11, 2017 at 02:04:37PM +0200, Greg Kurz wrote:
> > On Sun, 10 Sep 2017 13:41:41 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Mon, Sep 04, 2017 at 11:47:05PM +0200, Greg Kurz wrote: =20
> > > > The formula used to compute the address of the HPT allocated by QEM=
U is
> > > > open-coded in several places. This patch moves the magic to a dedic=
ated
> > > > helper. While here, we also patch the callers to only pass the addr=
ess
> > > > to KVM if we indeed have a userland HPT (ie, KVM PR).   =20
> > >=20
> > > The helper function seems reasonable, though I'm not sure about the
> > > name (a. it's not just a pointer, since it includes the encoded size
> > > and b. the name doesn't indicate this is basically KVM PR specific).
> > >  =20
> >=20
> > Sure, I'll come up with a better name.
> >  =20
> > > THe "only pass the address to KVM if we indeed have a userland HPT
> > > (ie, KVM PR)" bit doesn't really work.  You're doing it by testing for
> > > (sdr1 !=3D 0), but that can only be true if the HPT is minimum size,
> > > which doesn't have much to do with anything meaningful.
> > >  =20
> >=20
> > Hmmm... if QEMU has allocated an HPT in userspace then the helper
> > necessarily returns a non-null value, no matter the HPT size. Am
> > I missing something ? =20
>=20
> Yes, but the reverse is not true.  Even if qemu *hasn't* allocated an
> HPT in userspace, it will usually return a non-zero value - the only
> case it won't is when the HPT is minimum size.  That makes the test
> pretty pointless.
>=20

The helper does return 0 if QEMU hasn't allocated an HPT in userspace.

[...]
> > > > +target_ulong spapr_get_hpt_pointer(sPAPRMachineState *spapr)
> > > > +{
> > > > +    if (!spapr->htab) {
> > > > +        return 0;
> > > > +    }
> > > > +
> > > > +    return (target_ulong)(uintptr_t)spapr->htab | (spapr->htab_shi=
ft - 18);
> > > > +}
> > > > +

but I agree the patch isn't good... for the comprehension at least. I'll
rework the patchset.

Also this causes a behavior change: we won't update SDR1 anymore with KVM H=
V,
which already handles it BTW.

void kvmppc_set_hpt(struct kvm *kvm, struct kvm_hpt_info *info)
{
	atomic64_set(&kvm->arch.mmio_update, 0);
	kvm->arch.hpt =3D *info;
	kvm->arch.sdr1 =3D __pa(info->virt) | (info->order - 18);

Maybe I should push this behavior change to a separate patch anyway...

--Sig_/NXmNHS6lA5gKBdnCL5.oeKc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQQr1DtEU17Ap5iU26IC/DrrAQHbwgUCWbaViAAKCRAC/DrrAQHb
woudAKCVaegXHTnxSshYvtA/wWkelNJniQCgoGmZus7d6EdEB2pitqmOpqN6z40=
=HasG
-----END PGP SIGNATURE-----

--Sig_/NXmNHS6lA5gKBdnCL5.oeKc--
