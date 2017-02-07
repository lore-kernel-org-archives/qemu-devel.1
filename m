Received: from eggs.gnu.org ([2001:4830:134:3::10]:42046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cazbn-0001ok-Ai
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:50:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cazbk-00011p-9J
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:50:35 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40462)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cazbk-00011M-2D
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:50:32 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
Date: Tue, 7 Feb 2017 09:50:30 +0300
Message-ID: <002701d2810e$7929bf30$6b7d3d90$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: [Qemu-devel] [PATCH] replay: check icount in cpu exec loop
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>, 'Paolo Bonzini' <pbonzini@redhat.com>

This patch adds check to break cpu loop when icount expires without
setting the TB_EXIT_ICOUNT_EXPIRED flag. It happens when there is no
available translated blocks and all instructions were executed.
In icount replay mode unnecessary tb_find will be called (which may
cause an exception) and execution will be non-deterministic.

This patch should be applied over Paolo's series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg426058.html

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpu-exec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 3838eb8..5cef8bc 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -519,7 +519,8 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     }
 
     /* Finally, check if we need to exit to the main loop.  */
-    if (unlikely(atomic_read(&cpu->exit_request) || replay_has_interrupt())) {
+    if (unlikely(atomic_read(&cpu->exit_request)
+        || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
         atomic_set(&cpu->exit_request, 0);
         cpu->exception_index = EXCP_INTERRUPT;
         return true;
-- 
2.8.1
