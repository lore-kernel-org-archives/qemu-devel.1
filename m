Received: from eggs.gnu.org ([2001:4830:134:3::10]:39805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca5-0001WR-Cm
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ehca0-00035d-Dh
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:45 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57990
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ehca0-00034c-57
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:44:40 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12EiCks056062
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:44:38 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fvrarn6pn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:44:37 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 2 Feb 2018 07:44:35 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri,  2 Feb 2018 09:44:25 -0500
In-Reply-To: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517582668-10923-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1517582668-10923-2-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/4] tpm: Split off tpm_crb_reset function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com

Split off the tpm_crb_reset function part from tpm_crb_realize
that we need to run every time the machine resets.

Also register our reset function with the system since TYPE_DEVICE
seems to not get a reset otherwise.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>

---
 v1->v2: register reset function with qemu_register_reset since
         TYPE_DEVICE seems to not get a reset otherwise
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
 
@@ -210,29 +211,10 @@ static Property tpm_crb_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static void tpm_crb_realize(DeviceState *dev, Error **errp)
+static void tpm_crb_reset(void *dev)
 {
     CRBState *s = CRB(dev);
 
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
 
     ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID,
@@ -267,6 +249,32 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     tpm_backend_startup_tpm(s->tpmbe, s->be_buffer_size);
 }
 
+static void tpm_crb_realize(DeviceState *dev, Error **errp)
+{
+    CRBState *s = CRB(dev);
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
     DeviceClass *dc = DEVICE_CLASS(klass);
-- 
2.5.5
