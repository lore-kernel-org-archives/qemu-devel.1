Received: from eggs.gnu.org ([2001:4830:134:3::10]:42729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8g-0005DM-GZ
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1fgd8d-0005mt-9s
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1fgd8d-0005ln-4N
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 17:40:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EEA9818F6E1
	for <qemu-devel@nongnu.org>; Fri, 20 Jul 2018 21:40:34 +0000 (UTC)
From: Bandan Das <bsd@redhat.com>
Date: Fri, 20 Jul 2018 17:40:18 -0400
Message-Id: <20180720214020.22897-4-bsd@redhat.com>
In-Reply-To: <20180720214020.22897-1-bsd@redhat.com>
References: <20180720214020.22897-1-bsd@redhat.com>
Subject: [Qemu-devel] [PATCH 3/5] dev-mtp: retry write for incomplete
 transfers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

For large buffers, write may not copy the full buffer. For example,
on Linux, write imposes a limit of 0x7ffff000. Note that this does
not fix >4G transfers but ~>2G files will transfer successfully.

Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 1b72603dc5..c8f6eb4e9e 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1602,6 +1602,24 @@ static void utf16_to_str(uint8_t len, uint16_t *arr, char *name)
     g_free(wstr);
 }
 
+/* Wrapper around write, returns 0 on failure */
+static uint64_t write_retry(int fd, void *buf, uint64_t size)
+{
+        uint64_t bytes_left = size, ret;
+
+        while (bytes_left > 0) {
+                ret = write(fd, buf, bytes_left);
+                if ((ret == -1) && (errno != EINTR || errno != EAGAIN ||
+                                    errno != EWOULDBLOCK)) {
+                        break;
+                }
+                bytes_left -= ret;
+                buf += ret;
+        }
+
+        return size - bytes_left;
+}
+
 static void usb_mtp_write_data(MTPState *s)
 {
     MTPData *d = s->data_out;
@@ -1644,8 +1662,8 @@ static void usb_mtp_write_data(MTPState *s)
             goto success;
         }
 
-        rc = write(d->fd, d->data, s->dataset.size);
-        if (rc == -1) {
+        rc = write_retry(d->fd, d->data, s->dataset.size);
+        if (!rc) {
             usb_mtp_queue_result(s, RES_STORE_FULL, d->trans,
                                  0, 0, 0, 0);
             goto done;
-- 
2.14.4
