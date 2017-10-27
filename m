Received: from eggs.gnu.org ([2001:4830:134:3::10]:44874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1e87Hk-0001qB-RZ
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1e87Hg-00084V-S5
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:15:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36198
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1e87Hg-00083e-Lv
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:15:00 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v9RG2Al0048672
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 12:14:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2dv3t5exyp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 12:14:57 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Fri, 27 Oct 2017 12:14:56 -0400
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Fri, 27 Oct 2017 12:14:53 -0400
Message-Id: <1509120893-28054-1-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4] s390-ccw: print carriage return with new
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, borntraeger@de.ibm.com
Cc: thuth@redhat.com, bwalk@linux.vnet.ibm.com, david@redhat.com, pmorel@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de, pasic@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, rth@twiddle.net

The sclp console in the s390 bios writes raw data,
leading console emulators (such as virsh console) to
treat a new line ('\n') as just a new line instead
of as a Unix line feed. Because of this, output
appears in a "stair case" pattern.

Let's print \r\n on every occurrence of a new line
in the string passed to write to amend this issue.

This is in sync with the guest Linux code in
drivers/s390/char/sclp_vt220.c which also does a line feed
conversion in the console part of the driver. 

This fixes the s390-ccw and s390-netboot output like
$ virsh start test --console
Domain test started
Connected to domain test
Escape character is ^]
Network boot starting...
                          Using MAC address: 02:01:02:03:04:05
                                                                Requesting information via DHCP:  010

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/sclp.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 486fce1..e6a0898 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -68,17 +68,35 @@ void sclp_setup(void)
 long write(int fd, const void *str, size_t len)
 {
     WriteEventData *sccb = (void *)_sccb;
+    const char *p = str;
+    size_t data_len = 0;
+    size_t i;
 
     if (fd != 1 && fd != 2) {
         return -EIO;
     }
 
-    sccb->h.length = sizeof(WriteEventData) + len;
+    for (i = 0; i < len; i++) {
+        if ((data_len + 1) >= SCCB_DATA_LEN) {
+            /* We would overflow the sccb buffer, abort early */
+            len = i;
+            break;
+        }
+
+        if (*p == '\n') {
+            /* Terminal emulators might need \r\n, so generate it */
+            sccb->data[data_len++] = '\r';
+        }
+
+        sccb->data[data_len++] = *p;
+        p++;
+    }
+
+    sccb->h.length = sizeof(WriteEventData) + data_len;
     sccb->h.function_code = SCLP_FC_NORMAL_WRITE;
-    sccb->ebh.length = sizeof(EventBufferHeader) + len;
+    sccb->ebh.length = sizeof(EventBufferHeader) + data_len;
     sccb->ebh.type = SCLP_EVENT_ASCII_CONSOLE_DATA;
     sccb->ebh.flags = 0;
-    memcpy(sccb->data, str, len);
 
     sclp_service_call(SCLP_CMD_WRITE_EVENT_DATA, sccb);
 
-- 
2.7.4
