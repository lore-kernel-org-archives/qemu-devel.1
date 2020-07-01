Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B94AC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:17:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9A2206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5WcaGWE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9A2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeUn-0007lr-Kz
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHz-0003NJ-AV
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54156
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHu-0001CE-IM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=253AYkQqIOJliwnkH5Yrery8nHxm/AbhJzsuSYZY1J8=;
 b=U5WcaGWERvPuA3+M6yV3drTzoP6Fv1eiuirTYGxRuwv1vN4scOUokDpsS/U9u2ULRrEPBq
 0tTqUdJXc5Q2G1A7SIoyhpl8tuYI1RTrPt4pM9N3e5xN50tNVB6O6Bz25kY2qhpfR5B6V1
 7616DhAHlva0l++oLpG2UNwly+7a9PQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Ur1hck2lMRqGOnn5_rX6eg-1; Wed, 01 Jul 2020 11:04:34 -0400
X-MC-Unique: Ur1hck2lMRqGOnn5_rX6eg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9DFB107ACCA;
 Wed,  1 Jul 2020 15:04:33 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED515DA27;
 Wed,  1 Jul 2020 15:04:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 74D721FCF5; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/13] sm501: Optimise 1 pixel 2d ops
Date: Wed,  1 Jul 2020 17:04:17 +0200
Message-Id: <20200701150425.13739-6-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Some guests do 1x1 blits which is faster to do directly than calling a
function for it so avoid overhead in this case.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 7cccc302d7b4c5c313bad7681ac4686417143c3e.1592686588.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/sm501.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 3ced2c42db3a..2098e6981014 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -794,6 +794,14 @@ static void sm501_2d_operation(SM501State *s)
                 src_x == dst_x && src_y == dst_y) {
                 break;
             }
+            /* Some clients also do 1 pixel blits, avoid overhead for these */
+            if (width == 1 && height == 1) {
+                unsigned int si = (src_x + src_y * src_pitch) * bypp;
+                unsigned int di = (dst_x + dst_y * dst_pitch) * bypp;
+                stn_he_p(&s->local_mem[dst_base + di], bypp,
+                         ldn_he_p(&s->local_mem[src_base + si], bypp));
+                break;
+            }
             /* Check for overlaps, this could be made more exact */
             uint32_t sb, se, db, de;
             sb = src_base + src_x + src_y * (width + src_pitch);
@@ -842,9 +850,14 @@ static void sm501_2d_operation(SM501State *s)
             color = cpu_to_le16(color);
         }
 
-        pixman_fill((uint32_t *)&s->local_mem[dst_base],
-                    dst_pitch * bypp / sizeof(uint32_t),
-                    8 * bypp, dst_x, dst_y, width, height, color);
+        if (width == 1 && height == 1) {
+            unsigned int i = (dst_x + dst_y * dst_pitch) * bypp;
+            stn_he_p(&s->local_mem[dst_base + i], bypp, color);
+        } else {
+            pixman_fill((uint32_t *)&s->local_mem[dst_base],
+                        dst_pitch * bypp / sizeof(uint32_t),
+                        8 * bypp, dst_x, dst_y, width, height, color);
+        }
         break;
     }
     default:
-- 
2.18.4


