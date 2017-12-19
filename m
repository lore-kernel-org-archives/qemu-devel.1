Received: from eggs.gnu.org ([2001:4830:134:3::10]:46957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eROMR-00026S-2B
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:19:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eROMQ-0008Q0-4i
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:19:35 -0500
Received: from heinz.dinsnail.net
	([2a01:238:43b4:3200:9392:5dcc:2f0e:a960]:47094)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@rivendell.weiser.dinsnail.net>)
	id 1eROMP-0008PB-RE
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 15:19:34 -0500
From: Michael Weiser <michael.weiser@gmx.de>
Date: Tue, 19 Dec 2017 21:16:09 +0100
Message-Id: <20171219201613.7399-2-michael.weiser@gmx.de>
In-Reply-To: <20171219201613.7399-1-michael.weiser@gmx.de>
References: <20171219201613.7399-1-michael.weiser@gmx.de>
Subject: [Qemu-devel] [PATCH v2 1/5] linux-user: Add support for big-endian
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Weiser <michael.weiser@gmx.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Enable big-endian mode for data accesses on aarch64 for big-endian linux
user mode. Activate it for all execution levels as documented by ARM:
Set the SCTLR EE bit for ELs 1 through 3. Additionally set bit E0E in
EL1 to enable it in EL0 as well.

Signed-off-by: Michael Weiser <michael.weiser@gmx.de>
---
 linux-user/main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 2fd2a143ed..7ea863260d 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -4611,6 +4611,12 @@ int main(int argc, char **argv, char **envp)
         }
         env->pc = regs->pc;
         env->xregs[31] = regs->sp;
+#ifdef TARGET_WORDS_BIGENDIAN
+        env->cp15.sctlr_el[1] |= SCTLR_E0E;
+        for (i = 1; i < 4; ++i) {
+            env->cp15.sctlr_el[i] |= SCTLR_EE;
+        }
+#endif
     }
 #elif defined(TARGET_ARM)
     {
-- 
2.15.1
