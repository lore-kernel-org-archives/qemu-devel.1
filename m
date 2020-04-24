Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22DDFC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E148120728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 16:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txOOSUbC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E148120728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS1ZG-0003TC-1D
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 12:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57360)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS1X6-0008M5-UF
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alexander.duyck@gmail.com>) id 1jS1X5-0001S3-Ro
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:32 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:45464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jS1X4-0001Rc-Is
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 12:50:30 -0400
Received: by mail-pg1-x544.google.com with SMTP id s18so2209256pgl.12
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 09:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=qQSE9xY+bZPeugIwTDjDoRQwhyskSjNL7bLb7JxZBUU=;
 b=txOOSUbCrcSxcHyz0lNQnTgdMetnff6fJWt/CwoPZFzSWsaN1kjdH4ALqqP9xymigj
 +GKPLpdpS2wnABc296nsFWNmm8cUkcmPDM5FG2Ndmh2N7b2NqwEfnbIcs445nIHxYFEn
 F0DAfIb8Sy5r44L2SL/3okcgO3VyCEr70rwCbdP4jApKg9PVA6P4lA+mfO//dnAg7Otw
 1kaP+HscGE99N4ry3ReHb1FPx774s3xYZiSW4BcCnKSpItDSXXBJ9LATq287+eeZ+EWn
 +kRwUHDMmN1hlEyZjoomG+RBtoPA0Uk9hq86Keu2ctiWK9KDy8UFSOh8P2BXDjF3rxjZ
 VRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=qQSE9xY+bZPeugIwTDjDoRQwhyskSjNL7bLb7JxZBUU=;
 b=Iv7YSYQG4Wn2ZgzCo+KvvhQxMVQoJ6ssEHXr4jL/WteV3/h/Yd3JnxAxsBJnFaK9vk
 4GUmsAnHaI1q0sFSx3boRvCIiGc5UagmD8z9HV56MO9P4wr4+f+3LWKsSqvgJTKB4vXq
 CC1vaw0Yuf8/fDe4FYfmnW7Qi7pKTADvyECzd2wSrN+l0mTJNc6G1in7BYbX1yPlhSHU
 zXYBsKKxlFbS7GGAvJ0CKSJgHz9r4RI2ap9N2cy00wqE7U2C9NJ/z+PkEIloKNKzEmct
 abD9Kxlm6fAXOmwtE3i+cpMqeibLNkaPpV2UdBKtPHoEqihNQ6d0LE7gpGDHdQeSIK0g
 YGow==
X-Gm-Message-State: AGi0Pub4Pocwky6/QLMri9tUcEr8hPJZ2vx5lfOu5v3+xBVK2JGfg+Ac
 T+O3YDy9rrzgz5khxXPjw4s=
X-Google-Smtp-Source: APiQypKyCJyYueGFrNNHqX16f/Mf33XfCx8nkzMqjLW3orXtZeJM1t4QEUTRMvNAluEAUshN9ZeegQ==
X-Received: by 2002:a63:5044:: with SMTP id q4mr10173130pgl.5.1587747029193;
 Fri, 24 Apr 2020 09:50:29 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id w3sm6112817pfn.115.2020.04.24.09.50.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 24 Apr 2020 09:50:28 -0700 (PDT)
Subject: [PATCH v22 QEMU 4/5] virtio-balloon: Implement support for page
 poison reporting feature
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Fri, 24 Apr 2020 09:50:28 -0700
Message-ID: <20200424165028.10723.60530.stgit@localhost.localdomain>
In-Reply-To: <20200424164239.10723.58352.stgit@localhost.localdomain>
References: <20200424164239.10723.58352.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=alexander.duyck@gmail.com; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::544
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

We need to make certain to advertise support for page poison reporting if
we want to actually get data on if the guest will be poisoning pages.

Add a value for reporting the poison value being used if page poisoning is
enabled in the guest. With this we can determine if we will need to skip
free page reporting when it is enabled in the future.

The value currently has no impact on existing balloon interfaces. In the
case of existing balloon interfaces the onus is on the guest driver to
reapply whatever poison is in place.

When we add free page reporting the poison value is used to determine if
we can perform in-place page reporting. The expectation is that a reported
page will already contain the value specified by the poison, and the
reporting of the page should not change that value.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/virtio/virtio-balloon.c         |   29 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    1 +
 2 files changed, 30 insertions(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a1d6fb52c876..c1c76ec09c95 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -634,6 +634,7 @@ static void virtio_balloon_get_config(VirtIODevice *vdev, uint8_t *config_data)
 
     config.num_pages = cpu_to_le32(dev->num_pages);
     config.actual = cpu_to_le32(dev->actual);
+    config.poison_val = cpu_to_le32(dev->poison_val);
 
     if (dev->free_page_hint_status == FREE_PAGE_HINT_S_REQUESTED) {
         config.free_page_hint_cmd_id =
@@ -683,6 +684,14 @@ static ram_addr_t get_current_ram_size(void)
     return size;
 }
 
+static bool virtio_balloon_page_poison_support(void *opaque)
+{
+    VirtIOBalloon *s = opaque;
+    VirtIODevice *vdev = VIRTIO_DEVICE(s);
+
+    return virtio_vdev_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
+}
+
 static void virtio_balloon_set_config(VirtIODevice *vdev,
                                       const uint8_t *config_data)
 {
@@ -697,6 +706,10 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
         qapi_event_send_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
+    dev->poison_val = 0;
+    if (virtio_balloon_page_poison_support(dev)) {
+        dev->poison_val = le32_to_cpu(config.poison_val);
+    }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
 
@@ -755,6 +768,17 @@ static const VMStateDescription vmstate_virtio_balloon_free_page_hint = {
     }
 };
 
+static const VMStateDescription vmstate_virtio_balloon_page_poison = {
+    .name = "vitio-balloon-device/page-poison",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = virtio_balloon_page_poison_support,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(poison_val, VirtIOBalloon),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_virtio_balloon_device = {
     .name = "virtio-balloon-device",
     .version_id = 1,
@@ -767,6 +791,7 @@ static const VMStateDescription vmstate_virtio_balloon_device = {
     },
     .subsections = (const VMStateDescription * []) {
         &vmstate_virtio_balloon_free_page_hint,
+        &vmstate_virtio_balloon_page_poison,
         NULL
     }
 };
@@ -854,6 +879,8 @@ static void virtio_balloon_device_reset(VirtIODevice *vdev)
         g_free(s->stats_vq_elem);
         s->stats_vq_elem = NULL;
     }
+
+    s->poison_val = 0;
 }
 
 static void virtio_balloon_set_status(VirtIODevice *vdev, uint8_t status)
@@ -916,6 +943,8 @@ static Property virtio_balloon_properties[] = {
                     VIRTIO_BALLOON_F_DEFLATE_ON_OOM, false),
     DEFINE_PROP_BIT("free-page-hint", VirtIOBalloon, host_features,
                     VIRTIO_BALLOON_F_FREE_PAGE_HINT, false),
+    DEFINE_PROP_BIT("page-poison", VirtIOBalloon, host_features,
+                    VIRTIO_BALLOON_F_PAGE_POISON, true),
     /* QEMU 4.0 accidentally changed the config size even when free-page-hint
      * is disabled, resulting in QEMU 3.1 migration incompatibility.  This
      * property retains this quirk for QEMU 4.1 machine types.
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


