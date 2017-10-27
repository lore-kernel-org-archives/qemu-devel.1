Received: from eggs.gnu.org ([2001:4830:134:3::10]:40057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Def-0002g5-Kd
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Dec-00040Q-7i
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e8Deb-0003yi-VI
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:06 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RN1xrK063039
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:03:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv8s5vv0w-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:03:01 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:03:00 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 19:02:41 -0400
In-Reply-To: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1509145361-11218-8-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 7/7] tpm: extend TPM CRB with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

We need to synchronize with the backend thread to make sure that a command
being processed by the external TPM emulator has completed and its
response been received. In case the bottom half did not run, we run the
function it is supposed to run.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_crb.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 68 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 64039eb..a81431e 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -27,6 +27,8 @@
 #include "tpm_int.h"
 #include "tpm_util.h"
 
+#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - sizeof(struct crb_regs))
+
 typedef struct CRBState {
     SysBusDevice parent_obj;
 
@@ -36,6 +38,7 @@ typedef struct CRBState {
     TPMBackend *tpmbe;
     TPMBackendCmd cmd;
     struct crb_regs regs;
+    unsigned char buf[CRB_CTRL_CMD_SIZE];
 } CRBState;
 
 #define CRB(obj) OBJECT_CHECK(CRBState, (obj), TYPE_TPM_CRB)
@@ -64,8 +67,6 @@ typedef struct CRBState {
 #define CRB_INTF_IF_SELECTOR_CRB 0b1
 #define CRB_INTF_IF_SELECTOR_UNLOCKED 0b0
 
-#define CRB_CTRL_CMD_SIZE (TPM_CRB_ADDR_SIZE - sizeof(struct crb_regs))
-
 enum crb_loc_ctrl {
     CRB_LOC_CTRL_REQUEST_ACCESS = BIT(0),
     CRB_LOC_CTRL_RELINQUISH = BIT(1),
@@ -227,12 +228,17 @@ static void tpm_crb_reset(DeviceState *dev)
     tpm_backend_startup_tpm(s->tpmbe);
 }
 
+static void _tpm_crb_request_completed(CRBState *s)
+{
+    s->regs.ctrl_start &= ~CRB_START_INVOKE;
+    /* TODO, in case of error: s->regs.ctrl_sts = CRB_CTRL_STS_ERROR */
+}
+
 static void tpm_crb_request_completed(TPMIf *ti)
 {
     CRBState *s = CRB(ti);
 
-    s->regs.ctrl_start &= ~CRB_START_INVOKE;
-    /* TODO, in case of error: s->regs.ctrl_sts = CRB_CTRL_STS_ERROR */
+    _tpm_crb_request_completed(s);
 }
 
 static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
@@ -242,9 +248,66 @@ static enum TPMVersion tpm_crb_get_version(TPMIf *ti)
     return tpm_backend_get_tpm_version(s->tpmbe);
 }
 
+/* persistent state handling */
+
+static int tpm_crb_pre_save(void *opaque)
+{
+    CRBState *s = opaque;
+    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
+
+    /*
+     * Synchronize with backend completion.
+     */
+    tpm_backend_wait_cmd_completed(s->tpmbe);
+
+    if (s->regs.ctrl_start & CRB_START_INVOKE) {
+        _tpm_crb_request_completed(s);
+    }
+
+    memcpy(s->buf, mem, sizeof(s->buf));
+
+    return 0;
+}
+
+static int tpm_crb_post_load(void *opaque,
+                             int version_id __attribute__((unused)))
+{
+    CRBState *s = opaque;
+    void *mem = memory_region_get_ram_ptr(&s->cmdmem);
+
+    memcpy(mem, s->buf, sizeof(s->buf));
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_tpm_crb = {
     .name = "tpm-crb",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save  = tpm_crb_pre_save,
+    .post_load = tpm_crb_post_load,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(regs.loc_state, CRBState),
+        VMSTATE_UINT32(regs.loc_ctrl, CRBState),
+        VMSTATE_UINT32(regs.loc_sts, CRBState),
+        VMSTATE_UINT64(regs.intf_id, CRBState),
+        VMSTATE_UINT64(regs.ctrl_ext, CRBState),
+        VMSTATE_UINT32(regs.ctrl_req, CRBState),
+        VMSTATE_UINT32(regs.ctrl_sts, CRBState),
+        VMSTATE_UINT32(regs.ctrl_cancel, CRBState),
+        VMSTATE_UINT32(regs.ctrl_start, CRBState),
+        VMSTATE_UINT32(regs.ctrl_int_enable, CRBState),
+        VMSTATE_UINT32(regs.ctrl_int_sts, CRBState),
+        VMSTATE_UINT32(regs.ctrl_cmd_size, CRBState),
+        VMSTATE_UINT32(regs.ctrl_cmd_pa_low, CRBState),
+        VMSTATE_UINT32(regs.ctrl_rsp_size, CRBState),
+        VMSTATE_UINT64(regs.ctrl_rsp_pa, CRBState),
+
+        VMSTATE_UINT8_ARRAY(buf, CRBState, CRB_CTRL_CMD_SIZE),
+
+        VMSTATE_END_OF_LIST(),
+    }
 };
 
 static Property tpm_crb_properties[] = {
-- 
2.5.5
