Received: from eggs.gnu.org ([2001:4830:134:3::10]:40154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1fZwbz-0006rt-CI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:03:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1fZwbw-00074B-4z
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:03:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35278
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1fZwbw-000738-0a
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 07:03:12 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w62AsprE083281
	for <qemu-devel@nongnu.org>; Mon, 2 Jul 2018 07:03:10 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jygdhp6sw-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 07:03:09 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Mon, 2 Jul 2018 12:03:07 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Mon,  2 Jul 2018 13:03:04 +0200
Message-Id: <1530529384-3848-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/1] s390x/storage attributes: fix
 CMMA_BLOCK_SIZE usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

The macro CMMA_BLOCK_SIZE was defined but not used, and a hardcoded
value was instead used in the code.

This patch fixes the value of CMMA_BLOCK_SIZE and uses it in the
appropriate place in the code.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 hw/s390x/s390-stattrib.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
index 70b9555..a788cdb 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -20,7 +20,8 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 
-#define CMMA_BLOCK_SIZE  (1 << 10)
+/* 512kB cover 2GB of guest memory */
+#define CMMA_BLOCK_SIZE  (1 << 19)
 
 #define STATTR_FLAG_EOS     0x01ULL
 #define STATTR_FLAG_MORE    0x02ULL
@@ -202,7 +203,7 @@ static int cmma_save(QEMUFile *f, void *opaque, int final)
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     uint8_t *buf;
     int r, cx, reallen = 0, ret = 0;
-    uint32_t buflen = 1 << 19;   /* 512kB cover 2GB of guest memory */
+    uint32_t buflen = CMMA_BLOCK_SIZE;
     uint64_t start_gfn = sas->migration_cur_gfn;
 
     buf = g_try_malloc(buflen);
-- 
2.7.4
