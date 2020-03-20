Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A29C4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8A020732
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 11:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="vA0GSord"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8A020732
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFGIy-0001FD-6R
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 07:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52687)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHy-0007ps-HT
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jFGHx-0000Lu-7f
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:34188)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jFGHx-0000LT-1l
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 07:58:09 -0400
Received: by mail-wm1-x342.google.com with SMTP id 26so2851774wmk.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 04:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UxM/OE0A6aXJDzzbaw2R6dqzUVrzzPfxWU/B31t6IyQ=;
 b=vA0GSordADU74TKFIX1NZNTRSqjUY+NH16BHViQCO1/My1K52HXqKhY6MFTlnho3Dh
 d7/nZiC0mm9aHrJBS0I41xqfJkGzJMVts23qqN21Nl3pNvgrvkWwwI+G5HMHttcwTVKO
 CUNW83xXbQoRc7dKRXOyuWvQ++IL4ToIRzOQO5jD27KnGiggXt5q49C3mfzHqjZMtOvE
 w6SjV43WfY0/34RcP1nLSolgx9LntuME/7HDdn6f425gisJqfoQGZHEgxrgE3VRlZZYY
 Z8fMiTUZ3Zu2l0sJVX2jQAgn8hyF2utDX7FkmBMfyN4St9VA+4JgI0Mao2QXojCvpc0T
 +kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UxM/OE0A6aXJDzzbaw2R6dqzUVrzzPfxWU/B31t6IyQ=;
 b=rOcSgCcQxIrNP1v4Vi6bojJ5VJp3ctmpuTUTN1eEupY67Rmhc8U0kI6jxZ+QqGZXvL
 3LcofF6aviruu/NFn786HHSsGLnwTLzJvp3hUXG5G4ZasTwUuIegoDBngc9V/XI4OMbt
 5nTjTEx+DVBgtUfgXOCx48VQA8pVZeutwPFqs2bcgmDFOOqzvL18NrYe2uWIBU49yDoW
 bi5xkcjRGiT8QwZcIxfDCqbI52wVJ4qoYvqwl5MEuh478iidkGGW96qGSATWLZMJbfpV
 0P18SAqrhNyF2E3Ai+r6BigVTiJTg2FsBFqqusx+DVsd2lJjlyXy37eT56DjFeidQyHc
 xNbA==
X-Gm-Message-State: ANhLgQ0UpvwFhrpudHzXzWlMTw9EwGQ1dmPL+9xmd6j7fPlhRi3rFuzV
 nwZ+8wzkFaH+5USV7WLh7Xv+iem2GjVSOA==
X-Google-Smtp-Source: ADFU+vt6L1jRZxzIdsgyF3sAioQ7VImmSQvVm+PSias4Y6cf/I57+3D8w64THPY5UkCpnKPNQEeQKw==
X-Received: by 2002:a1c:a4c1:: with SMTP id n184mr9745917wme.27.1584705487825; 
 Fri, 20 Mar 2020 04:58:07 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-179-79-224.red.bezeqint.net.
 [79.179.79.224])
 by smtp.gmail.com with ESMTPSA id c18sm6637645wrx.5.2020.03.20.04.58.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 20 Mar 2020 04:58:07 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v6 7/7] virtio-net: add migration support for RSS and hash
 report
Date: Fri, 20 Mar 2020 13:57:51 +0200
Message-Id: <20200320115751.19446-8-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200320115751.19446-1-yuri.benditovich@daynix.com>
References: <20200320115751.19446-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
index a0614ad4e6..7de7587abd 100644
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


