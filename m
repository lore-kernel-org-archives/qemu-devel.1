Received: from eggs.gnu.org ([2001:4830:134:3::10]:57301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45a-0007He-DW
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1eR45Z-00046u-9V
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 17:40:50 -0500
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 18 Dec 2017 23:40:26 +0100
Message-Id: <20171218224030.26726-3-aurelien@aurel32.net>
In-Reply-To: <20171218224030.26726-1-aurelien@aurel32.net>
References: <20171218224030.26726-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/6] target/sh4: fix TCG leak during gusa
 sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-stable@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

From: Alex Bennée <alex.bennee@linaro.org>

This fixes bug #1735384 while running java under qemu-sh4. When debug
was enabled it showed a problem with TCG temps. Once fixed I was able
to run java -version normally.

Cc: qemu-stable@nongnu.org
Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20171206093050.25308-1-alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index f56808b45d..4a4a5c877e 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2191,7 +2191,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     }
 
     /* If op_src is not a valid register, then op_arg was a constant.  */
-    if (op_src < 0) {
+    if (op_src < 0 && !TCGV_IS_UNUSED(op_arg)) {
         tcg_temp_free_i32(op_arg);
     }
 
-- 
2.15.1
