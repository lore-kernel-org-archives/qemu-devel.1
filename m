Received: from eggs.gnu.org ([2001:4830:134:3::10]:53524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85a9-0000UL-9Q
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1g85a3-0005ih-Kd
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:30:29 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  4 Oct 2018 17:28:53 +0200
Message-Id: <20181004152857.14525-12-cohuck@redhat.com>
In-Reply-To: <20181004152857.14525-1-cohuck@redhat.com>
References: <20181004152857.14525-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/15] s390x/tcg: check for AFP-register,
 BFP and DFP data exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

With the annotated functions, we can now easily check this at a central
place.

DXC 1 is to be injected if an AFP register is used (for a HFP AND FPS
instruction) when AFP is disabled.
DXC 2 is to be injected if a BFP instruction is used when AFP is
disabled.
DXC 3 is to be injected if a DFP instruction is used when AFP is
disabled.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180927130303.12236-7-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/translate.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 49e5e2cc58..67049975fa 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -6094,6 +6094,11 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     return info;
 }
 
+static bool is_afp_reg(int reg)
+{
+    return reg % 2 || reg > 6;
+}
+
 static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
 {
     const DisasInsn *insn;
@@ -6120,6 +6125,34 @@ static DisasJumpType translate_one(CPUS390XState *env, DisasContext *s)
     }
 #endif
 
+    /* process flags */
+    if (insn->flags) {
+        /* if AFP is not enabled, instructions and registers are forbidden */
+        if (!(s->base.tb->flags & FLAG_MASK_AFP)) {
+            uint8_t dxc = 0;
+
+            if ((insn->flags & IF_AFP1) && is_afp_reg(get_field(&f, r1))) {
+                dxc = 1;
+            }
+            if ((insn->flags & IF_AFP2) && is_afp_reg(get_field(&f, r2))) {
+                dxc = 1;
+            }
+            if ((insn->flags & IF_AFP3) && is_afp_reg(get_field(&f, r3))) {
+                dxc = 1;
+            }
+            if (insn->flags & IF_BFP) {
+                dxc = 2;
+            }
+            if (insn->flags & IF_DFP) {
+                dxc = 3;
+            }
+            if (dxc) {
+                gen_data_exception(dxc);
+                return DISAS_NORETURN;
+            }
+        }
+    }
+
     /* Check for insn specification exceptions.  */
     if (insn->spec) {
         int spec = insn->spec, excp = 0, r;
-- 
2.14.4
