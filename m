Received: from eggs.gnu.org ([2001:4830:134:3::10]:46374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJi-0006SM-BI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cPQJe-0008Mn-Dp
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cPQJe-0008MA-8z
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:56:02 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri,  6 Jan 2017 09:55:34 +0100
Message-Id: <1483692945-9866-7-git-send-email-kraxel@redhat.com>
In-Reply-To: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
References: <1483692945-9866-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 06/17] wctablet: track line speed,
 reset on speed changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: avg.tolik@gmail.com, Gerd Hoffmann <kraxel@redhat.com>

Hook up ioctl callback to get notified when the guest reconfigures the
serial port.  Keep track of the line speed, also reset the device (just
flush buffers) on line speed changes.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 backends/wctablet.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/backends/wctablet.c b/backends/wctablet.c
index 767887e..4d14e96 100644
--- a/backends/wctablet.c
+++ b/backends/wctablet.c
@@ -113,6 +113,7 @@ typedef struct {
     uint8_t outbuf[WC_OUTPUT_BUF_MAX_LEN];
     int outlen;
     /* Command to be sent to serial port */
+    int line_speed;
 } TabletState;
 
 static int wctablet_memcmp(uint8_t *a1, uint8_t *a2, int count)
@@ -152,6 +153,13 @@ static void wctablet_queue_output(TabletState *tablet, uint8_t *buf, int count)
     tablet->outlen += count;
 }
 
+static void wctablet_reset(TabletState *tablet)
+{
+    /* clear buffers */
+    tablet->query_index = 0;
+    tablet->outlen = 0;
+}
+
 static void wctablet_event(void *opaque, int x,
                            int y, int dz, int buttons_state)
 {
@@ -277,6 +285,25 @@ static int wctablet_chr_write(struct CharDriverState *s,
     return len;
 }
 
+static int wctablet_chr_ioctl(CharDriverState *s, int cmd, void *arg)
+{
+    TabletState *tablet = (TabletState *) s->opaque;
+    QEMUSerialSetParams *ssp;
+
+    switch (cmd) {
+    case CHR_IOCTL_SERIAL_SET_PARAMS:
+        ssp = arg;
+        if (tablet->line_speed != ssp->speed) {
+            wctablet_reset(tablet);
+            tablet->line_speed = ssp->speed;
+        }
+        break;
+    default:
+        return -ENOTSUP;
+    }
+    return 0;
+}
+
 static void wctablet_chr_free(struct CharDriverState *chr)
 {
     g_free (chr->opaque);
@@ -299,6 +326,7 @@ static CharDriverState *qemu_chr_open_wctablet(const char *id,
         return NULL;
     }
     chr->chr_write = wctablet_chr_write;
+    chr->chr_ioctl = wctablet_chr_ioctl;
     chr->chr_free = wctablet_chr_free;
     *be_opened = true;
 
-- 
1.8.3.1
