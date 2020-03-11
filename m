Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B4DC10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B17D8208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="D47Obv3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B17D8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0bN-00068o-RC
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aG-0004Ux-7P
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aF-00030K-7j
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:36 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43513)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jC0aF-0002uz-0a
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:35 -0400
Received: by mail-wr1-x442.google.com with SMTP id v9so2376426wrf.10
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=RyiOiALmhWsHVTIBl5Km4kIgRAnoyapoCqy8nj7ptkc=;
 b=D47Obv3h8rRmWFVldTsXG95HpX6R4rRykcZGxKQf99wmVrz45YcqSnLzB4Bj5ZaPGE
 9lYYs1F+6dT+svD+svyy6a1az1C4E7BfZt5hnAATDGifW47FTruzI9CSDQl4D4qbSk71
 gEJjGyD4CZmhzsaivDY6Y9VTFLRp5ZVg4xzhJ035ajvE7pBUmRhbvisJ0pUQ2JZp08H3
 6VP2vKcO5yjrbyHKsqXABjaU8SlcsdO4kzc+vI2x4fnhqunq2AywBK5obLyOQRBhT1WV
 eqxatr3BljvV0Uhc3u68azsgTJWFaLqIpfWXY+3o+fN28ovM/YwEAIrhzeMEjgju5L6c
 xdRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=RyiOiALmhWsHVTIBl5Km4kIgRAnoyapoCqy8nj7ptkc=;
 b=RWQyzliFNcusLmMi0kyZfWvt1LTT/otZ2OaYfzxDwohbaBH+wFK2eRhNJ1qk8bzcsm
 RoYsJOqz0Ul4Lo5of32wtoRsMR2xgWZP7Ob3QthtBS0+hMDEPBN165UUmCFVNkTbNPGr
 f8XLb+ntxg4F3ICR2TUG0EYfs5QH6Vdq8jOJe3QP48gmQgsB1ansIA1O4CB5wZKqBCZL
 yEO6iZromoryt06H1Fa5RvZTr42cMHgEGjKepNjTjROfjsvr/Q4Limc12Fm6FrWWJe8N
 TnLyucbMX2oWAXNlVP6fhahpdk7sCFPoTkNbGriLA4uaOL6p49z58cN35CUZgQsr8KIZ
 JrtA==
X-Gm-Message-State: ANhLgQ0icRYdTaLOFWaz0of3vb8F8myZY7sOk6bgeEb2mqM+ayRab10O
 KZ0mOlOJObBwVHuSDaa58ixBmGX1duQDwQ==
X-Google-Smtp-Source: ADFU+vv4+ILwiY6BdOSSg6pKdHprsLF3+LTCpLq6Hc8VC2xzpjyMlOa6U3sGzO6jPk2W123nobiLGA==
X-Received: by 2002:a5d:5488:: with SMTP id h8mr4155130wrv.387.1583930133944; 
 Wed, 11 Mar 2020 05:35:33 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id o11sm61480696wrn.6.2020.03.11.05.35.32
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 05:35:33 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 5/6] virtio-net: add migration support for RSS and hast
 report
Date: Wed, 11 Mar 2020 14:35:17 +0200
Message-Id: <20200311123518.4025-6-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311123518.4025-1-yuri.benditovich@daynix.com>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Save and restore RSS/hash report configuration.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 7b6a929e8c..c8d97d45cd 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2869,6 +2869,13 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
         }
     }
 
+    if (n->rss_data.enabled) {
+        trace_virtio_net_rss_enable(n->rss_data.hash_types,
+                                    n->rss_data.indirections_len,
+                                    sizeof(n->rss_data.key));
+    } else {
+        trace_virtio_net_rss_disable();
+    }
     return 0;
 }
 
@@ -3094,6 +3101,8 @@ static const VMStateDescription vmstate_virtio_net_device = {
                          vmstate_virtio_net_tx_waiting),
         VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
                             has_ctrl_guest_offloads),
+        VMSTATE_UINT8_ARRAY(rss_data_migration, VirtIONet,
+                            sizeof(VirtioNetRssData)),
         VMSTATE_END_OF_LIST()
    },
 };
-- 
2.17.1


