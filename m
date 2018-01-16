Received: from eggs.gnu.org ([2001:4830:134:3::10]:57556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebSOu-00049K-JS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ebSOr-0007QR-QL
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:39:44 -0500
Received: from 11.mo5.mail-out.ovh.net ([46.105.47.167]:34217)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ebSOr-0007Po-H4
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:39:41 -0500
Received: from player695.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 9DC2417DF5B
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 15:39:39 +0100 (CET)
Date: Tue, 16 Jan 2018 15:39:30 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180116153930.7ffa14a9@bahia.lan>
In-Reply-To: <20180116122432.GJ30352@umbus.fritz.box>
References: <20180116044714.12571-1-david@gibson.dropbear.id.au>
	<20180116044714.12571-2-david@gibson.dropbear.id.au>
	<20180116102018.382fd035@bahia.lan>
	<20180116122432.GJ30352@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/K.x+AsVlr6goTAmBIICk2+T";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCHv2 1/2] spapr: Allow some cases where we
 can't set VSMT mode in the kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, surajjs@au1.ibm.com, sam.bobroff@au1.ibm.com, lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

--Sig_/K.x+AsVlr6goTAmBIICk2+T
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 16 Jan 2018 23:24:32 +1100
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Tue, Jan 16, 2018 at 10:20:18AM +0100, Greg Kurz wrote:
> > On Tue, 16 Jan 2018 15:47:13 +1100
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > At present if we require a vsmt mode that's not equal to the kernel's
> > > default, and the kernel doesn't let us change it (e.g. because it's a=
n old
> > > kernel without support) then we always fail.
> > >=20
> > > But in fact we can cope with the kernel having a different vsmt as lo=
ng as
> > >   a) it's >=3D the actual number of vthreads/vcore (so that guest thr=
eads
> > >      that are supposed to be on the same core act like it)
> > >   b) it's a submultiple of the requested vsmt mode (so that guest thr=
eads
> > >      spaced by the vsmt value will act like they're on different core=
s)
> > >=20
> > > Allowing this case gives us a bit more freedom to adjust the vsmt beh=
aviour
> > > without breaking existing cases.
> > >=20
> > > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > > --- =20
> >=20
> > I could check the following on a POWER9 host:
> >=20
> > $ ./ppc64-softmmu/qemu-system-ppc64 -accel kvm -smp threads=3D1
> > qemu-system-ppc64: warning: Failed to set KVM's VSMT mode to 8 (errno -=
22)
> >=20
> > and the guest boots.
> >=20
> > $ ./ppc64-softmmu/qemu-system-ppc64 -accel kvm -smp threads=3D2
> > qemu-system-ppc64: Failed to set KVM's VSMT mode to 8 (errno -22)
> > On PPC, a VM with 2 threads/core on a host with 1 threads/core requires=
 the
> >  use of VSMT mode 8.
> > This KVM seems to be too old to support VSMT.
> >=20
> > and QEMU exits. =20
>=20
> I assume the above is with an old kernel that doesn't have the ability
> to set the SMT cap?
>=20

Yes this was tested with a 4.11 kernel (setting of SMT came with 4.12).

> >=20
> > Tested-by: Greg Kurz <groug@kaod.org>
> >=20
> > Just one minor remark below but anyway:
> >=20
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> >  =20
> > >  hw/ppc/spapr.c | 26 +++++++++++++++++++-------
> > >  1 file changed, 19 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > > index e35214bfc3..6d3613d934 100644
> > > --- a/hw/ppc/spapr.c
> > > +++ b/hw/ppc/spapr.c
> > > @@ -2314,17 +2314,29 @@ static void spapr_set_vsmt_mode(sPAPRMachineS=
tate *spapr, Error **errp)
> > >      if (kvm_enabled() && (spapr->vsmt !=3D kvm_smt)) {
> > >          ret =3D kvmppc_set_smt_threads(spapr->vsmt);
> > >          if (ret) {
> > > +            /* Looks like KVM isn't able to change VSMT mode */
> > >              error_setg(&local_err,
> > >                         "Failed to set KVM's VSMT mode to %d (errno %=
d)",
> > >                         spapr->vsmt, ret);
> > > -            if (!vsmt_user) {
> > > -                error_append_hint(&local_err, "On PPC, a VM with %d =
threads/"
> > > -                             "core on a host with %d threads/core re=
quires "
> > > -                             " the use of VSMT mode %d.\n",
> > > -                             smp_threads, kvm_smt, spapr->vsmt);
> > > +            /* We can live with that if the default one is big enough
> > > +             * for the number of threads, and a submultiple of the o=
ne
> > > +             * we want.  In this case we'll waste some vcpu ids, but
> > > +             * behaviour will be correct */
> > > +            if ((kvm_smt >=3D smp_threads) && (spapr->vsmt % kvm_smt=
) =3D=3D 0) { =20
> >=20
> > Inconsistent use of parens in the left and right operands of &&
> >  =20
> > > +                warn_report_err(local_err);
> > > +                local_err =3D NULL;
> > > +                goto out;
> > > +            } else {
> > > +                if (!vsmt_user) {
> > > +                    error_append_hint(&local_err,
> > > +                                      "On PPC, a VM with %d threads/=
core"
> > > +                                      " on a host with %d threads/co=
re"
> > > +                                      " requires the use of VSMT mod=
e %d.\n",
> > > +                                      smp_threads, kvm_smt, spapr->v=
smt);
> > > +                }
> > > +                kvmppc_hint_smt_possible(&local_err);
> > > +                goto out;
> > >              }
> > > -            kvmppc_hint_smt_possible(&local_err);
> > > -            goto out;
> > >          }
> > >      }
> > >      /* else TCG: nothing to do currently */ =20
> >  =20
>=20


--Sig_/K.x+AsVlr6goTAmBIICk2+T
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlpeDqIACgkQcdTV5YIv
c9Y1mA/+NH/ff0OuBpsUYnNBxlKxl+kBWwx8e99+MgCFZUs/ia5J/WVz8ssIsKqN
XLCoxfSZvpV3GBoSdf9cPxKpp9Pwh7PhEeGxKSAAlhkADAifVrD8WRBmoYUmgiDa
2lxcoUTTiT36GggFk4O31Wm25yVmBkr+O2rnn1pdnFDzO55+ZQTyg0S4G5fmA0UL
bOm1cnmlwKBu/UaJ//IYCaY5wbKw6YEXz0h3N0UH2J28HlICGnSloXiUIEncIlyZ
1Ezgf/AABaaCcovlirPolKYs6scRqFLfuNx5IzKAA8fbYSD54OEu0BwxdoVf9fUe
u9D9mIjmkNqgfF6Qt60vSdch4c/IlVyrGomxK8mvjaEMNmTv0UrJqhxD/oA/WyDX
/ge1utVEPZfp82x8E/EcincURrHGlbmbsGGOnNBB1krNFThr0FWKNx7dYkasa7OK
cYQFrJQ99cNKXIsUeoKK4kzUxOBNu9O+byCOzByVU/Sj/m0W/2NQBzJjbXTS/zGS
Ej1mr/uOmQanhY/9tjnCcDHRv1+0J9YlH/Nm4ufR3zCX355kZhOWFw+D4PiicpsT
eokmh74GXVBs7SipIvq2M7/Jcu+hOZ9Ne6MTNZJYIQPdyMIfPq+kk+B9xrQ8Cdj9
t/VNZfJi82gkoiaY3At0aMqXD96n7ZDnpylCLhtC6EY54C82AUM=
=vKfu
-----END PGP SIGNATURE-----

--Sig_/K.x+AsVlr6goTAmBIICk2+T--
