Received: from eggs.gnu.org ([2001:4830:134:3::10]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi69-0000Ro-Tn
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dZi67-0004wS-Oj
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:28:53 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 24 Jul 2017 15:27:30 -0300
Message-Id: <20170724182751.18261-15-f4bug@amsat.org>
In-Reply-To: <20170724182751.18261-1-f4bug@amsat.org>
References: <20170724182751.18261-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 2.10 14/35] vfio/ccw: fix incorrect
 malloc() size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Since sizeof(struct vfio_irq_info) < sizeof(struct vfio_irq_set) a heap overflow
never occured. Still, let's use the correct size.

hw/vfio/ccw.c:170:16: warning: Cast a region whose size is not a multiple of the destination type size
    irq_info = g_malloc0(sizeof(*irq_set));
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/vfio/ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 12d0262336..8d97b53e77 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -168,7 +168,7 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
-    argsz = sizeof(*irq_set);
+    argsz = sizeof(*irq_info);
     irq_info = g_malloc0(argsz);
     irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
     irq_info->argsz = argsz;
-- 
2.13.3
