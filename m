Received: from eggs.gnu.org ([209.51.188.92]:46066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gyWAq-0006dg-Qg
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <weijiang.yang@intel.com>) id 1gyWAq-0000Rp-55
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:25:04 -0500
Received: from mga05.intel.com ([192.55.52.43]:65455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <weijiang.yang@intel.com>)
	id 1gyWAp-0008Q5-SZ
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 01:25:04 -0500
From: Yang Weijiang <weijiang.yang@intel.com>
Date: Mon, 25 Feb 2019 21:18:21 +0800
Message-Id: <20190225131822.6817-5-weijiang.yang@intel.com>
In-Reply-To: <20190225131822.6817-1-weijiang.yang@intel.com>
References: <20190225131822.6817-1-weijiang.yang@intel.com>
Subject: [Qemu-devel] [PATCH v3 4/5] Report CPUID xsave area support for CET.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, cdupontd@redhat.com, rkrcmar@redhat.com, qemu-devel@nongnu.org, mst@redhat.com
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
index d8c36e0f2f..15e2d5e009 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4399,12 +4399,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
             *ebx = xsave_area_size(env->xcr0);
         } else if (count == 1) {
             *eax = env->features[FEAT_XSAVE];
+            *ecx = env->features[FEAT_XSAVE_SV_LO];
+            *edx = env->features[FEAT_XSAVE_SV_HI];
+            *ebx = xsave_area_size_compacted(x86_cpu_xsave_components(cpu) |
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
+                *ebx = 0;
+                *ecx = 1;
+            }
         }
         break;
     }
-- 
2.17.1
