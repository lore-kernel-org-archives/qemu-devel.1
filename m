Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1440BC47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:04:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D399420640
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="HHH0aoB9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D399420640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvWw-0006Fn-VA
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIvRF-0008Ei-8t
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIvRD-0000XU-VZ
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:58:36 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mikhail.sennikovskii@cloud.ionos.com>)
 id 1iIvRD-0000X7-MG
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 09:58:35 -0400
Received: by mail-ed1-x542.google.com with SMTP id h2so8777158edn.3
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 06:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id;
 bh=pn/7UX82hnkyCmlRyxAFvkcLsirvCKVjBf2U+cH5riY=;
 b=HHH0aoB9fZ4oIf004cr1sVdGFpcUN4W9o7Qr98qduFW+7rNulcbj3yos2RginL6nGD
 VGLNYvfiAYzxQr15Rk6XxFmNvmkPLLXY9dyTnh1IandyNLztlF86i704GD7Rsmq1wHtH
 cFgq7rVeLtkQ3SK94Jp4LXj7+mS33PxUHyrkgrec/MVHTVTVKvNTJLn9iEmiR8EVb2Lg
 uUNiOsdY0K/nWZDZSEjoj0smNK1Xlan5lruC7psMU8gg8N83rrfd99emZOMPgFOAdMOV
 nzvHeOzK/Hbcme2ZdSkepLWYEgOxCRf5KlYO4ApXZ3R30e/vcavAiu+nIY32UjYA8Ftd
 vaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=pn/7UX82hnkyCmlRyxAFvkcLsirvCKVjBf2U+cH5riY=;
 b=hCUTUg2cleUHHRVY3FljdIxhOw9qXVXI1DlAjYjb0+cqKaZzBBAsvEe/8WERoTWJYJ
 tAb+o3AH0do57Sm3oeYwMgfXLQLZaRxT0fNu1ICFeesfPSd6DIxHmoq/rAbh1R9oQe0a
 PqQIunxXYezH8Qfjs900BhTG3gNRWHCruXb9y4jlT9yCQpftsDO0UttmUoY3EWteQ6kw
 5qf8qWNast4Ycluc/+cg3CnZJf36e3MQEdN9mnj/RliJ68gVEh3F+AHEQSkAAHqXLiAf
 XT9VeO85hb2/N7aqTtJIYwPKKzilHgLf8CplqAluXEf79wb6XDitukX9nQkDJsugyrdc
 xvVg==
X-Gm-Message-State: APjAAAUghEaZhFVQGYRyarR3SuZ44RkWGeh+/Sm/mRRUijjx/AxtGCb/
 LRRoH0Hj3/IzsoKUY+UfMtx9xg==
X-Google-Smtp-Source: APXvYqzAKc3TFtE/+d23x/KqY0f0ZAEYcf9bLjwHoRODgLkDesGD5phMs5HZnecgoHgn37LKO48WSA==
X-Received: by 2002:a17:906:4d85:: with SMTP id
 s5mr14316718eju.192.1570802314444; 
 Fri, 11 Oct 2019 06:58:34 -0700 (PDT)
Received: from msennikovskii2.pb.local
 ([2001:1438:4010:2558:9cc:2ca5:45db:2acf])
 by smtp.googlemail.com with ESMTPSA id 36sm1547982edz.92.2019.10.11.06.58.33
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 11 Oct 2019 06:58:33 -0700 (PDT)
From: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, dgilbert@redhat.com, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 1/2] virtio: new post_load hook
Date: Fri, 11 Oct 2019 15:58:03 +0200
Message-Id: <1570802284-3064-1-git-send-email-mikhail.sennikovskii@cloud.ionos.com>
X-Mailer: git-send-email 2.7.4
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Michael S. Tsirkin" <mst@redhat.com>

Post load hook in virtio vmsd is called early while device is processed,
and when VirtIODevice core isn't fully initialized.  Most device
specific code isn't ready to deal with a device in such state, and
behaves weirdly.

Add a new post_load hook in a device class instead.  Devices should use
this unless they specifically want to verify the migration stream as
it's processed, e.g. for bounds checking.

Suggested-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Mikhail Sennikovsky <mikhail.sennikovskii@cloud.ionos.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c         | 7 +++++++
 include/hw/virtio/virtio.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a94ea18..7c3822c 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2287,6 +2287,13 @@ int virtio_load(VirtIODevice *vdev, QEMUFile *f, int version_id)
     }
     rcu_read_unlock();
 
+    if (vdc->post_load) {
+        ret = vdc->post_load(vdev);
+        if (ret) {
+            return ret;
+        }
+    }
+
     return 0;
 }
 
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index b189788..f9f6237 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -158,6 +158,12 @@ typedef struct VirtioDeviceClass {
      */
     void (*save)(VirtIODevice *vdev, QEMUFile *f);
     int (*load)(VirtIODevice *vdev, QEMUFile *f, int version_id);
+    /* Post load hook in vmsd is called early while device is processed, and
+     * when VirtIODevice isn't fully initialized.  Devices should use this instead,
+     * unless they specifically want to verify the migration stream as it's
+     * processed, e.g. for bounds checking.
+     */
+    int (*post_load)(VirtIODevice *vdev);
     const VMStateDescription *vmsd;
 } VirtioDeviceClass;
 
-- 
2.7.4


