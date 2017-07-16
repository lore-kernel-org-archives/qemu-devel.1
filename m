Received: from eggs.gnu.org ([2001:4830:134:3::10]:46118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmY-0001Ae-W1
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008G5-Df
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:46 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35925)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008FL-7e
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:45 -0400
Message-Id: <1500235468-15341-3-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 02/45] translate-all: remove redundant
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

Reviewed-by: Richard Henderson <rth@twiddle.net>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e09bd43..090ebad 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1858,11 +1858,6 @@ void dump_exec_info(FILE *f, fprintf_function cpu_fprintf)
 
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
