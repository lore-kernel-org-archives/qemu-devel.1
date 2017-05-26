Received: from eggs.gnu.org ([2001:4830:134:3::10]:40527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbQ-0000cb-E1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbP-0008KG-KO
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:56 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbP-0008KB-GH
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:55 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so2668736qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:16:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:21 -0700
Message-Id: <20170526211638.32301-10-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v7 09/26] target/i386: optimize cross-page
 direct jumps in softmmu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

Instead of unconditionally exiting to the exec loop, use the
gen_jr helper to jump to the target if it is valid.

Perf impact: see next commit's log.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-10-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/i386/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/translate.c b/target/i386/translate.c
index f0e48dc..ea113fe 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -2154,9 +2154,9 @@ static inline void gen_goto_tb(DisasContext *s, int tb_num, target_ulong eip)
         gen_jmp_im(eip);
         tcg_gen_exit_tb((uintptr_t)s->tb + tb_num);
     } else {
-        /* jump to another page: currently not optimized */
+        /* jump to another page */
         gen_jmp_im(eip);
-        gen_eob(s);
+        gen_jr(s, cpu_tmp0);
     }
 }
 
-- 
2.9.4
