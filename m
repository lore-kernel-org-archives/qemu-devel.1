Received: from eggs.gnu.org ([2001:4830:134:3::10]:42025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjeg-0000Zb-5u
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRjef-0000hg-8H
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRjef-0000hT-3F
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:59:17 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jan 2017 15:53:54 -0200
Message-Id: <20170112175356.21701-5-ehabkost@redhat.com>
In-Reply-To: <20170112175356.21701-1-ehabkost@redhat.com>
References: <20170112175356.21701-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 4/6] target/i386: Fix bad patch application to
 translate.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Doug Evans <dje@google.com>

From: Doug Evans <dje@google.com>

In commit c52ab08aee6f7d4717fc6b517174043126bd302f,
the patch snippet for the "syscall" insn got applied to "iret".

Signed-off-by: Doug Evans <dje@google.com>
Message-Id: <f403045cde4049058c05446d5c04@google.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 59e11fcd1f..7adfff09fc 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -6435,10 +6435,7 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                                       tcg_const_i32(s->pc - s->cs_base));
             set_cc_op(s, CC_OP_EFLAGS);
         }
-        /* TF handling for the syscall insn is different. The TF bit is checked
-           after the syscall insn completes. This allows #DB to not be
-           generated after one has entered CPL0 if TF is set in FMASK.  */
-        gen_eob_worker(s, false, true);
+        gen_eob(s);
         break;
     case 0xe8: /* call im */
         {
@@ -7119,7 +7116,10 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
         gen_update_cc_op(s);
         gen_jmp_im(pc_start - s->cs_base);
         gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
-        gen_eob(s);
+        /* TF handling for the syscall insn is different. The TF bit is  checked
+           after the syscall insn completes. This allows #DB to not be
+           generated after one has entered CPL0 if TF is set in FMASK.  */
+        gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
-- 
2.11.0.259.g40922b1
