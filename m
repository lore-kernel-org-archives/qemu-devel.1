Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC1AC2BA1B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 19:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E7D2075E
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 19:50:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcfhmoW9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E7D2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMGi2-0003F4-3Q
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 15:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMGgt-0001pc-O4
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:48:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jMGgs-0002ta-Ai
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:48:51 -0400
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834]:38385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jMGgs-0002tI-5K
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 15:48:50 -0400
Received: by mail-qt1-x834.google.com with SMTP id 13so915928qtt.5
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 12:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=V78oNbusAm5S3e7SX3vKPs7Z58CB44qhuhwypR7BDJE=;
 b=jcfhmoW9bkjhL7qdUeaFbBuwrAjEdNZwBij6kRQsZk447P9yvAqF+VPAxIQ9RTnv2f
 2RGYzU7B8nOZtBW6/+OZbmBS+Pil6ytrNkvkCNzMBnjZRHgucylMj7kzZkRUZWkfnlTM
 tV2Xx+jmsQXrwOUC4+ptXTKWbJ20IGXpvK2FubMVrJUq5lEhSAkEKpSLKknp4q9LvU/s
 aZ963fMCsbWEH0BgYFWkuE7Z6mkvbFnvlNv3fIkAqOqz4uo+YwNwWxlQsccaib8YfqKi
 vDjFOUdKiZ1vylKCXUrC4e9kPbgXUe1z3/7LwXzXFSg3g1Qn304A9LtfkeGuuxvmNfxE
 sCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=V78oNbusAm5S3e7SX3vKPs7Z58CB44qhuhwypR7BDJE=;
 b=f41KauZDYu97qLNxMe1IIY4J3nmgZatK81Q+HbihcmQSZnCcaXN3Tyi9IkxhEtKcP0
 C4WAhzgKaZBStHZNe5cMVGDe/kNoaCYSGJeXCQfghKymipD9/TbqXEbDBhyaeAenp+eO
 0zC+Bfw4iCZpu1MBPBPJbFk7hQB60RVusKa2tVy/HbciDpHoV/x9hGXZen3WxgWXL6kW
 qtbuEmbv/Ud3g+PblujyrzAI/TMwTgKRj8GvUktIz0KexrLDZG0fmOB2ZA7XKmLbmaSt
 elv1zMm0t0HHi/Q00btrD3TIEHmCCS1K53I/IU47+f1jrke5nTU15fFEgPFuME08dzQZ
 iwCw==
X-Gm-Message-State: AGi0PuZFkKCgy4ADiCJsp7tvq+PtXagcFeKgEO8cvS5nczMTnE1xqvQ7
 WryfvkOQ7AwYAN8BmBoioLQ=
X-Google-Smtp-Source: APiQypK0j0AbyZ9uZMx6YtbYcZZpm6duOkXi5D/eh2ypm9IW5lE2Qx2a4HsrC7fib7wGjII2HUGjMg==
X-Received: by 2002:aed:21b0:: with SMTP id l45mr8944433qtc.47.1586375329394; 
 Wed, 08 Apr 2020 12:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id g187sm19413251qkf.115.2020.04.08.12.48.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 08 Apr 2020 12:48:49 -0700 (PDT)
Subject: [PATCH v17 RESUBMIT QEMU 1/3] virtio-balloon: Implement support for
 page poison tracking feature
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 08 Apr 2020 12:48:47 -0700
Message-ID: <20200408194847.24143.91542.stgit@localhost.localdomain>
In-Reply-To: <20200408194628.24143.51644.stgit@localhost.localdomain>
References: <20200408194628.24143.51644.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::834
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
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

We need to make certain to advertise support for page poison tracking if
we want to actually get data on if the guest will be poisoning pages. So
if free page hinting is active we should add page poisoning support and
let the guest disable it if it isn't using it.

Page poisoning will result in a page being dirtied on free. As such we
cannot really avoid having to copy the page at least one more time since
we will need to write the poison value to the destination. As such we can
just ignore free page hinting if page poisoning is enabled as it will
actually reduce the work we have to do.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   25 +++++++++++++++++++++----
 include/hw/virtio/virtio-balloon.h |    1 +
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a4729f7fc930..455d85b7082f 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -531,6 +531,15 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    /*
+     * If page poisoning is enabled then we probably shouldn't bother with
+     * the hinting since the poisoning will dirty the page and invalidate
+     * the work we are doing anyway.
+     */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return;
+    }
+
     if (s->free_page_report_cmd_id == UINT_MAX) {
         s->free_page_report_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
@@ -618,12 +627,10 @@ static size_t virtio_balloon_config_size(VirtIOBalloon *s)
     if (s->qemu_4_0_config_size) {
         return sizeof(struct virtio_balloon_config);
     }
-    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON)) {
+    if (virtio_has_feature(features, VIRTIO_BALLOON_F_PAGE_POISON) ||
+        virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
         return sizeof(struct virtio_balloon_config);
     }
-    if (virtio_has_feature(features, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
-        return offsetof(struct virtio_balloon_config, poison_val);
-    }
     return offsetof(struct virtio_balloon_config, free_page_report_cmd_id);
 }
 
@@ -634,6 +641,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.poison_val = cpu_to_le32(dev->poison_val);
 
     if (dev->free_page_report_status == FREE_PAGE_REPORT_S_REQUESTED) {
         config.free_page_report_cmd_id =
@@ -697,6 +705,8 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
+    dev->poison_val = virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON) ? 
+                      le32_to_cpu(config.poison_val) : 0;
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -706,6 +716,9 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
+    }
 
     return f;
 }
@@ -854,6 +867,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
+
+    s->poison_val = 0;
 }
 
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
@@ -916,6 +931,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("x-page-poison", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_PAGE_POISON, false),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index d1c968d2376e..7fe78e5c14d7 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+    uint32_t poison_val;
 } VirtIOBalloon;
 
 #endif


