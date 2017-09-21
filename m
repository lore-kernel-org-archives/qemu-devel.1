Received: from eggs.gnu.org ([2001:4830:134:3::10]:53226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duzJa-0001NL-CW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1duzJW-0002Gj-HG
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:06:42 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:50464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1duzJW-0002CS-BD
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 07:06:38 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b195so701739wmb.5
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 04:06:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 21 Sep 2017 12:06:25 +0100
Message-Id: <20170921110625.9500-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] accel/tcg/cputlb: avoid recursive BQL (fixes
 #1706296)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Jones <rjones@redhat.com>, Paolo Bonzini <bonzini@gnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

The mmio path (see exec.c:prepare_mmio_access) already protects itself
against recursive locking and it makes sense to do the same for
io_readx/writex. Otherwise any helper running in the BQL context will
assert when it attempts to write to device memory as in the case of
the bug report.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
CC: Richard Jones <rjones@redhat.com>
CC: Paolo Bonzini <bonzini@gnu.org>
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
2.14.1
