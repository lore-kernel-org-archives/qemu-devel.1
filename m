Received: from eggs.gnu.org ([209.51.188.92]:42085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gm11B-000157-RJ
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1gm113-0002fW-Am
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1gm10v-0001Yv-NV
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:43:11 -0500
From: Bandan Das <bsd@redhat.com>
References: <153994006052.15678.15962440455123359491.malonedeb@gac.canonical.com>
	<CAFEAcA9vczSpf+xd+3so1YKAW-d4RKY7iVEtMvJrgSNbRjQ+Zg@mail.gmail.com>
	<jpgd0ooc1f0.fsf@linux.bootlegged.copy>
Date: Tue, 22 Jan 2019 07:41:16 -0500
In-Reply-To: <jpgd0ooc1f0.fsf@linux.bootlegged.copy> (Bandan Das's message of
	"Tue, 22 Jan 2019 07:38:43 -0500")
Message-ID: <jpg8szcc1ar.fsf_-_@linux.bootlegged.copy>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] usb-mtp: replace the homebrew write with
 qemu_write_full
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Bug 1798780 <1798780@bugs.launchpad.net>, QEMU Developers <qemu-devel@nongnu.org>


qemu_write_full takes care of partial blocking writes,
as in cases of larger file sizes

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bandan <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 31fa83589b..53e20e2161 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1630,25 +1630,16 @@ static char *utf16_to_str(uint8_t len, uint16_t *arr)
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
2.20.1
