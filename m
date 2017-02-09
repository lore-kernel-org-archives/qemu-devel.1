Received: from eggs.gnu.org ([2001:4830:134:3::10]:38253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgjD-0002eb-4H
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cbgj9-00080B-HR
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:07 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cbgj9-000803-C7
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 23:53:03 -0500
Received: by mail-pg0-x242.google.com with SMTP id 204so16794149pge.2
	for <qemu-devel@nongnu.org>; Wed, 08 Feb 2017 20:53:03 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Wed,  8 Feb 2017 20:51:52 -0800
Message-Id: <20170209045154.16868-21-rth@twiddle.net>
In-Reply-To: <20170209045154.16868-1-rth@twiddle.net>
References: <20170209045154.16868-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 20/22] target/openrisc: Optimize l.jal to next
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

This allows the tcg optimizer to see, and fold, all of the
constants involved in a GOT base register load sequence.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 66064e1..cda84b6 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -198,7 +198,11 @@ static void gen_jump(DisasContext *dc, int32_t n26, uint32_t reg, uint32_t op0)
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
         break;
     case 0x01:     /* l.jal */
-        tcg_gen_movi_tl(cpu_R[9], (dc->pc + 8));
+        tcg_gen_movi_tl(cpu_R[9], dc->pc + 8);
+        /* Optimize jal being used to load the PC for PIC.  */
+        if (tmp_pc == dc->pc + 8) {
+            return;
+        }
         tcg_gen_movi_tl(jmp_pc, tmp_pc);
         break;
     case 0x03:     /* l.bnf */
-- 
2.9.3
