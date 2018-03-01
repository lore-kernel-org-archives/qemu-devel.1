Received: from eggs.gnu.org ([2001:4830:134:3::10]:59241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNsC-00051X-Gi
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNs6-0007s5-V6
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:48 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:02:01 +0100
Message-Id: <20180301130201.24666-28-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 27/27] s390x/tcg: fix loading 31bit PSWs with
 the highest bit set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's also put the 31-bit hack in front of the REAL MMU, otherwise right
now we get errors when loading a PSW where the highest bit is set (e.g.
via s390-netboot.img). The highest bit is not masked away, therefore we
inject addressing exceptions into the guest.

The proper fix will later be to do all address wrapping before accessing
the MMU - so we won't get any "wrong" entries in there (which makes
flushing also easier). But that will require more work (wrapping in
load_psw, wrapping when incrementing the PC, wrapping every memory
access).

This fixes the tests/pxe-test test.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180301120826.6847-1-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/excp_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index 411051edc3..dfee221111 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -107,6 +107,10 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr, int size,
             return 1;
         }
     } else if (mmu_idx == MMU_REAL_IDX) {
+        /* 31-Bit mode */
+        if (!(env->psw.mask & PSW_MASK_64)) {
+            vaddr &= 0x7fffffff;
+        }
         if (mmu_translate_real(env, vaddr, rw, &raddr, &prot)) {
             return 1;
         }
-- 
2.13.6
