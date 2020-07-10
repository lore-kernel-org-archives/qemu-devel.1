Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BB8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1455B207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/3BM+Nb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1455B207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtor7-0003Uz-C0
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:58:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1jtoqS-0002vN-Qz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:57:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39487
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1jtoqR-0000F3-C9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594371442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6UuvXk6F+b+Tv3n3h9p2quCLU/54dxm2IrU0BRnuky0=;
 b=D/3BM+Nb1ESS3hw5jPxkyq5H43eiScWg30fbNwiS1rlXT6KH7z61AL/OllxZ0uYwMyrivr
 wN/pkrhwJ0vZRDhBZ+9v1SMpe52KzyPBoz07+ryoXgfnIdhzpIcrG9aWBq6R64Ia/KQIaI
 awuXMWEN4uyPJgvo7fKj7f1IiSUAayE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-0jJaHsoGMbWBjIj1jSPDjA-1; Fri, 10 Jul 2020 04:56:12 -0400
X-MC-Unique: 0jJaHsoGMbWBjIj1jSPDjA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 48B781B18BDB;
 Fri, 10 Jul 2020 08:56:11 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.40.193.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F7E574F48;
 Fri, 10 Jul 2020 08:56:09 +0000 (UTC)
From: Mauro Matteo Cascella <mcascell@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/net/ftgmac100: Fix integer overflow in ftgmac100_do_tx()
Date: Fri, 10 Jul 2020 10:54:18 +0200
Message-Id: <20200710085417.638904-1-mcascell@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
Cc: peter.maydell@linaro.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 andrew@aj.id.au, qemu-arm@nongnu.org, clg@kaod.org, ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

An integer overflow issue was reported by Mr. Ziming Zhang, CC'd here. It
occurs while inserting the VLAN tag in packets whose length is less than
12 bytes, as (len-12) is passed to memmove() without proper checking.
This patch is intended to fix this issue by checking the minimum
Ethernet frame size during packet transmission.

Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: Mauro Matteo Cascella <mcascell@redhat.com>
---
 hw/net/ftgmac100.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 043ba61b86..bcf4d84aea 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -238,6 +238,11 @@ typedef struct {
  */
 #define FTGMAC100_MAX_FRAME_SIZE    9220
 
+/*
+ * Min frame size
+ */
+#define FTGMAC100_MIN_FRAME_SIZE    64
+
 /* Limits depending on the type of the frame
  *
  *   9216 for Jumbo frames (+ 4 for VLAN)
@@ -507,6 +512,15 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint32_t tx_ring,
         }
 
         len = FTGMAC100_TXDES0_TXBUF_SIZE(bd.des0);
+
+        /* drop small packets */
+        if (bd.des0 & FTGMAC100_TXDES0_FTS &&
+            len < FTGMAC100_MIN_FRAME_SIZE) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too small: %d bytes\n",
+                          __func__, len);
+            break;
+        }
+
         if (frame_size + len > sizeof(s->frame)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: frame too big : %d bytes\n",
                           __func__, len);
-- 
2.26.2


