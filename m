Received: from eggs.gnu.org ([2001:4830:134:3::10]:59834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehyVz-00077z-5g
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehyVu-0003uS-6R
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:09:59 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehyVt-0003tx-T3
	for qemu-devel@nongnu.org; Sat, 03 Feb 2018 09:09:54 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w13E8taZ141216
	for <qemu-devel@nongnu.org>; Sat, 3 Feb 2018 09:09:52 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fwax3wkn1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 03 Feb 2018 09:09:52 -0500
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 3 Feb 2018 09:09:51 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat,  3 Feb 2018 09:09:38 -0500
In-Reply-To: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1517666981-9339-2-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] tpm: Split off tpm_crb_reset function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com, peter.maydell@linaro.org

Split off the tpm_crb_reset function part from tpm_crb_realize
that we need to run every time the machine resets.

Also register our reset function with the system since TYPE_DEVICE
seems to not get a reset otherwise.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/tpm/tpm_crb.c | 48 ++++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 687d255..b5b8256 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -26,6 +26,7 @@
 #include "hw/acpi/tpm.h"
 #include "migration/vmstate.h"
 #include "sysemu/tpm_backend.h"
+#include "sysemu/reset.h"
 #include "tpm_int.h"
 #include "tpm_util.h"
=20
@@ -210,29 +211,10 @@ static Property tpm_crb_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void tpm_crb_realize(DeviceState *dev, Error **errp)
+static void tpm_crb_reset(void *dev)
 {
     CRBState *s =3D CRB(dev);
=20
-    if (!tpm_find()) {
-        error_setg(errp, "at most one TPM device is permitted");
-        return;
-    }
-    if (!s->tpmbe) {
-        error_setg(errp, "'tpmdev' property is required");
-        return;
-    }
-
-    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
-        "tpm-crb-mmio", sizeof(s->regs));
-    memory_region_init_ram(&s->cmdmem, OBJECT(s),
-        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
-
-    memory_region_add_subregion(get_system_memory(),
-        TPM_CRB_ADDR_BASE, &s->mmio);
-    memory_region_add_subregion(get_system_memory(),
-        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
-
     tpm_backend_reset(s->tpmbe);
=20
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
@@ -267,6 +249,32 @@ static void tpm_crb_realize(DeviceState *dev, Error =
**errp)
     tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
 }
=20
+static void tpm_crb_realize(DeviceState *dev, Error **errp)
+{
+    CRBState *s =3D CRB(dev);
+
+    if (!tpm_find()) {
+        error_setg(errp, "at most one TPM device is permitted");
+        return;
+    }
+    if (!s->tpmbe) {
+        error_setg(errp, "'tpmdev' property is required");
+        return;
+    }
+
+    memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
+        "tpm-crb-mmio", sizeof(s->regs));
+    memory_region_init_ram(&s->cmdmem, OBJECT(s),
+        "tpm-crb-cmd", CRB_CTRL_CMD_SIZE, errp);
+
+    memory_region_add_subregion(get_system_memory(),
+        TPM_CRB_ADDR_BASE, &s->mmio);
+    memory_region_add_subregion(get_system_memory(),
+        TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
+
+    qemu_register_reset(tpm_crb_reset, dev);
+}
+
 static void tpm_crb_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
--=20
2.5.5
