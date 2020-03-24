Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F0CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:10:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D124320775
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:10:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D124320775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGlCS-0008L6-0S
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35693)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBT-0006sZ-6a
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <frankja@linux.ibm.com>) id 1jGlBR-0003A5-QS
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17310)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <frankja@linux.ibm.com>)
 id 1jGlBR-00039J-Ho
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:09:37 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 02OF4KRV122569
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:36 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7ted3s-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 11:09:36 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <frankja@linux.ibm.com>;
 Tue, 24 Mar 2020 15:09:32 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
 by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 24 Mar 2020 15:09:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com
 (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 02OF9U4C51314844
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Mar 2020 15:09:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96FEAA4060;
 Tue, 24 Mar 2020 15:09:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 26560A405B;
 Tue, 24 Mar 2020 15:09:29 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.145.9.40])
 by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Tue, 24 Mar 2020 15:09:28 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/8] pc-bios: s390x: Consolidate timing functions into time.h
Date: Tue, 24 Mar 2020 11:08:40 -0400
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200324150847.10476-1-frankja@linux.ibm.com>
References: <20200324150847.10476-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20032415-4275-0000-0000-000003B22CD4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032415-4276-0000-0000-000038C766F9
Message-Id: <20200324150847.10476-2-frankja@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.645
 definitions=2020-03-24_05:2020-03-23,
 2020-03-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=939
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003240079
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's consolidate timing related functions into one header.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 pc-bios/s390-ccw/menu.c        |  1 +
 pc-bios/s390-ccw/netmain.c     | 15 +++----------
 pc-bios/s390-ccw/s390-ccw.h    | 18 ----------------
 pc-bios/s390-ccw/time.h        | 39 ++++++++++++++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c  |  1 +
 pc-bios/s390-ccw/virtio-scsi.c |  1 +
 pc-bios/s390-ccw/virtio.c      | 18 +++-------------
 7 files changed, 48 insertions(+), 45 deletions(-)
 create mode 100644 pc-bios/s390-ccw/time.h

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index ce3815b2010d20cb..7925c33248836913 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -12,6 +12,7 @@
 #include "libc.h"
 #include "s390-ccw.h"
 #include "sclp.h"
+#include "time.h"
 
 #define KEYCODE_NO_INP '\0'
 #define KEYCODE_ESCAPE '\033'
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 309ffa30d9922077..a8e2b1b6233735d8 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -35,6 +35,7 @@
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
+#include "time.h"
 
 #define DEFAULT_BOOT_RETRIES 10
 #define DEFAULT_TFTP_RETRIES 20
@@ -57,24 +58,14 @@ static SubChannelId net_schid = { .one = 1 };
 static uint8_t mac[6];
 static uint64_t dest_timer;
 
-static uint64_t get_timer_ms(void)
-{
-    uint64_t clk;
-
-    asm volatile(" stck %0 " : : "Q"(clk) : "memory");
-
-    /* Bit 51 is incremented each microsecond */
-    return (clk >> (63 - 51)) / 1000;
-}
-
 void set_timer(int val)
 {
-    dest_timer = get_timer_ms() + val;
+    dest_timer = get_time_milli() + val;
 }
 
 int get_timer(void)
 {
-    return dest_timer - get_timer_ms();
+    return dest_timer - get_time_milli();
 }
 
 int get_sec_ticks(void)
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 21f27e79906ea297..c5820e43aed143d0 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -74,8 +74,6 @@ unsigned long virtio_load_direct(ulong rec_list1, ulong rec_list2,
 bool virtio_is_supported(SubChannelId schid);
 void virtio_blk_setup_device(SubChannelId schid);
 int virtio_read(ulong sector, void *load_addr);
-u64 get_clock(void);
-ulong get_second(void);
 
 /* bootmap.c */
 void zipl_load(void);
@@ -144,24 +142,8 @@ static inline void debug_print_addr(const char *desc, void *p)
 #define KVM_S390_VIRTIO_SET_STATUS      2
 #define KVM_S390_VIRTIO_CCW_NOTIFY      3
 
-static inline void yield(void)
-{
-    asm volatile ("diag 0,0,0x44"
-                  : :
-                  : "memory", "cc");
-}
-
 #define MAX_SECTOR_SIZE 4096
 
-static inline void sleep(unsigned int seconds)
-{
-    ulong target = get_second() + seconds;
-
-    while (get_second() < target) {
-        yield();
-    }
-}
-
 static inline void IPL_assert(bool term, const char *message)
 {
     if (!term) {
diff --git a/pc-bios/s390-ccw/time.h b/pc-bios/s390-ccw/time.h
new file mode 100644
index 0000000000000000..98f5acaa33b500bd
--- /dev/null
+++ b/pc-bios/s390-ccw/time.h
@@ -0,0 +1,39 @@
+#ifndef TIME_H
+#define TIME_H
+
+static inline u64 get_clock(void)
+{
+    u64 r;
+
+    asm volatile("stck %0" : "=Q" (r) : : "cc");
+    return r;
+}
+
+static inline u64 get_time_milli(void)
+{
+    /* Bit 51 is incremented each microsecond */
+    return (get_clock() >> 12) / 1000;
+}
+
+static inline u64 get_time_seconds(void)
+{
+    return (get_time_milli()) / 1000;
+}
+
+static inline void yield(void)
+{
+    asm volatile ("diag 0,0,0x44"
+                  : :
+                  : "memory", "cc");
+}
+
+static inline void sleep(unsigned int seconds)
+{
+    ulong target = get_time_seconds() + seconds;
+
+    while (get_time_seconds() < target) {
+        yield();
+    }
+}
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index ff7f4dad2597eeae..4de03728bb648be1 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -19,6 +19,7 @@
 #include <ethernet.h>
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "time.h"
 
 #ifndef DEBUG_VIRTIO_NET
 #define DEBUG_VIRTIO_NET 0
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 4fe4b9d261a6c88d..0620651da82d569d 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -14,6 +14,7 @@
 #include "virtio.h"
 #include "scsi.h"
 #include "virtio-scsi.h"
+#include "time.h"
 
 static ScsiDevice default_scsi_device;
 static VirtioScsiCmdReq req;
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index fb40ca982853a8d7..43717b83d7b2a9b9 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -15,6 +15,7 @@
 #include "virtio-scsi.h"
 #include "bswap.h"
 #include "helper.h"
+#include "time.h"
 
 #define VRING_WAIT_REPLY_TIMEOUT 30
 
@@ -157,19 +158,6 @@ void vring_send_buf(VRing *vr, void *p, int len, int flags)
     }
 }
 
-u64 get_clock(void)
-{
-    u64 r;
-
-    asm volatile("stck %0" : "=Q" (r) : : "cc");
-    return r;
-}
-
-ulong get_second(void)
-{
-    return (get_clock() >> 12) / 1000000;
-}
-
 int vr_poll(VRing *vr)
 {
     if (vr->used->idx == vr->used_idx) {
@@ -194,7 +182,7 @@ int vr_poll(VRing *vr)
  */
 int vring_wait_reply(void)
 {
-    ulong target_second = get_second() + vdev.wait_reply_timeout;
+    ulong target_second = get_time_seconds() + vdev.wait_reply_timeout;
 
     /* Wait for any queue to be updated by the host */
     do {
@@ -207,7 +195,7 @@ int vring_wait_reply(void)
         if (r) {
             return 0;
         }
-    } while (!vdev.wait_reply_timeout || (get_second() < target_second));
+    } while (!vdev.wait_reply_timeout || (get_time_seconds() < target_second));
 
     return 1;
 }
-- 
2.25.1


