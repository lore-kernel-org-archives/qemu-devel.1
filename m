Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC5EC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:16:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9D212074D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 15:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DJOi6ud+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9D212074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkqqy-00082J-1A
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 11:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38752)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jkqpH-0005oi-7C
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:15:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45198
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jkqpE-0008Lb-Bx
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 11:15:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592234103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=F/2U1gqJCq2Vp9VYdoKiwFyHD55DQl1YJBnEpskCPy0=;
 b=DJOi6ud+xqlcKAMO2aKwOLznbZ2+dYEW7V5oDhGRjcA9bMki9xAu1dIz8EQZMDEmiodsFl
 KZBZ6df0wVnJlcxQV6UPJbkA+p02FYD5i8oVrCSJqB7LEUOMcfiTb3+foswLmSQN2fAIZb
 0v+WHB8l6WqHqvrvq8jD0ubYDOkK1Bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-_ga6LpE2M4GzgyU2dcJNBQ-1; Mon, 15 Jun 2020 11:14:54 -0400
X-MC-Unique: _ga6LpE2M4GzgyU2dcJNBQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5969100CCC3;
 Mon, 15 Jun 2020 15:14:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A1D6E60C47;
 Mon, 15 Jun 2020 15:14:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 99B0E9D8F; Mon, 15 Jun 2020 17:14:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] sm501: Optimise 1 pixel 2d ops
Date: Mon, 15 Jun 2020 17:14:49 +0200
Message-Id: <20200615151449.19818-5-kraxel@redhat.com>
In-Reply-To: <20200615151449.19818-1-kraxel@redhat.com>
References: <20200615151449.19818-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:12:36
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

Some guests do 1x1 blits which is faster to do directly than calling a
function for it so avoid overhead in this case.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 9fab4fe6513fe8b921ce86a57f4ff7e0d5a3c3f9.1591471056.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3397ca9fbf4c..59693fbb5c17 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -793,6 +793,25 @@ static void sm501_2d_operation(SM501State *s)
                 src_x == dst_x && src_y == dst_y) {
                 break;
             }
+            /* Some clients also do 1 pixel blits, avoid overhead for these */
+            if (width == 1 && height == 1) {
+                unsigned int si = (src_x + src_y * src_pitch) * (1 << format);
+                unsigned int di = (dst_x + dst_y * dst_pitch) * (1 << format);
+                switch (format) {
+                case 0:
+                    s->local_mem[dst_base + di] = s->local_mem[src_base + si];
+                    break;
+                case 1:
+                    *(uint16_t *)&s->local_mem[dst_base + di] =
+                                    *(uint16_t *)&s->local_mem[src_base + si];
+                    break;
+                case 2:
+                    *(uint32_t *)&s->local_mem[dst_base + di] =
+                                    *(uint32_t *)&s->local_mem[src_base + si];
+                    break;
+                }
+                break;
+            }
             /* Check for overlaps, this could be made more exact */
             uint32_t sb, se, db, de;
             sb = src_base + src_x + src_y * (width + src_pitch);
@@ -841,9 +860,24 @@ static void sm501_2d_operation(SM501State *s)
             color = cpu_to_le16(color);
         }
 
-        pixman_fill((uint32_t *)&s->local_mem[dst_base],
-                    dst_pitch * (1 << format) / sizeof(uint32_t),
-                    8 * (1 << format), dst_x, dst_y, width, height, color);
+        if (width == 1 && height == 1) {
+            unsigned int i = (dst_x + dst_y * dst_pitch) * (1 << format);
+            switch (format) {
+            case 0:
+                s->local_mem[dst_base + i] = color & 0xff;
+                break;
+            case 1:
+                *(uint16_t *)&s->local_mem[dst_base + i] = color & 0xffff;
+                break;
+            case 2:
+                *(uint32_t *)&s->local_mem[dst_base + i] = color;
+                break;
+            }
+        } else {
+            pixman_fill((uint32_t *)&s->local_mem[dst_base],
+                        dst_pitch * (1 << format) / sizeof(uint32_t),
+                        8 * (1 << format), dst_x, dst_y, width, height, color);
+        }
         break;
     }
     default:
-- 
2.18.4


