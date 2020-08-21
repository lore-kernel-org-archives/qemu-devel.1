Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D55C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:27:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE3E20658
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 08:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TuXKZmXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE3E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k92OI-0005wU-5z
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 04:27:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k92Ng-0005X6-1Z
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:26:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20444)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1k92Ne-0004k3-AP
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 04:26:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597998392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0RojAOjxorSRsHJEvFbmpNNLBc5BXOe1izDlI6zcrp8=;
 b=TuXKZmXjBICtYh9DMNig30AKUs5qWANa1Pi1UrN0/pCJw2oTaiPzcyrqk1a/ZXhfMB1XH4
 qCONTmWZeaU3+m2N9Rchb3RWa7mrjPQRVzESiaPdXlpINlJ8T8eC5aexYAuQjdqxDR4hT1
 DfuRRwmiyUByqCvbCw7RuMx1jzZDN4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-UOzBbcKZPBC-qqsG5W7edg-1; Fri, 21 Aug 2020 04:26:28 -0400
X-MC-Unique: UOzBbcKZPBC-qqsG5W7edg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F35B186A57C;
 Fri, 21 Aug 2020 08:26:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-195.ams2.redhat.com
 [10.36.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E615B7C0AF;
 Fri, 21 Aug 2020 08:26:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AEBED364D; Fri, 21 Aug 2020 10:26:22 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] cirrus: handle wraparound in cirrus_invalidate_region
Date: Fri, 21 Aug 2020 10:26:22 +0200
Message-Id: <20200821082622.7169-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 04:26:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Li Qiang <liq3ea@163.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Code simply asserts that there is no wraparound instead of handling
it properly.  The assert() can be triggered by the guest (must be
privilidged inside the guest though).  Fix it.

Buglink: https://bugs.launchpad.net/qemu/+bug/1880189
Cc: Li Qiang <liq3ea@163.com>
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index 212d6f5e6145..b91b64347473 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -640,10 +640,15 @@ static void cirrus_invalidate_region(CirrusVGAState * s, int off_begin,
     }
 
     for (y = 0; y < lines; y++) {
-        off_cur = off_begin;
+        off_cur = off_begin & s->cirrus_addr_mask;
         off_cur_end = ((off_cur + bytesperline - 1) & s->cirrus_addr_mask) + 1;
-        assert(off_cur_end >= off_cur);
-        memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
+        if (off_cur_end >= off_cur) {
+            memory_region_set_dirty(&s->vga.vram, off_cur, off_cur_end - off_cur);
+        } else {
+            /* wraparound */
+            memory_region_set_dirty(&s->vga.vram, off_cur, s->cirrus_addr_mask - off_cur);
+            memory_region_set_dirty(&s->vga.vram, 0, off_cur_end);
+        }
         off_begin += off_pitch;
     }
 }
-- 
2.27.0


