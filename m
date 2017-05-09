Received: from eggs.gnu.org ([2001:4830:134:3::10]:58218)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85B6-0002hF-9b
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d85B3-00084J-Ai
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d85B3-00083H-3e
	for qemu-devel@nongnu.org; Tue, 09 May 2017 09:27:45 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  9 May 2017 14:27:35 +0100
Message-Id: <20170509132736.10071-2-berrange@redhat.com>
In-Reply-To: <20170509132736.10071-1-berrange@redhat.com>
References: <20170509132736.10071-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/2] i386: rewrite way CPUID index is
 validated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Change the nested if statements into a flat format, to make
it clearer what validation / capping is being performed on
different CPUID index values.

NB this changes behaviour when "index > env->cpuid_xlevel2".
This won't have any guest-visible effect because no there is
no CPUID[0xC0000001] feature supported by TCG, and KVM code
will never call cpu_x86_cpuid() with such an index value.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 target/i386/cpu.c | 35 +++++++++++++++--------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985..8cb4af4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2626,28 +2626,23 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     X86CPU *cpu = x86_env_get_cpu(env);
     CPUState *cs = CPU(cpu);
     uint32_t pkg_offset;
+    uint32_t limit;
 
-    /* test if maximum index reached */
-    if (index & 0x80000000) {
-        if (index > env->cpuid_xlevel) {
-            if (env->cpuid_xlevel2 > 0) {
-                /* Handle the Centaur's CPUID instruction. */
-                if (index > env->cpuid_xlevel2) {
-                    index = env->cpuid_xlevel2;
-                } else if (index < 0xC0000000) {
-                    index = env->cpuid_xlevel;
-                }
-            } else {
-                /* Intel documentation states that invalid EAX input will
-                 * return the same information as EAX=cpuid_level
-                 * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
-                 */
-                index =  env->cpuid_level;
-            }
-        }
+    /* Calculate & apply limits for different index ranges */
+    if (index >= 0xC0000000) {
+        limit = env->cpuid_xlevel2;
+    } else if (index >= 0x80000000) {
+        limit = env->cpuid_xlevel;
     } else {
-        if (index > env->cpuid_level)
-            index = env->cpuid_level;
+        limit = env->cpuid_level;
+    }
+
+    if (index > limit) {
+        /* Intel documentation states that invalid EAX input will
+         * return the same information as EAX=cpuid_level
+         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
+         */
+        index = env->cpuid_level;
     }
 
     switch(index) {
-- 
2.9.3
