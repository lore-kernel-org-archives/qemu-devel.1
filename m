Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E0BC43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:04:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B00520773
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 09:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="En9qxgWK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B00520773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKHkM-0001Xv-C7
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 05:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKHf2-0005kQ-N3
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kKHf0-00060T-DY
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 04:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600678736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pm15xvqVjw9kncvzQ8oUo9hebAkTM85nEwxLtDkV1Kw=;
 b=En9qxgWKmQYMucIeqbTHAlySeEl9SmaRsUDvB2BdE6Z/EoHZrSuqlSjzXHsW/diGMYPrRu
 ZgKpEo92BT1ezJUmehXSwsHEgfKmFK/YcCdQD2c7m2xr2bt1aSwjFc+0LPDDXBCA/be9Hp
 IHjeFLxWxlA4DYpgdRG9JktbIqG2mIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-wOjK47XuNMm7-8gFn8SGTg-1; Mon, 21 Sep 2020 04:58:30 -0400
X-MC-Unique: wOjK47XuNMm7-8gFn8SGTg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 930AB85C734;
 Mon, 21 Sep 2020 08:58:28 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-85.ams2.redhat.com
 [10.36.112.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BBD56277B7;
 Mon, 21 Sep 2020 08:58:24 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 10E1B9D77; Mon, 21 Sep 2020 10:58:24 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] hw: usb: hcd-ohci: check len and frame_number variables
Date: Mon, 21 Sep 2020 10:58:22 +0200
Message-Id: <20200921085823.980-3-kraxel@redhat.com>
In-Reply-To: <20200921085823.980-1-kraxel@redhat.com>
References: <20200921085823.980-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.501,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yi Ren <yunye.ry@alibaba-inc.com>, Yongkang Jia <j_kangel@163.com>,
 Gaoning Pan <pgn@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

While servicing the OHCI transfer descriptors(TD), OHCI host
controller derives variables 'start_addr', 'end_addr', 'len'
etc. from values supplied by the host controller driver.
Host controller driver may supply values such that using
above variables leads to out-of-bounds access issues.
Add checks to avoid them.

AddressSanitizer: stack-buffer-overflow on address 0x7ffd53af76a0
  READ of size 2 at 0x7ffd53af76a0 thread T0
  #0 ohci_service_iso_td ../hw/usb/hcd-ohci.c:734
  #1 ohci_service_ed_list ../hw/usb/hcd-ohci.c:1180
  #2 ohci_process_lists ../hw/usb/hcd-ohci.c:1214
  #3 ohci_frame_boundary ../hw/usb/hcd-ohci.c:1257
  #4 timerlist_run_timers ../util/qemu-timer.c:572
  #5 qemu_clock_run_timers ../util/qemu-timer.c:586
  #6 qemu_clock_run_all_timers ../util/qemu-timer.c:672
  #7 main_loop_wait ../util/main-loop.c:527
  #8 qemu_main_loop ../softmmu/vl.c:1676
  #9 main ../softmmu/main.c:50

Reported-by: Gaoning Pan <pgn@zju.edu.cn>
Reported-by: Yongkang Jia <j_kangel@163.com>
Reported-by: Yi Ren <yunye.ry@alibaba-inc.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20200915182259.68522-2-ppandit@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/usb/hcd-ohci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 1e6e85e86a8d..9dc59101f958 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -731,7 +731,11 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
     }
 
     start_offset = iso_td.offset[relative_frame_number];
-    next_offset = iso_td.offset[relative_frame_number + 1];
+    if (relative_frame_number < frame_count) {
+        next_offset = iso_td.offset[relative_frame_number + 1];
+    } else {
+        next_offset = iso_td.be;
+    }
 
     if (!(OHCI_BM(start_offset, TD_PSW_CC) & 0xe) || 
         ((relative_frame_number < frame_count) && 
@@ -764,7 +768,12 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
         }
     } else {
         /* Last packet in the ISO TD */
-        end_addr = iso_td.be;
+        end_addr = next_offset;
+    }
+
+    if (start_addr > end_addr) {
+        trace_usb_ohci_iso_td_bad_cc_overrun(start_addr, end_addr);
+        return 1;
     }
 
     if ((start_addr & OHCI_PAGE_MASK) != (end_addr & OHCI_PAGE_MASK)) {
@@ -773,6 +782,9 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed,
     } else {
         len = end_addr - start_addr + 1;
     }
+    if (len > sizeof(ohci->usb_buf)) {
+        len = sizeof(ohci->usb_buf);
+    }
 
     if (len && dir != OHCI_TD_DIR_IN) {
         if (ohci_copy_iso_td(ohci, start_addr, end_addr, ohci->usb_buf, len,
@@ -975,8 +987,16 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if ((td.cbp & 0xfffff000) != (td.be & 0xfffff000)) {
             len = (td.be & 0xfff) + 0x1001 - (td.cbp & 0xfff);
         } else {
+            if (td.cbp > td.be) {
+                trace_usb_ohci_iso_td_bad_cc_overrun(td.cbp, td.be);
+                ohci_die(ohci);
+                return 1;
+            }
             len = (td.be - td.cbp) + 1;
         }
+        if (len > sizeof(ohci->usb_buf)) {
+            len = sizeof(ohci->usb_buf);
+        }
 
         pktlen = len;
         if (len && dir != OHCI_TD_DIR_IN) {
-- 
2.27.0


