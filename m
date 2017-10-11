Received: from eggs.gnu.org ([2001:4830:134:3::10]:47541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2Gbw-0007eX-TF
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:59:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1e2Gbt-0005U1-Q3
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:59:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1e2Gbt-0005To-Is
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:59:41 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9BCx3MY069076
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 08:59:38 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2dhhahajps-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 11 Oct 2017 08:59:38 -0400
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 11 Oct 2017 08:59:37 -0400
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 11 Oct 2017 08:59:32 -0400
Message-Id: <1507726772-16661-1-git-send-email-stefanb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] tpm: Use EMSGSIZE instead of EBADMSG to
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

EMSGSIZE was only added to OpenBSD very recently. To make QEMU
compileable on older OpenBSD versions use EMSGSIZE instead when
a mismatch between number of received bytes and message size in-
dicated in the header was found.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/tpm/tpm_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/tpm/tpm_util.c b/hw/tpm/tpm_util.c
index fb929f6..1129155 100644
--- a/hw/tpm/tpm_util.c
+++ b/hw/tpm/tpm_util.c
@@ -91,7 +91,7 @@ static int tpm_util_test(int fd,
     resp = (struct tpm_resp_hdr *)buf;
     /* check the header */
     if (be32_to_cpu(resp->len) != n) {
-        return EBADMSG;
+        return EMSGSIZE;
     }
 
     *return_tag = be16_to_cpu(resp->tag);
-- 
2.5.5
