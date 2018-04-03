Received: from eggs.gnu.org ([2001:4830:134:3::10]:53685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NR4-0000gC-Cs
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jan.kiszka@web.de>) id 1f3NQz-00005U-V7
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:01:22 -0400
Received: from mout.web.de ([212.227.15.3]:54355)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jan.kiszka@web.de>) id 1f3NQz-0008VU-Lt
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 11:01:17 -0400
From: Jan Kiszka <jan.kiszka@web.de>
Date: Tue,  3 Apr 2018 17:00:55 +0200
Message-Id: <37939b244dda0e9cccf96ce50f2b15df1e48315d.1522767657.git.jan.kiszka@web.de>
In-Reply-To: <cover.1522767657.git.jan.kiszka@web.de>
References: <cover.1522767657.git.jan.kiszka@web.de>
In-Reply-To: <cover.1522767657.git.jan.kiszka@web.de>
References: <cover.1522767657.git.jan.kiszka@web.de>
Subject: [Qemu-devel] [PATCH 2/4] target-i386: Allow interrupt injection
 after STGI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>
Cc: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

From: Jan Kiszka <jan.kiszka@siemens.com>

We need to terminate the translation block after STGI so that pending
interrupts can be injected.

This fixes pending NMI injection for Jailhouse which uses "stgi; clgi"
to open a brief injection window.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 target/i386/translate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index 0135415d92..71d97876c7 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -7450,8 +7450,9 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
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
2.13.6
