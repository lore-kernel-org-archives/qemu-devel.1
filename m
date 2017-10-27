Received: from eggs.gnu.org ([2001:4830:134:3::10]:40062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Deg-0002gJ-1w
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Deb-0003z2-Ix
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e8Deb-0003xx-9r
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RMwnAY140279
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:03:01 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dv79j1c7f-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:03:01 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:03:00 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 19:02:40 -0400
In-Reply-To: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1509145361-11218-7-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 6/7] tpm: extend TPM TIS with state
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

Extend the TPM TIS interface with state migration support.

We need to synchronize with the backend thread to make sure that a command
being processed by the external TPM emulator has completed and its
response been received. In case the bottom half did not run, we run the
function it is supposed to run.

Since only 1 locality can be active ay any time we only need
to store the command buffer of that active locality.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 134 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 128 insertions(+), 6 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 60887c3..1c52ea7 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -404,12 +404,8 @@ static void tpm_tis_prep_abort(TPMState *s, uint8_t locty, uint8_t newlocty)
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
 
@@ -442,6 +438,14 @@ static void tpm_tis_request_completed(TPMIf *ti)
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
@@ -1047,9 +1051,127 @@ static void tpm_tis_reset(DeviceState *dev)
     tpm_tis_do_startup_tpm(s);
 }
 
+/* persistent state handling */
+
+static int tpm_tis_pre_save(void *opaque)
+{
+    TPMState *s = opaque;
+    uint8_t locty = s->active_locty;
+
+    DPRINTF("tpm_tis: suspend: locty = %d : r_offset = %d, w_offset = %d\n",
+            locty, s->loc[0].r_offset, s->loc[0].w_offset);
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
+    /* copy current active read or write buffer into the buffer
+       written to disk */
+    if (TPM_TIS_IS_VALID_LOCTY(locty)) {
+        switch (s->loc[locty].state) {
+        case TPM_TIS_STATE_RECEPTION:
+            memcpy(s->buf,
+                   s->loc[locty].w_buffer.buffer,
+                   MIN(sizeof(s->buf),
+                       s->loc[locty].w_buffer.size));
+            s->offset = s->loc[locty].w_offset;
+        break;
+        case TPM_TIS_STATE_COMPLETION:
+            memcpy(s->buf,
+                   s->loc[locty].r_buffer.buffer,
+                   MIN(sizeof(s->buf),
+                       s->loc[locty].r_buffer.size));
+            s->offset = s->loc[locty].r_offset;
+        break;
+        default:
+            /* leak nothing */
+            memset(s->buf, 0x0, sizeof(s->buf));
+        break;
+        }
+    }
+
+    return 0;
+}
+
+static int tpm_tis_post_load(void *opaque,
+                             int version_id __attribute__((unused)))
+{
+    TPMState *s = opaque;
+
+    uint8_t locty = s->active_locty;
+
+    if (TPM_TIS_IS_VALID_LOCTY(locty)) {
+        switch (s->loc[locty].state) {
+        case TPM_TIS_STATE_RECEPTION:
+            memcpy(s->loc[locty].w_buffer.buffer,
+                   s->buf,
+                   MIN(sizeof(s->buf),
+                       s->loc[locty].w_buffer.size));
+            s->loc[locty].w_offset = s->offset;
+        break;
+        case TPM_TIS_STATE_COMPLETION:
+            memcpy(s->loc[locty].r_buffer.buffer,
+                   s->buf,
+                   MIN(sizeof(s->buf),
+                       s->loc[locty].r_buffer.size));
+            s->loc[locty].r_offset = s->offset;
+        break;
+        default:
+        break;
+        }
+    }
+
+    DPRINTF("tpm_tis: resume : locty = %d : r_offset = %d, w_offset = %d\n",
+            locty, s->loc[0].r_offset, s->loc[0].w_offset);
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
+    .post_load = tpm_tis_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(offset, TPMState),
+        VMSTATE_BUFFER(buf, TPMState),
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
