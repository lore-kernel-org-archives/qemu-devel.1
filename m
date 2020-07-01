Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45007C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1730B206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZtgpFW3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1730B206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeJV-00053g-67
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49760)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHs-0003CP-17
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:36 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHp-0001AF-UL
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=bRci/7hrP0UO3OQ9dRPTIqaOOtW6qqS7pi8JMy6dkzw=;
 b=ZtgpFW3iHfwp39yNeTQ6mHwrp5g1kkUKs3Ko/55EwYfG/1IMEgYtjPou+i8gXXeVizAOuh
 5n6JckFi0MNDaj7jLAnYz8ZoiuD5kfJm5I+dXUU+q1lNqNOpapfJ0AsGVWwk0VUOToAqVJ
 GXuGE1vHVWoOadaiCiVzoa/gz11iORk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-pc5sjBcGPfKyTFBZgxSgKQ-1; Wed, 01 Jul 2020 11:04:31 -0400
X-MC-Unique: pc5sjBcGPfKyTFBZgxSgKQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16152802ED4;
 Wed,  1 Jul 2020 15:04:30 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 086265C557;
 Wed,  1 Jul 2020 15:04:26 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 4F6619D71; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/13] sm501: Fix bounds checks
Date: Wed,  1 Jul 2020 17:04:13 +0200
Message-Id: <20200701150425.13739-2-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

We don't need to add width to pitch when calculating last point, that
would reject valid ops within the card's local_mem.

Fixes: b15a22bbcbe6a78dc3d88fe3134985e4cdd87de4
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: ddb5781d12913bb9d6dbfd9e5b1e2b893e2b3e2d.1592686588.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index a7fc08c52b2b..5ceee4166f6b 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -723,8 +723,8 @@ static void sm501_2d_operation(SM501State *s)
         dst_y -= height - 1;
     }
 
-    if (dst_base >= get_local_mem_size(s) || dst_base +
-        (dst_x + width + (dst_y + height) * (dst_pitch + width)) *
+    if (dst_base >= get_local_mem_size(s) ||
+        dst_base + (dst_x + width + (dst_y + height) * dst_pitch) *
         (1 << format) >= get_local_mem_size(s)) {
         qemu_log_mask(LOG_GUEST_ERROR, "sm501: 2D op dest is outside vram.\n");
         return;
@@ -749,8 +749,8 @@ static void sm501_2d_operation(SM501State *s)
             src_y -= height - 1;
         }
 
-        if (src_base >= get_local_mem_size(s) || src_base +
-            (src_x + width + (src_y + height) * (src_pitch + width)) *
+        if (src_base >= get_local_mem_size(s) ||
+            src_base + (src_x + width + (src_y + height) * src_pitch) *
             (1 << format) >= get_local_mem_size(s)) {
             qemu_log_mask(LOG_GUEST_ERROR,
                           "sm501: 2D op src is outside vram.\n");
-- 
2.18.4


