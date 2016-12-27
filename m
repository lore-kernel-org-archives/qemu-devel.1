Received: from eggs.gnu.org ([2001:4830:134:3::10]:53890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cLxJX-0004zr-Ap
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cLxJU-0006ks-PA
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cLxJU-0006ke-Iv
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:21:32 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 27 Dec 2016 17:21:17 -0200
Message-Id: <1482866480-26208-2-git-send-email-ehabkost@redhat.com>
In-Reply-To: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
References: <1482866480-26208-1-git-send-email-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 1/4] kvm: Simplify invtsc check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, Haozhong Zhang <haozhong.zhang@intel.com>

Instead of searching the table we have just built, we can check
the env->features field directly.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 10a9cd8..a26290f 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -962,8 +962,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
         has_msr_mcg_ext_ctl = has_msr_feature_control = true;
     }
 
-    c = cpuid_find_entry(&cpuid_data.cpuid, 0x80000007, 0);
-    if (c && (c->edx & 1<<8) && invtsc_mig_blocker == NULL) {
+    if ((env->features[FEAT_8000_0007_EDX] & CPUID_APM_INVTSC) &&
+        invtsc_mig_blocker == NULL) {
         /* for migration */
         error_setg(&invtsc_mig_blocker,
                    "State blocked by non-migratable CPU device"
-- 
2.7.4
