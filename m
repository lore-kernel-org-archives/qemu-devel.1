Received: from eggs.gnu.org ([2001:4830:134:3::10]:50641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6eD7-0007Am-SS
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:28:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6eD6-0000OE-6z
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:27:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d6eD6-0000Nt-1B
	for qemu-devel@nongnu.org; Fri, 05 May 2017 10:27:56 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  5 May 2017 15:27:42 +0100
Message-Id: <20170505142743.19849-2-berrange@redhat.com>
In-Reply-To: <20170505142743.19849-1-berrange@redhat.com>
References: <20170505142743.19849-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] i386: rewrite way CPUID index is
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

Change the nested if statements into a flat switch, to make
it clearer what validation / capping is being performed on
different CPUID index values.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 target/i386/cpu.c | 43 +++++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 18 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 13c0985..3d5903c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2628,26 +2628,33 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t pkg_offset;
 
     /* test if maximum index reached */
-    if (index & 0x80000000) {
+    switch (index & 0xF0000000) {
+    case 0:
+        /* Intel documentation states that invalid EAX input will
+         * return the same information as EAX=cpuid_level
+         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
+         */
+        if (index > env->cpuid_level) {
+            index = env->cpuid_level;
+        }
+        break;
+    case 0x80000000:
         if (index > env->cpuid_xlevel) {
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
+            index = env->cpuid_xlevel;
         }
-    } else {
-        if (index > env->cpuid_level)
-            index = env->cpuid_level;
+        break;
+    case 0xC0000000:
+        if (index > env->cpuid_xlevel2) {
+            index = env->cpuid_xlevel2;
+        }
+        break;
+    default:
+        /* Intel documentation states that invalid EAX input will
+         * return the same information as EAX=cpuid_level
+         * (Intel SDM Vol. 2A - Instruction Set Reference - CPUID)
+         */
+        index =  env->cpuid_level;
+        break;
     }
 
     switch(index) {
-- 
2.9.3
