Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93959C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E6320684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5xDHfB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E6320684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41661 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw1e-0000IO-Cg
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:39:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvrY-0003ZD-Hi
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvrT-0002GD-8Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47495
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvrT-0002E8-3M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51WDbq+PBwGZb4DLRjFJvXY/baMy4xbXgzhN6b6J6AM=;
 b=N5xDHfB7D+JqMHPbGTNaHLGYlmzTsg3gqzQcDzWgLcXiwohW/tjFL9wnIWJ9LZSTOUv8mO
 73KC/hEO9vUlsoh/LF3Pa9l/Hh81hBl0G341H6Ui71g9jx2g+XfeSFiyG7f0yZKB5LVLVc
 lj9p9k9v88GVPmqs8H7j/eRC4eXkimM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-89-1OYjnvGtMUmTZlmTY2eMWA-1; Thu, 19 Dec 2019 08:29:01 -0500
Received: by mail-qv1-f70.google.com with SMTP id v3so623742qvm.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:29:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o8odu1UwTWT4bWPiNG9EYA27yURxcpg5mIlh0CMeiVA=;
 b=SXBaLYxVmU8K9Vj8j2+8PSNx//3Tnn+lDtTsNHjH9ulFlS2+RKVkKdJX5R89rWP29x
 zBM+EbxwazDiSVj9ThXyxjn1SVX1T86A6qvqXNklEili9sYr0elhfq3eXsD490FO+5NT
 /vQoLcQLOhg/Cw1U7/YUpSsTN3WM8BZVoEnlOMMzWPXUJECwf9J+rBTTHxe0roqY0meJ
 uEeBPefYpWmrQlOeDlM6C7OGr3rXQUwjqomGoQo6zQhfFW/bfNUcLJ+ce9ef8+Q5qiM+
 hzmCSAjoRYUXDqfcATb70dCWarwNNx0hYXWzHs774hgpp3lXk66jsRJPT/4cN4cUZaCm
 il2Q==
X-Gm-Message-State: APjAAAXgcmLkueT5ZiayJB2ugSzMoUTfoz+jrrRrImrzcxnwtDGnKfBD
 vG2hfqzX++q86rT0ni7kiAh9N9oZS6BIRW0pmeRufdyKwu+zwjVjlG4L/+quWbCwd9rRia7VP3A
 ZCRFWuIDZ7nKmH+U=
X-Received: by 2002:a37:98c6:: with SMTP id a189mr8136605qke.500.1576762140420; 
 Thu, 19 Dec 2019 05:29:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqz9fPT3y+a9XwjOCQhYfL9erAj7ft8zFn5rKGEOB4gKChIFoyuY4Y/fIXkKRJgkdWeX4Guc8w==
X-Received: by 2002:a37:98c6:: with SMTP id a189mr8136579qke.500.1576762140173; 
 Thu, 19 Dec 2019 05:29:00 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id d8sm1802324qtr.53.2019.12.19.05.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:28:59 -0800 (PST)
Date: Thu, 19 Dec 2019 08:28:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/24] vhost-user: add VHOST_USER_RESET_DEVICE to reset devices
Message-ID: <20191219132621.16595-24-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 1OYjnvGtMUmTZlmTY2eMWA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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


