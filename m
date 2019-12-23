Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF12C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C0072073A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 16:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZL/MoRYD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C0072073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijQnS-00055j-Qr
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 11:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41346)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQle-000395-8D
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQlb-0005Ic-Nb
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32676
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQlb-0005Hh-D3
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:41:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ky3AoPDK1Dl90THjFQNp/2P2m3Le5A8fcjpKsYSUby0=;
 b=ZL/MoRYDiQFby784YPsdXQDcbYNytzzqe+yr8kojYDaO10BRcIMFRSBEEs53iYAGnBkBLp
 1fKF+gg5n6T4X2nzz9c+0lYrzSD55oP/u4DeyfQuc7R+pozeYwfGc+GOvnJoetFaaLqvE6
 4EkPNv0Siq1s0PuxaIXsVJK6MPF8wCk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-vwXPXrK6PRO9ISOwmQr6XQ-1; Mon, 23 Dec 2019 11:41:08 -0500
Received: by mail-qv1-f69.google.com with SMTP id v3so5879211qvm.2
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:41:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=S797ekb1koe77yVikHhjJoQQO+mcOVBkg02x1T+LNQw=;
 b=CFCw1xW9whLtG5z/SkgZ+pZnvcpfyIcLUBY3N1E3ZaBlWIX7UaBymCg7Ic8kAdMAa/
 Xxgy1rrZtT5Ti8+H0ZH4225D9zCQH923IRWqZ8SCZrgCuL3ZG+NuTUio9xQAJ5WT5GA+
 HgLbWIOCR1HCbarghp4f32jOa+EVK0P4hJXAyPkE+a7s4QRtcCnfLtJw9ip5y9TCWyNj
 pz6uQUWS5TOklUr5haPULgYT8BmmTXuPc3ObLOU9SWOua/g7XwuUDvz5RF13RXmzERFP
 H4eZI1uqMvb/jqBpnwrrtgmZ7oqCzM0dkRyXRCZHyP2DfcIwFdYRbkzD8GWvCcuKAGgc
 0nzQ==
X-Gm-Message-State: APjAAAWA25ue7drnTkDljk5CRdcjyKgQCUWts5R1pPeWGsoYTJVg5auR
 En1nS+UXajvozOXZWHG4N/17o0sBhqZ1m2utC/S8gNTG6dY7HanfveAz8ziNDVrqaIYSj+elrgH
 W+eibIicnTQIf5rk=
X-Received: by 2002:a05:620a:a0b:: with SMTP id
 i11mr27561349qka.11.1577119267303; 
 Mon, 23 Dec 2019 08:41:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqyn91PDVq0XnHgEm5/tkU0BZy/KXD4oOE6Yk18iwCMwgLjWtFeWJtALfHo3uQB/WHJGe7uiww==
X-Received: by 2002:a05:620a:a0b:: with SMTP id
 i11mr27561329qka.11.1577119267090; 
 Mon, 23 Dec 2019 08:41:07 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 u15sm5890157qku.67.2019.12.23.08.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:41:06 -0800 (PST)
Date: Mon, 23 Dec 2019 11:41:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 01/27] virtio: add ability to delete vq through a pointer
Message-ID: <20191223141536.72682-2-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: vwXPXrK6PRO9ISOwmQr6XQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Devices tend to maintain vq pointers, allow deleting them trough a vq point=
er.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/hw/virtio/virtio.h |  2 ++
 hw/virtio/virtio.c         | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index c32a815303..e18756d50d 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -183,6 +183,8 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int que=
ue_size,
=20
 void virtio_del_queue(VirtIODevice *vdev, int n);
=20
+void virtio_delete_queue(VirtQueue *vq);
+
 void virtqueue_push(VirtQueue *vq, const VirtQueueElement *elem,
                     unsigned int len);
 void virtqueue_flush(VirtQueue *vq, unsigned int count);
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 04716b5f6c..31dd140990 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2330,17 +2330,22 @@ VirtQueue *virtio_add_queue(VirtIODevice *vdev, int=
 queue_size,
     return &vdev->vq[i];
 }
=20
+void virtio_delete_queue(VirtQueue *vq)
+{
+    vq->vring.num =3D 0;
+    vq->vring.num_default =3D 0;
+    vq->handle_output =3D NULL;
+    vq->handle_aio_output =3D NULL;
+    g_free(vq->used_elems);
+}
+
 void virtio_del_queue(VirtIODevice *vdev, int n)
 {
     if (n < 0 || n >=3D VIRTIO_QUEUE_MAX) {
         abort();
     }
=20
-    vdev->vq[n].vring.num =3D 0;
-    vdev->vq[n].vring.num_default =3D 0;
-    vdev->vq[n].handle_output =3D NULL;
-    vdev->vq[n].handle_aio_output =3D NULL;
-    g_free(vdev->vq[n].used_elems);
+    virtio_delete_queue(&vdev->vq[n]);
 }
=20
 static void virtio_set_isr(VirtIODevice *vdev, int value)
--=20
MST


