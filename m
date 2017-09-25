Received: from eggs.gnu.org ([2001:4830:134:3::10]:57839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwbgR-0006SA-2A
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:17:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dwbgN-0006Ue-JA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:16:59 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:54168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dwbgN-0006Tc-Dv
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 18:16:55 -0400
Received: by mail-pf0-x22e.google.com with SMTP id x78so4513964pff.10
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 15:16:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 25 Sep 2017 15:16:50 -0700
Message-Id: <20170925221650.2190-2-richard.henderson@linaro.org>
In-Reply-To: <20170925221650.2190-1-richard.henderson@linaro.org>
References: <20170925221650.2190-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/1] accel/tcg/cputlb: avoid recursive BQL
 (fixes #1706296)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Jones <rjones@redhat.com>, Paolo Bonzini <bonzini@gnu.org>, qemu-stable@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

The mmio path (see exec.c:prepare_mmio_access) already protects itself
against recursive locking and it makes sense to do the same for
io_readx/writex. Otherwise any helper running in the BQL context will
assert when it attempts to write to device memory as in the case of
the bug report.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: Richard Jones <rjones@redhat.com>
CC: Paolo Bonzini <bonzini@gnu.org>
CC: qemu-stable@nongnu.org
Message-Id: <20170921110625.9500-1-alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index e72415a882..bcbcc4db6c 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -765,7 +765,7 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
 
     cpu->mem_io_vaddr = addr;
 
-    if (mr->global_locking) {
+    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         locked = true;
     }
@@ -800,7 +800,7 @@ static void io_writex(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
     cpu->mem_io_vaddr = addr;
     cpu->mem_io_pc = retaddr;
 
-    if (mr->global_locking) {
+    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
         qemu_mutex_lock_iothread();
         locked = true;
     }
-- 
2.13.5
