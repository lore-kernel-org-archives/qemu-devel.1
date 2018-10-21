Received: from eggs.gnu.org ([2001:4830:134:3::10]:33563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@greensocs.com>) id 1gEEfD-0007cG-21
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@greensocs.com>) id 1gEEbr-0000t9-5I
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:21:44 -0400
Received: from greensocs.com ([193.104.36.180]:38143)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@greensocs.com>) id 1gEEbq-0000rv-QV
	for qemu-devel@nongnu.org; Sun, 21 Oct 2018 10:21:39 -0400
From: Clement Deschamps <clement.deschamps@greensocs.com>
Date: Sun, 21 Oct 2018 16:21:03 +0200
Message-Id: <20181021142103.19014-1-clement.deschamps@greensocs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] icount: fix deadlock when all cpus are sleeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Clement Deschamps <clement.deschamps@greensocs.com>, pbonzini@redhat.com, artem.k.pisarenko@gmail.com, Pavel.Dovgaluk@ispras.ru

When all cpus are sleeping (e.g in WFI), to avoid a deadlock
in the main_loop, wake it up in order to start the warp timer.

Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
---
 cpus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cpus.c b/cpus.c
index bb2a511483..798d43623a 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1554,6 +1554,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
=20
+        if (use_icount && all_cpu_threads_idle()) {
+            /*
+             * When all cpus are sleeping (e.g in WFI), to avoid a deadl=
ock
+             * in the main_loop, wake it up in order to start the warp t=
imer.
+             */
+            qemu_notify_event();
+        }
+
         qemu_tcg_rr_wait_io_event(cpu ? cpu : first_cpu);
         deal_with_unplugged_cpus();
     }
--=20
2.19.1
