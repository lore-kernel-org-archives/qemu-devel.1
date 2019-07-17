Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC6EC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF2D620880
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 09:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TESzvAxJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF2D620880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hngXX-00073H-65
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 05:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hngXD-00063H-OL
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hngXC-0004Tl-Nb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:47:39 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45495)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hngXC-0004TU-HM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 05:47:38 -0400
Received: by mail-wr1-x430.google.com with SMTP id f9so24015978wre.12
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 02:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=NjI+HmyxGNKghok4nOlp66yM1BjstXg68u+D7oUdNEc=;
 b=TESzvAxJEltSse3Qs1grm+2ivvCGvT5m8QSEsHFCKtBDRl3veA70lPTI7NsDG5Wjjg
 +7yRXZZgOPgG4UgD+TR+C6+Zz9oyZVALoaQxM8rSdM6fsBbTWNarCKkjxNkXjhMJflZ8
 4nl5pL9yWOt/oR5isHurGWBN//4WKm9yat3ZsJdeSEXDEvZfcKFZvvZL/jTNXsHwhTAV
 Y+ertceD7rtG+o/qB/C8/OXYZ1tgL/o3kh/jIWMLlTZzbE2qB0UezHJoG7ikjNMR29EP
 koSxw+BLGmpNT/Xs5T3b2FhWlHPbf5UPTaNuJ8KSYTBkigdH2jNXpTv2yRCG5p4KR9N1
 l9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=NjI+HmyxGNKghok4nOlp66yM1BjstXg68u+D7oUdNEc=;
 b=neVIOAEsxxyfynkfytUxHe1vLVvB8KAwdOlLTNcK6rkKXLBal2DhnnXjSNHXImkhDa
 wkwS0z5LaxLcaddZav5kuqZkTIAxv9KKtb+mZNPwLMzBNBm7gjHd/B2+/n30B+uSHYc+
 aaRDhwE08bqXT5qz8eWldXDuCRQ/7DwznqB0QEkSMSoCkbaECq7P5zMF0YahYVV5LgAM
 W+2AhkERzIFQXlt2wlx+4baiZ9TjxA8HKpvpNTi7k+uE8dbbXp15PXuevTACjBvaE5wz
 LZkmqJaTZbWeTu8MBzTprytZsyyZBiy/9nRRgIKwwuASyjpiJthGl9OZaXc2OUIHzBT+
 Szdg==
X-Gm-Message-State: APjAAAXOk6C6ORtHESDdFtd7U7/ilYhIxYd7JZRSB9MBbp+MzHKVWqtp
 eJrgbIc9w6sTtIIkJF3esG6I9M9wJVs=
X-Google-Smtp-Source: APXvYqxrfniimrHvc8NUjiOLAb2h3gZNJG6RmqQuAcRpEoU9MvnJ8BtjuFgobiDQUpeKLLX1qr8l+Q==
X-Received: by 2002:adf:deca:: with SMTP id i10mr30730025wrn.313.1563356857248; 
 Wed, 17 Jul 2019 02:47:37 -0700 (PDT)
Received: from donizetti.lan ([2001:b07:6468:f312:e427:3beb:1110:dda2])
 by smtp.gmail.com with ESMTPSA id y12sm2037249wru.30.2019.07.17.02.47.36
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 02:47:36 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 17 Jul 2019 11:47:35 +0200
Message-Id: <20190717094735.31151-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PATCH] vhost-user-scsi: Call
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
 hw/scsi/vhost-user-scsi.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index a0b69fbc0f..665939df19 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -87,7 +87,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     }
 
     if (!vhost_user_init(&s->vhost_user, &vs->conf.chardev, errp)) {
-        return;
+        goto free_virtio;
     }
 
     vsc->dev.nvqs = 2 + vs->conf.num_queues;
@@ -101,15 +101,23 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
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
+    err = NULL;
+    virtio_scsi_common_unrealize(dev, &err);
+    error_propagate(errp, err);
 }
 
 static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
-- 
2.21.0


