Received: from eggs.gnu.org ([2001:4830:134:3::10]:45377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slV-00078T-HC
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slU-0002ey-1D
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:49 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:28 +1000
Message-Id: <20180410125233.31618-3-david@gibson.dropbear.id.au>
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/7] hw/misc/macio: Fix crash when listing
 device properties of macio device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The macio-newworld device can currently be used to abort QEMU unexpectedl=
y:

$ ppc-softmmu/qemu-system-ppc -S -M ref405ep,accel=3Dqtest -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 11, "major": 2},
 "package": "build-all"}, "capabilities": []}}
{ 'execute': 'qmp_capabilities' }
{"return": {}}
{ 'execute': 'device-list-properties',
  'arguments': {'typename': 'macio-newworld'}}
Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
Device 'serial0' is in use
Aborted (core dumped)

qdev properties should be set during realize(), not during instance_init(=
),
so move the related code there to fix this problem.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/misc/macio/macio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 454244f59e..b74a6572b0 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -115,6 +115,13 @@ static void macio_common_realize(PCIDevice *d, Error=
 **errp)
     memory_region_add_subregion(&s->bar, 0x16000,
                                 sysbus_mmio_get_region(sysbus_dev, 0));
=20
+    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
+    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
+    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
     object_property_set_bool(OBJECT(&s->escc), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
@@ -341,13 +348,6 @@ static void macio_instance_init(Object *obj)
     object_property_add_child(obj, "dbdma", OBJECT(&s->dbdma), NULL);
=20
     object_initialize(&s->escc, sizeof(s->escc), TYPE_ESCC);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "disabled", 0);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "frequency", ESCC_CLOCK);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "it_shift", 4);
-    qdev_prop_set_chr(DEVICE(&s->escc), "chrA", serial_hds[0]);
-    qdev_prop_set_chr(DEVICE(&s->escc), "chrB", serial_hds[1]);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "chnBtype", escc_serial);
-    qdev_prop_set_uint32(DEVICE(&s->escc), "chnAtype", escc_serial);
     qdev_set_parent_bus(DEVICE(&s->escc), sysbus_get_default());
     object_property_add_child(obj, "escc", OBJECT(&s->escc), NULL);
 }
--=20
2.14.3
