Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E78C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B3320720
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 10:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZCwk/9yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B3320720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIcF-0004um-NF
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 06:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIb7-0003BV-5p
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jrIb5-0005Vn-FU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 06:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593770826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TjbwQvkJITrWTA9A+5iaXR+6ePtF3qplJa1F/ZCt38g=;
 b=ZCwk/9yc1VSPwYdfVvunUkAgf6jWpFFdre6ABJGDHhR2BQibOEHBmDcnrjzT5HJSSMgA3g
 8UkbFMygMtm2d4BoGTTDRhzs8+X8xgxT82d+oAtDnOyLF7x4p7Z92x5FsUNq69mVqpmYGL
 OG5V2sR74hy3ariFyjSrxrcEhTdHlow=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-KVzH04uaNXifbm8UL3bhKw-1; Fri, 03 Jul 2020 06:07:02 -0400
X-MC-Unique: KVzH04uaNXifbm8UL3bhKw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AA6E800402;
 Fri,  3 Jul 2020 10:07:01 +0000 (UTC)
Received: from localhost (ovpn-113-54.ams2.redhat.com [10.36.113.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A9F27923E;
 Fri,  3 Jul 2020 10:07:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/14] pc-bios: s390x: Consolidate timing functions into time.h
Date: Fri,  3 Jul 2020 12:06:38 +0200
Message-Id: <20200703100650.621212-3-cohuck@redhat.com>
In-Reply-To: <20200703100650.621212-1-cohuck@redhat.com>
References: <20200703100650.621212-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's consolidate timing related functions into one header.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Acked-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-Id: <20200624075226.92728-3-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/menu.c        |  1 +
 pc-bios/s390-ccw/netmain.c     | 15 +++------------
 pc-bios/s390-ccw/s390-ccw.h    |  8 ++++----
 pc-bios/s390-ccw/s390-time.h   | 23 +++++++++++++++++++++++
 pc-bios/s390-ccw/virtio-net.c  |  1 +
 pc-bios/s390-ccw/virtio-scsi.c |  1 +
 pc-bios/s390-ccw/virtio.c      | 18 +++---------------
 7 files changed, 36 insertions(+), 31 deletions(-)
 create mode 100644 pc-bios/s390-ccw/s390-time.h

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index ce3815b2010d..de8260a5d6cf 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -12,6 +12,7 @@
 #include "libc.h"
 #include "s390-ccw.h"
 #include "sclp.h"
+#include "s390-time.h"
 
 #define KEYCODE_NO_INP '\0'
 #define KEYCODE_ESCAPE '\033'
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 309ffa30d992..f1ee63577ad7 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -35,6 +35,7 @@
 #include "s390-ccw.h"
 #include "cio.h"
 #include "virtio.h"
+#include "s390-time.h"
 
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
+    dest_timer = get_time_ms() + val;
 }
 
 int get_timer(void)
 {
-    return dest_timer - get_timer_ms();
+    return dest_timer - get_time_ms();
 }
 
 int get_sec_ticks(void)
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 21f27e79906e..fae1de363fb4 100644
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
@@ -153,11 +151,13 @@ static inline void yield(void)
 
 #define MAX_SECTOR_SIZE 4096
 
+#include "s390-time.h"
+
 static inline void sleep(unsigned int seconds)
 {
-    ulong target = get_second() + seconds;
+    ulong target = get_time_seconds() + seconds;
 
-    while (get_second() < target) {
+    while (get_time_seconds() < target) {
         yield();
     }
 }
diff --git a/pc-bios/s390-ccw/s390-time.h b/pc-bios/s390-ccw/s390-time.h
new file mode 100644
index 000000000000..ed6d98237185
--- /dev/null
+++ b/pc-bios/s390-ccw/s390-time.h
@@ -0,0 +1,23 @@
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
+static inline u64 get_time_ms(void)
+{
+    /* Bit 51 is incremented each microsecond */
+    return (get_clock() >> 12) / 1000;
+}
+
+static inline u64 get_time_seconds(void)
+{
+    return get_time_ms() / 1000;
+}
+
+#endif
diff --git a/pc-bios/s390-ccw/virtio-net.c b/pc-bios/s390-ccw/virtio-net.c
index ff7f4dad2597..a13f3b6fb9b4 100644
--- a/pc-bios/s390-ccw/virtio-net.c
+++ b/pc-bios/s390-ccw/virtio-net.c
@@ -19,6 +19,7 @@
 #include <ethernet.h>
 #include "s390-ccw.h"
 #include "virtio.h"
+#include "s390-time.h"
 
 #ifndef DEBUG_VIRTIO_NET
 #define DEBUG_VIRTIO_NET 0
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 4fe4b9d261a6..7bf0be4ffa31 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -14,6 +14,7 @@
 #include "virtio.h"
 #include "scsi.h"
 #include "virtio-scsi.h"
+#include "s390-time.h"
 
 static ScsiDevice default_scsi_device;
 static VirtioScsiCmdReq req;
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index fb40ca982853..ab49840db853 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -15,6 +15,7 @@
 #include "virtio-scsi.h"
 #include "bswap.h"
 #include "helper.h"
+#include "s390-time.h"
 
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
2.25.4


