Received: from eggs.gnu.org ([2001:4830:134:3::10]:58346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U6h-0006Yx-Dk
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:49:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U6g-0005Ur-KA
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:49:19 -0400
Received: from mail.ispras.ru ([83.149.199.45]:40028)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1e9U6g-0005T8-Cw
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 06:49:18 -0400
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 31 Oct 2017 13:49:18 +0300
Message-ID: <20171031104918.3079.99425.stgit@pasha-VirtualBox>
In-Reply-To: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
References: <20171031104741.3079.26584.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFCPATCH18/20] cpu-exec: don't overwrite
 exception_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dovgaluk@ispras.ru

This patch adds a condition before overwriting exception_index fiels.
It is needed when exception_index is already set to some meaningful value.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 accel/tcg/cpu-exec.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 4318441..35d0240 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -585,7 +585,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(atomic_read(&cpu->exit_request)
         || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
         atomic_set(&cpu->exit_request, 0);
-        cpu->exception_index = EXCP_INTERRUPT;
+        if (cpu->exception_index == -1) {
+            cpu->exception_index = EXCP_INTERRUPT;
+        }
         return true;
     }
 
