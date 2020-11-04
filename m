Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67473C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB99F2067D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:39:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmjaPKTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB99F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMkk-0001g2-7G
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:39:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaMei-0003IO-BH
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:33:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23959)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kaMeg-0000gf-PB
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604511186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RQ52DGXPQuvl7eCGJZ9UeFOScVLeQApfOO2+jytMN1A=;
 b=UmjaPKTPU0nVYQnai1+KMveEr5bai9ULtAIQmJJZAVTxU43wDajM+Nt9UR90gEAf87+mRC
 gdrHAHtxincOI7TB3eqSugL1+v9qGrkY0VLuc1PphvDZ/R4m109gbk/4hRX9Ceu5jmve5q
 kK0Ml2C/eIRtUWMvQ9FkNZwaWdr8jJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-p6120quWMvCRAdaseI_U9g-1; Wed, 04 Nov 2020 12:33:02 -0500
X-MC-Unique: p6120quWMvCRAdaseI_U9g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4165EC7437;
 Wed,  4 Nov 2020 17:33:01 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.35.207.23])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3120875127;
 Wed,  4 Nov 2020 17:32:50 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/5] block/scsi: correctly emulate the VPD block limits page
Date: Wed,  4 Nov 2020 19:32:17 +0200
Message-Id: <20201104173217.417538-6-mlevitsk@redhat.com>
In-Reply-To: <20201104173217.417538-1-mlevitsk@redhat.com>
References: <20201104173217.417538-1-mlevitsk@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Peter Lieven <pl@kamp.de>, Tom Yan <tom.ty89@gmail.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When the device doesn't support the VPD block limits page, we emulate it even
for SCSI passthrough.

As a part of the emulation we need to add it to the 'Supported VPD Pages'

The code that does this adds it to the page, but it doesn't increase the length
of the data to be copied to the guest, thus the guest never sees the VPD block
limits page as supported.

Bump the transfer size by 1 in this case.

I also refactored the code a bit, and I hopefully didn't introduce
another buffer overflow to this code...

Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 hw/scsi/scsi-generic.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
index 6df67bf889..387d885aee 100644
--- a/hw/scsi/scsi-generic.c
+++ b/hw/scsi/scsi-generic.c
@@ -134,9 +134,9 @@ static int execute_command(BlockBackend *blk,
     return 0;
 }
 
-static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
+static int scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s, int len)
 {
-    uint8_t page, page_idx;
+    uint8_t page;
 
     /*
      *  EVPD set to zero returns the standard INQUIRY data.
@@ -188,20 +188,26 @@ static void scsi_handle_inquiry_reply(SCSIGenericReq *r, SCSIDevice *s)
              * right place with an in-place insert.  When the while loop
              * begins the device response is at r[0] to r[page_idx - 1].
              */
-            page_idx = lduw_be_p(r->buf + 2) + 4;
-            page_idx = MIN(page_idx, r->buflen);
+            uint16_t page_len = lduw_be_p(r->buf + 2) + 4;
+
+            /* pointer to first byte after the page that device gave us */
+            uint16_t page_idx = page_len;
+
+            if (page_idx >= r->buflen)
+                return len;
+
             while (page_idx > 4 && r->buf[page_idx - 1] >= 0xb0) {
-                if (page_idx < r->buflen) {
-                    r->buf[page_idx] = r->buf[page_idx - 1];
-                }
+                r->buf[page_idx] = r->buf[page_idx - 1];
                 page_idx--;
             }
-            if (page_idx < r->buflen) {
-                r->buf[page_idx] = 0xb0;
-            }
+            r->buf[page_idx] = 0xb0;
+
+            /* increase the page len field */
             stw_be_p(r->buf + 2, lduw_be_p(r->buf + 2) + 1);
+            len++;
         }
     }
+    return len;
 }
 
 static int scsi_generic_emulate_block_limits(SCSIGenericReq *r, SCSIDevice *s)
@@ -316,7 +322,7 @@ static void scsi_read_complete(void * opaque, int ret)
         }
     }
     if (r->req.cmd.buf[0] == INQUIRY) {
-        scsi_handle_inquiry_reply(r, s);
+        len = scsi_handle_inquiry_reply(r, s, len);
     }
 
 req_complete:
-- 
2.26.2


