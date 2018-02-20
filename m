Received: from eggs.gnu.org ([2001:4830:134:3::10]:44560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eo42k-0003rq-53
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:16:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eo42h-0005hK-1R
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:16:58 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:34365)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eo42g-0005ff-OF
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 04:16:54 -0500
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 20 Feb 2018 10:16:38 +0100
Message-Id: <20180220091640.10875-3-laurent@vivier.eu>
In-Reply-To: <20180220091640.10875-1-laurent@vivier.eu>
References: <20180220091640.10875-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/4] linux-user: Fix register used for 6th and
 7th syscall argument on aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>, Laurent Vivier <laurent@vivier.eu>

From: Guido Günther <agx@sigxcpu.org>

This unbreaks the testcase from

    http://lists.nongnu.org/archive/html/qemu-arm/2018-01/msg00514.html

Thanks to Laurent Vivier for spotting the 7th one.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Suggested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <671eaa99f4e0bf3a58f76f9151f7cfa24662227f.1517565566.git.agx@sigxcpu.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/host/aarch64/safe-syscall.inc.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/host/aarch64/safe-syscall.inc.S b/linux-user/host/aarch64/safe-syscall.inc.S
index 58a2329b37..bc1f5a9792 100644
--- a/linux-user/host/aarch64/safe-syscall.inc.S
+++ b/linux-user/host/aarch64/safe-syscall.inc.S
@@ -36,7 +36,7 @@ safe_syscall_base:
 	 *               and return the result in x0
 	 * and the syscall instruction needs
 	 *               x8 == syscall number
-	 *               x0 ... x7 == syscall arguments
+	 *               x0 ... x6 == syscall arguments
 	 *               and returns the result in x0
 	 * Shuffle everything around appropriately.
 	 */
@@ -47,8 +47,8 @@ safe_syscall_base:
 	mov	x2, x4
 	mov	x3, x5
 	mov	x4, x6
-	mov	x6, x7
-	ldr	x7, [sp]
+	mov	x5, x7
+	ldr	x6, [sp]
 
 	/* This next sequence of code works in conjunction with the
 	 * rewind_if_safe_syscall_function(). If a signal is taken
-- 
2.14.3
