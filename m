Received: from eggs.gnu.org ([2001:4830:134:3::10]:47599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1eintd-0005ku-PG
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <walling@linux.vnet.ibm.com>) id 1einta-0003VS-M4
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41300
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <walling@linux.vnet.ibm.com>)
	id 1einta-0003V9-H8
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 16:01:46 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w15KxS4K010011
	for <qemu-devel@nongnu.org>; Mon, 5 Feb 2018 16:01:45 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2fxxmt0cyh-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 05 Feb 2018 16:01:44 -0500
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <walling@linux.vnet.ibm.com>;
	Mon, 5 Feb 2018 16:01:44 -0500
From: "Collin L. Walling" <walling@linux.vnet.ibm.com>
Date: Mon,  5 Feb 2018 15:57:25 -0500
In-Reply-To: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
References: <1517864246-11101-1-git-send-email-walling@linux.vnet.ibm.com>
Message-Id: <1517864246-11101-12-git-send-email-walling@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v5 11/12] s390-ccw: clear pending irqs
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
irq consumption and irq disabling. Those interrupts could
propagate to the guest after IPL completes and cause unwanted
behavior.

To avoid this, we clear the write event mask to prevent further
service interrupts from ASCII events and then consume all pending
irqs for a miniscule duration. Once finished, we reset the write
event mask and resume business as usual.

Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/menu.c | 16 ++++++++++++++++
 pc-bios/s390-ccw/sclp.c | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index 85d285f..971f6b6 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -64,6 +64,20 @@ static inline bool check_clock_int(void)
     return *code == 0x1004;
 }
 
+static void clear_pending_irqs(void)
+{
+    uint64_t time = 50 * TOD_CLOCK_SECOND / 0x3e8;
+
+    sclp_clear_write_mask();
+
+    set_clock_comparator(get_clock() + time);
+    enable_clock_int();
+    consume_sclp_int();
+    disable_clock_int();
+
+    sclp_setup(); /* re-enable write mask */
+}
+
 static int read_prompt(char *buf, size_t len)
 {
     char inp[2] = {};
@@ -165,6 +179,8 @@ static int get_boot_index(int entries)
     sclp_print("\nBooting entry #");
     sclp_print(itostr(boot_index, tmp, sizeof(tmp)));
 
+    clear_pending_irqs();
+
     return boot_index;
 }
 
diff --git a/pc-bios/s390-ccw/sclp.c b/pc-bios/s390-ccw/sclp.c
index 5902d5b..025eb2d 100644
--- a/pc-bios/s390-ccw/sclp.c
+++ b/pc-bios/s390-ccw/sclp.c
@@ -46,6 +46,18 @@ static int sclp_service_call(unsigned int command, void *sccb)
         return 0;
 }
 
+void sclp_clear_write_mask(void)
+{
+    WriteEventMask *sccb = (void *)_sccb;
+
+    sccb->h.length = sizeof(WriteEventMask);
+    sccb->mask_length = sizeof(unsigned int);
+    sccb->cp_receive_mask = 0;
+    sccb->cp_send_mask = 0;
+
+    sclp_service_call(SCLP_CMD_WRITE_EVENT_MASK, sccb);
+}
+
 static void sclp_set_write_mask(void)
 {
     WriteEventMask *sccb = (void *)_sccb;
-- 
2.7.4
