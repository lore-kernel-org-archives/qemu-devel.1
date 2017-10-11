Received: from eggs.gnu.org ([2001:4830:134:3::10]:38638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2Mym-00007x-CU
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2Myj-00039T-A9
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:47:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49924
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2Myj-000392-3n
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 15:47:41 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BJiIeS086438
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 15:47:37 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dhnt8367m-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 15:47:37 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 15:47:36 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 15:47:29 -0400
Message-Id: <1507751249-3035-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3] tpm: Use EMSGSIZE instead of EBADMSG to
 compile on OpenBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarnath.valluri@intel.com, marcandre.lureau@gmail.com, Stefan Berger <stefanb@linux.vnet.ibm.com>

EBADMSG was only added to OpenBSD very recently. To make QEMU compilable
on older OpenBSD versions use EMSGSIZE instead when a mismatch between
number of received bytes and message size indicated in the header was
found.

Return -EMSGSIZE and convert all other errnos in the same functions to
return the negative errno.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_util.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index fb929f6..73d7796 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -68,10 +68,10 @@ static int tpm_util_test(int fd,
 
     n = write(fd, request, requestlen);
     if (n < 0) {
-        return errno;
+        return -errno;
     }
     if (n != requestlen) {
-        return EFAULT;
+        return -EFAULT;
     }
 
     FD_ZERO(&readfds);
@@ -80,18 +80,18 @@ static int tpm_util_test(int fd,
     /* wait for a second */
     n = select(fd + 1, &readfds, NULL, NULL, &tv);
     if (n != 1) {
-        return errno;
+        return -errno;
     }
 
     n = read(fd, &buf, sizeof(buf));
     if (n < sizeof(struct tpm_resp_hdr)) {
-        return EFAULT;
+        return -EFAULT;
     }
 
     resp = (struct tpm_resp_hdr *)buf;
     /* check the header */
     if (be32_to_cpu(resp->len) != n) {
-        return EBADMSG;
+        return -EMSGSIZE;
     }
 
     *return_tag = be16_to_cpu(resp->tag);
-- 
2.5.5
