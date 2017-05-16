Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVT1-0001h4-GZ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:56:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVSy-00057h-Dg
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:56:19 -0400
Received: from 9.mo69.mail-out.ovh.net ([46.105.56.78]:43011)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAVSy-000577-89
	for qemu-devel@nongnu.org; Tue, 16 May 2017 01:56:16 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 36B111F97E
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:56:14 +0200 (CEST)
Date: Tue, 16 May 2017 07:56:05 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170516075605.69ba2b95@bahia>
In-Reply-To: <20170516043555.GE30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484836649.20089.8174753739169885859.stgit@bahia.lan>
	<20170516043555.GE30022@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/aefDyXvard1fOZidPF8hnjG";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 2/6] spapr: fix error path of required
 kernel-irqchip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>

--Sig_/aefDyXvard1fOZidPF8hnjG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 May 2017 14:35:55 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, May 15, 2017 at 01:39:26PM +0200, Greg Kurz wrote:
> > QEMU should exit if the user explicitely asked for kernel-irqchip suppo=
rt
> > and "xics-kvm" initialization fails.
> >=20
> > The changelog of commit 34f2af3d3edf ("spapr: Clean up misuse of qdev_i=
nit()
> > in xics-kvm creation") reads:
> >=20
> >     While there, improve the error message when we can't satisfy an
> >     explicit user request for "xics-kvm", and exit(1) instead of abort(=
).
> >     Simplify the abort when we can't create "xics".
> >=20
> > This patch adds the missing call to exit().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/spapr.c |    1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index abfb99b71b7d..f477d7b8a210 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -133,6 +133,7 @@ static void xics_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
> >          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> >              error_reportf_err(err,
> >                                "kernel_irqchip requested but unavailabl=
e: ");
> > +            exit(EXIT_FAILURE);
> >          } else {
> >              error_free(err);
> >          }
> >  =20
>=20
>=20
> This doesn't look right.  We have an errp pointer in the caller.  So
> on failure we should error_propagate(), rather than deciding for
> ourselves that exiting is the right course of action.
>=20

I generally agree with that but can the caller cope with the fact that
the user passed -machine accel=3Dkvm,kernel_irqchip=3Don and this cannot
be satisfied ?

--Sig_/aefDyXvard1fOZidPF8hnjG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkalHUACgkQAvw66wEB28LDSwCgp3XppGjeYhWjESAlodE06TYP
2vYAnjAkTIyvHmx8MLtrRmlGxCTxEZn1
=PVu1
-----END PGP SIGNATURE-----

--Sig_/aefDyXvard1fOZidPF8hnjG--
