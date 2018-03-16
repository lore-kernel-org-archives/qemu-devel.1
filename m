Received: from eggs.gnu.org ([2001:4830:134:3::10]:36888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewxBb-00036F-9f
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1ewxBY-0003YX-6Y
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38984
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1ewxBY-0003YE-1E
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 17:46:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w2GLitLc073939
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:46:47 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2grhf09vv5-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:46:47 -0400
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 16 Mar 2018 15:46:45 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 17:46:34 -0400
In-Reply-To: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1521236796-24551-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1521236796-24551-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 for 2.13 2/4] tpm: extend TPM TIS with state
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
Cc: dgilbert@redhat.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Extend the TPM TIS interface with state migration support.

We need to synchronize with the backend thread to make sure that a command
being processed by the external TPM emulator has completed and its
response been received.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 hw/tpm/trace-events |  1 +
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 2ac7e74..fec3d73 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -894,9 +894,57 @@ static void tpm_tis_reset(DeviceState *dev)
     tpm_backend_startup_tpm(s->be_driver, s->be_buffer_size);
 }
 
+/* persistent state handling */
+
+static int tpm_tis_pre_save(void *opaque)
+{
+    TPMState *s = opaque;
+    uint8_t locty = s->active_locty;
+
+    trace_tpm_tis_pre_save(locty, s->rw_offset);
+
+    if (DEBUG_TIS) {
+        tpm_tis_dump_state(opaque, 0);
+    }
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
+    .name = "tpm-tis/locty",
+    .version_id = 1,
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
-    .name = "tpm",
-    .unmigratable = 1,
+    .name = "tpm-tis",
+    .version_id = 1,
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
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index c5bfbf1..25bee0c 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -50,3 +50,4 @@ tpm_tis_mmio_write_locty_seized(uint8_t locty, uint8_t active) "Locality %d seiz
 tpm_tis_mmio_write_init_abort(void) "Initiating abort"
 tpm_tis_mmio_write_lowering_irq(void) "Lowering IRQ"
 tpm_tis_mmio_write_data2send(uint32_t value, unsigned size) "Data to send to TPM: 0x%08x (size=%d)"
+tpm_tis_pre_save(uint8_t locty, uint32_t rw_offset) "locty: %d, rw_offset = %u"
-- 
2.5.5
