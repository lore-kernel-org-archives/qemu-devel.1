Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC8CC76188
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B719A21849
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+mvkvVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B719A21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hor9i-0002SU-1d
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 11:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8S-0005wR-Vu
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hor8R-00087S-SP
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:56 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:42934)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hor8R-00086d-Lh
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 11:18:55 -0400
Received: by mail-wr1-x431.google.com with SMTP id x1so20022821wrr.9
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 08:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gEyNtMZO6zjfyzbu3zzmhWKRQ42+siiVg/LlDUHOq+c=;
 b=j+mvkvVCSTi0ypnxPSjFFSFtm5hSzfk7JxmV91Q9Dk77VcLQuL6ULdGpyDQdCJWbTQ
 LQLDAJMafu0QbAcmWdUwLkma3fmGPVrRTg5NMoDh8cl5+83TLfxaw7WSG/HoJhAUKWM4
 vu71CwwvbgJiDAINDRsrPfhZ2VK/OwTez+wGON3E3WyDQ7ZiVU9PaidjmtcjYhZwLh4V
 d4G4ccsSG5eN0MplgHgIefjzIEn5lrhSmcDyk2Cj1NVplghxNdqRdkErdT2/Sd66L5DZ
 pU5EYwccDbfqle7OY1KU9hziZiwKERLd476QiSqi1U04FQvUnxLERYj8bmagR4KC8G4R
 30iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=gEyNtMZO6zjfyzbu3zzmhWKRQ42+siiVg/LlDUHOq+c=;
 b=l4TqYU8A9C6t2EJSHVR+m7Bo6P4wdWKSWDm/Qa48VuT1+nXUMIvpZM9bFAQ2VHtGRS
 WA1vzfD7HIyVod0sBqboBdlnc0VN/bQnEpeOdREzRztidW04WYHJVJGU4PncORebmHvd
 4RI2V0X2fA0YZ5UN98bY7eY4GE5c293ct+Bj4EZudcnP8Hr2/jtQNrhqQlpbk9dAP344
 3tRjhUdQk6G/ImMLquptSyulZb/FtBZ7Tfq5qre47xlLc6S0b/xDRZgd3hA3azd8s9PY
 z6VkLljqiACVzMAmeXQ4KJwMF/xhCUomGfP9Ma/4CcpuHZl55uj4dni0bAoERZbth4cd
 93nQ==
X-Gm-Message-State: APjAAAWRjf3rKKOxepgiY4JtzbCy1EJQ3gG44/Jc2CfR/MUIGAh4J5fi
 PhBmxiNV5WmKn3rlAi4wYKZeOLP+hzw=
X-Google-Smtp-Source: APXvYqzqY/Uk/1g0Q98sK4OuEgomBt5kEe/JS9CtMdDYUI/esmTanpqv/kYCNSdrhsqADNt+02j9bA==
X-Received: by 2002:adf:aac8:: with SMTP id i8mr18862560wrc.56.1563635934464; 
 Sat, 20 Jul 2019 08:18:54 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:6468:f312:8501:6b03:f18c:74f8])
 by smtp.gmail.com with ESMTPSA id 4sm77517291wro.78.2019.07.20.08.18.53
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Sat, 20 Jul 2019 08:18:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Sat, 20 Jul 2019 17:18:39 +0200
Message-Id: <20190720151846.7450-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190720151846.7450-1-pbonzini@redhat.com>
References: <20190720151846.7450-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: [Qemu-devel] [PULL 05/12] vhost-user-scsi: Call
 virtio_scsi_common_unrealize() when device realize failed
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
Cc: Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Xie Yongji <xieyongji@baidu.com>

This avoids memory leak when device hotplug is failed.

Signed-off-by: Xie Yongji <xieyongji@baidu.com>
Message-Id: <20190717004606.12444-2-xieyongji@baidu.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a0b69fb..fcee67d 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -87,7 +87,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
-        return;
+        goto free_virtio;
     }
 
     vsc->dev.nvqs = 2 + vs->conf.num_queues;
@@ -101,15 +101,21 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     if (ret < 0) {
         error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
                    strerror(-ret));
-        vhost_user_cleanup(&s->vhost_user);
-        g_free(vqs);
-        return;
+        goto free_vhost;
     }
 
     /* Channel and lun both are 0 for bootable vhost-user-scsi disk */
     vsc->channel = 0;
     vsc->lun = 0;
     vsc->target = vs->conf.boot_tpgt;
+
+    return;
+
+free_vhost:
+    vhost_user_cleanup(&s->vhost_user);
+    g_free(vqs);
+free_virtio:
+    virtio_scsi_common_unrealize(dev);
 }
 
 static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
-- 
1.8.3.1



