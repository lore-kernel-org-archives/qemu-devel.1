Received: from eggs.gnu.org ([209.51.188.92]:51785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyB-0004RM-Nu
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyB-0004FX-3D
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:47 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:56124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyA-0004DS-TM
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:47 -0500
Received: by mail-wm1-x32c.google.com with SMTP id y139so11637896wmc.5
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:53 +0100
Message-Id: <1548093980-43088-23-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 22/49] cpus: ignore ESRCH in
 qemu_cpu_kick_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>

From: Laurent Vivier <lvivier@redhat.com>

We can have a race condition between qemu_cpu_kick_thread() and
qemu_kvm_cpu_thread_fn() when we hotunplug a CPU. In this case,
qemu_cpu_kick_thread() can try to kick a thread that is exiting.
pthread_kill() returns an error and qemu is stopped by an exit(1).

   qemu:qemu_cpu_kick_thread: No such process

We can ignore safely this error.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index b09b702..154daf5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1778,7 +1778,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
     }
     cpu->thread_kicked = true;
     err = pthread_kill(cpu->thread->thread, SIG_IPI);
-    if (err) {
+    if (err && err != ESRCH) {
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
-- 
1.8.3.1
