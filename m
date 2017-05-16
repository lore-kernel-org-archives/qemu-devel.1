Received: from eggs.gnu.org ([2001:4830:134:3::10]:33342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVsi-0005Vl-Ra
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:22:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAVsf-0006Ou-OX
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:22:52 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:49655)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAVsf-0006Oc-IQ
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:22:49 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id A2F291DC31
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 08:22:47 +0200 (CEST)
Date: Tue, 16 May 2017 08:22:40 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170516082240.4465933d@bahia>
In-Reply-To: <20170516060846.GK30022@umbus.fritz.box>
References: <149484833874.20089.4164801378197848306.stgit@bahia.lan>
	<149484836649.20089.8174753739169885859.stgit@bahia.lan>
	<20170516043555.GE30022@umbus.fritz.box>
	<20170516075605.69ba2b95@bahia>
	<20170516060846.GK30022@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/A5AihXlKKuNQxbWcHT=q5f0";
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

--Sig_/A5AihXlKKuNQxbWcHT=q5f0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 May 2017 16:08:46 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, May 16, 2017 at 07:56:05AM +0200, Greg Kurz wrote:
> > On Tue, 16 May 2017 14:35:55 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Mon, May 15, 2017 at 01:39:26PM +0200, Greg Kurz wrote: =20
> > > > QEMU should exit if the user explicitely asked for kernel-irqchip s=
upport
> > > > and "xics-kvm" initialization fails.
> > > >=20
> > > > The changelog of commit 34f2af3d3edf ("spapr: Clean up misuse of qd=
ev_init()
> > > > in xics-kvm creation") reads:
> > > >=20
> > > >     While there, improve the error message when we can't satisfy an
> > > >     explicit user request for "xics-kvm", and exit(1) instead of ab=
ort().
> > > >     Simplify the abort when we can't create "xics".
> > > >=20
> > > > This patch adds the missing call to exit().
> > > >=20
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/ppc/spapr.c |    1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > > index abfb99b71b7d..f477d7b8a210 100644
> > > > --- a/hw/ppc/spapr.c
> > > > +++ b/hw/ppc/spapr.c
> > > > @@ -133,6 +133,7 @@ static void xics_system_init(MachineState *mach=
ine, int nr_irqs, Error **errp)
> > > >          if (machine_kernel_irqchip_required(machine) && !spapr->ic=
s) {
> > > >              error_reportf_err(err,
> > > >                                "kernel_irqchip requested but unavai=
lable: ");
> > > > +            exit(EXIT_FAILURE);
> > > >          } else {
> > > >              error_free(err);
> > > >          }
> > > >    =20
> > >=20
> > >=20
> > > This doesn't look right.  We have an errp pointer in the caller.  So
> > > on failure we should error_propagate(), rather than deciding for
> > > ourselves that exiting is the right course of action.
> > >  =20
> >=20
> > I generally agree with that but can the caller cope with the fact that
> > the user passed -machine accel=3Dkvm,kernel_irqchip=3Don and this cannot
> > be satisfied ? =20
>=20
> AFAICT the only caller passes &error_fatal, so, yes..
>=20

Ok, then I'll rewrite xics_system_init() so that it propagates the error
message instead of printing it to the monitor.

--Sig_/A5AihXlKKuNQxbWcHT=q5f0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkamrAACgkQAvw66wEB28LrSACdEI2lDaKqRLINlVT2dEINyCGN
5oUAoI8YLSETjCrvrd5pAylJWLKqXofJ
=S/HI
-----END PGP SIGNATURE-----

--Sig_/A5AihXlKKuNQxbWcHT=q5f0--
