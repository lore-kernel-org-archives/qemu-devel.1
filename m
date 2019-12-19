Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B35FC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71FD2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPvoIaMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71FD2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihvuG-00065p-Ia
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvpx-0000y4-D2
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvpw-00033Q-5t
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46574
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvpv-0002zo-UC
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762047;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9epneyHKkAEq5gGDVE/gbeFue8BzwP7OkBM6QzY9Yk=;
 b=bPvoIaMU5QATgf+yXgsF1nIXWpi9E4STfdLNJ+Oz6E7DU+I0T1R/t+FBVWQvJVZYTnaQ8x
 1/yCti0v5AAW4K6oQ+19pXIXwfFXY2Le1pXC+JtY/6x3BJFA5Wo9sPL1qeg11Lre6vrqzT
 LfbS8tkShq7hUNtgLEX+DrId1O/W1kY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-Evpot7u6NaCjp8aT6n3wnw-1; Thu, 19 Dec 2019 08:27:23 -0500
Received: by mail-qv1-f71.google.com with SMTP id l1so3607705qvu.13
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iiaP0RxMw50Y4u2HruPOoUKc+xP0ZRMmYrMUAAr8Wgg=;
 b=hg0tGMT3xb6lHAjYqRLGFr3Gr4AiipMqYjRLGyiAmYBoU1n50aW4VzjszjPU1JHqFt
 OK4lp79aH31UUMBpF4JTq0q9zb4GWjQCNWAZ+NomsmldadZKOFpR5UobqxN6srKz6kfE
 g8IvzEGT2jYgHGm9SB+HFNMfaVWB2hKXqoLrCzcO/1miDRlt0lk1Axs1g03km5q0FfXn
 3OR/PCRq5nePrNkBfxIthG4gjg26EDP313Gy1smwwbkVza9dc6ZnoCoFuuV5Mdm/z3rn
 wy59eWgzNYQR1z9xl2TYum15m1DoXZMHGyjlBWlwqkubJJs3S23d+pgE37uYfkjQHSAB
 WS6A==
X-Gm-Message-State: APjAAAUhT3m7S6uGkr7mua7jcHR71XnHMUsaeSzqL384HAxXhGggYP2Q
 9TX5Jbb0vbdCD7KO6luDapl+IoLEnbr0SOaxN6n++EGv8c37qiKehnFsTivlaeFwOt/cvooeNk9
 yRgpN54UWtL607Ng=
X-Received: by 2002:ac8:43ce:: with SMTP id w14mr6840876qtn.256.1576762042565; 
 Thu, 19 Dec 2019 05:27:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqwfZ/tO72wFxLEI4JPFGcBIyC19eV+6gmBShoKgxCk8r0R2N5885i8e+ggVHP+x7XMqa8Qsrw==
X-Received: by 2002:ac8:43ce:: with SMTP id w14mr6840863qtn.256.1576762042403; 
 Thu, 19 Dec 2019 05:27:22 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id o33sm1897762qta.27.2019.12.19.05.27.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:27:21 -0800 (PST)
Date: Thu, 19 Dec 2019 08:27:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/24] virtio-input: convert to new virtio_delete_queue
Message-ID: <20191219132621.16595-6-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: Evpot7u6NaCjp8aT6n3wnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Seems cleaner than using VQ index values.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/input/virtio-input.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index ec54e46ad6..9c013afddb 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -280,6 +280,7 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
 {
     VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
     VirtIODevice *vdev =3D VIRTIO_DEVICE(dev);
+    VirtIOInput *vinput =3D VIRTIO_INPUT(dev);
     Error *local_err =3D NULL;
=20
     if (vic->unrealize) {
@@ -289,8 +290,8 @@ static void virtio_input_device_unrealize(DeviceState *=
dev, Error **errp)
             return;
         }
     }
-    virtio_del_queue(vdev, 0);
-    virtio_del_queue(vdev, 1);
+    virtio_delete_queue(vinput->evt);
+    virtio_delete_queue(vinput->sts);
     virtio_cleanup(vdev);
 }
=20
--=20
MST


