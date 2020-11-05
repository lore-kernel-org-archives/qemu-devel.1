Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2CEC55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FDD6206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 13:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eqGXr8mt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FDD6206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafd8-0005Bw-AJ
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 08:48:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafW0-0003ws-Lu
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:41:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kafVx-0004C5-Ur
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 08:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604583681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUA7GQ69KkiJkZm9iFyAQO55KpxwpxZAPfWwv0rjgvU=;
 b=eqGXr8mtoBY2LgDNAUtarxJCrTEm+lxZRfGGqP1y9r3gra8iaV7EkksLnx8dNOaa0uE7ZG
 MfKZH4gcYbsxiil5K3O3+lLo+RFcvdpNAzcYOY8CO4CP8U3EnoAFghdMEzBaIEuuzyDHZ7
 9Q1THyV9t0SF4MGRTOpy/ShABoQ8oF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-x57n4RmWMqiXU8Q4vVWftA-1; Thu, 05 Nov 2020 08:41:17 -0500
X-MC-Unique: x57n4RmWMqiXU8Q4vVWftA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA9564156
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 13:41:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 617C35D9D5;
 Thu,  5 Nov 2020 13:41:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9D64D9B0B; Thu,  5 Nov 2020 14:41:12 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] usb-storage: switch trace events
Date: Thu,  5 Nov 2020 14:41:07 +0100
Message-Id: <20201105134112.25119-2-kraxel@redhat.com>
In-Reply-To: <20201105134112.25119-1-kraxel@redhat.com>
References: <20201105134112.25119-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace most DPRINTF macros with trace events.
Drop some DPRINTF macros.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/dev-storage.c | 42 +++++++++++++++++-------------------------
 hw/usb/trace-events  | 12 ++++++++++++
 2 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/hw/usb/dev-storage.c b/hw/usb/dev-storage.c
index 648340323f68..e317cde8fd48 100644
--- a/hw/usb/dev-storage.c
+++ b/hw/usb/dev-storage.c
@@ -23,16 +23,10 @@
 #include "qapi/visitor.h"
 #include "qemu/cutils.h"
 #include "qom/object.h"
+#include "trace.h"
 
 //#define DEBUG_MSD
 
-#ifdef DEBUG_MSD
-#define DPRINTF(fmt, ...) \
-do { printf("usb-msd: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define DPRINTF(fmt, ...) do {} while(0)
-#endif
-
 /* USB requests.  */
 #define MassStorageReset  0xff
 #define GetMaxLun         0xfe
@@ -245,8 +239,8 @@ static void usb_msd_send_status(MSDState *s, USBPacket *p)
 {
     int len;
 
-    DPRINTF("Command status %d tag 0x%x, len %zd\n",
-            s->csw.status, le32_to_cpu(s->csw.tag), p->iov.size);
+    trace_usb_msd_send_status(s->csw.status, le32_to_cpu(s->csw.tag),
+                              p->iov.size);
 
     assert(s->csw.sig == cpu_to_le32(0x53425355));
     len = MIN(sizeof(s->csw), p->iov.size);
@@ -261,7 +255,7 @@ static void usb_msd_packet_complete(MSDState *s)
     /* Set s->packet to NULL before calling usb_packet_complete
        because another request may be issued before
        usb_packet_complete returns.  */
-    DPRINTF("Packet complete %p\n", p);
+    trace_usb_msd_packet_complete();
     s->packet = NULL;
     usb_packet_complete(&s->dev, p);
 }
@@ -289,7 +283,7 @@ static void usb_msd_command_complete(SCSIRequest *req, uint32_t status, size_t r
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
     USBPacket *p = s->packet;
 
-    DPRINTF("Command complete %d tag 0x%x\n", status, req->tag);
+    trace_usb_msd_cmd_complete(status, req->tag);
 
     s->csw.sig = cpu_to_le32(0x53425355);
     s->csw.tag = cpu_to_le32(req->tag);
@@ -331,6 +325,8 @@ static void usb_msd_request_cancelled(SCSIRequest *req)
 {
     MSDState *s = DO_UPCAST(MSDState, dev.qdev, req->bus->qbus.parent);
 
+    trace_usb_msd_cmd_cancel(req->tag);
+
     if (req == s->req) {
         scsi_req_unref(s->req);
         s->req = NULL;
@@ -342,7 +338,7 @@ static void usb_msd_handle_reset(USBDevice *dev)
 {
     MSDState *s = (MSDState *)dev;
 
-    DPRINTF("Reset\n");
+    trace_usb_msd_reset();
     if (s->req) {
         scsi_req_cancel(s->req);
     }
@@ -388,7 +384,7 @@ static void usb_msd_handle_control(USBDevice *dev, USBPacket *p,
             }
             maxlun++;
         }
-        DPRINTF("MaxLun %d\n", maxlun);
+        trace_usb_msd_maxlun(maxlun);
         data[0] = maxlun;
         p->actual_length = 1;
         break;
@@ -436,7 +432,6 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                              le32_to_cpu(cbw.sig));
                 goto fail;
             }
-            DPRINTF("Command on LUN %d\n", cbw.lun);
             scsi_dev = scsi_device_find(&s->bus, 0, 0, cbw.lun);
             if (scsi_dev == NULL) {
                 error_report("usb-msd: Bad LUN %d", cbw.lun);
@@ -451,8 +446,8 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
             } else {
                 s->mode = USB_MSDM_DATAOUT;
             }
-            DPRINTF("Command tag 0x%x flags %08x len %d data %d\n",
-                    tag, cbw.flags, cbw.cmd_len, s->data_len);
+            trace_usb_msd_cmd_submit(cbw.lun, tag, cbw.flags,
+                                     cbw.cmd_len, s->data_len);
             assert(le32_to_cpu(s->csw.residue) == 0);
             s->scsi_len = 0;
             s->req = scsi_req_new(scsi_dev, tag, cbw.lun, cbw.cmd, NULL);
@@ -466,7 +461,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
             break;
 
         case USB_MSDM_DATAOUT:
-            DPRINTF("Data out %zd/%d\n", p->iov.size, s->data_len);
+            trace_usb_msd_data_out(p->iov.size, s->data_len);
             if (p->iov.size > s->data_len) {
                 goto fail;
             }
@@ -488,14 +483,13 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 }
             }
             if (p->actual_length < p->iov.size) {
-                DPRINTF("Deferring packet %p [wait data-out]\n", p);
+                trace_usb_msd_packet_async();
                 s->packet = p;
                 p->status = USB_RET_ASYNC;
             }
             break;
 
         default:
-            DPRINTF("Unexpected write (len %zd)\n", p->iov.size);
             goto fail;
         }
         break;
@@ -510,6 +504,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 goto fail;
             }
             /* Waiting for SCSI write to complete.  */
+            trace_usb_msd_packet_async();
             s->packet = p;
             p->status = USB_RET_ASYNC;
             break;
@@ -521,7 +516,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
 
             if (s->req) {
                 /* still in flight */
-                DPRINTF("Deferring packet %p [wait status]\n", p);
+                trace_usb_msd_packet_async();
                 s->packet = p;
                 p->status = USB_RET_ASYNC;
             } else {
@@ -531,8 +526,7 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
             break;
 
         case USB_MSDM_DATAIN:
-            DPRINTF("Data in %zd/%d, scsi_len %d\n",
-                    p->iov.size, s->data_len, s->scsi_len);
+            trace_usb_msd_data_in(p->iov.size, s->data_len, s->scsi_len);
             if (s->scsi_len) {
                 usb_msd_copy_data(s, p);
             }
@@ -550,20 +544,18 @@ static void usb_msd_handle_data(USBDevice *dev, USBPacket *p)
                 }
             }
             if (p->actual_length < p->iov.size && s->mode == USB_MSDM_DATAIN) {
-                DPRINTF("Deferring packet %p [wait data-in]\n", p);
+                trace_usb_msd_packet_async();
                 s->packet = p;
                 p->status = USB_RET_ASYNC;
             }
             break;
 
         default:
-            DPRINTF("Unexpected read (len %zd)\n", p->iov.size);
             goto fail;
         }
         break;
 
     default:
-        DPRINTF("Bad token\n");
     fail:
         p->status = USB_RET_STALL;
         break;
diff --git a/hw/usb/trace-events b/hw/usb/trace-events
index a3292d46248f..38e05fc7f4db 100644
--- a/hw/usb/trace-events
+++ b/hw/usb/trace-events
@@ -252,6 +252,18 @@ usb_hub_attach(int addr, int nr) "dev %d, port %d"
 usb_hub_detach(int addr, int nr) "dev %d, port %d"
 usb_hub_status_report(int addr, int status) "dev %d, status 0x%x"
 
+# dev-storage.c
+usb_msd_reset(void) ""
+usb_msd_maxlun(unsigned maxlun) "%d"
+usb_msd_send_status(unsigned status, unsigned tag, size_t size) "status %d, tag 0x%x, len %zd"
+usb_msd_data_in(unsigned packet, unsigned remaining, unsigned total) "%d/%d (scsi %d)"
+usb_msd_data_out(unsigned packet, unsigned remaining) "%d/%d"
+usb_msd_packet_async(void) ""
+usb_msd_packet_complete(void) ""
+usb_msd_cmd_submit(unsigned lun, unsigned tag, unsigned flags, unsigned len, unsigned data_len) "lun %u, tag 0x%x, flags 0x%08x, len %d, data-len %d"
+usb_msd_cmd_complete(unsigned status, unsigned tag) "status %d, tag 0x%x"
+usb_msd_cmd_cancel(unsigned tag) "tag 0x%x"
+
 # dev-uas.c
 usb_uas_reset(int addr) "dev %d"
 usb_uas_command(int addr, uint16_t tag, int lun, uint32_t lun64_1, uint32_t lun64_2) "dev %d, tag 0x%x, lun %d, lun64 0x%08x-0x%08x"
-- 
2.27.0


