Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF17C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38C9E206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhEDAWtj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38C9E206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHwD-0006yz-BB
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:47:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33678)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlx-0001nq-Jq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlr-0005Cj-KN
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=2IsMfaxaTTz5vy0Vupg6v30s/PyqIpQcE0ZMO3BCp/U=;
 b=GhEDAWtjbee60KMUwh8g3U2dA0pp+RRijlzNZOatiGJ28nGvQyq2P8M8Hu3oA6MBNjyIvi
 9JP91q4NbCKT3UGqstKivGf80vB46qtzcI7yTJpTii1RQXCSYSgeRisRo2Ep+ZsrGn3ght
 01YAXbakAgGH2ufOu/blmCEt/3mz7RA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-emKINCxxMzis6e2BQMv_Wg-1; Thu, 28 May 2020 08:36:21 -0400
X-MC-Unique: emKINCxxMzis6e2BQMv_Wg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 485001855A0D;
 Thu, 28 May 2020 12:36:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF37E10013C3;
 Thu, 28 May 2020 12:36:19 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 1BBB39D72; Thu, 28 May 2020 14:36:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 20/21] sm501: Optimize small overlapping blits
Date: Thu, 28 May 2020 14:36:08 +0200
Message-Id: <20200528123609.27362-21-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

AmigaOS tends to do a lot of small blits (even 1 pixel). Avoid malloc
overhead by keeping around a buffer for this and only alloc when
blitting larger areas.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 7946852258d528497e85f465327fc90b5c3b59fb.1590089984.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 8bf4d111f4b3..e7a9f77de7bc 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -750,6 +750,7 @@ static void sm501_2d_operation(SM501State *s)
     switch (cmd) {
     case 0: /* BitBlt */
     {
+        static uint32_t tmp_buf[16384];
         unsigned int src_x = (s->twoD_source >> 16) & 0x01FFF;
         unsigned int src_y = s->twoD_source & 0xFFFF;
         uint32_t src_base = s->twoD_source_base & 0x03FFFFFF;
@@ -812,10 +813,14 @@ static void sm501_2d_operation(SM501State *s)
             de = db + width + height * (width + dst_pitch);
             if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
                 /* regions may overlap: copy via temporary */
-                int llb = width * (1 << format);
+                int free_buf = 0, llb = width * (1 << format);
                 int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
-                uint32_t *tmp = g_malloc(tmp_stride * sizeof(uint32_t) *
-                                         height);
+                uint32_t *tmp = tmp_buf;
+
+                if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
+                    tmp = g_malloc(tmp_stride * sizeof(uint32_t) * height);
+                    free_buf = 1;
+                }
                 pixman_blt((uint32_t *)&s->local_mem[src_base], tmp,
                            src_pitch * (1 << format) / sizeof(uint32_t),
                            tmp_stride, 8 * (1 << format), 8 * (1 << format),
@@ -825,7 +830,9 @@ static void sm501_2d_operation(SM501State *s)
                            dst_pitch * (1 << format) / sizeof(uint32_t),
                            8 * (1 << format), 8 * (1 << format),
                            0, 0, dst_x, dst_y, width, height);
-                g_free(tmp);
+                if (free_buf) {
+                    g_free(tmp);
+                }
             } else {
                 pixman_blt((uint32_t *)&s->local_mem[src_base],
                            (uint32_t *)&s->local_mem[dst_base],
-- 
2.18.4


