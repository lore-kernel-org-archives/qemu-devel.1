Received: from eggs.gnu.org ([209.51.188.92]:38264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hAz2t-00015d-6g
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eroken1@gmail.com>) id 1hAz2s-0002mq-4M
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:40:23 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:41127)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eroken1@gmail.com>) id 1hAz2r-0002mC-OZ
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 11:40:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id r4so12671402wrq.8
	for <qemu-devel@nongnu.org>; Mon, 01 Apr 2019 08:40:21 -0700 (PDT)
Date: Mon, 1 Apr 2019 16:40:28 +0100
From: Ernest Esene <eroken1@gmail.com>
Message-ID: <20190401154028.GA10574@erokenlabserver>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH v2] Replace calls to object_child_foreach()
 with object_child_foreach_recursive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Replace calls to object_child_foreach() with object_child_foreach_recursive=
()
when applicable: nvdimm_device_list, nmi_monitor_handle,
find_sysbus_device,
pc_dimm_slot2bitmap, build_dimm_list.

Signed-off-by: Ernest Esene <eroken1@gmail.com>

---
v2:
  * applied changes suggested by Paolo
---
 hw/acpi/nvdimm.c           |  4 +---
 hw/core/sysbus.c           | 11 ++++-------
 hw/mem/pc-dimm.c           |  3 +--
 hw/virtio/virtio-balloon.c |  3 +--
 4 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9fdad6dc3f..36ff075a42 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -40,8 +40,6 @@ static int nvdimm_device_list(Object *obj, void *opaque)
     if (object_dynamic_cast(obj, TYPE_NVDIMM)) {
         *list =3D g_slist_append(*list, DEVICE(obj));
     }
-
-    object_child_foreach(obj, nvdimm_device_list, opaque);
     return 0;
 }
=20
@@ -56,7 +54,7 @@ static GSList *nvdimm_get_device_list(void)
 {
     GSList *list =3D NULL;
=20
-    object_child_foreach(qdev_get_machine(), nvdimm_device_list, &list);
+    object_child_foreach_recursive(qdev_get_machine(), nvdimm_device_list,=
 &list);
     return list;
 }
=20
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index 307cf90a51..3d0bf47a04 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -41,13 +41,10 @@ static int find_sysbus_device(Object *obj, void *opaque)
     dev =3D object_dynamic_cast(obj, TYPE_SYS_BUS_DEVICE);
     sbdev =3D (SysBusDevice *)dev;
=20
-    if (!sbdev) {
-        /* Container, traverse it for children */
-        return object_child_foreach(obj, find_sysbus_device, opaque);
+    if (sbdev) {
+        find->func(sbdev, find->opaque);
     }
=20
-    find->func(sbdev, find->opaque);
-
     return 0;
 }
=20
@@ -65,9 +62,9 @@ void foreach_dynamic_sysbus_device(FindSysbusDeviceFunc *=
func, void *opaque)
=20
     /* Loop through all sysbus devices that were spawened outside the mach=
ine */
     container =3D container_get(qdev_get_machine(), "/peripheral");
-    find_sysbus_device(container, &find);
+    object_child_foreach_recursive(container, find_sysbus_device, &find);
     container =3D container_get(qdev_get_machine(), "/peripheral-anon");
-    find_sysbus_device(container, &find);
+    object_child_foreach_recursive(container, find_sysbus_device, &find);
 }
=20
=20
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 19b9c0f406..6eaac49a22 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -84,7 +84,6 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
         }
     }
=20
-    object_child_foreach(obj, pc_dimm_slot2bitmap, opaque);
     return 0;
 }
=20
@@ -100,7 +99,7 @@ static int pc_dimm_get_free_slot(const int *hint, int ma=
x_slots, Error **errp)
     }
=20
     bitmap =3D bitmap_new(max_slots);
-    object_child_foreach(qdev_get_machine(), pc_dimm_slot2bitmap, bitmap);
+    object_child_foreach_recursive(qdev_get_machine(), pc_dimm_slot2bitmap=
, bitmap);
=20
     /* check if requested slot is not occupied */
     if (hint) {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index 2112874055..7945637077 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -649,7 +649,6 @@ static int build_dimm_list(Object *obj, void *opaque)
         }
     }
=20
-    object_child_foreach(obj, build_dimm_list, opaque);
     return 0;
 }
=20
@@ -658,7 +657,7 @@ static ram_addr_t get_current_ram_size(void)
     GSList *list =3D NULL, *item;
     ram_addr_t size =3D ram_size;
=20
-    build_dimm_list(qdev_get_machine(), &list);
+    object_child_foreach_recursive(qdev_get_machine(), build_dimm_list, &l=
ist);
     for (item =3D list; item; item =3D g_slist_next(item)) {
         Object *obj =3D OBJECT(item->data);
         if (!strcmp(object_get_typename(obj), TYPE_PC_DIMM)) {
--=20
2.14.2


--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEFkNmxXgplc+HqgQGJZ4JoaCvxKoFAlyiMOcACgkQJZ4JoaCv
xKqCUxAAwNufJhTcmuf2DZenDjHsxnMHgbP7MEeZ7dzRSGCo0tY6ogxyGQuJ067L
NigjWYH5wOBoGFkJdvFvshiR5LMy2WLWOioZT6aQUVToQWiX+I+fuW7221Pd9HyS
LSm47OLVVwl6smbD3cOL9b8r7egvloGeoexPZwG94NxF23swz193zKi00S7HRSG3
RKHmo0KUJYQgamBt/MbYOAoLkhkCK0YLxIZiDp3RXNHVcRN+IM9FqR4mUl4gbBBz
aa0GeTx5JNi0NtmgtHfYnQLK8JTJTy+tzikxzlmSTxAEfU/WN7tzXahKjqEX74sT
IgQtJV9KM/JcBqWZ04V9fj2ZJ5wbBmUVI99DluB6vAo2+a8d05nUz8YNzS1/BN/4
rPK2GSVxEyPb6OwjCFJqKPgS6aN8epreQ5QVsYqX83+gKTXYuv6pvOIV296Xk3WK
0uudQ6E+kzH5QbIZjcz6xzf+H0yvBoEuZas5d2+Pnhioq6divnztTgdcj7YyB48X
eZfLRnXc8jKRpfuTV18QD5Fa88Nh1lk4CA+tn3l8JM8sTQiQVaOo0w2fCWiLbfX8
QN/SguLh8CyMbuUvhhq768qzAjJwaue7ESr19Ss6SY77mjouiBTeK3ngG4+ymfXq
ojpw/qYnWWIsKZOvIsP+MJmNEvn5wAUP4fIjgJgeFOdAv3ebB5o=
=zqnd
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
