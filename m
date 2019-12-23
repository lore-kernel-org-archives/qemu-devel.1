Return-Path: <SRS0=AgAn=2N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A789C2D0C0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CFE20709
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2019 17:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iw2gaXyM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CFE20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ijR5P-0002dI-Qb
	for qemu-devel@archiver.kernel.org; Mon, 23 Dec 2019 12:01:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ijQn9-00058e-MW
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ijQn8-0005j5-C8
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36834
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ijQn8-0005is-7q
 for qemu-devel@nongnu.org; Mon, 23 Dec 2019 11:42:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577119365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51WDbq+PBwGZb4DLRjFJvXY/baMy4xbXgzhN6b6J6AM=;
 b=iw2gaXyMG9uHoFlEFY6yRrj3T8X1HcNJDY8YQzW/QJTMjp/KZFm4TsQ3zOD55aEMt/vt3E
 EPfY4WDHbtZkbLVejzg9mvp7r9KEsTkSytSC9KX/+yLoDummWLsa5g6F21bvi7Zmn0X9GX
 jsJaphWf2Pa40AKTlrTHCyWdnTSpKuw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-fKOzOR5fP6qnUbRysGFrrQ-1; Mon, 23 Dec 2019 11:42:44 -0500
Received: by mail-qt1-f197.google.com with SMTP id e1so8290770qto.5
 for <qemu-devel@nongnu.org>; Mon, 23 Dec 2019 08:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=o8odu1UwTWT4bWPiNG9EYA27yURxcpg5mIlh0CMeiVA=;
 b=o39V5a4uE7vZhZSuQrdI0/7TXrKK3VOChVzrxVp8WorIJsXQSmNEnjkBqIyCYgsDZ/
 f9mHPgeKSv+167F7HAo8O678S1VOU69YIGkKPbZywfwqqpSAQZFvGjF++z82NxWKAUgi
 klk7Uk70Flf2MpFpRjf6OCKpBbXRcBOSrMXkrUGcmfqWCalTf7PrFae7XjbXwI5o7fgx
 PaM/SSCiWB4GVj5SdAmtbjWd5XATmquhpT62Cy0pi2tZgHSozaJn+otS8Pj9Q+pLJudg
 YoKoxFPt+Nlys8EqPHs87Qpgly6q9Sd+YHpwOOJSdP0ogDjl4lxccxtFx+zqmKduaY7y
 wqhg==
X-Gm-Message-State: APjAAAXZAbFhcDiWwXE08eWSxLFWIGqKbFoq43rq4jqrkUClD0pSKFWN
 eRVrXYXA8r81MbY9yTsvs+aWyNTrb+JaZi3vuZp4TOwMKsrWD8Z/ISSa0ymir2ViZMxDm5P6At7
 ydfipJLIiAyikCTE=
X-Received: by 2002:a37:b946:: with SMTP id j67mr25865243qkf.35.1577119363618; 
 Mon, 23 Dec 2019 08:42:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdocjm8XB29JnkVa9zMO1WV+qjDM2zdGBCtngrtywtL+CR/24BiLXzwkbf4YV7N0WZZCol5Q==
X-Received: by 2002:a37:b946:: with SMTP id j67mr25865225qkf.35.1577119363404; 
 Mon, 23 Dec 2019 08:42:43 -0800 (PST)
Received: from redhat.com (bzq-109-64-31-13.red.bezeqint.net. [109.64.31.13])
 by smtp.gmail.com with ESMTPSA id
 k73sm5941000qke.36.2019.12.23.08.42.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2019 08:42:42 -0800 (PST)
Date: Mon, 23 Dec 2019 11:42:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 23/27] vhost-user: add VHOST_USER_RESET_DEVICE to reset
 devices
Message-ID: <20191223141536.72682-24-mst@redhat.com>
References: <20191223141536.72682-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191223141536.72682-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: fKOzOR5fP6qnUbRysGFrrQ-1
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


