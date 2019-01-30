Received: from eggs.gnu.org ([209.51.188.92]:45579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOV-0004vs-G1
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gokOS-000796-QY
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gokOR-00074a-SI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 02:34:44 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 30 Jan 2019 08:34:26 +0100
Message-Id: <20190130073426.11525-9-kraxel@redhat.com>
In-Reply-To: <20190130073426.11525-1-kraxel@redhat.com>
References: <20190130073426.11525-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 8/8] usb-mtp: replace the homebrew write with
 qemu_write_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Bandan Das <bsd@redhat.com>

From: Bandan Das <bsd@redhat.com>

qemu_write_full takes care of partial blocking writes,
as in cases of larger file sizes

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bandan Das <bsd@redhat.com>
Message-id: 20190129131908.27924-4-bsd@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-mtp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 2ca25c9da5..f1d20fa1b9 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1632,24 +1632,16 @@ static char *utf16_to_str(uint8_t len, uint16_t *arr)
 /* Wrapper around write, returns 0 on failure */
 static uint64_t write_retry(int fd, void *buf, uint64_t size, off_t offset)
 {
-        uint64_t bytes_left = size, ret;
+        uint64_t ret = 0;
 
         if (lseek(fd, offset, SEEK_SET) < 0) {
             goto done;
         }
 
-        while (bytes_left > 0) {
-                ret = write(fd, buf, bytes_left);
-                if ((ret == -1) && (errno != EINTR || errno != EAGAIN ||
-                                    errno != EWOULDBLOCK)) {
-                        break;
-                }
-                bytes_left -= ret;
-                buf += ret;
-        }
+        ret = qemu_write_full(fd, buf, size);
 
 done:
-        return size - bytes_left;
+        return ret;
 }
 
 static void usb_mtp_update_object(MTPObject *parent, char *name)
-- 
2.9.3
