Received: from eggs.gnu.org ([2001:4830:134:3::10]:55457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdSOV-0007gK-RQ
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 20:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cdSOU-0008WH-FW
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 20:59:03 -0500
Date: Tue, 14 Feb 2017 12:58:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170214015843.GA2169@umbus.fritz.box>
References: <1486978404-17509-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <1486978404-17509-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/xics: fix XICSStateClass parent class
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 10:33:24AM +0100, C=E9dric Le Goater wrote:
> XICSState inherits from SysBusDevice and so the object class should
> inherit from SysBusDeviceClass.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

That's definitely a bug, but I don't think this is the right fix.

XICS was put on sysbus back when I thought that was where you put any
"system" devices that didn't belong on a more specific bus.  I've
since discovered that's not the case, and - particularly since xics
doesn't expose any mmio - it shouldn't be a sysbus device at all.

I've instead made a patch changing it to a direct child of
TYPE_DEVICE.  Since the device shouldn't ever be command line
instantiated, and it has no migratable state I believe this should be
a safe change.

This is in ppc-for-2.9, tentatively; please review:

=46rom eae21fcf2430588f17e6a58d505aa8eaa580b507 Mon Sep 17 00:00:00 2001
=46rom: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Feb 2017 12:58:05 +1100
Subject: [PATCH] xics: XICS should not be a SysBusDevice

Currently xics - the component of the IBM POWER interrupt controller
representing the overall interrupt fabric / architecture is represented as
a descedent of SysBusDevice.  However, this is not really correct - the
xics presents nothing in MMIO space so it should be an "unattached" device
in the current QOM model.

Since this device will always be created by the machine type, not created
specifically from the command line, and because it has no migrated state
it should be safe to move it around the device composition tree.

Therefore this patch changes it to a descendent of TYPE_DEVICE, and makes
it an unattached device.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/intc/xics.c | 2 +-
 hw/ppc/spapr.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 095c16a..372b831 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -260,7 +260,7 @@ static void xics_common_class_init(ObjectClass *oc, voi=
d *data)
=20
 static const TypeInfo xics_common_info =3D {
     .name          =3D TYPE_XICS_COMMON,
-    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(XICSState),
     .class_size    =3D sizeof(XICSStateClass),
     .instance_init =3D xics_common_initfn,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6f37288..9b6ad0f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -101,7 +101,7 @@ static XICSState *try_create_xics(const char *type, int=
 nr_servers,
     Error *err =3D NULL;
     DeviceState *dev;
=20
-    dev =3D qdev_create(NULL, type);
+    dev =3D DEVICE(object_new(type));
     qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
     qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
     object_property_set_bool(OBJECT(dev), true, "realized", &err);
--=20
2.9.3

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYomRQAAoJEGw4ysog2bOStnYP/jfkc0xrKXbWNB9HtdBIg5Vd
FZqpoEqdE6bNdkqFums4bGL5H6C25YzZ6cjhyjTY2M8ZPVJ/V8acZt5GRchByQXq
DjDDyvWNtS1v/wO54C3K+KuUaoQGthkbSaHh05L1Q2WPaDXXf54u+/ZqzIq44jKl
5HDdp/PPevmP7SQkQS77eoKnM4D7RuUWr6vq7G6xPC6BJ0tFjjm+9nVgOfaEzV1Z
RtGshQq5OQW7ZMkL0SMouJLb4/0F+urG2YmkQuFYBimkgEDAAFbx/9rjjPmrO3jp
JTKQ85uw2n098YYEQY6bbwmpsVhIhGIFj7dOQbwZ4ux46Cq1dKXop1CW+aogbs3i
c0Q8yhPF3SwgZpTLsMWXwIrW1xH5gBEKhXG8HhEadtb55p7tMdWotFzTsy24CuOZ
5jetX4Rt6qN48XebuGxN6Vh6Ptv9I4eznOEkHMiPjHhbOuwrv298UFnNEgii+WqX
lWlJ+oUpeECq9ALykWXN2y40t/QhkROLPOAHCIeNI7yjeDZLS82hwoXh9r/etmAw
qhHwPN2k5A1lq4eizQ9DpzKo1roLlVlo4RB3xssorsdbqL30+wWwhp2hJzUWndq0
/deaLRAnvjsHOsOhMQsVtTqcDn77tedtEyd+5A0z+PGfkVQ1x2xcHu0TH3eOWGk3
F3kggAwER7rdlU3Oj6vw
=DU0q
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
