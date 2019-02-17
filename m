Received: from eggs.gnu.org ([209.51.188.92]:52615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWiA-0008C7-Tz
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvWi9-0005dG-JT
	for qemu-devel@nongnu.org; Sun, 17 Feb 2019 19:23:06 -0500
Date: Mon, 18 Feb 2019 10:33:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190217233346.GD2765@umbus.fritz.box>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
	<155023080049.1011724.15423463482790260696.stgit@bahia.lan>
	<b25de46d-9449-4538-b2b5-dd18d373e6d9@kaod.org>
	<20190215140356.7919577c@bahia.lan>
	<bae9f493-b8db-d413-6ce6-b2a71356824a@kaod.org>
	<20190215142741.330f478b@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sXc4Kmr5FA7axrvy"
Content-Disposition: inline
In-Reply-To: <20190215142741.330f478b@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 03/10] xics: Handle KVM ICP realize from
 the common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--sXc4Kmr5FA7axrvy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 15, 2019 at 02:27:41PM +0100, Greg Kurz wrote:
> On Fri, 15 Feb 2019 14:09:53 +0100
> C=E9dric Le Goater <clg@kaod.org> wrote:
>=20
> > On 2/15/19 2:03 PM, Greg Kurz wrote:
> > > On Fri, 15 Feb 2019 13:54:02 +0100
> > > C=E9dric Le Goater <clg@kaod.org> wrote:
> > >  =20
> > >> On 2/15/19 12:40 PM, Greg Kurz wrote: =20
> > >>> The realization of KVM ICP currently follows the parent_realize log=
ic,
> > >>> which is a bit overkill here. Also we want to get rid of the KVM ICP
> > >>> class. Explicitely call icp_kvm_realize() from the base ICP realize
> > >>> function.
> > >>>
> > >>> Note that ICPStateClass::parent_realize is retained because powernv
> > >>> needs it.
> > >>>
> > >>> Signed-off-by: Greg Kurz <groug@kaod.org>>
> > >>> ---
> > >>>  hw/intc/xics.c        |    8 ++++++++
> > >>>  hw/intc/xics_kvm.c    |   10 +---------
> > >>>  include/hw/ppc/xics.h |    1 +
> > >>>  3 files changed, 10 insertions(+), 9 deletions(-)
> > >>>
> > >>> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> > >>> index 822d367e6388..acd63ab5e0b9 100644
> > >>> --- a/hw/intc/xics.c
> > >>> +++ b/hw/intc/xics.c
> > >>> @@ -349,6 +349,14 @@ static void icp_realize(DeviceState *dev, Erro=
r **errp)
> > >>>          return;
> > >>>      }
> > >>> =20
> > >>> +    if (kvm_irqchip_in_kernel()) {
> > >>> +        icp_kvm_realize(dev, &err);   =20
> > >>
> > >> While we are at changing things, I would prefix all the KVM=20
> > >> backends routine with kvmppc_*. so that icp_kvm_realize()=20
> > >> becomes kvmppc_icp_realize()
> > >> =20
> > >=20
> > > Well... kvmppc_* routines have historically been sitting under
> > > target/ppc so I'm not sure we want to use the same prefix
> > > elsewhere... =20
> >=20
> > Well, they could also be moved there but I think what is important=20
> > is that the kvmppc_* routine should be used under the kvm_enabled()=20
> > flag.=20
> >=20
> > Those under target/ppc have and extra dummy stub provided for the=20
> > !kvm_enabled() case.=20
> >=20
>=20
> Well, I don't really care but if we go this way (David?), I'd rather do it
> globally in a followup patch.

I concur.  I'm not all that fussed really, and I think it would be
done best as a followup.

>=20
> > C.
> >=20
> >=20
> >=20
> > >  =20
> > >> Apart from that,
> > >>
> > >> Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > >>
> > >> Thanks,
> > >>
> > >> C.
> > >>
> > >> =20
> > >>> +        if (err) {
> > >>> +            error_propagate(errp, err);
> > >>> +            return;
> > >>> +        }
> > >>> +    }
> > >>> +
> > >>>      qemu_register_reset(icp_reset_handler, dev);
> > >>>      vmstate_register(NULL, icp->cs->cpu_index, &vmstate_icp_server=
, icp);
> > >>>  }
> > >>> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> > >>> index 80321e9b75ab..4eebced516b6 100644
> > >>> --- a/hw/intc/xics_kvm.c
> > >>> +++ b/hw/intc/xics_kvm.c
> > >>> @@ -115,11 +115,9 @@ int icp_set_kvm_state(ICPState *icp)
> > >>>      return 0;
> > >>>  }
> > >>> =20
> > >>> -static void icp_kvm_realize(DeviceState *dev, Error **errp)
> > >>> +void icp_kvm_realize(DeviceState *dev, Error **errp)
> > >>>  {
> > >>>      ICPState *icp =3D ICP(dev);
> > >>> -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> > >>> -    Error *local_err =3D NULL;
> > >>>      CPUState *cs;
> > >>>      KVMEnabledICP *enabled_icp;
> > >>>      unsigned long vcpu_id;
> > >>> @@ -129,12 +127,6 @@ static void icp_kvm_realize(DeviceState *dev, =
Error **errp)
> > >>>          abort();
> > >>>      }
> > >>> =20
> > >>> -    icpc->parent_realize(dev, &local_err);
> > >>> -    if (local_err) {
> > >>> -        error_propagate(errp, local_err);
> > >>> -        return;
> > >>> -    }
> > >>> -
> > >>>      cs =3D icp->cs;
> > >>>      vcpu_id =3D kvm_arch_vcpu_id(cs);
> > >>> =20
> > >>> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > >>> index e33282a576d0..ab61dc24010a 100644
> > >>> --- a/include/hw/ppc/xics.h
> > >>> +++ b/include/hw/ppc/xics.h
> > >>> @@ -202,5 +202,6 @@ Object *icp_create(Object *cpu, const char *typ=
e, XICSFabric *xi,
> > >>>  void icp_get_kvm_state(ICPState *icp);
> > >>>  int icp_set_kvm_state(ICPState *icp);
> > >>>  void icp_synchronize_state(ICPState *icp);
> > >>> +void icp_kvm_realize(DeviceState *dev, Error **errp);
> > >>> =20
> > >>>  #endif /* XICS_H */
> > >>>    =20
> > >> =20
> > >  =20
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sXc4Kmr5FA7axrvy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxp71oACgkQbDjKyiDZ
s5K6RBAA3xSGatDT19KmI5Z4sqvOlfPvGqZq0ZZpFOnEFD3ckjL4mEn9PWSqqH+x
B9ju3aj/VKyEJ15Y00txMpFvwmDU+OQp4c7VUIDh1i8WQeLji7BX8n901yLs0Chy
um7YAR3n2xaB0CQfr+aSpKerfN1Z5icX6DplbiErmEQr5Jb1EXejB+8nrbbBZr5T
+uBEb2lnvxBOBo4EyTGdIjpkxcEi5R2YYiOFYNCbb+lFTFrvF1SYOOJH+cn3c9g/
rp+7rplZ3yr+2IMBghP6wFD/5NWJpdGQVjx/NTdTM2jlIg/blMYBWKIm7JMdDY1N
HQ2UD5zxBgSTrNksSrlqOVo5lRXTTI/Wq4yIaWf7AI5kqjN2cjQll+LR9gpvq28b
CJWVfP7cgobP5HOAjIzrXfQ05MdJtGNIOrGfCGa+YKo23kJ+oHYHLtGeSu5d1kV3
Yvhq7Acc3BlIB1QCrOqADDUMfUp1XgWr2lAwiaYtEBCWDmPUzPpDGJ7vW8Kx42ox
u1r8+MxSi9Og8R54nackRRbO1GSTO/z2pNaU67cIhP0OXofd79wCmvLRz0xPYRc6
d3wxGMqxtq9PpF/6TJxv1IaWBpHOX9AaHt6M/R7+eUOj1jdkUyKFcmSnNfRBp/uX
5KO0s4uuqMGKCT1OmfhaTTj4XUyAN5Lf5KK2uBABavNdOF7JtdI=
=jCe/
-----END PGP SIGNATURE-----

--sXc4Kmr5FA7axrvy--
