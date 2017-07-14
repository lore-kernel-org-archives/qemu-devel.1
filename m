Received: from eggs.gnu.org ([2001:4830:134:3::10]:56659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyP7-0008Lw-W2
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVyP4-0003yN-RH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:05:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45560
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVyP4-0003y1-MK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 07:04:58 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6EB4jC5078193
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:58 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpmhws9yu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 07:04:57 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 14 Jul 2017 12:04:53 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Jul 2017 12:40:48 +0200
In-Reply-To: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
References: <1500028867-134709-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1500028867-134709-22-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PULL 21/40] pc-bios/s390-ccw: Add a write() function
 for stdio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Thomas Huth <thuth@redhat.com>

The stdio functions from the SLOF libc need a write() function for
printing text to stdout/stderr. Let's implement this function by
refactoring the code from sclp_print().

Acked-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1499863793-18627-5-git-send-email-thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
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
2.7.4
