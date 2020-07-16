Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098B3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C822B2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 09:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R1ehUuzk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C822B2074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw0HM-0001VP-3Z
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 05:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jw0En-0006V5-MT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:31:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jw0Ek-0002Nx-7W
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 05:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594891889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=8jqvyBBFqiJ+Hi23niTtYK6jymS8r/+nxU61U47Diro=;
 b=R1ehUuzkgRq2LDndhZ9Io1L0HOC5fVLI+nz4BQqyrR2UgXSy7+hsuBE74aiEY6ZIdMbiBQ
 N/n9j9WMDKBthh/dB2QQSFa2mHSfXVCpSiaW2SKNP4DLctIFADoLppmLjP8oscl//utvrb
 QFfA08uTcriNDJSRjHfKup1lrWn2yrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-BOamg8qNMGCBHVOTXK9MTg-1; Thu, 16 Jul 2020 05:31:27 -0400
X-MC-Unique: BOamg8qNMGCBHVOTXK9MTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 989E11009440
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:31:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C26A378481;
 Thu, 16 Jul 2020 09:31:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B00689DA0; Thu, 16 Jul 2020 11:31:19 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] vfio: fix use-after-free in display
Date: Thu, 16 Jul 2020 11:31:18 +0200
Message-Id: <20200716093119.10740-2-kraxel@redhat.com>
In-Reply-To: <20200716093119.10740-1-kraxel@redhat.com>
References: <20200716093119.10740-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 01:59:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Calling ramfb_display_update() might replace the DisplaySurface with the
boot display, which in turn will free the currently active
DisplaySurface.

So clear our DisplaySurface pinter (dpy->region.surface pointer) to (a)
avoid use-after-free and (b) force replacing the boot display with the
real display when switching back.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Message-id: 20200713124520.23266-1-kraxel@redhat.com
---
 hw/vfio/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index a57a22674d62..342054193b3c 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -405,6 +405,7 @@ static void vfio_display_region_update(void *opaque)
     if (!plane.drm_format || !plane.size) {
         if (dpy->ramfb) {
             ramfb_display_update(dpy->con, dpy->ramfb);
+            dpy->region.surface = NULL;
         }
         return;
     }
-- 
2.18.4


