Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC33C4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476092084E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 09:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YuVT3SUl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476092084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6sj6-00055k-EH
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 04:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59406)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6sfT-0006bN-Nn
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6sfS-00011A-9K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30404
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6sfS-00010b-2C
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 04:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582708065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaVZ83rgHHJzvD04uhNEPYZywTa4yNbe9G1r2BQHUDs=;
 b=YuVT3SUlUmhZOL8MYQykCeru4fzRscdu1XWIPtkT7RAwg5W4Tp3mDG/7npcqZ2yQrOh7wS
 Yd1EGEMH5oGn8V1q3JNpHr6MW2CNjjx5rTPZMrzQV4tpXyRdZVa7lzJMUAzNoOwalCtAY4
 kf2/n54SRyjuq5BeQn5ss2Cl/NSUccE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-r6AZ2QiCPKWqw__n5n0g8w-1; Wed, 26 Feb 2020 04:07:41 -0500
X-MC-Unique: r6AZ2QiCPKWqw__n5n0g8w-1
Received: by mail-wr1-f70.google.com with SMTP id p5so1167702wrj.17
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 01:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BEIFZp6ZV6EMxNZvhYr+RG8aqKLzp8+FfOWRj9nMRTw=;
 b=FTpgsMPqFKvDV+9pDqDDt5uUXEMa9fqfl7A/VjeX81xVAxYBZ8kDvNYiexgO9Gg2cl
 yAnbn5v5dEjOaO5a2rFjuabnY9qmKvAIaV2aNFZW1Y1ypSW8RcJ90xlGnTvgbMsJlahO
 wkuoE85DfrJR7kkpRySEtkEcl0Q3JJd3IwF7HdTfYQanbGLEaRfoyVy/0rhi7KIw/75M
 HpNMtlPl/KPbbqgK5/uxDrIcJxO0gyf32VfBvZolo9MnE3DbdT1wSAg8TAOsM8Iex57g
 pB0L+Pky/68dsDvbL9SQb7Q8ppJlSCIFcP4oICqzCB0Aj23yEZtvlpXntMWxjw+Q2jZo
 80GA==
X-Gm-Message-State: APjAAAWmfYR7VldMZvzDmHwd+0aBMycYCB6bnC0jLlVXW9E4nSOSA76C
 sphKaibCWaFU9VCT5PZO996X0LhGAMiwBWREkw//UQZae4xppVW7WWsBi9h1DjnfgmifbOAzwMW
 egkJ95h75bQEpDcg=
X-Received: by 2002:adf:e644:: with SMTP id b4mr4206266wrn.110.1582708060139; 
 Wed, 26 Feb 2020 01:07:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqww5iB5V2WczINd8OkK7tVEKvKlKcNuqwVytB3smY32PXkVbyDVpmoUhxrLeC79wCj4BazXLg==
X-Received: by 2002:adf:e644:: with SMTP id b4mr4206241wrn.110.1582708059907; 
 Wed, 26 Feb 2020 01:07:39 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 p17sm11274wre.89.2020.02.26.01.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2020 01:07:39 -0800 (PST)
Date: Wed, 26 Feb 2020 04:07:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 25/30] libvhost-user: handle NOFD flag in call/kick/err
 better
Message-ID: <20200226090010.708934-26-mst@redhat.com>
References: <20200226090010.708934-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200226090010.708934-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
 Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Johannes Berg <johannes.berg@intel.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Johannes Berg <johannes.berg@intel.com>

The code here is odd, for example will it print out invalid
file descriptor numbers that were never sent in the message.

Clean that up a bit so it's actually possible to implement
a device that uses polling.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Message-Id: <20200123081708.7817-5-johannes@sipsolutions.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/=
libvhost-user.c
index 533d55d82a..3abc9689e5 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -948,6 +948,7 @@ static bool
 vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd =3D vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
=20
     if (index >=3D dev->max_queues) {
         vmsg_close_fds(vmsg);
@@ -955,8 +956,12 @@ vu_check_queue_msg_file(VuDev *dev, VhostUserMsg *vmsg=
)
         return false;
     }
=20
-    if (vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK ||
-        vmsg->fd_num !=3D 1) {
+    if (nofd) {
+        vmsg_close_fds(vmsg);
+        return true;
+    }
+
+    if (vmsg->fd_num !=3D 1) {
         vmsg_close_fds(vmsg);
         vu_panic(dev, "Invalid fds in request: %d", vmsg->request);
         return false;
@@ -1053,6 +1058,7 @@ static bool
 vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd =3D vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
=20
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
=20
@@ -1066,8 +1072,8 @@ vu_set_vring_kick_exec(VuDev *dev, VhostUserMsg *vmsg=
)
         dev->vq[index].kick_fd =3D -1;
     }
=20
-    dev->vq[index].kick_fd =3D vmsg->fds[0];
-    DPRINT("Got kick_fd: %d for vq: %d\n", vmsg->fds[0], index);
+    dev->vq[index].kick_fd =3D nofd ? -1 : vmsg->fds[0];
+    DPRINT("Got kick_fd: %d for vq: %d\n", dev->vq[index].kick_fd, index);
=20
     dev->vq[index].started =3D true;
     if (dev->iface->queue_set_started) {
@@ -1147,6 +1153,7 @@ static bool
 vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd =3D vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
=20
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
=20
@@ -1159,14 +1166,14 @@ vu_set_vring_call_exec(VuDev *dev, VhostUserMsg *vm=
sg)
         dev->vq[index].call_fd =3D -1;
     }
=20
-    dev->vq[index].call_fd =3D vmsg->fds[0];
+    dev->vq[index].call_fd =3D nofd ? -1 : vmsg->fds[0];
=20
     /* in case of I/O hang after reconnecting */
-    if (eventfd_write(vmsg->fds[0], 1)) {
+    if (dev->vq[index].call_fd !=3D -1 && eventfd_write(vmsg->fds[0], 1)) =
{
         return -1;
     }
=20
-    DPRINT("Got call_fd: %d for vq: %d\n", vmsg->fds[0], index);
+    DPRINT("Got call_fd: %d for vq: %d\n", dev->vq[index].call_fd, index);
=20
     return false;
 }
@@ -1175,6 +1182,7 @@ static bool
 vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int index =3D vmsg->payload.u64 & VHOST_USER_VRING_IDX_MASK;
+    bool nofd =3D vmsg->payload.u64 & VHOST_USER_VRING_NOFD_MASK;
=20
     DPRINT("u64: 0x%016"PRIx64"\n", vmsg->payload.u64);
=20
@@ -1187,7 +1195,7 @@ vu_set_vring_err_exec(VuDev *dev, VhostUserMsg *vmsg)
         dev->vq[index].err_fd =3D -1;
     }
=20
-    dev->vq[index].err_fd =3D vmsg->fds[0];
+    dev->vq[index].err_fd =3D nofd ? -1 : vmsg->fds[0];
=20
     return false;
 }
--=20
MST


