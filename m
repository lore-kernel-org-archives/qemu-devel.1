Received: from eggs.gnu.org ([2001:4830:134:3::10]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMW2m-0007Cq-Ae
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:31:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMW2i-00010Y-8Z
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:31:08 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:46166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eMW2i-000103-22
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 04:31:04 -0500
Received: by mail-wm0-x242.google.com with SMTP id r78so6017641wme.5
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 01:31:03 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed,  6 Dec 2017 09:30:50 +0000
Message-Id: <20171206093050.25308-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] target/sh4/translate.c: fix TCG leak
 during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 1735384@bugs.launchpad.net, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

This fixes bug #1735384 while running java under qemu-sh4. When debug
was enabled it showed a problem with TCG temps. Once fixed I was able
to run java -version normally.

Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/sh4/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 703020fe87..b4b5c822d0 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -2189,7 +2189,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4State *env, int *pmax_insns)
     }
 
     /* If op_src is not a valid register, then op_arg was a constant.  */
-    if (op_src < 0) {
+    if (op_src < 0 && !TCGV_IS_UNUSED(op_arg)) {
         tcg_temp_free_i32(op_arg);
     }
 
-- 
2.15.1
