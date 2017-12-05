Received: from eggs.gnu.org ([2001:4830:134:3::10]:45087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eMJws-0003OC-MJ
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eMJwq-0001Pw-6G
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:36:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eMJwp-0001PJ-U5
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 15:36:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB5KY89A071401
	for <qemu-devel@nongnu.org>; Tue, 5 Dec 2017 15:36:08 -0500
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2enya31vvy-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 15:36:08 -0500
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 5 Dec 2017 15:36:06 -0500
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue,  5 Dec 2017 15:35:53 -0500
In-Reply-To: <1512506153-8011-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1512506153-8011-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1512506153-8011-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 2/2] tpm_spapr: Support suspend and resume
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org, lo1@us.ibm.com, James.Bottomley@HansenPartnership.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_spapr.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 57 insertions(+), 4 deletions(-)

diff --git a/hw/tpm/tpm_spapr.c b/hw/tpm/tpm_spapr.c
index 909aeeb..e145697 100644
--- a/hw/tpm/tpm_spapr.c
+++ b/hw/tpm/tpm_spapr.c
@@ -248,9 +248,8 @@ static int tpm_spapr_do_crq(struct VIOsPAPRDevice *dev, uint8_t *crq_data)
     return 0;
 }
 
-static void tpm_spapr_request_completed(TPMIf *ti)
+static void _tpm_spapr_request_completed(SPAPRvTPMState *s)
 {
-    SPAPRvTPMState *s = VIO_SPAPR_VTPM_DEVICE(ti);
     tpm_spapr_crq *crq = &s->crq;
     uint32_t len;
     int rc;
@@ -278,6 +277,13 @@ static void tpm_spapr_request_completed(TPMIf *ti)
     }
 }
 
+static void tpm_spapr_request_completed(TPMIf *ti)
+{
+    SPAPRvTPMState *s = VIO_SPAPR_VTPM_DEVICE(ti);
+
+    _tpm_spapr_request_completed(s);
+}
+
 static int tpm_spapr_do_startup_tpm(SPAPRvTPMState *s, size_t buffersize)
 {
     return tpm_backend_startup_tpm(s->be_driver, buffersize);
@@ -310,9 +316,56 @@ static enum TPMVersion tpm_spapr_get_version(TPMIf *ti)
     return tpm_backend_get_tpm_version(s->be_driver);
 }
 
+/* persistent state handling */
+
+static int tpm_spapr_pre_save(void *opaque)
+{
+    SPAPRvTPMState *s = opaque;
+
+    /*
+     * Synchronize with backend completion.
+     */
+    tpm_backend_wait_cmd_completed(s->be_driver);
+
+    /*
+     * we cannot deliver the results to the VM (in state
+     * SPAPR_VTPM_STATE_EXECUTION) since DMA would touch VM memory
+     */
+
+    return 0;
+}
+
+static int tpm_spapr_post_load(void *opaque,
+                               int version_id __attribute__((unused)))
+{
+    SPAPRvTPMState *s = opaque;
+
+    if (s->state == SPAPR_VTPM_STATE_EXECUTION) {
+        /*
+         * now we can deliver the results to the VM via DMA
+         */
+        _tpm_spapr_request_completed(s);
+    }
+
+    return 0;
+}
+
 static const VMStateDescription vmstate_spapr_vtpm = {
-    .name = "tpm_spapr",
-    .unmigratable = 1,
+    .name = "tpm-spapr",
+    .version_id = 1,
+    .minimum_version_id = 0,
+    .minimum_version_id_old = 0,
+    .pre_save = tpm_spapr_pre_save,
+    .post_load = tpm_spapr_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_BUFFER(crq.raw, SPAPRvTPMState),
+        VMSTATE_UINT64(vdev.crq.qladdr, SPAPRvTPMState),
+        VMSTATE_UINT32(vdev.crq.qsize, SPAPRvTPMState),
+        VMSTATE_UINT32(vdev.crq.qnext, SPAPRvTPMState),
+        VMSTATE_UINT8(state, SPAPRvTPMState),
+        VMSTATE_BUFFER(buffer, SPAPRvTPMState),
+        VMSTATE_END_OF_LIST(),
+    }
 };
 
 static Property tpm_spapr_properties[] = {
-- 
2.5.5
