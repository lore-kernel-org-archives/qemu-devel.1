Received: from eggs.gnu.org ([2001:4830:134:3::10]:52858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fS08i-0007s5-LG
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 09:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fS08f-0006Yz-Eu
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 09:12:12 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Sun, 10 Jun 2018 15:12:05 +0200
Message-Id: <1528636325-4237-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/s390x/ipl: Fix crash that occurs when
 -kernel is used with small images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

Add a sanity check to fix the following crash:

$ echo "Insane in the mainframe" > /tmp/test.txt
$ s390x-softmmu/qemu-system-s390x -nographic -kernel /tmp/test.txt
Segmentation fault (core dumped)

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/ipl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 04245b5..9bb9b50 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -168,7 +168,8 @@ static void s390_ipl_realize(DeviceState *dev, Error **errp)
          * we can not rely on the ELF entry point - it was 0x800 (the SALIPL
          * loader) and it won't work. For this case we force it to 0x10000, too.
          */
-        if (pentry == KERN_IMAGE_START || pentry == 0x800) {
+        if ((pentry == KERN_IMAGE_START || pentry == 0x800) &&
+            kernel_size > KERN_PARM_AREA + strlen(ipl->cmdline)) {
             ipl->start_addr = KERN_IMAGE_START;
             /* Overwrite parameters in the kernel image, which are "rom" */
             strcpy(rom_ptr(KERN_PARM_AREA), ipl->cmdline);
-- 
1.8.3.1
