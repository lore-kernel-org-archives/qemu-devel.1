Received: from eggs.gnu.org ([2001:4830:134:3::10]:54656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlP-0005TL-5x
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1daYlO-0007vM-G5
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 22:42:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 26 Jul 2017 23:42:13 -0300
Message-Id: <20170727024224.22900-9-f4bug@amsat.org>
In-Reply-To: <20170727024224.22900-1-f4bug@amsat.org>
References: <20170727024224.22900-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 v2 08/20] vfio/platform: fix use of
 freed memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

free the data _after_ using it.

hw/vfio/platform.c:126:29: warning: Use of memory after it is freed
        qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
                            ^~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/vfio/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 7c09deda61..da84abf4fc 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -120,11 +120,11 @@ static int vfio_set_trigger_eventfd(VFIOINTp *intp,
     *pfd = event_notifier_get_fd(intp->interrupt);
     qemu_set_fd_handler(*pfd, (IOHandler *)handler, NULL, intp);
     ret = ioctl(vbasedev->fd, VFIO_DEVICE_SET_IRQS, irq_set);
-    g_free(irq_set);
     if (ret < 0) {
         error_report("vfio: Failed to set trigger eventfd: %m");
         qemu_set_fd_handler(*pfd, NULL, NULL, NULL);
     }
+    g_free(irq_set);
     return ret;
 }
 
-- 
2.13.3
