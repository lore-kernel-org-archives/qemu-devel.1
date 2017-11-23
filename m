Received: from eggs.gnu.org ([2001:4830:134:3::10]:48546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1eHrK2-0001U3-9K
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:13:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bp@alien8.de>) id 1eHrJy-0005ho-Ax
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:13:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59732)
	by eggs.gnu.org with esmtp (Exim 4.71) (envelope-from <bp@alien8.de>)
	id 1eHrJy-0005gL-4G
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 08:13:38 -0500
Date: Thu, 23 Nov 2017 14:13:31 +0100
From: Borislav Petkov <bp@alien8.de>
Message-ID: <20171123131331.5jyqwlbgthijqgl7@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Subject: [Qemu-devel] qemu x86 CPUID leafs override
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>

Hi guys,

I'm using the hack below to do some quick kernel testing by setting
arbitrary feature bits and then make it execute the code for that
feature.

For example, boot with:

-cpu EPYC,cpuid-leaf=0x80000007,ebx=0xf

to set some RAS feature bits and test newer RAS code.

Would something like that be of interest to a wider audience?

It is rough and ugly but if deemed useful, I could try to clean it up.

Thx.

---
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 045d66191f28..249fb23be696 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -2732,6 +2732,13 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t limit;
     uint32_t signature[3];
 
+    /*
+     * Pull up max xlevel in case the one we've specified on the cmdline is
+     * higher.
+     */
+    if (cpu->cpuid_leaf && env->cpuid_xlevel < cpu->cpuid_leaf)
+	    env->cpuid_xlevel = cpu->cpuid_leaf;
+
     /* Calculate & apply limits for different index ranges */
     if (index >= 0xC0000000) {
         limit = env->cpuid_xlevel2;
@@ -3140,6 +3147,22 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         *edx = 0;
         break;
     }
+
+    /* Do CPUID overrides: */
+    if (cpu->cpuid_leaf && cpu->cpuid_leaf == index) {
+
+	    if (cpu->eax)
+		    *eax = cpu->eax;
+
+	    if (cpu->ebx)
+		    *ebx = cpu->ebx;
+
+	    if (cpu->ecx)
+		    *ecx = cpu->ecx;
+
+	    if (cpu->edx)
+		    *edx = cpu->edx;
+    }
 }
 
 /* CPUClass::reset() */
@@ -4173,6 +4196,11 @@ static Property x86_cpu_properties[] = {
      * to the specific Windows version being used."
      */
     DEFINE_PROP_INT32("x-hv-max-vps", X86CPU, hv_max_vps, -1),
+    DEFINE_PROP_UINT32("cpuid-leaf", X86CPU, cpuid_leaf, UINT32_MAX),
+    DEFINE_PROP_UINT32("eax", X86CPU, eax, UINT32_MAX),
+    DEFINE_PROP_UINT32("ebx", X86CPU, ebx, UINT32_MAX),
+    DEFINE_PROP_UINT32("ecx", X86CPU, ecx, UINT32_MAX),
+    DEFINE_PROP_UINT32("edx", X86CPU, edx, UINT32_MAX),
     DEFINE_PROP_END_OF_LIST()
 };
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b89..b336b0849456 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1284,6 +1284,13 @@ struct X86CPU {
     int32_t thread_id;
 
     int32_t hv_max_vps;
+
+    /*
+     * CPUID overrides:
+     */
+    uint32_t cpuid_leaf;
+    uint32_t eax, ebx, ecx, edx;
+
 };
 
 static inline X86CPU *x86_env_get_cpu(CPUX86State *env)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
