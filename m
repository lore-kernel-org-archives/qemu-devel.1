Received: from eggs.gnu.org ([2001:4830:134:3::10]:55388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewi6D-0005b8-12
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 01:40:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ewi6C-0003Bw-3F
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 01:40:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Fri, 16 Mar 2018 06:39:53 +0100
Message-Id: <1521178795-21894-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1521178795-21894-1-git-send-email-thuth@redhat.com>
References: <1521178795-21894-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] tests/boot-sector: Add magic bytes to
 s390x boot code header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Victor Kaplansky <victork@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org, qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

We're going to use the s390x boot code for testing CD-ROM booting.
But the ISO loader of the s390-ccw bios is a little bit more picky
than the network loader and expects some magic bytes in the header
of the file (see linux_s390_magic in pc-bios/s390-ccw/bootmap.c), so
we've got to add them in our boot code here, too.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/boot-sector.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tests/boot-sector.c b/tests/boot-sector.c
index c373f0e..7824286 100644
--- a/tests/boot-sector.c
+++ b/tests/boot-sector.c
@@ -68,8 +68,11 @@ static uint8_t x86_boot_sector[512] = {
 };
 
 /* For s390x, use a mini "kernel" with the appropriate signature */
-static const uint8_t s390x_psw[] = {
-    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00
+static const uint8_t s390x_psw_and_magic[] = {
+    0x00, 0x08, 0x00, 0x00, 0x80, 0x01, 0x00, 0x00,  /* Program status word  */
+    0x02, 0x00, 0x00, 0x18, 0x60, 0x00, 0x00, 0x50,  /* Magic:               */
+    0x02, 0x00, 0x00, 0x68, 0x60, 0x00, 0x00, 0x50,  /* see linux_s390_magic */
+    0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40, 0x40   /* in the s390-ccw bios */
 };
 static const uint8_t s390x_code[] = {
     0xa7, 0xf4, 0x00, 0x0a,                                /* j 0x10010 */
@@ -110,7 +113,7 @@ int boot_sector_init(char *fname)
     } else if (g_str_equal(arch, "s390x")) {
         len = 0x10000 + sizeof(s390x_code);
         boot_code = g_malloc0(len);
-        memcpy(boot_code, s390x_psw, sizeof(s390x_psw));
+        memcpy(boot_code, s390x_psw_and_magic, sizeof(s390x_psw_and_magic));
         memcpy(&boot_code[0x10000], s390x_code, sizeof(s390x_code));
     } else {
         g_assert_not_reached();
-- 
1.8.3.1
