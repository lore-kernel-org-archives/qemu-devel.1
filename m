Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5072DC2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16D51206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="uOC7xMkg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16D51206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOYjp-0005YN-2a
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 23:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jOYim-0003zD-11
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jOYik-0003Wd-S6
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:15 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jOYik-0003WG-NM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:14 -0400
Received: by mail-pl1-x642.google.com with SMTP id d24so744447pll.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
 :references:content-transfer-encoding;
 bh=b6O9MOPsS5sqJwwRSOtIH4vxPCnN0SubzzVkQkgHtWE=;
 b=uOC7xMkgTRK3uL5lWMJprvE4cZXzrsuX/xuqArrJ0W6B75tletpxKX46xDiAsQmfDJ
 vNLHTzkwcQJ2NauINYSoTSVgTd0/CvqVh2leLzqVKxzexzU/SrUtOZYBO2czXDofrlX/
 LV3pDstcCJQSArYL3xrSnuQZd9jFcTcvujVNiVj8Dop9YtQxi3cidovoZ9BbQUQZ64je
 Lk7fT+2ee97TxRgzUr2kODul1O3pEP/l69UlE43sVAC6ReHSl+9VSyoHV1jI+EBIF9bj
 UpCVHbCjrpdZOE8enBfW1IqQsKxkDo5U0/W0ysm5HU5n/SPJvRe7RbfkPKsZgWeVkw/h
 Yz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :in-reply-to:references:content-transfer-encoding;
 bh=b6O9MOPsS5sqJwwRSOtIH4vxPCnN0SubzzVkQkgHtWE=;
 b=BVqaSHPU4kjTVKyc/enl4zixLsSZcYj4ht24UYtS5e23O1hYu1xx6W0IgB9PO6RZtw
 uGxRnMTtEL5RS7sBgsP+N5090d/7y3B6FBVZqXaJILDfgvfglOQR+OLnG6euT7B0xIxJ
 ou2xSqXcXWip91avx6acgMg0H5O3RT2xO2UwZFs0FpXxQ4QfXKLlEd35YumwAb5CYgYN
 e0z37PCjKXnyaIlwI8C+7gqwKJMQzttmNO0NVb1ZUoYyA2VMTk1HuF7jkV3mRuGvThDW
 jT0z0ghGnk7iQLbsamzYLVPNDFfEkXBfGeUjEVeSuXFy5FDdryFSv409iHyGH3nwrTmf
 iQug==
MIME-Version: 1.0
X-Gm-Message-State: AGi0PuZMfp33RBshug4WZBLi9bW+ShplbhLfeSNqS/b1einYnLclmlEg
 y/BywBtkumrxcUTgo971RMsY/nuXx6tSrHso/eqNvqj33ohmryc32nRs7YNZbXTNPipw49Tv6Jn
 9WBPG4AP7
X-Google-Smtp-Source: APiQypLPo/eiQ8JgedI0yKEnD504kyhFcjFFqgZwQuQJG1GlQZ49O9vbKix5//mHOeunCdmvYeglcQ==
X-Received: by 2002:a17:902:8d89:: with SMTP id
 v9mr3026092plo.83.1586921293772; 
 Tue, 14 Apr 2020 20:28:13 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id d21sm5915061pjs.3.2020.04.14.20.28.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2020 20:28:13 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 4/4] vhost-user-blk: fix crash in realize process
Date: Wed, 15 Apr 2020 11:28:26 +0800
Message-Id: <20200415032826.16701-5-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200415032826.16701-1-fengli@smartx.com>
References: <20200415032826.16701-1-fengli@smartx.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: Li Feng <fengli@smartx.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The crash could be reproduced like this:
1. break vhost_user_write;
2. kill the vhost-user-blk target;
3. let qemu continue running;
4. start vhost-user-blk;
5. see crash!

This fix makes changes:
1. set s->connected to true after vhost_dev_init;
2. call vhost_dev_get_config when s->connected is true, otherwise the
    hdev->host_ops will be nullptr.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c | 47 +++++++++++++++++++++++++------------------=
----
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 19e79b96e4..35386b7cb7 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -303,8 +303,6 @@ static int vhost_user_blk_connect(DeviceState *dev)
     if (s->connected) {
         return 0;
     }
-    s->connected =3D true;
-
     s->dev.nvqs =3D s->num_queues;
     s->dev.vqs =3D s->vhost_vqs;
     s->dev.vq_index =3D 0;
@@ -318,6 +316,11 @@ static int vhost_user_blk_connect(DeviceState *dev)
                      strerror(-ret));
         return ret;
     }
+    /*
+     * set true util vhost_dev_init return ok, because CLOSE event may hap=
pen
+     * in vhost_dev_init routine.
+     */
+    s->connected =3D true;
=20
     /* restore vhost state */
     if (virtio_device_started(vdev, vdev->status)) {
@@ -401,6 +404,7 @@ static void vhost_user_blk_device_realize(DeviceState *=
dev, Error **errp)
     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
     Error *err =3D NULL;
     int i, ret;
+    bool reconnect;
=20
     if (!s->chardev.chr) {
         error_setg(errp, "vhost-user-blk: chardev is mandatory");
@@ -433,27 +437,26 @@ static void vhost_user_blk_device_realize(DeviceState=
 *dev, Error **errp)
     s->inflight =3D g_new0(struct vhost_inflight, 1);
     s->vhost_vqs =3D g_new0(struct vhost_virtqueue, s->num_queues);
     s->connected =3D false;
+    reconnect =3D false;
=20
-    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_even=
t,
-                             NULL, (void *)dev, NULL, true);
-
-reconnect:
-    if (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0) {
-        error_report_err(err);
-        goto virtio_err;
-    }
-
-    /* check whether vhost_user_blk_connect() failed or not */
-    if (!s->connected) {
-        goto reconnect;
-    }
-
-    ret =3D vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
-                               sizeof(struct virtio_blk_config));
-    if (ret < 0) {
-        error_report("vhost-user-blk: get block config failed");
-        goto reconnect;
-    }
+    do {
+        if (qemu_chr_fe_wait_connected(&s->chardev, &err) < 0) {
+            error_report_err(err);
+            goto virtio_err;
+        }
+        qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_=
event,
+                                 NULL, (void *)dev, NULL, true);
+        if (s->connected) {
+            ret =3D vhost_dev_get_config(&s->dev, (uint8_t *)&s->blkcfg,
+                                       sizeof(struct virtio_blk_config));
+            if (ret < 0) {
+                error_report("vhost-user-blk: get block config failed");
+                reconnect =3D true;
+            } else {
+                reconnect =3D false;
+            }
+        }
+    } while (!s->connected || reconnect);
=20
     if (s->blkcfg.num_queues !=3D s->num_queues) {
         s->blkcfg.num_queues =3D s->num_queues;
--=20
2.11.0


--=20
The SmartX email address is only for business purpose. Any sent message=20
that is not related to the business is not authorized or permitted by=20
SmartX.
=B1=BE=D3=CA=CF=E4=CE=AA=B1=B1=BE=A9=D6=BE=C1=E8=BA=A3=C4=C9=BF=C6=BC=BC=D3=
=D0=CF=DE=B9=AB=CB=BE=A3=A8SmartX=A3=A9=B9=A4=D7=F7=D3=CA=CF=E4. =C8=E7=B1=
=BE=D3=CA=CF=E4=B7=A2=B3=F6=B5=C4=D3=CA=BC=FE=D3=EB=B9=A4=D7=F7=CE=DE=B9=D8=
,=B8=C3=D3=CA=BC=FE=CE=B4=B5=C3=B5=BD=B1=BE=B9=AB=CB=BE=C8=CE=BA=CE=B5=C4=
=C3=F7=CA=BE=BB=F2=C4=AC=CA=BE=B5=C4=CA=DA=C8=A8.



