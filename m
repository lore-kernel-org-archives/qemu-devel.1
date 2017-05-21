Received: from eggs.gnu.org ([2001:4830:134:3::10]:40617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dCUGj-00058h-Lu
	for qemu-devel@nongnu.org; Sun, 21 May 2017 13:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dCUGg-0002Ev-H5
	for qemu-devel@nongnu.org; Sun, 21 May 2017 13:03:49 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:48198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dCUGg-0002EN-9v
	for qemu-devel@nongnu.org; Sun, 21 May 2017 13:03:46 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id D30FD3D679
	for <qemu-devel@nongnu.org>; Sun, 21 May 2017 19:03:42 +0200 (CEST)
Date: Sun, 21 May 2017 19:03:33 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170521190333.49404422@bahia.lan>
In-Reply-To: <20170520064509.GD30246@umbus.fritz.box>
References: <149518991537.24289.6673616934370284758.stgit@bahia.lan>
	<149518993198.24289.7946457258780782948.stgit@bahia.lan>
	<20170520064509.GD30246@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/eZeo3aoAPxjrcmH9A=zA.Mt";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 2/4] spapr: fix error reporting in
 xics_system_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Cedric Le Goater <clg@kaod.org>

--Sig_/eZeo3aoAPxjrcmH9A=zA.Mt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 20 May 2017 16:45:09 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Fri, May 19, 2017 at 12:32:12PM +0200, Greg Kurz wrote:
> > If the user explicitely asked for kernel-irqchip support and "xics-kvm"
> > initialization fails, we shouldn't fallback to emulated "xics" as we
> > do now. It is also awkward to print an error message when we have an
> > errp pointer argument.
> >=20
> > Let's use the errp argument to report the error and let the caller deci=
de.
> > This simplifies the code as we don't need a local Error * here.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
> Concept looks good, but..
>=20
> > ---
> > v2: - total rewrite
> > ---
> >  hw/ppc/spapr.c |   13 ++++++-------
> >  1 file changed, 6 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 91f7434861a8..75e298b4c6be 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -128,18 +128,14 @@ static void xics_system_init(MachineState *machin=
e, int nr_irqs, Error **errp)
> >      sPAPRMachineState *spapr =3D SPAPR_MACHINE(machine);
> > =20
> >      if (kvm_enabled()) {
> > -        Error *err =3D NULL;
> > -
> >          if (machine_kernel_irqchip_allowed(machine) &&
> >              !xics_kvm_init(spapr, errp)) {
> >              spapr->icp_type =3D TYPE_KVM_ICP;
> > -            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_ir=
qs, &err);
> > +            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_ir=
qs, errp); =20
>=20
> I believe there are reasons you're not supposed to just pass an errp
> through to a subordinate function.  Instead you're supposed to have a
> local Error * and use error_propagate().
>=20

You only need to have a local Error * if it is used to check the return sta=
tus
of the function (ie, you cannot check *errp because errp could be NULL) as
described in error.h. This isn't the case here but...

> >          }
> >          if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
> > -            error_reportf_err(err,
> > -                              "kernel_irqchip requested but unavailabl=
e: ");
> > -        } else {
> > -            error_free(err);
> > +            error_prepend(errp, "kernel_irqchip requested but unavaila=
ble: ");
> > +            return;
> >          }
> >      }
> > =20
> > @@ -147,6 +143,9 @@ static void xics_system_init(MachineState *machine,=
 int nr_irqs, Error **errp)
> >          xics_spapr_init(spapr);
> >          spapr->icp_type =3D TYPE_ICP;
> >          spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irq=
s, errp);
> > +        if (!spapr->ics) { =20
>=20
> It would also be more standard to check the returned error, rather
> than the other result.
>=20

... if you prefer to use a local Error *, I'll gladly do that. :)

> > +            return;
> > +        }
> >      }
> >  }
> > =20
> >  =20
>=20


--Sig_/eZeo3aoAPxjrcmH9A=zA.Mt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkhyGUACgkQAvw66wEB28JgaQCgny6X2ynFyOzYJWqvYxRNZ89V
dssAoISoGWtxi0pHKZDCMaGZ1ifB4kkI
=lBAT
-----END PGP SIGNATURE-----

--Sig_/eZeo3aoAPxjrcmH9A=zA.Mt--
