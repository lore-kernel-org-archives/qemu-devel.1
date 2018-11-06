Received: from eggs.gnu.org ([2001:4830:134:3::10]:40129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK9Cr-0002l6-Do
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:48:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gK93V-0001OE-WF
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:41 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332]:36807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gK93V-0008JR-42
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 16:38:37 -0500
Received: by mail-wm1-x332.google.com with SMTP id a8-v6so13741234wmf.1
	for <qemu-devel@nongnu.org>; Tue, 06 Nov 2018 13:38:07 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue,  6 Nov 2018 22:37:47 +0100
Message-Id: <1541540283-45699-2-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
References: <1541540283-45699-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 01/17] icount: fix deadlock when all cpus are
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
