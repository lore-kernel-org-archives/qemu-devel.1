Received: from eggs.gnu.org ([2001:4830:134:3::10]:53543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNK4-0005YL-9R
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNK3-0008Or-F5
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:44 -0500
Received: from mail.ispras.ru ([83.149.199.45]:39762)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gSNK3-0008KM-1q
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 09:29:43 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 29 Nov 2018 17:29:40 +0300
Message-ID: <154350177975.8036.15938122264089433909.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
References: <154350164526.8036.12623669071583857903.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 23/39] windbg: add helper functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Add helper functions for serialization and deserialization kernel structures to
byte buffer.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 target/i386/windbgstub.c |  123 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 5d47d5c9e9..03807ce63e 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -280,6 +280,129 @@ static InitedAddr kdDebuggerDataBlock;
 static InitedAddr kdVersion;
 #endif /* TARGET_I386 */
 
+__attribute__ ((unused)) /* unused yet */
+static void windbg_set_dr(CPUState *cs, int index, target_ulong value)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    switch (index) {
+    case 0 ... 3:
+        env->dr[index] = value;
+        return;
+    case 6:
+        env->dr[6] = value | DR6_FIXED_1;
+        return;
+    case 7:
+        cpu_x86_update_dr7(env, value);
+        return;
+    }
+}
+
+/* copy from gdbstub.c */
+__attribute__ ((unused)) /* unused yet */
+static void windbg_set_sr(CPUState *cs, int sreg, uint16_t selector)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    if (selector != env->segs[sreg].selector) {
+#if defined(CONFIG_USER_ONLY)
+        cpu_x86_load_seg(env, sreg, selector);
+#else
+        unsigned int limit, flags;
+        target_ulong base;
+
+        if (!(env->cr[0] & CR0_PE_MASK) || (env->eflags & VM_MASK)) {
+            int dpl = (env->eflags & VM_MASK) ? 3 : 0;
+            base = selector << 4;
+            limit = 0xffff;
+            flags = DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                    DESC_A_MASK | (dpl << DESC_DPL_SHIFT);
+        } else {
+            if (!cpu_x86_get_descr_debug(env, selector, &base, &limit,
+                                         &flags)) {
+                return;
+            }
+        }
+        cpu_x86_load_seg_cache(env, sreg, selector, base, limit, flags);
+#endif
+    }
+}
+
+#define rwuw_p(ptr, var, is_read)                                              \
+    do {                                                                       \
+        if (is_read) {                                                         \
+            var = lduw_p(ptr);                                                 \
+        } else {                                                               \
+            stw_p(ptr, var);                                                   \
+        }                                                                      \
+    } while (0)
+
+#define rwl_p(ptr, var, is_read)                                               \
+    do {                                                                       \
+        if (is_read) {                                                         \
+            var = ldl_p(ptr);                                                  \
+        } else {                                                               \
+            stl_p(ptr, var);                                                   \
+        }                                                                      \
+    } while (0)
+
+#define rwtul_p(ptr, var, is_read)                                             \
+    do {                                                                       \
+        if (is_read) {                                                         \
+            var = ldtul_p(ptr);                                                \
+        } else {                                                               \
+            sttul_p(ptr, var);                                                 \
+        }                                                                      \
+    } while (0)
+
+#define RW_DR(ptr, cs, dr_index, is_read)                                      \
+    do {                                                                       \
+        if (is_read) {                                                         \
+            windbg_set_dr(cs, dr_index, ldtul_p(ptr));                         \
+        } else {                                                               \
+            sttul_p(ptr, X86_CPU(cs)->env.dr[dr_index]);                       \
+        }                                                                      \
+    } while (0)
+
+#define RW_SR(ptr, cs, sr_index, is_read)                                      \
+    do {                                                                       \
+        if (is_read) {                                                         \
+            windbg_set_sr(cs, sr_index, lduw_p(ptr));                          \
+        } else {                                                               \
+            stw_p(ptr, X86_CPU(cs)->env.segs[R_CS].selector);                  \
+        }                                                                      \
+    } while (0)
+
+#define RW_CR(ptr, cs, cr_index, is_read)                                      \
+    do {                                                                       \
+        if (is_read) {                                                         \
+            cpu_x86_update_cr##cr_index(env, (int32_t) ldtul_p(ptr));          \
+        } else {                                                               \
+            sttul_p(ptr, (target_ulong) X86_CPU(cs)->env.cr[cr_index]);        \
+        }                                                                      \
+    } while (0)
+
+#define CASE_FIELD(srct, field, field_size, block)                             \
+    case offsetof(srct, field):                                                \
+        field_size = sizeof_field(srct, field);                                \
+        block;                                                                 \
+        break;
+
+#define CASE_FIELD_X32_64(srct, field_x32, field_x64, field_size, block) \
+    CASE_FIELD(srct, TARGET_SAFE(field_x32, field_x64), field_size, block)
+
+#ifdef TARGET_X86_64
+#define CASE_FIELD_X32(srct, field, field_size, block)
+#define CASE_FIELD_X64(srct, field, field_size, block) \
+    CASE_FIELD(srct, field, field_size, block)
+#else  /* TARGET_I386 */
+#define CASE_FIELD_X64(srct, field, field_size, block)
+#define CASE_FIELD_X32(srct, field, field_size, block) \
+    CASE_FIELD(srct, field, field_size, block)
+#endif /* TARGET_I386 */
+
 static bool find_KPCR(CPUState *cs)
 {
     X86CPU *cpu = X86_CPU(cs);
