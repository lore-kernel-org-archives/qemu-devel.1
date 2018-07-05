Received: from eggs.gnu.org ([2001:4830:134:3::10]:33595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1fb1gr-0001Iy-TS
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imbrenda@linux.vnet.ibm.com>) id 1fb1gn-00038V-Fa
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:40:45 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36082
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imbrenda@linux.vnet.ibm.com>)
	id 1fb1gn-00032a-42
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 06:40:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65AeWNf050369
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 06:40:38 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2k1ghy2wtx-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 06:40:38 -0400
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <imbrenda@linux.vnet.ibm.com>;
	Thu, 5 Jul 2018 11:39:34 +0100
From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Thu,  5 Jul 2018 12:39:30 +0200
Message-Id: <1530787170-3101-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] s390x/storage attributes: fix
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
index 5161a16..766f201 100644
--- a/hw/s390x/s390-stattrib.c
+++ b/hw/s390x/s390-stattrib.c
@@ -21,7 +21,8 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 
-#define CMMA_BLOCK_SIZE  (1 * KiB)
+/* 512KiB cover 2GB of guest memory */
+#define CMMA_BLOCK_SIZE  (512 * KiB)
 
 #define STATTR_FLAG_EOS     0x01ULL
 #define STATTR_FLAG_MORE    0x02ULL
@@ -203,7 +204,7 @@ static int cmma_save(QEMUFile *f, void *opaque, int final)
     S390StAttribClass *sac = S390_STATTRIB_GET_CLASS(sas);
     uint8_t *buf;
     int r, cx, reallen = 0, ret = 0;
-    uint32_t buflen = 1 << 19;   /* 512kB cover 2GB of guest memory */
+    uint32_t buflen = CMMA_BLOCK_SIZE;
     uint64_t start_gfn = sas->migration_cur_gfn;
 
     buf = g_try_malloc(buflen);
-- 
2.7.4
