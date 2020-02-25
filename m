Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43147C35E08
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:22:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11CEC2064A
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 15:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2jJfMr9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11CEC2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6c2u-00085b-7s
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 10:22:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1j6buz-0001ux-Kn
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1j6buy-0001hV-D9
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29634
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1j6buy-0001fh-83
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 10:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582643678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaVZ83rgHHJzvD04uhNEPYZywTa4yNbe9G1r2BQHUDs=;
 b=O2jJfMr9NpoOQ+dCOsKPvAPu/5wYTU2+THzKlWBr6dxxbYR0l2zdCZW2ET7eoQWnZPO1yk
 8oE9FXVYQE3hf6jwe2GXhp8sklJnV6QSUJoSXIdq1Pn4iMIC+A+lLHmW//9hZ6utIvwZGE
 SNT0Z4PdZTLh9dPL1Qq1DQ8qOnnA+Pw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-RsKhekESMMulHudztwt3GQ-1; Tue, 25 Feb 2020 10:14:36 -0500
X-MC-Unique: RsKhekESMMulHudztwt3GQ-1
Received: by mail-qt1-f200.google.com with SMTP id d9so15201930qtq.13
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 07:14:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BEIFZp6ZV6EMxNZvhYr+RG8aqKLzp8+FfOWRj9nMRTw=;
 b=X5fo05QRanVIPwD9y+FbRjy27dccPkBkFMkkR6ByODXWRarw3i0Bc5yK4Pd6IiW152
 xgZrhS0cNomNrnnBK0nBmlks0zGJ0cHhomz2hDaoARjG0EehMv4BbCyAnCG5dpvRVIy+
 xLuE+9yVGyIQwLm8LxjmcVrr38JvL5zcUS/FAlpREMHUuKS7mwr32hteILCrsCJxcPrA
 b4rud904XXK0HFX7HKYBDqvLDg8gmQE+tpxbRBSzeC8dLUGuaqPZL767r3yyxasDQXBg
 U0rk699TMpuBCuFPJPd3DlYHS8W8Q4lNEcAwwToBlSwh0/DG6eJdsYElp9aL+MA8g2R8
 46JA==
X-Gm-Message-State: APjAAAWxJVqbJXhIuXV40R2x4NmKlyZ6Lq94DksTjF6OwKnvaK3a9cL8
 zBqGBOzSxqDD3FEhrqdc5F2jA2hatXUfp/E2HVeDDB4n4Pw//IhF1LgHCZirWCLlaONKA794+Nw
 mlh3Do5YR0qkYpn0=
X-Received: by 2002:aed:37a4:: with SMTP id j33mr3919252qtb.363.1582643675578; 
 Tue, 25 Feb 2020 07:14:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqzTJ0QI3azMUZ1bYT7H35iT1Lt8umIsgba9SBNyIzNGt9m7DpqRQuBfbixJfZZ9V5ppy4Olcg==
X-Received: by 2002:aed:37a4:: with SMTP id j33mr3919222qtb.363.1582643675326; 
 Tue, 25 Feb 2020 07:14:35 -0800 (PST)
Received: from redhat.com (bzq-79-178-2-214.red.bezeqint.net. [79.178.2.214])
 by smtp.gmail.com with ESMTPSA id
 d1sm7436695qkj.29.2020.02.25.07.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 07:14:34 -0800 (PST)
Date: Tue, 25 Feb 2020 10:14:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 25/32] libvhost-user: handle NOFD flag in call/kick/err better
Message-ID: <20200225151210.647797-26-mst@redhat.com>
References: <20200225151210.647797-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200225151210.647797-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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


