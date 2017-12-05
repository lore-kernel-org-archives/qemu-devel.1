Received: from eggs.gnu.org ([2001:4830:134:3::10]:40647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaW-0006PY-20
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaT-0002v7-0f
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:56 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaS-0002v1-Sx
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:52 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so2350990qtj.6
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 09:00:52 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  5 Dec 2017 14:00:13 -0300
Message-Id: <20171205170013.22337-3-f4bug@amsat.org>
In-Reply-To: <20171205170013.22337-1-f4bug@amsat.org>
References: <20171205170013.22337-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/2] target/sh4: add missing tcg_temp_free() in
 _decode_opc()
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

missed in c55497ecb8c and 852d481faf7.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/sh4/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 5aeaabdd8d..62d01227fc 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -604,6 +604,7 @@ static void _decode_opc(DisasContext * ctx)
 	    tcg_gen_subi_i32(addr, REG(B11_8), 4);
             tcg_gen_qemu_st_i32(REG(B7_4), addr, ctx->memidx, MO_TEUL);
 	    tcg_gen_mov_i32(REG(B11_8), addr);
+        tcg_temp_free(addr);
 	}
 	return;
     case 0x6004:		/* mov.b @Rm+,Rn */
@@ -1527,6 +1528,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_qemu_ld_i32(val, REG(B11_8), ctx->memidx, MO_TEUL);
             gen_helper_movcal(cpu_env, REG(B11_8), val);
             tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
+            tcg_temp_free(val);
         }
         ctx->has_movcal = 1;
 	return;
-- 
2.15.1
