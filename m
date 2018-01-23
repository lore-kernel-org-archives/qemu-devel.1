Received: from eggs.gnu.org ([2001:4830:134:3::10]:40109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduKc-0000wD-MI
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:53:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduKb-00083V-OM
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:53:26 -0500
Received: from mail.ispras.ru ([83.149.199.45]:56968)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Pavel.Dovgaluk@ispras.ru>) id 1eduKb-00083L-Fx
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 03:53:25 -0500
From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Date: Tue, 23 Jan 2018 11:53:25 +0300
Message-ID: <20180123085325.3419.9724.stgit@pasha-VirtualBox>
In-Reply-To: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
References: <20180123085319.3419.97865.stgit@pasha-VirtualBox>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [RFC PATCH v5 01/24] cpu-exec: fix exception_index
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, dovgaluk@ispras.ru, kraxel@redhat.com, pavel.dovgaluk@ispras.ru, pbonzini@redhat.com, alex.bennee@linaro.org

Function cpu_handle_interrupt calls cc->cpu_exec_interrupt to process
pending hardware interrupts. Under the hood cpu_exec_interrupt uses
cpu->exception_index to pass information to the internal function which
is usually common for exception and interrupt processing.
But this value is not reset after return and may be processed again
by cpu_handle_exception. This does not happen due to overwriting
the exception_index at the end of cpu_handle_interrupt.
But this branch may also overwrite the valid exception_index in some cases.
Therefore this patch:
 1. resets exception_index just after the call to cpu_exec_interrupt
 2. prevents overwriting the meaningful value of exception_index

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/cpu-exec.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 280200f..9cc6972 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -585,6 +585,7 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
         else {
             if (cc->cpu_exec_interrupt(cpu, interrupt_request)) {
                 replay_interrupt();
+                cpu->exception_index = -1;
                 *last_tb = NULL;
             }
             /* The target hook may have updated the 'cpu->interrupt_request';
@@ -606,7 +607,9 @@ static inline bool cpu_handle_interrupt(CPUState *cpu,
     if (unlikely(atomic_read(&cpu->exit_request)
         || (use_icount && cpu->icount_decr.u16.low + cpu->icount_extra == 0))) {
         atomic_set(&cpu->exit_request, 0);
-        cpu->exception_index = EXCP_INTERRUPT;
+        if (cpu->exception_index == -1) {
+            cpu->exception_index = EXCP_INTERRUPT;
+        }
         return true;
     }
 
