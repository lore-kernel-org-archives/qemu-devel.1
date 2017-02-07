Received: from eggs.gnu.org ([2001:4830:134:3::10]:43525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cazg3-0003N6-TV
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:55:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cazg0-0002xy-T5
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:55:00 -0500
Received: from mail.ispras.ru ([83.149.199.45]:40782)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1cazg0-0002xo-LW
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:54:56 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
Date: Tue, 7 Feb 2017 09:54:57 +0300
Message-ID: <002801d2810f$18809c20$4981d460$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: [Qemu-devel] [PATCH] icount: remove useless exit_request assignment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <dovgaluk@ispras.ru>

This patch removes unneeded assignment to cpu->exit_request.
cpu_exec_nocache executes all available instructions and therefore
icount becomes 0. Then other conditions will break the execution
loop, making assignment to cpu->exit_request useless.

This patch should be applied over Paolo's series:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg426058.html

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 cpu-exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 5cef8bc..91d1faf 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -577,7 +577,6 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
         if (insns_left > 0) {
             cpu_exec_nocache(cpu, insns_left, tb, false);
         }
-        atomic_set(&cpu->exit_request, 1);
     }
 }
 
-- 
2.8.1
