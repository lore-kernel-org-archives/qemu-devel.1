Received: from eggs.gnu.org ([2001:4830:134:3::10]:38965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX7RU-0004Wu-LV
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dX7RT-0005U0-LF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:12 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:35368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dX7RT-0005TS-Dh
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 10:56:11 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Mon, 17 Jul 2017 16:55:55 +0200
Message-Id: <20170717145556.14142-2-aurelien@aurel32.net>
In-Reply-To: <20170717145556.14142-1-aurelien@aurel32.net>
References: <20170717145556.14142-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/2] mips: set CP0 Debug DExcCode for SDBBP
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yongbok Kim <yongbok.kim@imgtec.com>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Aurelien Jarno <aurelien@aurel32.net>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes setting DExcCode field of CP0 Debug register
when SDBBP instruction is executed. According to EJTAG specification,
this field must be set to the value 9 (Bp).

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-id: 20170502120350.3368.92338.stgit@PASHA-ISP
Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/mips/helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index e359ca3b44..166f0d1243 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -627,6 +627,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
         goto set_DEPC;
     case EXCP_DBp:
         env->CP0_Debug |= 1 << CP0DB_DBp;
+        /* Setup DExcCode - SDBBP instruction */
+        env->CP0_Debug = (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) | 9 << CP0DB_DEC;
         goto set_DEPC;
     case EXCP_DDBS:
         env->CP0_Debug |= 1 << CP0DB_DDBS;
-- 
2.11.0
