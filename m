Received: from eggs.gnu.org ([2001:4830:134:3::10]:40631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkf-0003x5-Te
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkd-0005Mn-V3
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:29 -0500
Date: Thu, 23 Feb 2017 13:42:38 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223024238.GB12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-17-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="03sphU6jKm9HdgU1"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-17-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 16/22] ppc/xics: register the reset
 handler of ICP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--03sphU6jKm9HdgU1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:39PM +0100, C=E9dric Le Goater wrote:
> The reset of the ICP objects is currently handled by XICS but this can
> be done for each individual ICP.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Hrm.  I think whether device_reset() gets called automatically depends
on how the device is wired into the composition tree, and I'm not sure
the icps are in the right place for it to work.

This doesn't replace the code in xics_common_reset() so if it does
work it means we must have previously been resetting the ICPs twice.
Is that right?

> ---
>  hw/intc/xics.c | 18 ------------------
>  hw/ppc/spapr.c |  1 +
>  2 files changed, 1 insertion(+), 18 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index dd41340d41a5..3ad7e8cf8ec4 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -137,29 +137,11 @@ static void ics_simple_pic_print_info(InterruptStat=
sProvider *obj,
>  /*
>   * XICS Common class - parent for emulated XICS and KVM-XICS
>   */
> -static void xics_common_reset(DeviceState *d)
> -{
> -    XICSState *xics =3D XICS_COMMON(d);
> -    int i;
> -
> -    for (i =3D 0; i < xics->nr_servers; i++) {
> -        device_reset(DEVICE(&xics->ss[i]));
> -    }
> -}
> -
> -static void xics_common_class_init(ObjectClass *oc, void *data)
> -{
> -    DeviceClass *dc =3D DEVICE_CLASS(oc);
> -
> -    dc->reset =3D xics_common_reset;
> -}
> -
>  static const TypeInfo xics_common_info =3D {
>      .name          =3D TYPE_XICS_COMMON,
>      .parent        =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(XICSState),
>      .class_size    =3D sizeof(XICSStateClass),
> -    .class_init    =3D xics_common_class_init,
>  };
> =20
>  /*
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9c1772f93155..445d9a6ddad4 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -130,6 +130,7 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
>          ICPState *icp =3D &xics->ss[i];
> =20
>          object_initialize(icp, sizeof(*icp), type_icp);
> +        qdev_set_parent_bus(DEVICE(icp), sysbus_get_default());
>          object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp), N=
ULL);
>          object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xics)=
, NULL);
>          object_property_set_bool(OBJECT(icp), true, "realized", &err);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--03sphU6jKm9HdgU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkweAAoJEGw4ysog2bOSIOkQAKZOftryfdNiGlNMHdesvdiB
7ntPLQ9RCwOGI/J3c+rFh+GOzYwG1wFQGMZkj9NAeCr1h+O41OuUrvhiBCrwCOha
Hfz0qn1ZcywS1LaZslY8RJ9lPhjkJcHEFKupkzojeBnsepENd8BcV/YuTBox/qrr
7hmoPKuhcpoJlITNWVlC5AtGYX4vbKfTN2vivsVZNFpKuRckPkjaFpvA98tBH97k
lZZaMO1isVole1LOktvIKNElBpqCphTTyUIkRlNOacUgVt6xOcHkOIuTb4x0Iklp
lmTpz/npuwzaC/zOpdYVOPK1elZVS/agrMEktvLRY8oHSTWbYPwEV2VLptdDDvuU
0dZgJSoFFns63M1/a5NMgl38056ZVTDGT9XfLnP7WYeQvOqTqqTtq85K+kgqUJIW
+FnlE06u3TJLfNzFKnG7GSPkNkBzHBwZyUrb4hHTDRB8Ac+1Tu/TBFl1a420umj8
eUyZsQ1gBDwI4Oj0skrpr8IMg4sS+km4+fu1k1tybm2aU16c+ZQhuZPkh/UkSdqX
/st1HWE+sjfgZMfB+KG+7in4gSgCraQtMqBgqSKtVcfPLUu3cWJcosnCgfk42Bn1
sRi+lz2WnFh4UYnBmKnZj/xXuah1OX39pPpF2ZqUztPx/cdKoKoIbolCo24XavRt
bHQiOq1SjVNFC2wC1Zk+
=7XyJ
-----END PGP SIGNATURE-----

--03sphU6jKm9HdgU1--
