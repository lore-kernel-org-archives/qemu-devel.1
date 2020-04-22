Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A57C54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 758E72098B
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ca2j8IaF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 758E72098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRK2S-0000Gl-Ma
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzw-0005Ij-O1
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jRJzw-0003Fw-4n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:24 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:44625)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jRJzv-0003DD-Mc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:21:23 -0400
Received: by mail-qt1-x843.google.com with SMTP id c23so1969123qtp.11
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2020 11:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=3XHy8cPDC058ii5Kpvd4Vd9LUQpAYLHDshsvadW2rYw=;
 b=Ca2j8IaF63I//mpvBhD/h3tEVSMmXmgLy/mXrU7Tp6Pi9R+8OtFo+d25sd16Sa4RKq
 yXPqCIOkFzQcvPhGQ4Hr6wAy5F7v89XuXVAmq/mmUwwL0/lHgr6tMUF9ahcPv94/hW6l
 ukVmUZ0m8SNE79ZsfCv4wGtGfiZbWD/fEfN/B+4GSDKVeJF3fL51YHtS/Sx46WDr1Agd
 lAY9bzdBalIZrDV2F2mQMRyAf0zSL38b9EPcL8HEJMRfjjFNQ+OPaGRk6OyM9WJtkwog
 nybF5sfEYN2sAZm3pzxqzglf/IgkwZr9zpunWP1E8a+NBaeoylJ2qeJkjq6HkG1FH13i
 o09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=3XHy8cPDC058ii5Kpvd4Vd9LUQpAYLHDshsvadW2rYw=;
 b=tmP33geFfCJ10ht0sFD9eG/q+bxsodad6ttfDtPmgfMELHjZMU0vf+SCYgmBXXiWVp
 hA6oW+r8HZFfp9vmOpCY2TVkXfJd5Pwq1QVohvf+gDsMNxqQBcPHD6QdHGKPdQwf5Utj
 AYEzjeWdY3qZVlkKSEzup3rwqpJiPid6qYWMMpvJGAngkMpW04kC1SbZJGvz2/Z4DDsl
 FiWBZOvqUjGJAQXQRkLUjfhlDc+tdqDDATkXhQLGX2bmukVHFMOiCOst+k8wqjxoiiL9
 sGJ2OIw8idjt7Mb1YL+Yda7IvnbMAhVNnb/sFs4Ix30V81DXjsNHIzjxPnVmkcJyYjqX
 11pA==
X-Gm-Message-State: AGi0PuZWbQugJNLY/ASez5KhPrG0fAWtpMsuI6BSuA/P9QoNA0xske1x
 CM8M7nznX7Ue6EB123YV9SA=
X-Google-Smtp-Source: APiQypLWDF3f0qFxa+6+HGzJSoHVxo0zSUHkDxEs+y+v/RaMyA7Av1wfNmeeECPfsezr0A8LOESxQw==
X-Received: by 2002:ac8:3254:: with SMTP id y20mr28002535qta.67.1587579682135; 
 Wed, 22 Apr 2020 11:21:22 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id b126sm4422623qkc.119.2020.04.22.11.21.21
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 22 Apr 2020 11:21:21 -0700 (PDT)
Subject: [PATCH v21 QEMU 4/5] virtio-balloon: Implement support for page
 poison tracking feature
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Wed, 22 Apr 2020 11:21:20 -0700
Message-ID: <20200422182120.12258.67417.stgit@localhost.localdomain>
In-Reply-To: <20200422181649.12258.37077.stgit@localhost.localdomain>
References: <20200422181649.12258.37077.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::843;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qt1-x843.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::843
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
we want to actually get data on if the guest will be poisoning pages.

Add a value for tracking the poison value being used if page poisoning is
enabled. With this we can determine if we will need to skip page reporting
when it is enabled in the future.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |    7 +++++++
 include/hw/virtio/virtio-balloon.h |    1 +
 2 files changed, 8 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a1d6fb52c876..5effc8b4653b 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.poison_val = cpu_to_le32(dev->poison_val);
 
     if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
         config.free_page_hint_cmd_id =
@@ -697,6 +698,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
+    dev->poison_val = 0;
+    if (virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
+        dev->poison_val = le32_to_cpu(config.poison_val);
+    }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -854,6 +859,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
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


