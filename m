Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7417C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:46:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E7F62083E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="qnltBC7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E7F62083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBE3j-0002ek-JO
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsF-0007fo-6b
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsE-0007Ol-3X
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:55 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:39817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBDsD-0007NG-SL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id f7so4204401wml.4
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 01:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=qwff9geVcA9Ofl81vgC89M4fcI3BmCYQGSyZyytOdBU=;
 b=qnltBC7yVakg4nqdoErtT2D3DClG3hrzoJeqQTbHxsSu6xjOcKmoRlZoyUPJ/FuZqC
 NtkbhXIliOaIO0fHOMAus7ReOo5jdLrtZVUlnxgwGzfB6dRiz3QJfYDHqfvnLwOWnK6V
 4M+SEu2cj9x5ywQOJYGMVxXWJ798wxHglx8kfpioHz5LDSktiS1abDLX4N1fgXCKDT8a
 kfPEYmQKllM5e5FoQGGPyPEX9sN1v95+olwZRd5jN8Zx4dTijR3iwhzQATOX0SAvzY/F
 0X0u84WfK5QF6vLkKBJaUHBQgCPbrautaeppeblHpvnKxu6P1DLgkN+d3MnzbAqjTdda
 mfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=qwff9geVcA9Ofl81vgC89M4fcI3BmCYQGSyZyytOdBU=;
 b=M56f2I0/15gOD1pmyIVc+Rmf2r+ho6V8nPfegzEQXC7zqIkM07ZGjKsu78dFIXYfqz
 dgd+mb74VC5xMmIohllLQnrYhKsDPItnbRQr6sp+Zxhywjv9NhmaYDtgSevD81Ms9IH+
 3r6jaRwbD6YPvW4pczwtSx7jdirIDqmBBPpDjbW+tRm9aYKReHzJG0Fob/OgO1dpMM5z
 Fsfz27HjYIO9diiiNPVIrlll7C/R+uYRfnmXpHkvI0ghFXiwbls25z8DRX+pT2mtDVrU
 7FQodxTMq5iXfBNHHh0h03FeXYKCvKISklMNnDQWRPhD6nlScyZIWE7vNwOSlyZdVAXp
 PqAA==
X-Gm-Message-State: ANhLgQ08XUKM5YOxIhOl6S7UuJ4e9fvlev2C0Nk2EU19HL/zrlgV3ZVP
 6/FpoJ85liwRcfs/dvBJ8L6Jgp4wbUVi7w==
X-Google-Smtp-Source: ADFU+vsWax8EvBxUUSu4b017CHsX2Y62Vq1glMujvpYYGxwHtHTxCn7b1dX/DC4aO8gS4rHq52CESQ==
X-Received: by 2002:a1c:e341:: with SMTP id a62mr7003260wmh.121.1583742892693; 
 Mon, 09 Mar 2020 01:34:52 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id h3sm63749726wrb.23.2020.03.09.01.34.51
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Mar 2020 01:34:52 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 4/4] virtio-net: block migration if RSS feature negotiated
Date: Mon,  9 Mar 2020 10:34:38 +0200
Message-Id: <20200309083438.2389-5-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309083438.2389-1-yuri.benditovich@daynix.com>
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
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

Block migration for reference implementation of
RSS feature in QEMU. When we add support for RSS
on backend side, we'll implement migration of
current RSS settings.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c            | 18 ++++++++++++++++++
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 19 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index abc41fdb16..943d1931a2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -37,6 +37,7 @@
 #include "qapi/qapi-events-migration.h"
 #include "hw/virtio/virtio-access.h"
 #include "migration/misc.h"
+#include "migration/blocker.h"
 #include "standard-headers/linux/ethtool.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
@@ -627,6 +628,12 @@ static void virtio_net_reset(VirtIODevice *vdev)
     n->announce_timer.round = 0;
     n->status &= ~VIRTIO_NET_S_ANNOUNCE;
 
+    if (n->migration_blocker) {
+        migrate_del_blocker(n->migration_blocker);
+        error_free(n->migration_blocker);
+        n->migration_blocker = NULL;
+    }
+
     /* Flush any MAC and VLAN filter table state */
     n->mac_table.in_use = 0;
     n->mac_table.first_multi = 0;
@@ -1003,6 +1010,17 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
         vhost_net_ack_features(get_vhost_net(nc->peer), features);
     }
 
+    if (virtio_has_feature(features, VIRTIO_NET_F_RSS)) {
+        if (!n->migration_blocker) {
+            error_setg(&n->migration_blocker, "virtio-net: RSS negotiated");
+            migrate_add_blocker(n->migration_blocker, &err);
+            if (err) {
+                error_report_err(err);
+                err = NULL;
+            }
+        }
+    }
+
     if (virtio_has_feature(features, VIRTIO_NET_F_CTRL_VLAN)) {
         memset(n->vlans, 0, MAX_VLAN >> 3);
     } else {
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 45670dd054..fba768ba9b 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -180,6 +180,7 @@ struct VirtIONet {
     virtio_net_conf net_conf;
     NICConf nic_conf;
     DeviceState *qdev;
+    Error *migration_blocker;
     int multiqueue;
     uint16_t max_queues;
     uint16_t curr_queues;
-- 
2.17.1


