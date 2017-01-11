Received: from eggs.gnu.org ([2001:4830:134:3::10]:45390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgc-0003JO-9B
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cROgZ-0003NM-2b
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:54 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34847)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cROgY-0003NE-T9
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 14:35:51 -0500
Received: by mail-wm0-x244.google.com with SMTP id l2so325408wml.2
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 11:35:50 -0800 (PST)
Received: from 640k.lan (94-39-158-71.adsl-ull.clienti.tiscali.it.
	[94.39.158.71]) by smtp.gmail.com with ESMTPSA id
	k11sm10463101wmb.18.2017.01.11.11.35.48 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 11 Jan 2017 11:35:49 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 11 Jan 2017 20:35:11 +0100
Message-Id: <1484163327-111841-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 17/33] target-i386: Correctly apply patch for
 syscall eflags.TF handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The change to the "syscall" insn got applied to the "iret" instruction instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 59e11fc..7e9d073 100644
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
+        /* TF handling for the syscall insn is different. The TF bit is checked
+           after the syscall insn completes. This allows #DB to not be
+           generated after one has entered CPL0 if TF is set in FMASK.  */
+        gen_eob_worker(s, false, true);
         break;
     case 0x107: /* sysret */
         if (!s->pe) {
-- 
1.8.3.1
