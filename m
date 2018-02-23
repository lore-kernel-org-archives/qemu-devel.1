Received: from eggs.gnu.org ([2001:4830:134:3::10]:46976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epFVu-0001JO-2A
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1epFVq-0007l0-Pl
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:43:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47782
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1epFVq-0007kC-K3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 10:43:54 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1NFd0Q7132986
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:43:54 -0500
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2gakp56212-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 10:43:53 -0500
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 23 Feb 2018 10:43:53 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 23 Feb 2018 10:43:17 -0500
In-Reply-To: <1519400599-21081-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1519400599-21081-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1519400599-21081-12-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v9 11/13] s390-ccw: set cp_receive mask only
 when needed and consume pending service irqs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, thuth@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com, eblake@redhat.com, mihajlov@linux.vnet.ibm.com

It is possible while waiting for multiple types of external
interrupts that we might have pending irqs remaining between
irq consumption and irq-type disabling. Those interrupts
could potentially propagate to the guest after IPL completes
and cause unwanted behavior.

As it is today, the SCLP will only recognize write events that
are enabled by the control program's send and receive masks. To
limit the window for, and prevent further irqs from, ASCII
console events (specifically keystrokes), we should only enable
the control program's receive mask when we need it.

While we're at it, remove assignment of the (non control program)
send and receive masks, as those are actually set by the SCLP.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c     |  5 +++++
 pc-bios/s390-ccw/s390-ccw.h |  1 +
 pc-bios/s390-ccw/sclp.c     | 10 ++++------
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index b99ff03..8d55869 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -11,6 +11,7 @@
 
 #include "libc.h"
 #include "s390-ccw.h"
+#include "sclp.h"
 
 #define KEYCODE_NO_INP '\0'
 #define KEYCODE_ESCAPE '\033'
@@ -116,8 +117,12 @@ static int get_index(void)
 
     memset(buf, 0, sizeof(buf));
 
+    sclp_set_write_mask(SCLP_EVENT_MASK_MSG_ASCII, SCLP_EVENT_MASK_MSG_ASCII);
+
     len = read_prompt(buf, sizeof(buf) - 1);
 
+    sclp_set_write_mask(0, SCLP_EVENT_MASK_MSG_ASCII);
+
     /* If no input, boot default */
     if (len == 0) {
         return 0;
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index aeba8b0..c4ddf9f 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -69,6 +69,7 @@ unsigned int get_loadparm_index(void);
 
 /* sclp.c */
 void sclp_print(const char *string);
+void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask);
 void sclp_setup(void);
 void sclp_get_loadparm_ascii(char *loadparm);
 int sclp_read(char *str, size_t count);
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index a2f25eb..3836cb4 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -46,23 +46,21 @@ static int sclp_service_call(unsigned int command, void *sccb)
         return 0;
 }
 
-static void sclp_set_write_mask(void)
+void sclp_set_write_mask(uint32_t receive_mask, uint32_t send_mask)
 {
     WriteEventMask *sccb = (void *)_sccb;
 
     sccb->h.length = sizeof(WriteEventMask);
     sccb->mask_length = sizeof(unsigned int);
-    sccb->receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
-    sccb->cp_receive_mask = SCLP_EVENT_MASK_MSG_ASCII;
-    sccb->send_mask = SCLP_EVENT_MASK_MSG_ASCII;
-    sccb->cp_send_mask = SCLP_EVENT_MASK_MSG_ASCII;
+    sccb->cp_receive_mask = receive_mask;
+    sccb->cp_send_mask = send_mask;
 
     sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
 }
 
 void sclp_setup(void)
 {
-    sclp_set_write_mask();
+    sclp_set_write_mask(0, SCLP_EVENT_MASK_MSG_ASCII);
 }
 
 long write(int fd, const void *str, size_t len)
-- 
2.7.4
