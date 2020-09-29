Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74858C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:44:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1116206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBdLF+z6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1116206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNAJQ-0001gB-Mr
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0f-0007Yo-K5
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0Z-0002Bb-GL
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:13 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OtuDJIdJ5w4UGc1V2cVEinxPVBCkF805rxImr5K61RY=;
 b=UBdLF+z6FtFVw+PIIRH6ktegkEQ3+Wt6N1PeEndh1vXtDvE7M+v6PHpRyk6Le2zBTTp6Yw
 EGz3lXet+C+HUoV9F1OYT2sof3KqPMI7m6DO+DMhvvTyBTvjBT/IEnDAOR67R/alLSXJye
 EYvhNxyVSoXYz8xfXnioba7rDEHmYKI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-utD7RgCQNR-E-B5AVqupwQ-1; Tue, 29 Sep 2020 03:21:49 -0400
X-MC-Unique: utD7RgCQNR-E-B5AVqupwQ-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1375728wrv.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=OtuDJIdJ5w4UGc1V2cVEinxPVBCkF805rxImr5K61RY=;
 b=OCUjzrtgkm/dWDb08hJE5vC1YDInLEVoUB90aQpTasvxcaHPloANwLNOxpsVS81Fan
 wziEOe3Wp1bVjWUPPPAV3K/lkyE8hhMj+OR8lBrxAVokDAwEbZgUK85SuFLsfVQ0IW/V
 kp8do0Yjnq13X5xO1QRqgeKzWqWBX6wT1jYkFUgNR9NAWAe8+56bb69H0v0ZqRzTdX0G
 4EBORjAbC6q0XBmKZx9FdOvtU9IBYmdzuVDCYSEKgAxUtesu/8pkVD7oskTfeKpUMV7+
 6UXNBgS45k//Dxx9yCHJkofzpQFoefDbi19zFgw8zqKnLC/QvT850rg8KAkqHtv3CIFS
 h56A==
X-Gm-Message-State: AOAM532FOYvpEK7hqxtltKLyZj7JVUA70hAC0xIlp9Gas6hN5RmV0HTm
 e/EvuI0TYGgMJeuoua91OJ3mbXwsx1nQXxztkwWgWoCmzu5ULD/LtiAsiuAoPKbMJJL3fP2YCPp
 TKFDqlMdKzHr+oJE=
X-Received: by 2002:adf:a35d:: with SMTP id d29mr2523763wrb.307.1601364108456; 
 Tue, 29 Sep 2020 00:21:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkNrZWMqxoVjiN9DBOVuxj00BgGz1FN9YDiZfN3ysMzveoaymFmRZPTBLJ2jezhq7Sh7ECsA==
X-Received: by 2002:adf:a35d:: with SMTP id d29mr2523742wrb.307.1601364108298; 
 Tue, 29 Sep 2020 00:21:48 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id a10sm4125449wmj.38.2020.09.29.00.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:47 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 20/48] virtio: update MemoryRegionCaches when guest set bad
 features
Message-ID: <20200929071948.281157-21-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Li Qiang <liq3ea@163.com>,
 Alexander Bulekov <alxndr@bu.edu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Current the 'virtio_set_features' only update the 'MemorRegionCaches'
when the 'virtio_set_features_nocheck' return '0' which means it is
not bad features. However the guest can still trigger the access of the
used vring after set bad features. In this situation it will cause assert
failure in 'ADDRESS_SPACE_ST_CACHED'.

Buglink: https://bugs.launchpad.net/qemu/+bug/1890333
Fixes: db812c4073c7 ("virtio: update MemoryRegionCaches when guest negotiates features")
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200919082706.6703-1-liq3ea@163.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index a2edb4f386..6f8f865aff 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2963,17 +2963,16 @@ int virtio_set_features(VirtIODevice *vdev, uint64_t val)
         return -EINVAL;
     }
     ret = virtio_set_features_nocheck(vdev, val);
-    if (!ret) {
-        if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
-            /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
-            int i;
-            for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
-                if (vdev->vq[i].vring.num != 0) {
-                    virtio_init_region_cache(vdev, i);
-                }
+    if (virtio_vdev_has_feature(vdev, VIRTIO_RING_F_EVENT_IDX)) {
+        /* VIRTIO_RING_F_EVENT_IDX changes the size of the caches.  */
+        int i;
+        for (i = 0; i < VIRTIO_QUEUE_MAX; i++) {
+            if (vdev->vq[i].vring.num != 0) {
+                virtio_init_region_cache(vdev, i);
             }
         }
-
+    }
+    if (!ret) {
         if (!virtio_device_started(vdev, vdev->status) &&
             !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
             vdev->start_on_kick = true;
-- 
MST


