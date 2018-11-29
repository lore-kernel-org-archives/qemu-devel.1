Received: from eggs.gnu.org ([2001:4830:134:3::10]:52955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVAB-0007xW-1R
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gSVA9-0007zs-Dg
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 17:52:02 -0500
Date: Fri, 30 Nov 2018 09:43:49 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181129224349.GA30479@umbus.fritz.box>
References: <20181116105729.23240-1-clg@kaod.org>
	<20181116105729.23240-29-clg@kaod.org>
	<20181129040806.GE14697@umbus.fritz.box>
	<59605f25-7208-1b57-874b-282c39120b18@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
In-Reply-To: <59605f25-7208-1b57-874b-282c39120b18@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v5 28/36] ppc/xics: introduce a
 icp_kvm_init() routine
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


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 29, 2018 at 05:36:19PM +0100, C=E9dric Le Goater wrote:
> On 11/29/18 5:08 AM, David Gibson wrote:
> > On Fri, Nov 16, 2018 at 11:57:21AM +0100, C=E9dric Le Goater wrote:
> >> This routine gathers all the KVM initialization of the XICS KVM
> >> presenter. It will be useful when the initialization of the KVM XICS
> >> device is moved to a global routine.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > I dislike calling things *_init() because it's not clear which of
> > qemu's many "init" hooks it belongs with.
>=20
> we could use 'icp_kvm_connect' instead. Which was QEMU is doing,=20
> connecting a QEMU model to a KVM one.

Works for me.

>=20
> C.
>=20
> =20
> >> ---
> >>  hw/intc/xics_kvm.c | 29 +++++++++++++++++++----------
> >>  1 file changed, 19 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> >> index e8fa9a53aeba..efad1b19d821 100644
> >> --- a/hw/intc/xics_kvm.c
> >> +++ b/hw/intc/xics_kvm.c
> >> @@ -123,11 +123,8 @@ static void icp_kvm_reset(DeviceState *dev)
> >>      icp_set_kvm_state(ICP(dev), 1);
> >>  }
> >> =20
> >> -static void icp_kvm_realize(DeviceState *dev, Error **errp)
> >> +static void icp_kvm_init(ICPState *icp, Error **errp)
> >>  {
> >> -    ICPState *icp =3D ICP(dev);
> >> -    ICPStateClass *icpc =3D ICP_GET_CLASS(icp);
> >> -    Error *local_err =3D NULL;
> >>      CPUState *cs;
> >>      KVMEnabledICP *enabled_icp;
> >>      unsigned long vcpu_id;
> >> @@ -137,12 +134,6 @@ static void icp_kvm_realize(DeviceState *dev, Err=
or **errp)
> >>          abort();
> >>      }
> >> =20
> >> -    icpc->parent_realize(dev, &local_err);
> >> -    if (local_err) {
> >> -        error_propagate(errp, local_err);
> >> -        return;
> >> -    }
> >> -
> >>      cs =3D icp->cs;
> >>      vcpu_id =3D kvm_arch_vcpu_id(cs);
> >> =20
> >> @@ -168,6 +159,24 @@ static void icp_kvm_realize(DeviceState *dev, Err=
or **errp)
> >>      QLIST_INSERT_HEAD(&kvm_enabled_icps, enabled_icp, node);
> >>  }
> >> =20
> >> +static void icp_kvm_realize(DeviceState *dev, Error **errp)
> >> +{
> >> +    ICPStateClass *icpc =3D ICP_GET_CLASS(dev);
> >> +    Error *local_err =3D NULL;
> >> +
> >> +    icpc->parent_realize(dev, &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +
> >> +    icp_kvm_init(ICP(dev), &local_err);
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +        return;
> >> +    }
> >> +}
> >> +
> >>  static void icp_kvm_class_init(ObjectClass *klass, void *data)
> >>  {
> >>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwAa6UACgkQbDjKyiDZ
s5IBWg//YOwi1YdpqkEFiMpsGojQuF/tmLgyJQJXWiabJeUhV+jVRRpsyV9AT14t
1vY0KR9FnhwFNfp3wraA7hnyw6U9RcD4OWfXpmKWmud/OhY1fZCNM82F8OcvV4UO
FOg4Yvee+UvoaierrFFyBQB9HG2MzLdxZnPdX0vaLwkeo8mwneD+0Gm7fr1qahbf
Rm1LT0BaouOqU1RK25yKirugi+oh2NNwG5pNNxWtW7RnYpXC+HzCoNmwarYeWZ0F
A/dIoOe/eXEaeqhTVPCFf1C/TMEhH5lPyvVKerrp6JT42Qqu29dDyLvPrrInVipC
Yi1c218SncAnGiwEVZvIepMkOO8nl1jvn1TkGgohqZbCe32WHx27AcN53WvpwaTu
KBN5mWx/O9Xt/IMrqBCQwjekyPnrShtbpqCj5rJUP7LBduBPWJorkvqSF3b+QGTA
Uqu3hF2lcG3pQoIbfsB+dELJTzWV2nc1Y18Hyx5jQ4DKevTP+FytrkFC8T1ITUMl
0VPSvi6RfcwEtdOu7t0Xg8eNhq/igmg+/eXIrOrZsZFSmYjAYo/e0GbTmoK3fNba
NqbY4pi5T8DV1C7VxW6KZfnbtIDU+MRyTe2TectCA0Z86P5TzMqSJchKwbqlpbbt
tODq5sFPkfl+s7sgC1/D27GBVdhsTAdUiF9oPUeuq/ZJc8dgNFc=
=707s
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
