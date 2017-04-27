Received: from eggs.gnu.org ([2001:4830:134:3::10]:37428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7b-0007wd-Ci
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1d3a7a-0001x0-B6
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 23:29:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 26 Apr 2017 23:29:19 -0400
Message-Id: <1493263764-18657-7-git-send-email-cota@braap.org>
In-Reply-To: <1493263764-18657-1-git-send-email-cota@braap.org>
References: <1493263764-18657-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v4 06/11] target/arm: optimize cross-page
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexander Graf <agraf@suse.de>, Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org, alex.bennee@linaro.org, Pranith Kumar <bobby.prani+qemu@gmail.com>

Instead of unconditionally exiting to the exec loop, use the
lookup_and_goto_ptr helper to jump to the target if it is valid.

Perf impact: see next commit's log.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 target/arm/translate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index e32e38c..02cad96 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -4085,8 +4085,12 @@ static inline void gen_goto_tb(DisasContext *s, int n, target_ulong dest)
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
2.7.4
