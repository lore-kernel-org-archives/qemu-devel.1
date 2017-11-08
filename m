Received: from eggs.gnu.org ([2001:4830:134:3::10]:36792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVcC-0000cw-8V
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eCVc4-0000Q4-MH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:20 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38562)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eCVc4-0000PP-91
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 14:02:12 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vA8J1jpL082006
	for <qemu-devel@nongnu.org>; Wed, 8 Nov 2017 14:02:11 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2e44gvusf5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 14:02:09 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 8 Nov 2017 12:02:09 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed,  8 Nov 2017 14:01:56 -0500
In-Reply-To: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1510167719-4357-1-git-send-email-stefanb@linux.vnet.ibm.com>
Message-Id: <1510167719-4357-3-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 2/5] tpm: pull tpm_util_request() out of
 tpm_util_test()
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

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_util.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index daf1faa..b852f53 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -50,13 +50,13 @@ bool tpm_util_is_selftest(const uint8_t *in, uint32_t in_len)
 }
 
 /*
- * A basic test of a TPM device. We expect a well formatted response header
- * (error response is fine) within one second.
+ * Send request to a TPM device. We expect a response within one second.
  */
-static int tpm_util_test(int fd,
-                         unsigned char *request,
-                         size_t requestlen,
-                         uint16_t *return_tag)
+static int tpm_util_request(int fd,
+                            unsigned char *request,
+                            size_t requestlen,
+                            unsigned char *response,
+                            size_t responselen)
 {
     struct tpm_resp_hdr *resp;
     fd_set readfds;
@@ -65,7 +65,6 @@ static int tpm_util_test(int fd,
         .tv_sec = 1,
         .tv_usec = 0,
     };
-    unsigned char buf[1024];
 
     n = write(fd, request, requestlen);
     if (n < 0) {
@@ -84,17 +83,40 @@ static int tpm_util_test(int fd,
         return -errno;
     }
 
-    n = read(fd, &buf, sizeof(buf));
+    n = read(fd, response, responselen);
     if (n < sizeof(struct tpm_resp_hdr)) {
         return -EFAULT;
     }
 
-    resp = (struct tpm_resp_hdr *)buf;
+    resp = (struct tpm_resp_hdr *)response;
     /* check the header */
     if (be32_to_cpu(resp->len) != n) {
         return -EMSGSIZE;
     }
 
+    return 0;
+}
+
+/*
+ * A basic test of a TPM device. We expect a well formatted response header
+ * (error response is fine).
+ */
+static int tpm_util_test(int fd,
+                         unsigned char *request,
+                         size_t requestlen,
+                         uint16_t *return_tag)
+{
+    struct tpm_resp_hdr *resp;
+    unsigned char buf[1024];
+    ssize_t ret;
+
+    ret = tpm_util_request(fd, request, requestlen,
+                           buf, sizeof(buf));
+    if (ret < 0) {
+        return ret;
+    }
+
+    resp = (struct tpm_resp_hdr *)buf;
     *return_tag = be16_to_cpu(resp->tag);
 
     return 0;
-- 
2.5.5
