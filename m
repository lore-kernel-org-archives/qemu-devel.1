Received: from eggs.gnu.org ([2001:4830:134:3::10]:48653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e31Oy-0006jL-Nf
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1e31Ox-0004Nx-Rp
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:57:28 -0400
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:56729)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1e31Ox-0004Ls-Li
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 10:57:27 -0400
Received: by mail-pf0-x242.google.com with SMTP id b85so10560736pfj.13
	for <qemu-devel@nongnu.org>; Fri, 13 Oct 2017 07:57:27 -0700 (PDT)
From: Stafford Horne <shorne@gmail.com>
Date: Fri, 13 Oct 2017 23:57:11 +0900
Message-Id: <20171013145714.2740-3-shorne@gmail.com>
In-Reply-To: <20171013145714.2740-1-shorne@gmail.com>
References: <20171013145714.2740-1-shorne@gmail.com>
Subject: [Qemu-devel] [PULL 2/5] target/openrisc: Make coreid and numcores
 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>

Previously coreid and numcores were hard coded as 0 and 1 respectively
as OpenRISC QEMU did not have multicore support.

Multicore support is now being added so these registers need to have
configured values.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 target/openrisc/sys_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/openrisc/sys_helper.c b/target/openrisc/sys_helper.c
index abdef5d6a5..dc6e5cc7f2 100644
--- a/target/openrisc/sys_helper.c
+++ b/target/openrisc/sys_helper.c
@@ -23,6 +23,7 @@
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
 #include "exception.h"
+#include "sysemu/sysemu.h"
 
 #define TO_SPR(group, number) (((group) << 11) + (number))
 
@@ -249,10 +250,10 @@ target_ulong HELPER(mfspr)(CPUOpenRISCState *env,
         return env->esr;
 
     case TO_SPR(0, 128): /* COREID */
-        return 0;
+        return cpu->parent_obj.cpu_index;
 
     case TO_SPR(0, 129): /* NUMCORES */
-        return 1;
+        return max_cpus;
 
     case TO_SPR(0, 1024) ... TO_SPR(0, 1024 + (16 * 32)): /* Shadow GPRs */
         idx = (spr - 1024);
-- 
2.13.6
