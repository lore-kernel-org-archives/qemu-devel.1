Received: from eggs.gnu.org ([2001:4830:134:3::10]:59796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQm-0003w3-Vn
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dGPQi-0005mD-JA
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:25 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dGPQi-0005lm-CQ
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 08:42:20 -0400
Received: by mail-wm0-x243.google.com with SMTP id b84so11064600wmh.0
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 05:42:20 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  1 Jun 2017 14:41:39 +0200
Message-Id: <1496320911-51305-22-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
References: <1496320911-51305-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 21/33] i386: fix read/write cr with icount option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Mihail Abakumov <mikhail.abakumov@ispras.ru>

From: Mihail Abakumov <mikhail.abakumov@ispras.ru>

Running Windows with icount causes a crash in instruction of write cr.
This patch fixes it.

Reading and writing cr cause an icount read because there are called
cpu_get_apic_tpr and cpu_set_apic_tpr functions. So, there is need
gen_io_start()/gen_io_end() calls.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Message-Id: <ffb376034ff184f2fcbe93d5317d9e76@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 1d1372f..39912f3 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7914,14 +7914,26 @@ static target_ulong disas_insn(CPUX86State *env, DisasContext *s,
                 gen_update_cc_op(s);
                 gen_jmp_im(pc_start - s->cs_base);
                 if (b & 2) {
+                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                        gen_io_start();
+                    }
                     gen_op_mov_v_reg(ot, cpu_T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          cpu_T0);
+                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                        gen_io_end();
+                    }
                     gen_jmp_im(s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
+                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                        gen_io_start();
+                    }
                     gen_helper_read_crN(cpu_T0, cpu_env, tcg_const_i32(reg));
                     gen_op_mov_reg_v(ot, rm, cpu_T0);
+                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                        gen_io_end();
+                    }
                 }
                 break;
             default:
-- 
1.8.3.1
