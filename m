Received: from eggs.gnu.org ([2001:4830:134:3::10]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLN-00026O-Cw
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzLM-0007nJ-G7
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:17 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:46152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzLM-0007mu-9y
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:58:16 -0400
Received: by mail-pg0-x244.google.com with SMTP id q14-v6so7184234pgt.13
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:58:16 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:57:42 +0900
Message-Id: <20180702135806.7087-2-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/25] target/openrisc: Fix mtspr shadow gprs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, Stafford Horne <shorne@gmail.com>

From: Richard Henderson <richard.henderson@linaro.org>

Missing break when this feature was added in 89e71e873d
("target/openrisc: implement shadow registers").  This was causing
strange issues as we get writes into the translation block jump cache
and other bits of state.

Fixes: 89e71e873d ("target/openrisc: implement shadow registers")
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index b284064381..2f337363ec 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -98,6 +98,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env,
     case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
         idx = (spr - 1024);
         env->shadow_gpr[idx / 32][idx % 32] = rb;
+        break;
 
     case TO_SPR(1, 512) ... TO_SPR(1, 512+DTLB_SIZE-1): /* DTLBW0MR 0-127 */
         idx = spr - TO_SPR(1, 512);
-- 
2.17.0
