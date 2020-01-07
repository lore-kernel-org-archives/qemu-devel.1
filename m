Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F5EC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A122080A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jAkpqcBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A122080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokQT-0000Wo-22
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:41:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQT-0006cB-Ql
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQS-0008UU-AC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51310
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQS-0008Rt-6T
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51WDbq+PBwGZb4DLRjFJvXY/baMy4xbXgzhN6b6J6AM=;
 b=jAkpqcBNhq2bL/yMuvIcgAYjcIkclpEm3oav1tECmFnSpXVocx9D81jFoARJza0Z5184rY
 az0bD+9o7DAe+QrRwRYQL1m9k7AgInO8ER7ahzdzwyOnRcWOy+7UxuwdZS9lKlnHn7zO80
 k2vRJJbTBgNIl7Eh8uUJ+grx2CuFVIg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-ZNWMLvW2PZmpzb7drDApPQ-1; Tue, 07 Jan 2020 02:37:11 -0500
Received: by mail-qk1-f197.google.com with SMTP id f124so31120662qkb.22
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o8odu1UwTWT4bWPiNG9EYA27yURxcpg5mIlh0CMeiVA=;
 b=OvD+V1gmDQDU57JJUToP6kTxAocOdW2y2hYeOW3Ekbjz3XNGtXb78bHzNWmi9aXldA
 hdAXKFRiTdbePwd0ZIqwGZn9Tsbek2VT4hB8ZFX0qv4x7vfMcl7za+a7Op0L11ASZ7Gj
 LdtAUWd0N6yb6rkmpeYNV/mhCoNmsx5AfCH0wFCJlSI7s2dCIVtazMo27rNmDqwriIyG
 2575R/Gw6xjUNa2Zk2OpRbIYiEB5hosPmhlrkEsP+qcEIuMy1bh2jq23zdSmQ3mkHMDy
 rJpOvuc4QvGy4lJl7k3cnbiRthiJknKJ5ajww2ZkRXPGvLH8RZG+mloIPbU0qlEd+QkU
 /h2w==
X-Gm-Message-State: APjAAAVeMUZMh+Kj/1o9TSvApsxDRMKdEvMdyKiIZsZNJYJ/J0ykHOTZ
 FH9KF3xa9Pq/VAzi5cHmEvXfZQ6LAL9gt0sIeu1pxma8VhDjF3zqGrxhvH8V8Udf/GasY4eDk4R
 7+IAnB1dtVgM28yg=
X-Received: by 2002:a05:620a:14a2:: with SMTP id
 x2mr87591279qkj.36.1578382630731; 
 Mon, 06 Jan 2020 23:37:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqyiIb/URXkFZljVHs/rTZTTzqzTtW7o5REey1kTCC0F3MOkRAfV4sEIHbB0D1K9fgqM2ZBGLw==
X-Received: by 2002:a05:620a:14a2:: with SMTP id
 x2mr87591275qkj.36.1578382630498; 
 Mon, 06 Jan 2020 23:37:10 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id w20sm24937356qtj.4.2020.01.06.23.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:09 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 23/32] vhost-user: add VHOST_USER_RESET_DEVICE to reset
 devices
Message-ID: <20200107073451.298261-24-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: ZNWMLvW2PZmpzb7drDApPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 David Vrabel <david.vrabel@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

Add a VHOST_USER_RESET_DEVICE message which will reset the vhost user
backend. Disabling all rings, and resetting all internal state, ready
for the backend to be reinitialized.

A backend has to report it supports this features with the
VHOST_USER_PROTOCOL_F_RESET_DEVICE protocol feature bit. If it does
so, the new message is used instead of sending a RESET_OWNER which has
had inconsistent implementations.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1572385083-5254-2-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c      |  8 +++++++-
 docs/interop/vhost-user.rst | 15 +++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 02a9b25199..d27a10fcc6 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -58,6 +58,7 @@ enum VhostUserProtocolFeature {
     VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD =3D 10,
     VHOST_USER_PROTOCOL_F_HOST_NOTIFIER =3D 11,
     VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD =3D 12,
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
     VHOST_USER_PROTOCOL_F_MAX
 };
=20
@@ -98,6 +99,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_GET_INFLIGHT_FD =3D 31,
     VHOST_USER_SET_INFLIGHT_FD =3D 32,
     VHOST_USER_GPU_SET_SOCKET =3D 33,
+    VHOST_USER_RESET_DEVICE =3D 34,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -890,10 +892,14 @@ static int vhost_user_set_owner(struct vhost_dev *dev=
)
 static int vhost_user_reset_device(struct vhost_dev *dev)
 {
     VhostUserMsg msg =3D {
-        .hdr.request =3D VHOST_USER_RESET_OWNER,
         .hdr.flags =3D VHOST_USER_VERSION,
     };
=20
+    msg.hdr.request =3D virtio_has_feature(dev->protocol_features,
+                                         VHOST_USER_PROTOCOL_F_RESET_DEVIC=
E)
+        ? VHOST_USER_RESET_DEVICE
+        : VHOST_USER_RESET_OWNER;
+
     if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
         return -1;
     }
diff --git a/docs/interop/vhost-user.rst b/docs/interop/vhost-user.rst
index 015ac08177..5f8b3a456b 100644
--- a/docs/interop/vhost-user.rst
+++ b/docs/interop/vhost-user.rst
@@ -785,6 +785,7 @@ Protocol features
   #define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD  10
   #define VHOST_USER_PROTOCOL_F_HOST_NOTIFIER  11
   #define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD 12
+  #define VHOST_USER_PROTOCOL_F_RESET_DEVICE   13
=20
 Master message types
 --------------------
@@ -1190,6 +1191,20 @@ Master message types
   ancillary data. The GPU protocol is used to inform the master of
   rendering state and updates. See vhost-user-gpu.rst for details.
=20
+``VHOST_USER_RESET_DEVICE``
+  :id: 34
+  :equivalent ioctl: N/A
+  :master payload: N/A
+  :slave payload: N/A
+
+  Ask the vhost user backend to disable all rings and reset all
+  internal device state to the initial state, ready to be
+  reinitialized. The backend retains ownership of the device
+  throughout the reset operation.
+
+  Only valid if the ``VHOST_USER_PROTOCOL_F_RESET_DEVICE`` protocol
+  feature is set by the backend.
+
 Slave message types
 -------------------
=20
--=20
MST


