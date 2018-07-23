Received: from eggs.gnu.org ([2001:4830:134:3::10]:42088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJf-0002tH-GO
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJe-0004g8-Cw
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:23 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:00 -0500
Message-Id: <20180723201748.25573-52-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 51/99] usb/dev-mtp: Fix use of uninitialized
 values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Gerd Hoffmann <kraxel@redhat.com>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

This fixes:

  hw/usb/dev-mtp.c:971:5: warning: 4th function call argument is an uninitialized value
      trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path,
                                           c->argv[1], c->argv[2]);
                                                       ^~~~~~~~~~
and:

  hw/usb/dev-mtp.c:981:12: warning: Assigned value is garbage or undefined
      offset = c->argv[1];
               ^ ~~~~~~~~~~

Reported-by: Clang Static Analyzer
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180604151421.23385-3-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
(cherry picked from commit 62713a2e50f653162387451034f1a2490e87be88)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/usb/dev-mtp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 6ecf70a79b..c50d0bc15e 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1017,12 +1017,16 @@ static MTPData *usb_mtp_get_object(MTPState *s, MTPControl *c,
 static MTPData *usb_mtp_get_partial_object(MTPState *s, MTPControl *c,
                                            MTPObject *o)
 {
-    MTPData *d = usb_mtp_data_alloc(c);
+    MTPData *d;
     off_t offset;
 
+    if (c->argc <= 2) {
+        return NULL;
+    }
     trace_usb_mtp_op_get_partial_object(s->dev.addr, o->handle, o->path,
                                         c->argv[1], c->argv[2]);
 
+    d = usb_mtp_data_alloc(c);
     d->fd = open(o->path, O_RDONLY);
     if (d->fd == -1) {
         usb_mtp_data_free(d);
-- 
2.17.1
