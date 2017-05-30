Received: from eggs.gnu.org ([2001:4830:134:3::10]:55717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFmcc-0005Zk-Gh
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dFmcb-0007fN-Gm
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:02 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:52286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dFmcb-0007ep-AX
	for qemu-devel@nongnu.org; Tue, 30 May 2017 15:16:01 -0400
From: Aurelien Jarno <aurelien@aurel32.net>
Date: Tue, 30 May 2017 21:15:49 +0200
Message-Id: <20170530191553.31500-2-aurelien@aurel32.net>
In-Reply-To: <20170530191553.31500-1-aurelien@aurel32.net>
References: <20170530191553.31500-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 1/5] target/sh4: log unauthorized accesses
 using qemu_log_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

qemu_log_mask() is preferred over fprintf() for logging errors.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 target/sh4/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 8f8ce81401..4c024f9529 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -420,7 +420,7 @@ static int get_physical_address(CPUSH4State * env, target_ulong * physical,
         if (!(env->sr & (1u << SR_MD))
 	    && (address < 0xe0000000 || address >= 0xe4000000)) {
 	    /* Unauthorized access in user mode (only store queues are available) */
-	    fprintf(stderr, "Unauthorized access\n");
+            qemu_log_mask(LOG_GUEST_ERROR, "Unauthorized access\n");
 	    if (rw == 0)
 		return MMU_DADDR_ERROR_READ;
 	    else if (rw == 1)
-- 
2.11.0
