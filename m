Received: from eggs.gnu.org ([2001:4830:134:3::10]:52385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5WX5-0008IE-8g
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5WX0-0004Go-D6
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:03:55 -0400
Received: from mail.ispras.ru ([83.149.199.45]:59192)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1d5WX0-0004Fk-5e
	for qemu-devel@nongnu.org; Tue, 02 May 2017 08:03:50 -0400
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 02 May 2017 15:03:50 +0300
Message-ID: <20170502120350.3368.92338.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] mips: set CP0 Debug DExcCode for SDBBP
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
Cc: yongbok.kim@imgtec.com, dovgaluk@ispras.ru, aurelien@aurel32.net

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

This patch fixes setting DExcCode field of CP0 Debug register
when SDBBP instruction is executed. According to EJTAG specification,
this field must be set to the value 9 (Bp).

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 target/mips/helper.c |    2 ++
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
