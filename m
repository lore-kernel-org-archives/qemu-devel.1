Received: from eggs.gnu.org ([2001:4830:134:3::10]:40611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaO-0006M0-Ua
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaO-0002u5-8M
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:49 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaO-0002u1-3o
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:48 -0500
Received: by mail-qt0-x242.google.com with SMTP id w10so2323492qtb.10
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 09:00:47 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  5 Dec 2017 14:00:12 -0300
Message-Id: <20171205170013.22337-2-f4bug@amsat.org>
In-Reply-To: <20171205170013.22337-1-f4bug@amsat.org>
References: <20171205170013.22337-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/2] target/sh4: add missing tcg_temp_free() in
 gen_conditional_jump()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Vladimir Prus <vladimir.prus@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

missed in c55497ecb8c.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sh4/translate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 703020fe87..5aeaabdd8d 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -322,13 +322,16 @@ static void gen_delayed_conditional_jump(DisasContext * ctx)
         gen_jump(ctx);
 
         gen_set_label(l1);
-        return;
+        goto done;
     }
 
     tcg_gen_brcondi_i32(TCG_COND_NE, ds, 0, l1);
     gen_goto_tb(ctx, 1, ctx->pc + 2);
     gen_set_label(l1);
     gen_jump(ctx);
+
+done:
+    tcg_temp_free(ds);
 }
 
 static inline void gen_load_fpr64(DisasContext *ctx, TCGv_i64 t, int reg)
-- 
2.15.1
