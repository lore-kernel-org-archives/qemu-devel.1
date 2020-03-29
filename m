Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942ABC2D0E5
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DA292073E
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="l+p8tCTC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DA292073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIZcx-0004Ff-Fx
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 11:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZo-0007v5-C0
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZn-0006tn-4E
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jIZZm-0006sz-UF
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id s1so17870732wrv.5
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EH6oNg+1XnVlYF4aQzYUAyrXIjqeHFa39k5bqe6Q+YA=;
 b=l+p8tCTCfgIFRgyf2arLgXub8SgWRWX0+CbhLsbIIro3jZd4RcG5oRdz0KxlCoWc2r
 cw26mFOTpGQVCg450SemUV8jKcMLpXFk5cpg6kMAjAKoeH3LHqQEzAFTCAzYxou6mYTs
 IcaHNhVJkFpXgIRUbhCYEN3O+VDXNaMe9gqwScA9zEr2dnm97zVYLUGSb98n7gvtN+2t
 V/rA/OtOaaS607/NHn1raAGrUA0S1SJUpQMc2CxkPbYr1MPg3JjK4KOXY5lmssMr1Oog
 WcGg76iIaTboaCShaNEtIDSLKt+mDracNNmYC31YwlqZo6h5pqifzMXQ+KcEZBb79jmH
 Vm5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EH6oNg+1XnVlYF4aQzYUAyrXIjqeHFa39k5bqe6Q+YA=;
 b=QSmOxck8vFDUWVvGrGivRAJLYkEX/d1HrUiD8E0ePkCPYKRB3QiLmpQyx54I0VwGp2
 LuYJIakJg2jr54JEi5wYQQZT2cqsgDnpKnYQHFKY9EUcCJolZwz+7WD7eahJl0pXHQAf
 Cfr/2cPIVzPdD7OfoD9coaBWvnsLmQbuyOeltMKcLQG1ZK74aZaMaYk1TC5B3Q2jNnHR
 2Iwd9oxdnuz0YwNX6w82xwWJxMewpHVvQr4/aREDju0x47+d0Bcl4BVWiMdr6GocpjQq
 QKNKuMqeQnfMuuRpZMtOCUQN8KifjUUVrx+Ma1ULn1qWGncHQbTIOzMAm1IfwxEfcNn8
 Ze3w==
X-Gm-Message-State: ANhLgQ08s4QMOUm/QArSI7hYVLa7g8e3G1ayhaN+2sO28j+dd1V/kAfh
 Lt1N5soEI/vFUL58/XcRoQJsEYg+dYr/KQ==
X-Google-Smtp-Source: ADFU+vslU04nEm8SoW6S7e1PbNm+/qe/nnMF9+VGeXLR6DPEhvUAj3d8jgkJN1yEzExov5hgx8RYtQ==
X-Received: by 2002:adf:9e94:: with SMTP id a20mr10593777wrf.334.1585494613725; 
 Sun, 29 Mar 2020 08:10:13 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-67-107.red.bezeqint.net.
 [79.183.67.107])
 by smtp.gmail.com with ESMTPSA id s2sm5477874wmh.37.2020.03.29.08.10.12
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 29 Mar 2020 08:10:13 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v7 7/7] virtio-net: add migration support for RSS and hash
 report
Date: Sun, 29 Mar 2020 18:09:53 +0300
Message-Id: <20200329150953.23812-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329150953.23812-1-yuri.benditovich@daynix.com>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 hw/net/virtio-net.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 61c956d0ff..8e09aa0b99 100644
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
 
@@ -3019,6 +3026,32 @@ static const VMStateDescription vmstate_virtio_net_has_vnet = {
     },
 };
 
+static bool virtio_net_rss_needed(void *opaque)
+{
+    return VIRTIO_NET(opaque)->rss_data.enabled;
+}
+
+static const VMStateDescription vmstate_virtio_net_rss = {
+    .name      = "virtio-net-device/rss",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_net_rss_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(rss_data.enabled, VirtIONet),
+        VMSTATE_BOOL(rss_data.redirect, VirtIONet),
+        VMSTATE_BOOL(rss_data.populate_hash, VirtIONet),
+        VMSTATE_UINT32(rss_data.hash_types, VirtIONet),
+        VMSTATE_UINT16(rss_data.indirections_len, VirtIONet),
+        VMSTATE_UINT16(rss_data.default_queue, VirtIONet),
+        VMSTATE_UINT8_ARRAY(rss_data.key, VirtIONet,
+                            VIRTIO_NET_RSS_MAX_KEY_SIZE),
+        VMSTATE_VARRAY_UINT16_ALLOC(rss_data.indirections_table, VirtIONet,
+                                    rss_data.indirections_len, 0,
+                                    vmstate_info_uint16, uint16_t),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_virtio_net_device = {
     .name = "virtio-net-device",
     .version_id = VIRTIO_NET_VM_VERSION,
@@ -3069,6 +3102,10 @@ static const VMStateDescription vmstate_virtio_net_device = {
                             has_ctrl_guest_offloads),
         VMSTATE_END_OF_LIST()
    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_virtio_net_rss,
+        NULL
+    }
 };
 
 static NetClientInfo net_virtio_info = {
-- 
2.17.1


