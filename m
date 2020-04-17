Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F157C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49D7220644
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 08:05:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpZknUQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49D7220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPM0A-00072E-ES
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 04:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ni.xun.intel@gmail.com>) id 1jPJKk-0005fx-7E
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ni.xun.intel@gmail.com>) id 1jPJKj-0002Vc-6P
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 01:14:34 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ni.xun.intel@gmail.com>)
 id 1jPJKg-0002Ub-Qf; Fri, 17 Apr 2020 01:14:30 -0400
Received: by mail-pf1-x441.google.com with SMTP id y25so524321pfn.5;
 Thu, 16 Apr 2020 22:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4FGrssPyP2GvHmjw7awTY/F55dKYyfXpXPoaU8AZM5o=;
 b=HpZknUQu+qOV8VzyAhv26eF5Hm5NZxSpSUOIuCeZUOwA3Ob2KzImoDfoQaQtYWbweD
 oId5YBUoC4BbMXjomPMOwBZljXK8ByzrerujS1xq6Jwp8DZAT4gykVFq313il8v5kNu6
 dSGpmTsjZq+3ofSoCKtokOfYFcNBxrTGyyftlnSX/hd0HbchC6ccOXbjHXUx8Hl+gdY7
 JHLfKpksnHaN1M/PiscSNLrbssaxWlL2EacRWabyEwjhCRcKe34HtTsN9+AnaYQJdQMe
 mPpKCUhlVRC62bG8/08b9gK4PNyt/7PMHn/upwbOm8uJveFof5xV/G8ZnygflQ3oA/Zp
 Lgkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4FGrssPyP2GvHmjw7awTY/F55dKYyfXpXPoaU8AZM5o=;
 b=Y4Tz1bMoC0qiX8boKGJ26/5jVt4qXNB7K6/Xy0Lh0hBVVW5dH1f6GqJmQI+g+haU66
 ZtcQyFDoeBFqKahKkmykKTdYr7R8ZxbObP+e4wOWZtn6PJhURemw2erbIugAmU194fQ/
 IOzUjYq6HrLvylF5UZxGqr4qu/FgMJTB1cIsVh3Mo/aIPkLy1h/wf9rPqzE6irYzasID
 L/qWYuRZf7Bwz34/eSxDUq0dZZl0ghHXQ0EHMVaOwUeOe937BeYvwK9wkTkkB1nY4/gi
 2fWQIccZNRhB4uqjonmJ+jWxeZ9zauF3y4RG2OpIi7j2IPrp0p4esrzv00i3Pe9vU8jl
 XmIw==
X-Gm-Message-State: AGi0PubwxgYDFkxxApAlt5IJRYDjUet/pBbUEwTKqOjxND9Gm/a3Twox
 cZ5mkDMaYh+dRZzvzWQdE8w=
X-Google-Smtp-Source: APiQypLJ4fcDAc9SZ1fR6eViE3QCLgps6/l3HyeWQZUPzfFhisJmXvvpFWq1AwV5JGJxcvCC9FrgVQ==
X-Received: by 2002:aa7:9a92:: with SMTP id w18mr1446065pfi.95.1587100469260; 
 Thu, 16 Apr 2020 22:14:29 -0700 (PDT)
Received: from RICHARDNI-MB0.tencent.com ([203.205.141.36])
 by smtp.gmail.com with ESMTPSA id d7sm18241638pfa.106.2020.04.16.22.14.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 16 Apr 2020 22:14:28 -0700 (PDT)
From: ni.xun.intel@gmail.com
X-Google-Original-From: richardni@tencent.com
To: raphael.norwitz@nutanix.com, mst@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, qemu-block@nongnu.org
Subject: [PATCH] resend slave fd to vhost when reconnect to vhost
Date: Fri, 17 Apr 2020 13:14:00 +0800
Message-Id: <20200417051400.30398-1-richardni@tencent.com>
X-Mailer: git-send-email 2.24.1 (Apple Git-126)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
X-Mailman-Approved-At: Fri, 17 Apr 2020 04:03:58 -0400
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
Cc: Yan Miao <leomyan@tencent.com>, lucascye <lucascye@tencent.com>,
 Lu Zhigang <tonnylu@tencent.com>, qemu-devel@nongnu.org,
 Ni Xun <richardni@tencent.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Ni Xun <richardni@tencent.com>

when reconnecting to vhost server, it doesn't send slave fd to vhost
as the slave fd is only sent in vhost_user_init. also resend the slave fd
in vhost reconnect.

Signed-off-by: Ni Xun <richardni@tencent.com>
Signed-off-by: Lu Zhigang <tonnylu@tencent.com>
Signed-off-by: Yan Miao <leomyan@tencent.com>
Signed-off-by: lucascye <lucascye@tencent.com>
---
 hw/block/vhost-user-blk.c | 6 ++++++
 hw/virtio/vhost-user.c    | 2 +-
 include/hw/virtio/vhost.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 17df5338e7..59650a570b 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -138,6 +138,12 @@ static int vhost_user_blk_start(VirtIODevice *vdev)
             error_report("Error get inflight: %d", -ret);
             goto err_guest_notifiers;
         }
+    } else {
+        ret = vhost_setup_slave_channel(&s->dev);
+        if (ret < 0) {
+            error_report("Error setting vhost slave channel: %d", -ret);
+            return ret;
+        }
     }
 
     ret = vhost_dev_set_inflight(&s->dev, s->inflight);
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 08e7e63790..0da4a12787 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1115,7 +1115,7 @@ err:
     return;
 }
 
-static int vhost_setup_slave_channel(struct vhost_dev *dev)
+int vhost_setup_slave_channel(struct vhost_dev *dev)
 {
     VhostUserMsg msg = {
         .hdr.request = VHOST_USER_SET_SLAVE_REQ_FD,
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 085450c6f8..cad60ad521 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -100,6 +100,7 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev);
 void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev);
 int vhost_dev_enable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
 void vhost_dev_disable_notifiers(struct vhost_dev *hdev, VirtIODevice *vdev);
+int vhost_setup_slave_channel(struct vhost_dev *hdev);
 
 /* Test and clear masked event pending status.
  * Should be called after unmask to avoid losing events.
-- 
2.24.1 (Apple Git-126)


