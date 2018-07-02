Received: from eggs.gnu.org ([2001:4830:134:3::10]:36831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1fZyVl-0001JS-0y
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:05:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1fZyVh-0005xR-Se
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:04:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1fZyVh-0005ws-K9
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:04:53 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w62D4UbZ097928
	for <qemu-devel@nongnu.org>; Mon, 2 Jul 2018 09:04:51 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2jym5198bp-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:04:46 -0400
Received: from localhost
	by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Mon, 2 Jul 2018 14:04:14 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Mon,  2 Jul 2018 15:04:11 +0200
Message-Id: <1530536651-1588-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 1/1] s390x/storage attributes: fix
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
appropriate place in the code, and fixes another case of hardcoded
value in the KVM backend, replacing it with the more appropriate
constant KVM_S390_CMMA_SIZE_MAX.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 hw/s390x/s390-stattrib-kvm.c | 3 ++-
 hw/s390x/s390-stattrib.c     | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 480551c..c7e1f35 100644
--- a/hw/s390x/s390-stattrib-kvm.c
+++ b/hw/s390x/s390-stattrib-kvm.c
@@ -105,7 +105,8 @@ static void kvm_s390_stattrib_synchronize(S390StAttribState *sa)
     KVMS390StAttribState *sas = KVM_S390_STATTRIB(sa);
     MachineState *machine = MACHINE(qdev_get_machine());
     unsigned long max = machine->maxram_size / TARGET_PAGE_SIZE;
-    unsigned long cx, len = 1 << 19;
+    /* We do not need to reach the maximum buffer size allowed */
+    unsigned long cx, len = KVM_S390_SKEYS_MAX / 2;
     int r;
     struct kvm_s390_cmma_log clog = {
         .flags = 0,
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
