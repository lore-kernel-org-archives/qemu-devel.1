Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBBBDC5ACD6
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83C72076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="YjjS6Efj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83C72076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUsf-0000pY-Sr
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:20:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUnp-0003F5-MP
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUno-0004sR-LG
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40613)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEUno-0004ml-EQ
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id z12so2335115wmf.5
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=v8SYlyFWHibMbzw5x9/Oky71TcnVdLOahGjn4df4QAU=;
 b=YjjS6EfjtvisDjroCFTSc9vhLIDSTXCO3bilV6VM/f8t6RAgU5+tg4LCUPe0u3vroj
 Q4WiCXdNzdEMqwF0pB6pkdAIikKKqqkzHrVEAzDr94CT/oO3/iIVqtrP4X+OKRD/Z0lw
 VqCyMBo0CKX4rojQUUGVXOQeU2zco5qMBiEiBMtRGnatoiQ8OompkgnufzuXICyTnNvH
 ri0Xqocmn837S28LWGWfI1UqQxOoXjHwifrfRH/dOWN+g8Kq/6E93gyt8MSAe2g8ASg5
 SGCOXDCWGtuVneqq7EQu7PyXVlrsSLnd64hXNUqAAMGNqLytclqHGE6OoiZQzDXaCtx5
 4DNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=v8SYlyFWHibMbzw5x9/Oky71TcnVdLOahGjn4df4QAU=;
 b=uNtHK4kjk1IS39jq4U3f0exTaxkSoiU95rC7Ys0I2u/j0z3K6HbZAwxjvjPPWcb2Hh
 AK4iL1Bj1gKK9eZZqkhbyXCSZo6OxWKbina00/kpv9XFCZIS01tu7z2sjaWtngL8nFH9
 H4CNmHdSQ+M5rvt1LHhWJgwyP7ExhQhSw/RV2WRnjggnSYBH7BBRXOZ/8bSJuDyadIrW
 RTTzajAqz2DkB1KrhHxT2ZHruHvW5Hkskb2haTSsrLcjN7fZjLCYwHcyH+tVmsXAdJOB
 IIs7yPI2fT1EBL0jOZ4vTM8MORThyWxH2cQD0Wy38f+rqGdCvdOydUj02Fa8pXp8S0yf
 VrXw==
X-Gm-Message-State: ANhLgQ0ydjT0+5h95IKaQNHgPToxEUZ5yNZ8ZD4pEL2LvUQaYblCYLpO
 ZV+AOTnVwvkA05JY5XMA7Z+7nJc2r1AQ0A==
X-Google-Smtp-Source: ADFU+vvfcYVmUqX5mlgjYgUP1miBwlrf413OxxZJv3oiHJKUYYK4A4DPlrsVQ/XLz2Pnvr5IP020vQ==
X-Received: by 2002:a1c:2dc7:: with SMTP id t190mr4254586wmt.137.1584522950384; 
 Wed, 18 Mar 2020 02:15:50 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id z22sm3062342wmi.1.2020.03.18.02.15.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Mar 2020 02:15:49 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v5 7/7] virtio-net: add migration support for RSS and hash
 report
Date: Wed, 18 Mar 2020 11:15:25 +0200
Message-Id: <20200318091525.27044-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318091525.27044-1-yuri.benditovich@daynix.com>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
 hw/net/virtio-net.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index a0614ad4e6..0b058aae9f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -2842,6 +2842,13 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
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
 
@@ -3019,6 +3026,24 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
     },
 };
 
+static const VMStateDescription vmstate_rss = {
+    .name      = "vmstate_rss",
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(enabled, VirtioNetRssData),
+        VMSTATE_BOOL(redirect, VirtioNetRssData),
+        VMSTATE_BOOL(populate_hash, VirtioNetRssData),
+        VMSTATE_UINT32(hash_types, VirtioNetRssData),
+        VMSTATE_UINT16(indirections_len, VirtioNetRssData),
+        VMSTATE_UINT16(default_queue, VirtioNetRssData),
+        VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
+                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
+        VMSTATE_VARRAY_UINT16_ALLOC(indirections_table, VirtioNetRssData,
+                                    indirections_len, 0,
+                                    vmstate_info_uint16, uint16_t),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3067,6 +3092,7 @@ static const VMStateDescription vmstate_virtio_net_device = {
                          vmstate_virtio_net_tx_waiting),
         VMSTATE_UINT64_TEST(curr_guest_offloads, VirtIONet,
                             has_ctrl_guest_offloads),
+        VMSTATE_STRUCT(rss_data, VirtIONet, 1, vmstate_rss, VirtioNetRssData),
         VMSTATE_END_OF_LIST()
    },
 };
-- 
2.17.1


