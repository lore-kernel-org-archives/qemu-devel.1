Received: from eggs.gnu.org ([2001:4830:134:3::10]:59985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9TaH-0003Eo-Hd
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:48:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1f9TaD-0006Fa-I6
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:48:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50080 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1f9TaD-0006Ei-Bd
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 06:48:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 86996F1205
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 10:47:57 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 20 Apr 2018 12:47:43 +0200
Message-Id: <20180420104743.7396-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] simple firmware.json test tool
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, Gerd Hoffmann <kraxel@redhat.com>

applies on top of the firmware.json v2 series.
---
 configure       |  2 +-
 Makefile        |  2 ++
 qemu-firmware.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 1 deletion(-)
 create mode 100644 qemu-firmware.c

diff --git a/configure b/configure
index 0a19b033bc..753f80147b 100755
--- a/configure
+++ b/configure
@@ -5495,7 +5495,7 @@ fi
 
 tools=""
 if test "$want_tools" = "yes" ; then
-  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
+  tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) qemu-firmware\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
   fi
diff --git a/Makefile b/Makefile
index 32034abe15..4d6e627113 100644
--- a/Makefile
+++ b/Makefile
@@ -543,6 +543,8 @@ qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
 qemu-keymap$(EXESUF): qemu-keymap.o ui/input-keymap.o $(COMMON_LDADDS)
 
+qemu-firmware$(EXESUF): qemu-firmware.o $(COMMON_LDADDS)
+
 fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
diff --git a/qemu-firmware.c b/qemu-firmware.c
new file mode 100644
index 0000000000..792f0fec8f
--- /dev/null
+++ b/qemu-firmware.c
@@ -0,0 +1,81 @@
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/error-report.h"
+
+#include "qapi/error.h"
+#include "qapi/qapi-types-firmware.h"
+#include "qapi/qapi-visit-firmware.h"
+#include "qapi/qobject-input-visitor.h"
+
+int main(int argc, char *argv[])
+{
+    Error *err = NULL;
+    FirmwareMappingFlash *flash;
+    Firmware *fw;
+    Visitor *v;
+    int fd, size, rc;
+    char *buf;
+
+    if (argc != 2) {
+        fprintf(stderr, "usage: qemu-firmware <firmware-desc.json>\n");
+        exit(1);
+    }
+
+    /* read file */
+    fd = open(argv[1], O_RDONLY);
+    if (fd < 0) {
+        fprintf(stderr, "open %s: %s\n", argv[1], strerror(errno));
+        exit(1);
+    }
+    size = lseek(fd, 0, SEEK_END);
+    if (size < 0) {
+        perror("lseek");
+        exit(1);
+    }
+    lseek(fd, 0, SEEK_SET);
+    buf = malloc(size+1);
+    rc = read(fd, buf, size);
+    if (rc != size) {
+        fprintf(stderr, "file read error\n");
+        exit(1);
+    }
+    buf[size] = 0;
+    close(fd);
+
+    /* parse file */
+    v = qobject_input_visitor_new_str(buf, "", &err);
+    if (!v) {
+        error_report_err(err);
+        exit(1);
+    }
+    visit_type_Firmware(v, NULL, &fw, &error_fatal);
+    visit_free(v);
+
+    /* print cmdline */
+    switch (fw->mapping->device) {
+    case FIRMWARE_DEVICE_FLASH:
+        /*
+         * FIXME: nvram should be a per-guest copy.
+         *        How to handle that best here?
+         */
+        flash = &fw->mapping->u.flash;
+        printf("-drive if=pflash,index=0,format=%s,file=%s\n",
+               BlockdevDriver_str(flash->executable->format),
+               flash->executable->pathname);
+        printf("-drive if=pflash,index=1,format=%s,file=%s\n",
+               BlockdevDriver_str(flash->nvram_template->format),
+               flash->nvram_template->pathname);
+        break;
+    case FIRMWARE_DEVICE_MEMORY:
+        printf("-bios %s\n", fw->mapping->u.memory.pathname);
+        break;
+    case FIRMWARE_DEVICE_KERNEL:
+        printf("-kernel %s\n", fw->mapping->u.kernel.pathname);
+        break;
+    default:
+        fprintf(stderr, "TODO\n");
+        break;
+    }
+
+    exit(0);
+}
-- 
2.9.3
