Received: from eggs.gnu.org ([2001:4830:134:3::10]:54704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyw-0007s5-Kg
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dPoyv-0003g3-S0
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dPoyv-0003eT-M9
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 07:48:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 27 Jun 2017 13:48:09 +0200
Message-Id: <1498564100-10045-4-git-send-email-thuth@redhat.com>
In-Reply-To: <1498564100-10045-1-git-send-email-thuth@redhat.com>
References: <1498564100-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 03/14] pc-bios/s390-ccw: Add a write()
 function for stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

The stdio functions from the SLOF libc need a write() function for
printing text to stdout/stderr. Let's implement this function by
refactoring the code from sclp_print().

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/sclp.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index a1639ba..a23bdd3 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -8,6 +8,7 @@
  * directory.
  */
 
+#include <unistd.h>
 #include "s390-ccw.h"
 #include "sclp.h"
 
@@ -51,34 +52,29 @@ void sclp_setup(void)
     sclp_set_write_mask();
 }
 
-static int _strlen(const char *str)
+ssize_t write(int fd, const void *buf, size_t len)
 {
-    int i;
-    for (i = 0; *str; i++)
-        str++;
-    return i;
-}
-
-static void _memcpy(char *dest, const char *src, int len)
-{
-    int i;
-    for (i = 0; i < len; i++)
-        dest[i] = src[i];
-}
-
-void sclp_print(const char *str)
-{
-    int len = _strlen(str);
     WriteEventData *sccb = (void *)_sccb;
 
+    if (fd != 1 && fd != 2) {
+        return -EIO;
+    }
+
     sccb->h.length = sizeof(WriteEventData) + len;
     sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
     sccb->ebh.length = sizeof(EventBufferHeader) + len;
     sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
     sccb->ebh.flags = 0;
-    _memcpy(sccb->data, str, len);
+    memcpy(sccb->data, buf, len);
 
     sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
+
+    return len;
+}
+
+void sclp_print(const char *str)
+{
+    write(1, str, strlen(str));
 }
 
 void sclp_get_loadparm_ascii(char *loadparm)
-- 
1.8.3.1
