Received: from eggs.gnu.org ([2001:4830:134:3::10]:33101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2i-00040E-CI
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eDA2c-00058O-CN
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:24 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39340
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eDA2c-00056r-6U
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 09:12:18 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAAE9rEP064179
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:13 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2e59xau84y-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 10 Nov 2017 09:12:12 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Fri, 10 Nov 2017 07:12:11 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Fri, 10 Nov 2017 09:11:47 -0500
In-Reply-To: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510323112-2207-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510323112-2207-9-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 08/13] tpm: Implement tpm_sized_buffer_reset
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

Move the definition of TPMSizedBuffer out of tpm_tis.c into tpm_util.h
and implement tpm_sized_buffer_reset() for the following patches to use.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_tis.c  | 5 -----
 hw/tpm/tpm_util.c | 7 +++++++
 hw/tpm/tpm_util.h | 7 +++++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 7d7e2cd..035c6ef 100644
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
index a317243..bf97811 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -288,3 +288,10 @@ int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
 
     return 0;
 }
+
+void tpm_sized_buffer_reset(TPMSizedBuffer *tsb)
+{
+    g_free(tsb->buffer);
+    tsb->buffer = NULL;
+    tsb->size = 0;
+}
diff --git a/hw/tpm/tpm_util.h b/hw/tpm/tpm_util.h
index 1c17e39..26c9613 100644
--- a/hw/tpm/tpm_util.h
+++ b/hw/tpm/tpm_util.h
@@ -39,4 +39,11 @@ static inline uint32_t tpm_cmd_get_size(const void *b)
 int tpm_util_get_buffer_size(int tpm_fd, TPMVersion tpm_version,
                              size_t *buffersize);
 
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
