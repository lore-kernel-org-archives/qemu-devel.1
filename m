Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C7DC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:05:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0813205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 11:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="hXenj+NN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0813205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDnYk-0000Tt-Mq
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 07:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38419)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jDmgx-00064H-Us
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:09:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jDmgw-0004ld-PM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:09:51 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36344)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jDmgw-0004ME-IM
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 06:09:50 -0400
Received: by mail-wr1-x444.google.com with SMTP id s5so20437694wrg.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 03:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=0PD+9CT/Xt0zgE5b0vEiJJ+90ECqaJXhO+EHUt2RRT8=;
 b=hXenj+NNyw/BK0hLhzXx4lInYXCPHi9x5fN3yg0SZClVTFrOa61AK8iSyg87/ieZWJ
 6eLxAjZcNVQAjxhv9Dmc54kuMFjAns30uGTFYX5W2PVIvqf0xqOwIUnaiQ0sq07oQBag
 EpvwA64wnrK47eYbKXGVlzNighUkonzK7lr3a0L/5Se6bKAIs/VRjle2AD+DPv+H6v2A
 m/hXGapxisfyeT8S/FPXHJQ8bVX8d3sKaPBiw7T4O/kpJUMinz1jZBdf9eWIAUB4Lyoj
 Z055Mj3pKalLdzUhrAiRiZjP04p0vr/j/eUvaj9CCakDe1bnGT3uIZuqJxn7ssZmKOQ+
 skmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=0PD+9CT/Xt0zgE5b0vEiJJ+90ECqaJXhO+EHUt2RRT8=;
 b=YQutqsdOxJYVHcmHePACl4v7SXicmq+fEPzfERtW0auIIHpCv7M6zLeXsEJSL1rPus
 Lg9fq0KjpKKgtno8LgKLv7V/Pp7uiczNjRbOOSiQG4UPte+yN9XEc1PLyOflO2TYI9MF
 00hG+mIqxqmGzcODmxHxxpqw1o10L0JvqFx6GvTziFpSyrp4F64Hf3Y979fKlNfxSg4e
 kElILjZpQn5l2uM/hua1tCyj4UGytA3T/tq7Iskktqv6VTtZYEx9IJ6p1MVmJZ8NGTJK
 xkCC2vE7UVP8bC19kuVmkPtRgciNpaLJvh+ZDlGXc489xv3FqXRcZBJQGUTXlP5M4Ac4
 Urcw==
X-Gm-Message-State: ANhLgQ3hneV1Q3dUSMSRR5aVh1pRD3HJeW+eAmg9DjFNA2Kll/O+9vC9
 0vII0PRldDvZbXlMGwCuRtFU1vbBa+L77g==
X-Google-Smtp-Source: ADFU+vsJc9u0CKcm6DtRSRUN+Dgj2TMNVLPf3NncsVKC0NGZhRrZquVhNdCZifihON349Os8pyF4CA==
X-Received: by 2002:a5d:67ca:: with SMTP id n10mr28633972wrw.268.1584353387743; 
 Mon, 16 Mar 2020 03:09:47 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id l7sm22083171wrw.33.2020.03.16.03.09.46
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 16 Mar 2020 03:09:47 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v4 6/6] virtio-net: add migration support for RSS and hash
 report
Date: Mon, 16 Mar 2020 12:09:33 +0200
Message-Id: <20200316100933.11499-7-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316100933.11499-1-yuri.benditovich@daynix.com>
References: <20200316100933.11499-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
index a0614ad4e6..f343762a0f 100644
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
+        VMSTATE_UINT32(indirections_len, VirtioNetRssData),
+        VMSTATE_UINT16(default_queue, VirtioNetRssData),
+        VMSTATE_UINT8_ARRAY(key, VirtioNetRssData,
+                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
+        VMSTATE_VARRAY_UINT32_ALLOC(indirections_table, VirtioNetRssData,
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


