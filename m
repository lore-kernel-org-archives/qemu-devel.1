Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ABBAC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 21:32:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C51A821582
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 21:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI9BSC4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C51A821582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXAbS-0005Rx-TL
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 17:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jXAZL-000474-QN
 for qemu-devel@nongnu.org; Fri, 08 May 2020 17:30:07 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45427)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander.duyck@gmail.com>)
 id 1jXAZK-0008Nj-PH
 for qemu-devel@nongnu.org; Fri, 08 May 2020 17:30:07 -0400
Received: by mail-qk1-x742.google.com with SMTP id c64so3294707qkf.12
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 14:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:from:to:cc:date:message-id:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=kWpDL9Wq56xlA/lKBb//jEOpRoZyN/hs0hSMMWDLET0=;
 b=JI9BSC4N3pDB38mLBcFvDd2tp0goG4FiO0ZA+kcDHB6g5vbFMYHJhOy5/6gVsN/kOs
 eClEIMhMJJB0/N796xp+H4xTVetH+7GyRIul+t0R/9FJI5YV+MnrzKMlUjDnqcXia6s/
 58d6VHyk2uBP2bYkJJDCXfIoxdohlYfaUzqQUjD7dsbSKkS17rBIGKRyxtrZRPu1NXT/
 zToHDrrCiw9xoCQU4LiO8HrsBJb2vh3R2TN8MZHMErMtjcApRBfWYx7WhfLw89aB0DfT
 plSNGbT6YibTUYj/jdH2yKvj8+2IXZyEjcnDhDvgY20FUlxCmq0r9GuoHmjSUXFIGd3R
 mDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=kWpDL9Wq56xlA/lKBb//jEOpRoZyN/hs0hSMMWDLET0=;
 b=Hi7Ixgl3XCNTiOwWiATA3RroNvnYgaJxRbO8o0VJDUGcaBiUS6DuVu5hDkw5L0oNMB
 KzBEbS4f0p756HSKimFKIgT03vE1wyPohwhyqP3M+FjsUHSvbRmYX5/LRn9dhkou9Q+X
 /cQuZ/S/lxJGt1a95hCLuwoo7SPKhZYokmV04ryh7Pyu/EGAdJ3iX9SdUcNT3ACQyXDO
 jC+X83fnyipudH/XjroNa86rkgyQIswlqHAN89SXySZv2UNjxS25QTc9uO7FdikBKYMO
 pzZACQOu5BWckcmu7LBei5YZnzBU5+mj417b6IGCAqq0SEMcgLjBpDy96X6jddZMZbKJ
 2s7A==
X-Gm-Message-State: AGi0PubtAzn+TAqtkjx9mOLvg0JYUwXX80comFJObD3Hnvee1gP4Pe8E
 aA4SNohmLf9Nb3bP12NEPC4=
X-Google-Smtp-Source: APiQypLmFG4qdqFo/QfLNb9iWky/BaflRucfiIMtieeh+2N6fQrUHXYeIKIMRIiUF5HzAUr64FXNEA==
X-Received: by 2002:a05:620a:b19:: with SMTP id
 t25mr4586856qkg.428.1588973405564; 
 Fri, 08 May 2020 14:30:05 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:b:9c3:9e5c:8eff:fe4f:f2d0])
 by smtp.gmail.com with ESMTPSA id c41sm2584988qta.96.2020.05.08.14.30.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 May 2020 14:30:05 -0700 (PDT)
Subject: [PATCH v24 QEMU 2/3] virtio-balloon: Implement support for page
 poison reporting feature
From: Alexander Duyck <alexander.duyck@gmail.com>
To: david@redhat.com, mst@redhat.com
Date: Fri, 08 May 2020 14:30:03 -0700
Message-ID: <20200508213003.26071.95962.stgit@localhost.localdomain>
In-Reply-To: <20200508212719.26071.94248.stgit@localhost.localdomain>
References: <20200508212719.26071.94248.stgit@localhost.localdomain>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::742;
 envelope-from=alexander.duyck@gmail.com; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 hw/core/machine.c                  |    4 +++-
 hw/virtio/virtio-balloon.c         |   29 +++++++++++++++++++++++++++++
 include/hw/virtio/virtio-balloon.h |    1 +
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 7a50dd518f4c..da26d58634dc 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -28,7 +28,9 @@
 #include "hw/mem/nvdimm.h"
 #include "migration/vmstate.h"
 
-GlobalProperty hw_compat_5_0[] = {};
+GlobalProperty hw_compat_5_0[] = {
+    { "virtio-balloon-device", "page-poison", "false" },
+};
 const size_t hw_compat_5_0_len = G_N_ELEMENTS(hw_compat_5_0);
 
 GlobalProperty hw_compat_4_2[] = {
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index a209706b4d8d..1666132a24c1 100644
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


