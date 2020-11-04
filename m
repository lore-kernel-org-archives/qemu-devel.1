Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BE2C388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:50:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E375920735
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 15:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CkW/5QQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E375920735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaL34-0000FQ-VW
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 10:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38170)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaKzy-0003pj-1Q
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56227)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1kaKzu-0003Nn-U5
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 10:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604504813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kbSYNM4jZEtZxtXKJKhl2nMQHBOpftEGtubYsEEFmJs=;
 b=CkW/5QQ/MpQ+N3EdxydOj/NuRMxnBLBgto1ybgrXPw58Lm37it/B8Nxfenxvva+BZrGH2k
 d6ZDg79seCJD7s+qHmI+21vCLITksaYzpCbO4WFniShxqFIXWtYKgNLOr5PaCRgXblDrzv
 nJR3lQcUAxsKsJCo4+ORJWZZmGdJ75g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-TZZ_7oM3MwefOVKBNxlVaw-1; Wed, 04 Nov 2020 10:46:51 -0500
X-MC-Unique: TZZ_7oM3MwefOVKBNxlVaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32187186DD33;
 Wed,  4 Nov 2020 15:46:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9A495C5DE;
 Wed,  4 Nov 2020 15:46:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 0936A9D15; Wed,  4 Nov 2020 16:46:46 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/3] ati: check x y display parameter values
Date: Wed,  4 Nov 2020 16:46:44 +0100
Message-Id: <20201104154645.15877-3-kraxel@redhat.com>
In-Reply-To: <20201104154645.15877-1-kraxel@redhat.com>
References: <20201104154645.15877-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
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
Cc: Gaoning Pan <pgn@zju.edu.cn>, Gerd Hoffmann <kraxel@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

The source and destination x,y display parameters in ati_2d_blt()
may run off the vga limits if either of s->regs.[src|dst]_[xy] is
zero. Check the parameter values to avoid potential crash.

Reported-by: Gaoning Pan <pgn@zju.edu.cn>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-id: 20201021103818.1704030-1-ppandit@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_2d.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 23a8ae0cd8ce..4dc10ea79529 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -75,8 +75,9 @@ void ati_2d_blt(ATIVGAState *s)
         dst_stride *= bpp;
     }
     uint8_t *end = s->vga.vram_ptr + s->vga.vram_size;
-    if (dst_bits >= end || dst_bits + dst_x + (dst_y + s->regs.dst_height) *
-        dst_stride >= end) {
+    if (dst_x > 0x3fff || dst_y > 0x3fff || dst_bits >= end
+        || dst_bits + dst_x
+         + (dst_y + s->regs.dst_height) * dst_stride >= end) {
         qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
         return;
     }
@@ -107,8 +108,9 @@ void ati_2d_blt(ATIVGAState *s)
             src_bits += s->regs.crtc_offset & 0x07ffffff;
             src_stride *= bpp;
         }
-        if (src_bits >= end || src_bits + src_x +
-            (src_y + s->regs.dst_height) * src_stride >= end) {
+        if (src_x > 0x3fff || src_y > 0x3fff || src_bits >= end
+            || src_bits + src_x
+             + (src_y + s->regs.dst_height) * src_stride >= end) {
             qemu_log_mask(LOG_UNIMP, "blt outside vram not implemented\n");
             return;
         }
-- 
2.27.0


