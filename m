Received: from eggs.gnu.org ([2001:4830:134:3::10]:40495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbM-0000ZF-Sy
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEMbL-0008JJ-UY
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:52 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33643)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEMbL-0008JB-Qc
	for qemu-devel@nongnu.org; Fri, 26 May 2017 17:16:51 -0400
Received: by mail-qk0-x241.google.com with SMTP id o85so2668633qkh.0
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 14:16:51 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 26 May 2017 14:16:18 -0700
Message-Id: <20170526211638.32301-7-rth@twiddle.net>
In-Reply-To: <20170526211638.32301-1-rth@twiddle.net>
References: <20170526211638.32301-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 06/26] target/arm: optimize cross-page
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
lookup_and_goto_ptr helper to jump to the target if it is valid.

Perf impact: see next commit's log.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1493263764-18657-7-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0b5a0bc..facb52f 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4153,8 +4153,12 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
         gen_set_pc_im(s, dest);
         tcg_gen_exit_tb((uintptr_t)s->tb + n);
     } else {
+        TCGv addr = tcg_temp_new();
+
         gen_set_pc_im(s, dest);
-        tcg_gen_exit_tb(0);
+        tcg_gen_extu_i32_tl(addr, cpu_R[15]);
+        tcg_gen_lookup_and_goto_ptr(addr);
+        tcg_temp_free(addr);
     }
 }
 
-- 
2.9.4
