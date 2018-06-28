Received: from eggs.gnu.org ([2001:4830:134:3::10]:38350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB1-0007gB-GG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdB0-00012H-LT
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:59 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:33401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdB0-00011d-D9
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:58 -0400
Received: by mail-wr0-x241.google.com with SMTP id k7-v6so3190460wrq.0
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:58 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:54 +0200
Message-Id: <1530216310-52873-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 44/60] target-i386: Allow interrupt injection
 after STGI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to terminate the translation block after STGI so that pending
interrupts can be injected.

This fixes pending NMI injection for Jailhouse which uses "stgi; clgi"
to open a brief injection window.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
Message-Id: <37939b244dda0e9cccf96ce50f2b15df1e48315d.1522769774.git.jan.kiszka@web.de>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index c918494..07d185e 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7444,8 +7444,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                 break;
             }
             gen_update_cc_op(s);
-            gen_jmp_im(pc_start - s->cs_base);
             gen_helper_stgi(cpu_env);
+            gen_jmp_im(s->pc - s->cs_base);
+            gen_eob(s);
             break;
 
         case 0xdd: /* CLGI */
-- 
1.8.3.1
