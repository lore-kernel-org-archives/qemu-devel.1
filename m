Received: from eggs.gnu.org ([2001:4830:134:3::10]:48226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa28-00082R-Vp
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gHa26-0002Il-EJ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:36 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:37514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gHa26-00022C-2H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 15:50:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id p2-v6so12455445wmc.2
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 12:50:19 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Oct 2018 20:50:02 +0100
Message-Id: <1540929011-19894-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
References: <1540929011-19894-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] icount: fix deadlock when all cpus are
 sleeping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Clement Deschamps <clement.deschamps@greensocs.com>

From: Clement Deschamps <clement.deschamps@greensocs.com>

When all cpus are sleeping (e.g in WFI), to avoid a deadlock
in the main_loop, wake it up in order to start the warp timer.

Signed-off-by: Clement Deschamps <clement.deschamps@greensocs.com>
Message-Id: <20181021142103.19014-1-clement.deschamps@greensocs.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpus.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/cpus.c b/cpus.c
index 3978f63..a2b33cc 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1554,6 +1554,14 @@ static void *qemu_tcg_rr_cpu_thread_fn(void *arg)
             atomic_mb_set(&cpu->exit_request, 0);
         }
 
+        if (use_icount && all_cpu_threads_idle()) {
+            /*
+             * When all cpus are sleeping (e.g in WFI), to avoid a deadlock
+             * in the main_loop, wake it up in order to start the warp timer.
+             */
+            qemu_notify_event();
+        }
+
         qemu_tcg_rr_wait_io_event(cpu ? cpu : first_cpu);
         deal_with_unplugged_cpus();
     }
-- 
1.8.3.1
