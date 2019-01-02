Received: from eggs.gnu.org ([208.118.235.92]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gehJk-0002lO-Oh
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:16:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1gehJf-0005nW-4j
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:16:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1gehJa-0005jT-Q2
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:16:11 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Wed,  2 Jan 2019 15:16:03 +0100
Message-Id: <20190102141603.3681-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] cpus: ignore ESRCH in qemu_cpu_kick_thread()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

We can have a race condition between qemu_cpu_kick_thread() and
qemu_kvm_cpu_thread_fn() when we hotunplug a CPU. In this case,
qemu_cpu_kick_thread() can try to kick a thread that is exiting.
pthread_kill() returns an error and qemu is stopped by an exit(1).

   qemu:qemu_cpu_kick_thread: No such process

We can ignore safely this error.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 cpus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cpus.c b/cpus.c
index 0ddeeefc14..4717490bd0 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1778,7 +1778,7 @@ static void qemu_cpu_kick_thread(CPUState *cpu)
     }
     cpu->thread_kicked =3D true;
     err =3D pthread_kill(cpu->thread->thread, SIG_IPI);
-    if (err) {
+    if (err && err !=3D ESRCH) {
         fprintf(stderr, "qemu:%s: %s", __func__, strerror(err));
         exit(1);
     }
--=20
2.20.1
