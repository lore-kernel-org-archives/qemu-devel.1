Received: from eggs.gnu.org ([2001:4830:134:3::10]:60380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3S-0001uO-SX
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1d4y3O-0006Uc-UN
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:15:02 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33917)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1d4y3O-0006UC-Oy
	for qemu-devel@nongnu.org; Sun, 30 Apr 2017 19:14:58 -0400
Received: by mail-pg0-x244.google.com with SMTP id t7so13879703pgt.1
	for <qemu-devel@nongnu.org>; Sun, 30 Apr 2017 16:14:58 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Mon,  1 May 2017 08:14:17 +0900
Message-Id: <3fee028d1ea02cd16470dc5c65d54974ef85b673.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
In-Reply-To: <cover.1493593744.git.shorne@gmail.com>
References: <cover.1493593744.git.shorne@gmail.com>
Subject: [Qemu-devel] [PULL 03/11] target/openrisc: Implement EPH bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: QEMU Development <qemu-devel@nongnu.org>, Tim 'mithro' Ansell <mithro@mithis.com>, Stafford Horne <shorne@gmail.com>

From: Tim 'mithro' Ansell <mithro@mithis.com>

Exception Prefix High (EPH) control bit of the Supervision Register
(SR).

The significant bits (31-12) of the vector offset address for each
exception depend on the setting of the Supervision Register (SR)'s EPH
bit and the Exception Vector Base Address Register (EVBAR).

If SR[EPH] is set, the vector offset is logically ORed with the offset
0xF0000000.

This means if EPH is;
 * 0 - Exceptions vectors start at EVBAR
 * 1 - Exception vectors start at EVBAR | 0xF0000000

Signed-off-by: Tim 'mithro' Ansell <mithro@mithis.com>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/openrisc/interrupt.c b/target/openrisc/interrupt.c
index 78f0ba9..2c91fab 100644
--- a/target/openrisc/interrupt.c
+++ b/target/openrisc/interrupt.c
@@ -69,6 +69,9 @@ void openrisc_cpu_do_interrupt(CPUState *cs)
         if (env->cpucfgr & CPUCFGR_EVBARP) {
             vect_pc |= env->evbar;
         }
+        if (env->sr & SR_EPH) {
+            vect_pc |= 0xf0000000;
+        }
         env->pc = vect_pc;
     } else {
         cpu_abort(cs, "Unhandled exception 0x%x\n", cs->exception_index);
-- 
2.9.3
