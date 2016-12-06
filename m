Received: from eggs.gnu.org ([2001:4830:134:3::10]:36617)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<3w_FGWAMKCoorxsu22uzs.q204s08-rs9sz121u18.25u@flex--dje.bounces.google.com>)
	id 1cEJKb-0007Qr-3g
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<3w_FGWAMKCoorxsu22uzs.q204s08-rs9sz121u18.25u@flex--dje.bounces.google.com>)
	id 1cEJKX-00029h-VU
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:15:05 -0500
Received: from mail-pg0-f74.google.com ([74.125.83.74]:33097)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from
	<3w_FGWAMKCoorxsu22uzs.q204s08-rs9sz121u18.25u@flex--dje.bounces.google.com>)
	id 1cEJKX-000243-Pl
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 12:15:01 -0500
Received: by mail-pg0-f74.google.com with SMTP id p66so32876393pga.0
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 09:14:40 -0800 (PST)
MIME-Version: 1.0
Message-ID: <001a113ec6308021110543008630@google.com>
Date: Tue, 06 Dec 2016 17:13:39 +0000
From: Doug Evans <dje@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed; delsp=yes
Subject: [Qemu-devel] [PATCH] x86: Fix eflags tracking for syscall insn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com

Hi.

While researching an issue related to the syscall insn it seemed
like eflags status tracking was missing this step.

I think(!) this is correct, it follows what similar code does elsewhere,
and what the doc says. If it's not correct IWBN to clarify the situation.

commit 393243eda30d4429a07a0f7c29b0f6297616a355
Author: Doug Evans <dje@google.com>
Date:   Tue Dec 6 09:00:42 2016 -0800

     syscall insn: update eflags to CC_OP_EFLAGS

     Signed-off-by: Doug Evans <dje@google.com>

diff --git a/target-i386/translate.c b/target-i386/translate.c
index 324103c..9fd1a04 100644
--- a/target-i386/translate.c
+++ b/target-i386/translate.c
@@ -7104,6 +7104,10 @@ static target_ulong disas_insn(CPUX86State *env,  
DisasContext *s,
          gen_update_cc_op(s);
          gen_jmp_im(pc_start - s->cs_base);
          gen_helper_syscall(cpu_env, tcg_const_i32(s->pc - pc_start));
+        /* condition codes are modified only in long mode */
+        if (s->lma) {
+            set_cc_op(s, CC_OP_EFLAGS);
+        }
          gen_eob(s);
          break;
      case 0x107: /* sysret */
