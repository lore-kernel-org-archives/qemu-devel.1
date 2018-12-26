Received: from eggs.gnu.org ([208.118.235.92]:50687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RL-0005nM-37
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RJ-0005rt-54
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:14750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gc4RH-0005q6-6d
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:16 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 26 Dec 2018 16:25:19 +0800
Message-Id: <7a6de6a8c37161fc207f7003fc0e762045fb4028.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH 3/4] Add hepler functions for CPUID xsave area
 size calculation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, rkrcmar@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, yu-cheng.yu@intel.com, yi.z.zhang@intel.com, hjl.tools@gmail.com
Cc: Yang Weijiang <weijiang.yang@intel.com>, Zhang Yi <yi.z.zhang@linux.intel.com>

These functions are called when return CPUID xsave area
size information.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3630c688d6..cf4f2798dc 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1281,12 +1281,34 @@ static inline bool accel_uses_host_cpuid(void)
     return kvm_enabled() || hvf_enabled();
 }
 
+static uint32_t xsave_area_size_compat(uint64_t mask)
+{
+    int i;
+    uint64_t ret = 0;
+    uint32_t offset;
+
+    for (i = 0; i < ARRAY_SIZE(x86_ext_save_areas); i++) {
+        const ExtSaveArea *esa = &x86_ext_save_areas[i];
+        offset = i > 1 ? ret : esa->offset;
+        if ((mask >> i) & 1) {
+            ret = MAX(ret, offset + esa->size);
+        }
+    }
+    return ret;
+}
+
 static inline uint64_t x86_cpu_xsave_components(X86CPU *cpu)
 {
     return ((uint64_t)cpu->env.features[FEAT_XSAVE_COMP_HI]) << 32 |
            cpu->env.features[FEAT_XSAVE_COMP_LO];
 }
 
+static inline uint64_t x86_cpu_xsave_sv_components(X86CPU *cpu)
+{
+    return ((uint64_t)cpu->env.features[FEAT_XSAVE_SV_HI]) << 32 |
+           cpu->env.features[FEAT_XSAVE_SV_LO];
+}
+
 const char *get_register_name_32(unsigned int reg)
 {
     if (reg >= CPU_NB_REGS32) {
@@ -4913,8 +4935,10 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
         }
     }
 
-    env->features[FEAT_XSAVE_COMP_LO] = mask;
+    env->features[FEAT_XSAVE_COMP_LO] = mask & CPUID_XSTATE_USER_MASK;
     env->features[FEAT_XSAVE_COMP_HI] = mask >> 32;
+    env->features[FEAT_XSAVE_SV_LO] = mask & CPUID_XSTATE_KERNEL_MASK;
+    env->features[FEAT_XSAVE_SV_HI] = mask >> 32;
 }
 
 /***** Steps involved on loading and filtering CPUID data
-- 
2.17.1
