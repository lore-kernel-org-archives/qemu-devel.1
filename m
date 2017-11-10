Received: from eggs.gnu.org ([2001:4830:134:3::10]:33157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2n-00045h-Kq
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2j-0005PQ-62
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52780
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2i-0005OT-WC
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:25 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAEA17n099245
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:21 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e59mu3xty-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:20 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:19 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:52 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-14-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 13/13] tpm_tis: extend TPM TIS with state
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Cc: amarnath.valluri@intel.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM TIS interface with state migration support.

We need to synchronize with the backend thread to make sure that a command
being processed by the external TPM emulator has completed and its
response been received. In case the bottom half did not run, we run the
function it is supposed to run.

Since only 1 locality can be active at any time we only need
to store the command buffer of that active locality.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 68 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 86e9a92..c0a0204 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -393,12 +393,8 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
     tpm_tis_abort(s, locty);
 }
 
-/*
- * Callback from the TPM to indicate that the response was received.
- */
-static void tpm_tis_request_completed(TPMIf *ti)
+static void _tpm_tis_request_completed(TPMState *s)
 {
-    TPMState *s = TPM(ti);
     uint8_t locty = s->cmd.locty;
     uint8_t l;
 
@@ -431,6 +427,14 @@ static void tpm_tis_request_completed(TPMIf *ti)
 }
 
 /*
+ * Callback from the TPM to indicate that the response was received.
+ */
+static void tpm_tis_request_completed(TPMIf *ti)
+{
+    _tpm_tis_request_completed(TPM(ti));
+}
+
+/*
  * Read a byte of response data
  */
 static uint32_t tpm_tis_data_read(TPMState *s, uint8_t locty)
@@ -1012,9 +1016,67 @@ static void tpm_tis_reset(DeviceState *dev)
     tpm_tis_do_startup_tpm(s, s->be_buffer_size);
 }
 
+/* persistent state handling */
+
+static int tpm_tis_pre_save(void *opaque)
+{
+    TPMState *s = opaque;
+    uint8_t locty = s->active_locty;
+
+    DPRINTF("tpm_tis: suspend: locty = %d : rw_offset = %u\n",
+            locty, s->rw_offset);
+#ifdef DEBUG_TIS
+    tpm_tis_dump_state(opaque, 0);
+#endif
+
+    /*
+     * Synchronize with backend completion.
+     */
+    tpm_backend_wait_cmd_completed(s->be_driver);
+
+    if (TPM_TIS_IS_VALID_LOCTY(locty) &&
+        s->loc[locty].state == TPM_TIS_STATE_EXECUTION) {
+        /* bottom half did not run - run its function */
+        _tpm_tis_request_completed(s);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_locty = {
+    .name = "loc",
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(state, TPMLocality),
+        VMSTATE_UINT32(inte, TPMLocality),
+        VMSTATE_UINT32(ints, TPMLocality),
+        VMSTATE_UINT8(access, TPMLocality),
+        VMSTATE_UINT32(sts, TPMLocality),
+        VMSTATE_UINT32(iface_id, TPMLocality),
+        VMSTATE_END_OF_LIST(),
+    }
+};
+
 static const VMStateDescription vmstate_tpm_tis = {
     .name = "tpm",
-    .unmigratable = 1,
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save  = tpm_tis_pre_save,
+    .fields = (VMStateField[]) {
+        VMSTATE_BUFFER(buffer, TPMState),
+        VMSTATE_UINT16(rw_offset, TPMState),
+        VMSTATE_UINT8(active_locty, TPMState),
+        VMSTATE_UINT8(aborting_locty, TPMState),
+        VMSTATE_UINT8(next_locty, TPMState),
+
+        VMSTATE_STRUCT_ARRAY(loc, TPMState, TPM_TIS_NUM_LOCALITIES, 1,
+                             vmstate_locty, TPMLocality),
+
+        VMSTATE_END_OF_LIST()
+    }
 };
 
 static Property tpm_tis_properties[] = {
-- 
2.5.5
