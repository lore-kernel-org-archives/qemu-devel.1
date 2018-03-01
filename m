Received: from eggs.gnu.org ([2001:4830:134:3::10]:48914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erUMm-0006v3-Tj
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1erUMj-0002eb-SH
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:59:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53224)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1erUMj-0002e0-Jw
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:59:45 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w21JxEX7124546
	for <qemu-devel@nongnu.org>; Thu, 1 Mar 2018 14:59:44 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2geprxbkys-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 14:59:43 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Thu, 1 Mar 2018 12:59:43 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Thu,  1 Mar 2018 14:59:33 -0500
In-Reply-To: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519934373-3629-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1519934373-3629-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 2/2] tpm: extend TPM TIS with state
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
Cc: marcandre.lureau@redhat.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM TIS interface with state migration support.

We need to synchronize with the backend thread to make sure that a command
being processed by the external TPM emulator has completed and its
response been received.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 834eef7..5016d28 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -902,9 +902,61 @@ static void tpm_tis_reset(DeviceState *dev)
     tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
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
+    tpm_backend_finish_sync(s->be_driver);
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
