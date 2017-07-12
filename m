Received: from eggs.gnu.org ([2001:4830:134:3::10]:42371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH6A-0008Uh-2K
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dVH69-0004WJ-D3
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dVH69-0004Vw-77
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:33 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 12 Jul 2017 14:49:46 +0200
Message-Id: <1499863793-18627-5-git-send-email-thuth@redhat.com>
In-Reply-To: <1499863793-18627-1-git-send-email-thuth@redhat.com>
References: <1499863793-18627-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v5 04/11] pc-bios/s390-ccw: Add a write()
 function for stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Farhan Ali <alifm@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

The stdio functions from the SLOF libc need a write() function for
printing text to stdout/stderr. Let's implement this function by
refactoring the code from sclp_print().

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/sclp.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 2ee204a..b1fc8ff 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -12,6 +12,8 @@
 #include "s390-ccw.h"
 #include "sclp.h"
 
+long write(int fd, const void *str, size_t len);
+
 static char _sccb[PAGE_SIZE] __attribute__((__aligned__(4096)));
 
 const unsigned char ebc2asc[256] =
@@ -71,11 +73,14 @@ static int _strlen(const char *str)
     return i;
 }
 
-void sclp_print(const char *str)
+long write(int fd, const void *str, size_t len)
 {
-    int len = _strlen(str);
     WriteEventData *sccb = (void *)_sccb;
 
+    if (fd != 1 && fd != 2) {
+        return -EIO;
+    }
+
     sccb->h.length = sizeof(WriteEventData) + len;
     sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
     sccb->ebh.length = sizeof(EventBufferHeader) + len;
@@ -84,6 +89,13 @@ void sclp_print(const char *str)
     memcpy(sccb->data, str, len);
 
     sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
+
+    return len;
+}
+
+void sclp_print(const char *str)
+{
+    write(1, str, _strlen(str));
 }
 
 void sclp_get_loadparm_ascii(char *loadparm)
-- 
1.8.3.1
