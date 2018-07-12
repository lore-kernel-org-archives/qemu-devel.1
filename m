Received: from eggs.gnu.org ([2001:4830:134:3::10]:51498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdXyK-0000oT-EN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:33:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fdXyJ-0000hq-HK
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 05:33:12 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 12 Jul 2018 11:33:00 +0200
Message-Id: <20180712093301.9343-2-cohuck@redhat.com>
In-Reply-To: <20180712093301.9343-1-cohuck@redhat.com>
References: <20180712093301.9343-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-3.0 1/2] s390x/storage attributes: fix
 CMMA_BLOCK_SIZE usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

The macro CMMA_BLOCK_SIZE was defined but not used, and a hardcoded
value was instead used in the code.

This patch fixes the value of CMMA_BLOCK_SIZE and uses it in the
appropriate place in the code, and fixes another case of hardcoded
value in the KVM backend, replacing it with the more appropriate
constant KVM_S390_CMMA_SIZE_MAX.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Message-Id: <1530787170-3101-1-git-send-email-imbrenda@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-stattrib-kvm.c | 3 ++-
 hw/s390x/s390-stattrib.c     | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
index 480551c3db..c7e1f35524 100644
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
index 5161a1659b..766f2015a4 100644
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
2.14.4
