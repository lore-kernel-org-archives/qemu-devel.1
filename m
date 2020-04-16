Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2D3C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7442F21744
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 20:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G492WGL1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7442F21744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPAiQ-0006na-JY
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 16:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgr-000526-1n
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alexander.duyck@gmail.com>) id 1jPAgo-0000U4-SA
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:48 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38294)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alexander.duyck@gmail.com>)
 id 1jPAgo-0000Tm-Lj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 16:00:46 -0400
Received: by mail-pl1-x644.google.com with SMTP id w3so25945plz.5
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=wvk7nigxCNm3PB+AvD69Criz9Bq5lWke+Bvc71+/U/E=;
 b=G492WGL1cz1eCnfFjL3KlDJye+n7mj0KjCq8Nzpu6Qb1oLWeFtPrRWAIOp7SfXwDb8
 GrwQC6K+Utk8gi8jQ0MQxePLGjL0l4JN4EdJpot9knqFAgSElITcELsqkUMzxSo/XUy6
 VjA2PCZ+fw3t3Zkdvy1tAJwz7JBliK+yBpXQzE3o39rNf5E0cmc386HmQhww6O5Z3jvl
 yoR9Hcb30TKpJZihO+ZOr2JtBd85V6xmhyOKlhe6ieMppjWEcb0vKynUxDvGoyXzH8R/
 XLWdcFzfwTlX2/76iOtm+2FuZnjCLQoeE+knN901KFaTPBoq7ifrOnQcUDzvV8xZubN1
 VBZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=wvk7nigxCNm3PB+AvD69Criz9Bq5lWke+Bvc71+/U/E=;
 b=tn+xkaldNd40Q52Ehj/JsrO+Yv1EZBA5EkEr0c2F4KoCkbgI1nZPbEMM8677kqFc0g
 TCpJZq2WiHWhhFUcUEciTPjbQ7ilMXyDEPMtMxYybmCSo9OLkKuGbYgaZxI08yUH5+rR
 4zbuHwFd++eO37qKBYxTV5MJ/QMxXWi2SAkHaLGD3ODkfKgcAkFpC3KSdEuPxYqANxqg
 fAo6jSlVEr5oLdrW7pEQs7xUBzif5DyfgdfnVzgzIC4oO4F7NqoLTe+ULrxXYV0qXIif
 I8lLVm9pI1Trv7JGF0i26AJob3/6s92RItkPFudzBUJugOTDjgffPWCmDbpmWTzMPvPL
 MWqA==
X-Gm-Message-State: AGi0PuaLIJCMC4fHhcK97aRVm/vEL++T5OAUZIR+XOO0ZIYflY/rm4Q4
 gI/H1hy2jwhlMPLW9SZNeQA=
X-Google-Smtp-Source: APiQypKJLAm0D1gjhTifvaKp99X2/3SU6AyhBgMF+2kUC0JERsXYS1f3IaI10COM6csIAQdV0BbQvA==
X-Received: by 2002:a17:902:fe90:: with SMTP id
 x16mr11549082plm.295.1587067245627; 
 Thu, 16 Apr 2020 13:00:45 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id a13sm3322899pjq.0.2020.04.16.13.00.43
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 13:00:43 -0700 (PDT)
Subject: [PATCH v20 QEMU 3/5] virtio-balloon: Implement support for page
 poison tracking feature
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Thu, 16 Apr 2020 13:00:42 -0700
Message-ID: <20200416200042.13144.65487.stgit@localhost.localdomain>
In-Reply-To: <20200416195641.13144.16955.stgit@localhost.localdomain>
References: <20200416195641.13144.16955.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
 hw/virtio/virtio-balloon.c         |   27 +++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    1 +
 2 files changed, 28 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a1d6fb52c876..19d587fd05cb 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -531,6 +531,23 @@ static void virtio_balloon_free_page_start(VirtIOBalloon *s)
         return;
     }
 
+    /*
+     * If page poisoning is enabled then we probably shouldn't bother with
+     * the hinting since the poisoning will dirty the page and invalidate
+     * the work we are doing anyway.
+     *
+     * If at some point in the future the implementation is changed in the
+     * guest we would still have issues as the poison would need to be
+     * applied to the last state of the page on the remote end.
+     *
+     * To do that we could improve upon this current implementation by
+     * migrating a poison/zero page if the page is flagged as dirty instead
+     * of simply skipping it.
+     */
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        return;
+    }
+
     if (s->free_page_hint_cmd_id == UINT_MAX) {
         s->free_page_hint_cmd_id =
                        VIRTIO_BALLOON_FREE_PAGE_HINT_CMD_ID_MIN;
@@ -634,6 +651,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.poison_val = cpu_to_le32(dev->poison_val);
 
     if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
         config.free_page_hint_cmd_id =
@@ -697,6 +715,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
+    dev->poison_val = 0;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        dev->poison_val = le32_to_cpu(config.poison_val);
+    }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -706,6 +728,9 @@ static uint64_t virtio_balloon_get_features(VirtIODevice *vdev, uint64_t f,
     VirtIOBalloon *dev = VIRTIO_BALLOON(vdev);
     f |= dev->host_features;
     virtio_add_feature(&f, VIRTIO_BALLOON_F_STATS_VQ);
+    if (virtio_has_feature(f, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+        virtio_add_feature(&f, VIRTIO_BALLOON_F_PAGE_POISON);
+    }
 
     return f;
 }
@@ -854,6 +879,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
+
+    s->poison_val = 0;
 }
 
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
diff --git a/include/hw/virtio/virtio-balloon.h b/include/hw/virtio/virtio-balloon.h
index 108cff97e71a..3ca2a78e1aca 100644
--- a/include/hw/virtio/virtio-balloon.h
+++ b/include/hw/virtio/virtio-balloon.h
@@ -70,6 +70,7 @@ typedef struct VirtIOBalloon {
     uint32_t host_features;
 
     bool qemu_4_0_config_size;
+    uint32_t poison_val;
 } VirtIOBalloon;
 
 #endif


