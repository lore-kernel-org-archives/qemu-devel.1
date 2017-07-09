Received: from eggs.gnu.org ([2001:4830:134:3::10]:46359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zJ-0004RA-71
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dU6zD-0002zQ-W5
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:41 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48077)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dU6zD-0002vI-O3
	for qemu-devel@nongnu.org; Sun, 09 Jul 2017 03:50:35 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Jul 2017 03:49:54 -0400
Message-Id: <1499586614-20507-3-git-send-email-cota@braap.org>
In-Reply-To: <1499586614-20507-1-git-send-email-cota@braap.org>
References: <1499586614-20507-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 02/22] translate-all: remove redundant
 !tcg_enabled check in dump_exec_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This check is redundant because it is already performed by the only
caller of dump_exec_info -- the caller was updated by b7da97eef
("monitor: Check whether TCG is enabled before running the "info jit"
code").

Checking twice wouldn't necessarily be too bad, but here the check also
returns with tb_lock held. So we can either do the check before tb_lock is
acquired, or just get rid of it. Given that it is redundant, I am going
for the latter option.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index dfb9f0d..f768681 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1851,11 +1851,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
 
     tb_lock();
 
-    if (!tcg_enabled()) {
-        cpu_fprintf(f, "TCG not enabled\n");
-        return;
-    }
-
     target_code_size = 0;
     max_target_code_size = 0;
     cross_page = 0;
-- 
2.7.4
