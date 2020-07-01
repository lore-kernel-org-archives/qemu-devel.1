Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A21C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:09:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32010206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VVV9Hs44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32010206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeMD-0001P3-FM
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:09:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHt-0003E2-Du
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50898
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHr-0001Aa-1e
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=Gwk0p8dpwxIxSohyl8AcvPZ5pK0Qgk7UcXoftMHGXH4=;
 b=VVV9Hs44DboFpzrWJnz+Nsd3Z2Jaz5R8Jf6NUfqOUEQvFX733b+5WLFGdMejRKWGY0NRk0
 IE0p6x0hEd7lpM3qZ8Na/pECJGZ82v5ajjhLZ0grtGhD0fcIwAB/mndlse3OeEBC30aare
 t486L3CTtTtDlkdmrn9vO8phHOLFC0k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-ULn6gkb8MsaEQwDy8UCWew-1; Wed, 01 Jul 2020 11:04:32 -0400
X-MC-Unique: ULn6gkb8MsaEQwDy8UCWew-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E585107ACF2;
 Wed,  1 Jul 2020 15:04:31 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D76625BAC3;
 Wed,  1 Jul 2020 15:04:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9D0A831E88; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/13] sm501: Fix and optimize overlap check
Date: Wed,  1 Jul 2020 17:04:21 +0200
Message-Id: <20200701150425.13739-10-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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

When doing reverse blit we need to check if source and dest overlap
but it is not trivial due to possible different base and pitch of
source and dest. Do rectangle overlap if base and pitch match,
otherwise just check if memory area containing the rects overlaps so
rects could possibly overlap.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20200624164737.A941374633D@zero.eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 2db347dcbc1c..9cccc68c35e5 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -690,6 +690,7 @@ static void sm501_2d_operation(SM501State *s)
     unsigned int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
+    bool overlap = false;
 
     if ((s->twoD_stretch >> 16) & 0xF) {
         qemu_log_mask(LOG_UNIMP, "sm501: only XY addressing is supported.\n");
@@ -784,16 +785,21 @@ static void sm501_2d_operation(SM501State *s)
                          ldn_he_p(&s->local_mem[src_base + si], bypp));
                 break;
             }
-            /* Check for overlaps, this could be made more exact */
-            uint32_t sb, se, db, de;
-            sb = src_base + src_x + src_y * (width + src_pitch);
-            se = sb + width + height * (width + src_pitch);
-            db = dst_base + dst_x + dst_y * (width + dst_pitch);
-            de = db + width + height * (width + dst_pitch);
-            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
-                /* regions may overlap: copy via temporary */
-                int llb = width * bypp;
-                int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
+            /* If reverse blit do simple check for overlaps */
+            if (rtl && src_base == dst_base && src_pitch == dst_pitch) {
+                overlap = (src_x < dst_x + width && src_x + width > dst_x &&
+                           src_y < dst_y + height && src_y + height > dst_y);
+            } else if (rtl) {
+                unsigned int sb, se, db, de;
+                sb = src_base + (src_x + src_y * src_pitch) * bypp;
+                se = sb + (width + (height - 1) * src_pitch) * bypp;
+                db = dst_base + (dst_x + dst_y * dst_pitch) * bypp;
+                de = db + (width + (height - 1) * dst_pitch) * bypp;
+                overlap = (db < se && sb < de);
+            }
+            if (overlap) {
+                /* pixman can't do reverse blit: copy via temporary */
+                int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
                 uint32_t *tmp = tmp_buf;
 
                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
-- 
2.18.4


