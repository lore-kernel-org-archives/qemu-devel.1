Received: from eggs.gnu.org ([2001:4830:134:3::10]:48692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dBeKb-0007Yb-VH
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:36:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dBeKY-000712-34
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:36:22 -0400
Received: from mail.ispras.ru ([83.149.199.45]:59366)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dBeKX-00070d-Ql
	for qemu-devel@nongnu.org; Fri, 19 May 2017 05:36:18 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 19 May 2017 12:36:15 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Message-ID: <ffb376034ff184f2fcbe93d5317d9e76@ispras.ru>
Subject: [Qemu-devel] [PATCH] i386: fix read/write cr with icount option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu Devel <qemu-devel@nongnu.org>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>, Pbonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Running Windows with icount causes a crash in instruction of write cr. 
This patch fixes it.

Reading and writing cr cause an icount read because there are called 
cpu_get_apic_tpr and cpu_set_apic_tpr functions. So, there is need 
gen_io_start()/gen_io_end() calls.

---
  target/i386/translate.c | 12 ++++++++++++
  1 file changed, 12 insertions(+)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 06d8833..3b009bd 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7907,14 +7907,26 @@ static target_ulong disas_insn(CPUX86State *env, 
DisasContext *s,
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
                      gen_helper_read_crN(cpu_T0, cpu_env, 
tcg_const_i32(reg));
                      gen_op_mov_reg_v(ot, rm, cpu_T0);
+                    if (s->tb->cflags & CF_USE_ICOUNT) {
+                        gen_io_end();
+                    }
                  }
                  break;
              default:
-- 
1.9.1
