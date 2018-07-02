Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzMK-00030T-DP
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fZzMJ-0008Uk-K8
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:16 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:42963)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fZzMJ-0008UY-Di
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 09:59:15 -0400
Received: by mail-pg0-x244.google.com with SMTP id c10-v6so7196214pgu.9
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 06:59:15 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  2 Jul 2018 22:58:06 +0900
Message-Id: <20180702135806.7087-26-shorne@gmail.com>
In-Reply-To: <20180702135806.7087-1-shorne@gmail.com>
References: <20180702135806.7087-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 25/25] target/openrisc: Fix writes to interrupt
 mask register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Development <qemu-devel@nongnu.org>, Stafford Horne <shorne@gmail.com>

The interrupt controller mask register (PICMR) allows writing any value
to any of the 32 interrupt mask bits.  Writing a 0 masks the interrupt
writing a 1 unmasks (enables) the the interrupt.

For some reason the old code was or'ing the write values to the PICMR
meaning it was not possible to ever mask a interrupt once it was
enabled.

I have tested this by running linux 4.18 and my regular checks, I don't
see any issues.

Reported-by: Davidson Francis <davidsondfgl@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index 541615bfb3..b66a45c1e0 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -142,7 +142,7 @@ void HELPER(mtspr)(CPUOpenRISCState *env, target_ulong spr, target_ulong rb)
         }
         break;
     case TO_SPR(9, 0):  /* PICMR */
-        env->picmr |= rb;
+        env->picmr = rb;
         break;
     case TO_SPR(9, 2):  /* PICSR */
         env->picsr &= ~rb;
-- 
2.17.0
