Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF2B6C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:46:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 788B12071E
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 08:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AbqDpJHY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788B12071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41395 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZA0h-0007VX-7K
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 03:46:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iZ9z8-00064B-S0
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iZ9z7-0004nT-Uc
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58126
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iZ9z6-0004mQ-0t
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 03:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574671478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D69oNG7b0azwE9NFjTWHIQsylubZZHajetVSBheyyWc=;
 b=AbqDpJHYzLU0geamFXW0vJXLampvnkI/PoE/pYgOlvOYSmbPDlChk+muzRGv6oEb+rLPes
 P9WymTcllhEOO+pX9pc2CrhGqp65lF1S3jV31Ow9B08+gG7DKDS6GQ8+lVt//SebR2S8f0
 0vV3MfKP7KZ5Lpll41944B5sXlmfPUc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-NCLrlL27NnyF4sVbR3-5Lw-1; Mon, 25 Nov 2019 03:44:37 -0500
Received: by mail-qt1-f198.google.com with SMTP id x8so7998946qtq.14
 for <qemu-devel@nongnu.org>; Mon, 25 Nov 2019 00:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=LqCPiJ37mcVI0DJ8LVWFFDKGbwhqfFvRE/VI24d69sc=;
 b=gIxC7hJpmpeAg99f4y7kWI/Uj/ndLKrJrTuVHG4IBKJZGe7SwQQMgpNrUi41oBRJ5X
 0wGTxU38SlyDL7BK3Itpb05zsn9pFgxU8/qtQ0/5Ym27JmIsC2t6x0iyqnMKTWB+C57D
 6Msd5+8PKuj/Qww7MgpiqOLZPweFYjNWaSS+KfAhMmzh87YHMS7qeRYyZqnCcenLeQ/R
 JImhygyUVkn5DjxLi9nOIBinYZ99lkqAZsDmmnsSJr/PkaWNi7/H8HUhon3Hhd+bKvnV
 EWwQlJ0evFv7KbxtBzNzXaN+Vvv/rfic7UnkW2X+YlXKRrLx8meLYw0XJlazwp3SDXcO
 Plhw==
X-Gm-Message-State: APjAAAX/vSWenrn8fjsY98Fu6bMn3Bm8ajzYp1V/D22zy+4xr0ydwLY0
 zo9n6+eFtkagubgChtbB4HXX7EXQYuKVR2tOGOjuMUmMHzXkvEpHgb+qn0s3EGKREcJ3a1v2vwj
 +dZYPDWf1WVq/Lw0=
X-Received: by 2002:ac8:27e2:: with SMTP id x31mr16941068qtx.342.1574671476444; 
 Mon, 25 Nov 2019 00:44:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqy7m1s+m0U63qWc/BKyrL88SxlZHAGjfu6aL398l73BeryZSE7oLx9pdAQvmShVSaMi5T+ONg==
X-Received: by 2002:ac8:27e2:: with SMTP id x31mr16941057qtx.342.1574671476282; 
 Mon, 25 Nov 2019 00:44:36 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id d15sm3001307qke.55.2019.11.25.00.44.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2019 00:44:35 -0800 (PST)
Date: Mon, 25 Nov 2019 03:44:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/3] virtio-input: fix memory leak on unrealize
Message-ID: <20191125084403.324866-2-mst@redhat.com>
References: <20191125084403.324866-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191125084403.324866-1-mst@redhat.com>
X-Mailer: git-send-email 2.22.0.678.g13338e74b8
X-Mutt-Fcc: =sent
X-MC-Unique: NCLrlL27NnyF4sVbR3-5Lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Spotted by ASAN + minor stylistic change.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20191121095649.25453-1-marcandre.lureau@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/input/virtio-input.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index 51617a5885..ec54e46ad6 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -275,6 +275,7 @@ static void virtio_input_finalize(Object *obj)
=20
     g_free(vinput->queue);
 }
+
 static void virtio_input_device_unrealize(DeviceState *dev, Error **errp)
 {
     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
@@ -288,6 +289,8 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
             return;
         }
     }
+    virtio_del_queue(vdev, 0);
+    virtio_del_queue(vdev, 1);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


