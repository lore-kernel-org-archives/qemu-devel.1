Received: from eggs.gnu.org ([2001:4830:134:3::10]:33407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhm-0002hH-1P
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liang.z.li@intel.com>) id 1cREhj-00053n-1b
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:26 -0500
Received: from mga11.intel.com ([192.55.52.93]:30517)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liang.z.li@intel.com>)
	id 1cREhi-00053I-MK
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 03:56:22 -0500
From: Liang Li <liang.z.li@intel.com>
Date: Wed, 11 Jan 2017 16:48:43 +0800
Message-Id: <1484124524-481-6-git-send-email-liang.z.li@intel.com>
In-Reply-To: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
References: <1484124524-481-1-git-send-email-liang.z.li@intel.com>
Subject: [Qemu-devel] [PATCH v4 qemu 5/6] kvm.c: Add two new arch specific
 functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, mst@redhat.com, pbonzini@redhat.com, uintela@redhat.com, amit.shah@redhat.com, mtosatti@redhat.com, dgilbert@redhat.com, wei.w.wang@intel.com, dave.hansen@intel.com, Liang Li <liang.z.li@intel.com>

Add a new function to get the vm's max pfn and a new function
to filter out the holes in the undressed free page bitmap to get
a tight free page bitmap. They are implemented on X86 and should
be implemented on other arches for live migration optimization.

Signed-off-by: Liang Li <liang.z.li@intel.com>
---
 include/sysemu/kvm.h | 18 ++++++++++++++++++
 target/arm/kvm.c     | 14 ++++++++++++++
 target/i386/kvm.c    | 37 +++++++++++++++++++++++++++++++++++++
 target/mips/kvm.c    | 14 ++++++++++++++
 target/ppc/kvm.c     | 14 ++++++++++++++
 target/s390x/kvm.c   | 14 ++++++++++++++
 6 files changed, 111 insertions(+)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index df67cc0..ef91053 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -238,6 +238,24 @@ int kvm_remove_breakpoint(CPUState *cpu, target_ulong addr,
                           target_ulong len, int type);
 void kvm_remove_all_breakpoints(CPUState *cpu);
 int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_trap);
+
+/**
+ * tighten_guest_free_page_bmap - process the free page bitmap from
+ *         guest to get a tight page bitmap which does not contain
+ *         holes.
+ * @bmap: undressed guest free page bitmap
+ * Returns: a tight guest free page bitmap, the n th bit in the
+ *         returned bitmap and the n th bit in the migration bitmap
+ *         should correspond to the same guest RAM page.
+ */
+unsigned long *tighten_guest_free_page_bmap(unsigned long *bmap);
+
+/**
+ * get_guest_max_pfn - get the max pfn of guest
+ * Returns: the max pfn of guest
+ */
+unsigned long get_guest_max_pfn(void);
+
 #ifndef _WIN32
 int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index c00b94e..785e969 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -638,3 +638,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     return (data - 32) & 0xffff;
 }
+
+unsigned long get_guest_max_pfn(void)
+{
+    /* To be done */
+
+    return 0;
+}
+
+unsigned long *tighten_guest_free_page_bmap(unsigned long *bmap)
+{
+    /* To be done */
+
+    return bmap;
+}
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 10a9cd8..b8dbe3d 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -3541,3 +3541,40 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     abort();
 }
+
+#define _4G (1ULL << 32)
+
+unsigned long get_guest_max_pfn(void)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    ram_addr_t above_4g_mem = pcms->above_4g_mem_size;
+    unsigned long max_pfn;
+
+    if (above_4g_mem) {
+        max_pfn = (_4G + above_4g_mem) >> TARGET_PAGE_BITS;
+    } else {
+        max_pfn = pcms->below_4g_mem_size >> TARGET_PAGE_BITS;
+    }
+
+    return max_pfn;
+}
+
+unsigned long *tighten_guest_free_page_bmap(unsigned long *bmap)
+{
+    PCMachineState *pcms = PC_MACHINE(current_machine);
+    ram_addr_t above_4g_mem = pcms->above_4g_mem_size;
+
+    if (above_4g_mem) {
+        unsigned long *src, *dst, len, pos;
+        ram_addr_t below_4g_mem = pcms->below_4g_mem_size;
+        src = bmap + (_4G >> TARGET_PAGE_BITS) / BITS_PER_LONG;
+        dst = bmap + (below_4g_mem >> TARGET_PAGE_BITS) / BITS_PER_LONG;
+        bitmap_move(dst, src, above_4g_mem >> TARGET_PAGE_BITS);
+
+        pos = (above_4g_mem + below_4g_mem) >> TARGET_PAGE_BITS;
+        len = (_4G - below_4g_mem) >> TARGET_PAGE_BITS;
+        bitmap_clear(bmap, pos, len);
+    }
+
+    return bmap;
+}
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index dcf5fbb..2feb406 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -1058,3 +1058,17 @@ int kvm_arch_msi_data_to_gsi(uint32_t data)
 {
     abort();
 }
+
+unsigned long get_guest_max_pfn(void)
+{
+    /* To be done */
+
+    return 0;
+}
+
+unsigned long *tighten_guest_free_page_bmap(unsigned long *bmap)
+{
+    /* To be done */
+
+    return bmap;
+}
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 9c4834c..a130d3a 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2672,3 +2672,17 @@ int kvmppc_enable_hwrng(void)
 
     return kvmppc_enable_hcall(kvm_state, H_RANDOM);
 }
+
+unsigned long get_guest_max_pfn(void)
+{
+    /* To be done */
+
+    return 0;
+}
+
+unsigned long *tighten_guest_free_page_bmap(unsigned long *bmap)
+{
+    /* To be done */
+
+    return bmap;
+}
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 97afe02..181c59c 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2651,3 +2651,17 @@ void kvm_s390_apply_cpu_model(const S390CPUModel *model, Error **errp)
         }
     }
 }
+
+unsigned long get_guest_max_pfn(void)
+{
+    /* To be done */
+
+    return 0;
+}
+
+unsigned long *tighten_guest_free_page_bmap(unsigned long *bmap)
+{
+    /* To be done */
+
+    return bmap;
+}
-- 
1.9.1
