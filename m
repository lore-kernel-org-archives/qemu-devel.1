Received: from eggs.gnu.org ([2001:4830:134:3::10]:59408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOF-0001gu-5W
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dOE-0001Y8-6q
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:15 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:36145)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dOE-0001Xe-1z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:14 -0400
Received: by mail-qt0-x243.google.com with SMTP id t52so21724352qtb.3
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:14 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:41 -0700
Message-Id: <20170502192300.2124-7-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 06/25] target/arm: optimize cross-page
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
Cc: cota@braap.org

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
2.9.3
