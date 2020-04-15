Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29967C38A29
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E77CE20774
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 03:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20150623.gappssmtp.com header.i=@smartx-com.20150623.gappssmtp.com header.b="kUdN+5+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77CE20774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOYl4-0007S5-47
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 23:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengli@smartx.com>) id 1jOYie-0003qx-Ml
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengli@smartx.com>) id 1jOYid-0003Te-Kj
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:08 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41445)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fengli@smartx.com>) id 1jOYid-0003Sl-G3
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 23:28:07 -0400
Received: by mail-pg1-x542.google.com with SMTP id h69so874301pgc.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 20:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
 :references:content-transfer-encoding;
 bh=TwgnJmPadU3PRD+Wik0Nx8aB1MFbEI3Wplly0TQHwwk=;
 b=kUdN+5+Uw4a2c+bhi313HV5e51yUFB6NmuLD9wajdjuyUgtmuvKwRADQxgZ1j6Rc5N
 JDkEz5aco2ScDAh9NWjqQe+/2u3uIOZH3QrC9eEtyuD2OKMZMx5V6Iy4C7nOg8IFI4EF
 BjNK7zkfnfJuoc1nyjVpiC3Xvn5LEhEtSfRwqxBD3fRxxYQXygFeDfZScq9okIshyMNM
 64ro/0/DlRILQ6WkRAWEHw3GjUbMoSs8wurEpE8dXcGbZu95l3zv3P8oDrdKc7DVAUks
 W50AW+w+rZAyrEK3tr6zdOMpUth3axOavXa/F8vfWlaveNnckSf9z3UTxfepbVXRFYhe
 Xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :in-reply-to:references:content-transfer-encoding;
 bh=TwgnJmPadU3PRD+Wik0Nx8aB1MFbEI3Wplly0TQHwwk=;
 b=G9PEaSI3urnu7Jxoka2eUR4arL062aJxPdg5h1Obg8DoW2tWlW2xW1XDVU86TycWhD
 VaExuSXTZ6ItOV3kli8PqbbPqmmYWG3PUgLz/VRGW1H0bYO3c/sNxEg5H6bdINs6QzlL
 GNP/k7aIyNg+cYALI/yDDAMWnNj7ezf2Q80js+lL0TPMeIZZFdm3G0BCPGHd7VaQemgD
 ociVKZ/maOdCBHlpYwfX3Ojs8mdJTyhFCBwr4TWDxfJBiGOoZVZxAKKjvZRqBCHqtTd+
 o9WiNbe36mZB3KP6AlcAgGGncBrbIA3yyilZa0ZmyDICVJwIp+UC27rtFR+WwjOIu/Ng
 sOMg==
MIME-Version: 1.0
X-Gm-Message-State: AGi0PuZf3V3b6rpdg3TnTy+ElHnmY3cfBThOvs5phUKMs9BW9AdmxZzt
 O4yOxzSMzN9Gc2khXDcjQ4kpGXg/RMZ7wqBTX/UgseuSnT/usPncrGdXQSH58a3raz1KmiAfoXu
 GpgYIOHlm
X-Google-Smtp-Source: APiQypJV/JQFC25bGpCrV2bQ7xJrTDyM/NxV0I+OcWIy8Vcn9GO4JkuiF3SrPfKkYjnkuTp200CbcQ==
X-Received: by 2002:a63:2e44:: with SMTP id u65mr6130125pgu.142.1586921285512; 
 Tue, 14 Apr 2020 20:28:05 -0700 (PDT)
Received: from 31_216.localdomain ([47.240.167.159])
 by smtp.gmail.com with ESMTPSA id d21sm5915061pjs.3.2020.04.14.20.28.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Apr 2020 20:28:04 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: kyle@smartx.com, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Block layer core),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 1/4] vhost-user-blk: delay vhost_user_blk_disconnect
Date: Wed, 15 Apr 2020 11:28:23 +0800
Message-Id: <20200415032826.16701-2-fengli@smartx.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200415032826.16701-1-fengli@smartx.com>
References: <20200415032826.16701-1-fengli@smartx.com>
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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

Since commit b0a335e351103bf92f3f9d0bd5759311be8156ac, a socket write
may trigger a disconnect events, calling vhost_user_blk_disconnect() and
clearing all the vhost_dev strutures. Then the next socket read will
encounter an invalid pointer to vhost_dev.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 hw/block/vhost-user-blk.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
index 17df5338e7..776b9af3eb 100644
--- a/hw/block/vhost-user-blk.c
+++ b/hw/block/vhost-user-blk.c
@@ -349,11 +349,24 @@ static void vhost_user_blk_disconnect(DeviceState *de=
v)
     vhost_dev_cleanup(&s->dev);
 }
=20
+static void vhost_user_blk_event(void *opaque, QEMUChrEvent event);
+
+static void vhost_user_blk_chr_closed_bh(void *opaque)
+{
+    DeviceState *dev =3D opaque;
+    VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
+    vhost_user_blk_disconnect(dev);
+    qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, vhost_user_blk_even=
t,
+                             NULL, (void *)dev, NULL, true);
+}
+
 static void vhost_user_blk_event(void *opaque, QEMUChrEvent event)
 {
     DeviceState *dev =3D opaque;
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
     VHostUserBlk *s =3D VHOST_USER_BLK(vdev);
+    AioContext *ctx;
=20
     switch (event) {
     case CHR_EVENT_OPENED:
@@ -363,7 +376,16 @@ static void vhost_user_blk_event(void *opaque, QEMUChr=
Event event)
         }
         break;
     case CHR_EVENT_CLOSED:
-        vhost_user_blk_disconnect(dev);
+        /*
+         * a close event may happen during a read/write, but vhost
+         * code assumes the vhost_dev remains setup, so delay the
+         * stop & clear to idle.
+         */
+        ctx =3D qemu_get_current_aio_context();
+
+        qemu_chr_fe_set_handlers(&s->chardev,  NULL, NULL, NULL,
+                                 NULL, NULL, NULL, false);
+        aio_bh_schedule_oneshot(ctx, vhost_user_blk_chr_closed_bh, opaque)=
;
         break;
     case CHR_EVENT_BREAK:
     case CHR_EVENT_MUX_IN:
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



