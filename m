Received: from eggs.gnu.org ([2001:4830:134:3::10]:48624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f60an-0005Oj-3y
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:14:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f60aj-0001GT-Sj
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:14:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41296)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1f60aj-0001Fi-NP
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 17:14:13 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue, 10 Apr 2018 18:14:09 -0300
Message-Id: <20180410211409.25133-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH] i386: Don't automatically enable
 FEAT_KVM_HINTS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>

The assumption in the cpu->max_features code is that anything
enabled on GET_SUPPORTED_CPUID should be enabled on "-cpu host".
This shouldn't be the case for FEAT_KVM_HINTS.

This adds a new FeatureWordInfo::no_autoenable_flags field, that
can be used to prevent FEAT_KVM_HINTS bits to be enabled
automatically.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1a6b082b6f..a20fe26573 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -295,6 +295,8 @@ typedef struct FeatureWordInfo {
     uint32_t tcg_features; /* Feature flags supported by TCG */
     uint32_t unmigratable_flags; /* Feature flags known to be unmigratable */
     uint32_t migratable_flags; /* Feature flags known to be migratable */
+    /* Features that shouldn't be auto-enabled by "-cpu host" */
+    uint32_t no_autoenable_flags;
 } FeatureWordInfo;
 
 static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
@@ -400,6 +402,11 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         },
         .cpuid_eax = KVM_CPUID_FEATURES, .cpuid_reg = R_EDX,
         .tcg_features = TCG_KVM_FEATURES,
+        /*
+         * KVM hints aren't auto-enabled by -cpu host, they need to be
+         * explicitly enabled in the command-line.
+         */
+        .no_autoenable_flags = ~0U,
     },
     [FEAT_HYPERV_EAX] = {
         .feat_names = {
@@ -4062,7 +4069,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
              */
             env->features[w] |=
                 x86_cpu_get_supported_feature_word(w, cpu->migratable) &
-                ~env->user_features[w];
+                ~env->user_features[w] & \
+                ~feature_word_info[w].no_autoenable_flags;
         }
     }
 
-- 
2.14.3
