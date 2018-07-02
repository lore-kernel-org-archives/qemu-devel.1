Received: from eggs.gnu.org ([2001:4830:134:3::10]:49105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UP-0004eR-UN
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1fa0UP-0008Qc-10
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:41 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:35715)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1fa0UO-0008QN-S0
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:11:40 -0400
Received: by mail-pg0-x243.google.com with SMTP id i7-v6so7283886pgp.2
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 08:11:40 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Tue,  3 Jul 2018 00:10:23 +0900
Message-Id: <20180702151023.24532-26-shorne@gmail.com>
In-Reply-To: <20180702151023.24532-1-shorne@gmail.com>
References: <20180702151023.24532-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL v2 25/25] target/openrisc: Fix writes to
 interrupt mask register
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
