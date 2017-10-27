Received: from eggs.gnu.org ([2001:4830:134:3::10]:40040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8Dee-0002ed-Fs
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e8DeY-0003wJ-RB
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e8DeY-0003v8-Gc
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:03:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RN06ia060170
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:58 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dvcurjcf6-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 19:02:57 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 19:02:56 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 19:02:38 -0400
In-Reply-To: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1509145361-11218-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1509145361-11218-5-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 4/7] tpm: Implement tpm_sized_buffer_reset
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

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c  | 5 -----
 hw/tpm/tpm_util.c | 7 +++++++
 hw/tpm/tpm_util.h | 7 +++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 90dca4e..60887c3 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -48,11 +48,6 @@ typedef enum {
     TPM_TIS_STATE_RECEPTION,
 } TPMTISState;
 
-typedef struct TPMSizedBuffer {
-    uint32_t size;
-    uint8_t  *buffer;
-} TPMSizedBuffer;
-
 /* locality data  -- all fields are persisted */
 typedef struct TPMLocality {
     TPMTISState state;
diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index daf1faa..6132a14 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -151,3 +151,10 @@ int tpm_util_test_tpmdev(int tpm_fd, TPMVersion *tpm_version)
 
     return 1;
 }
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
+{
+    g_free(tsb->buffer);
+    tsb->buffer = NULL;
+    tsb->size = 0;
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index aca10c9..4c0d596 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -36,4 +36,11 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
     return be32_to_cpu(*(const uint32_t *)(b + 2));
 }
 
+typedef struct TPMSizedBuffer {
+    uint32_t size;
+    uint8_t  *buffer;
+} TPMSizedBuffer;
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb);
+
 #endif /* TPM_TPM_UTIL_H */
-- 
2.5.5
