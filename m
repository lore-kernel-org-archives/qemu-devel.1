Received: from eggs.gnu.org ([2001:4830:134:3::10]:52710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2IEE-0007qm-7I
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2IEA-0001AR-4j
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:43:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58472)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2IE9-00019x-SA
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 10:43:18 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BEgqQR046806
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:43:12 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dhjx5s6wu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 10:42:54 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 08:42:32 -0600
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 10:42:25 -0400
Message-Id: <1507732945-23555-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2] tpm: Use EMSGSIZE instead of EBADMSG to
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
 hw/tpm/tpm_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index fb929f6..a83c6f4 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -71,7 +71,7 @@ static int tpm_util_test(int fd,
         return errno;
     }
     if (n != requestlen) {
-        return EFAULT;
+        return -EFAULT;
     }
 
     FD_ZERO(&readfds);
@@ -85,13 +85,13 @@ static int tpm_util_test(int fd,
 
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
