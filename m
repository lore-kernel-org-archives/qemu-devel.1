Received: from eggs.gnu.org ([208.118.235.92]:50689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RL-0005nO-3V
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gc4RJ-0005rz-5j
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:19 -0500
Received: from mga06.intel.com ([134.134.136.31]:14744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gc4RH-0005p1-9t
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 03:21:17 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Wed, 26 Dec 2018 16:25:20 +0800
Message-Id: <b3b315a59c56582e2c4fd5f3e262f5d38b4b8985.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
In-Reply-To: <cover.1545806972.git.weijiang.yang@intel.com>
References: <cover.1545806972.git.weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH 4/4] Report CPUID xsave area support for CET.
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

CPUID bit definition as below:
CPUID.(EAX=d, ECX=1):ECX.CET_U(bit 11): user mode state
CPUID.(EAX=d, ECX=1):ECX.CET_S(bit 12): kernel mode state

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
---
 target/i386/cpu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index cf4f2798dc..78994bfa1d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4396,12 +4396,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = xsave_area_size(env->xcr0);
         } else if (count == 1) {
             *eax = env->features[FEAT_XSAVE];
+            *ecx = env->features[FEAT_XSAVE_SV_LO];
+            *edx = env->features[FEAT_XSAVE_SV_HI];
+            *ebx = xsave_area_size_compat(x86_cpu_xsave_components(cpu) |
+                    x86_cpu_xsave_sv_components(cpu));
         } else if (count < ARRAY_SIZE(x86_ext_save_areas)) {
             if ((x86_cpu_xsave_components(cpu) >> count) & 1) {
                 const ExtSaveArea *esa = &x86_ext_save_areas[count];
                 *eax = esa->size;
                 *ebx = esa->offset;
             }
+            if ((x86_cpu_xsave_sv_components(cpu) >> count) & 1) {
+                const ExtSaveArea *esa_sv = &x86_ext_save_areas[count];
+                *eax = esa_sv->size;
+                *ebx = esa_sv->offset;
+                *ecx = 1;
+            }
         }
         break;
     }
-- 
2.17.1
