Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C31C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:42:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E7C20684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 13:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yhj0kd6W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E7C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihw4n-0004Le-CK
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 08:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1ihvrZ-0003bP-T1
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1ihvrY-0002iF-2M
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:09 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47983
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1ihvrX-0002fJ-SO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 08:29:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576762147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EhLJ8ESaItKzPeue3PIZ6PBy1w7sicN5shNVXQfGIo=;
 b=Yhj0kd6WPbP/r7kv1gboGQcIx7FiBmsa6wL8UpeN9P0FH3jNhXDprmbKB5iqInfpPbEXo4
 w/VHyXy/iBHHsEeDBVhzWpt40570XdCzF+LJeUdUHFZKZlfRJyoPGLnJLHMpMDP0Pjsohf
 L9ycjqaO8BaGp1k0F+G0SzLzDKnJH5Y=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-gTKy-oztPteuJYrrVEe3jw-1; Thu, 19 Dec 2019 08:29:06 -0500
Received: by mail-qt1-f200.google.com with SMTP id e8so3667291qtg.9
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2019 05:29:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wp7IEacTPDnbh2fT1ey9LJUjRbVmj0GN0bCAT90OXe4=;
 b=f8DZhq9Bi9Ujsd+FTbvLrO85Lk96iS9VcpuK/UqK7JrCKZtsfFW8E6kZS2GSWywMU3
 yUYsgAL/o8FGEcW2PzZJC9eHJxG1T47CKk2dUYVdF78CfKpwwtVPb9Ak+tmcuJlKB6A/
 gS0pf//GqH7iv2MsaF20o3fXRkXdBdJHYT2mu5C9k7pGq/Z4aVKHQByWj8P8etvhJukQ
 MqcmYQHag3MIpnNS3O57VI0SKmQP7c87sTCGMxh18BIRmP3KNC+U/MoWuDTQuOY5CRqG
 FX9M0i5WnIZCNAtWwozXIZES8wcQrMp7eXNrdCswzwtRmYbff3BAPCTpHZ8TloHCjcdu
 Jv/A==
X-Gm-Message-State: APjAAAWVmulEqBxiFh57OiRvh6xzVn3d0ryb9r2p5HKWrdboKSln0dr2
 GyfV/umGn3Y4CaBuC+tPF39l0ghovEYvw+BOR7KS4ck7rsKPN4hxlMUp4i+U0XpfTvfQUy984li
 IFXketM5BymrxYIo=
X-Received: by 2002:ac8:768d:: with SMTP id g13mr6948166qtr.7.1576762145447;
 Thu, 19 Dec 2019 05:29:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqzdL66iSvydYXqYxiJeIDCxy3TRsQOjcbzZ/o/Mu03gw2y8M2HbJDzdMk+ZcMkjzOh3QrCtIw==
X-Received: by 2002:ac8:768d:: with SMTP id g13mr6948145qtr.7.1576762145270;
 Thu, 19 Dec 2019 05:29:05 -0800 (PST)
Received: from redhat.com (bzq-79-181-48-215.red.bezeqint.net. [79.181.48.215])
 by smtp.gmail.com with ESMTPSA id 124sm1755170qkn.58.2019.12.19.05.29.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 05:29:04 -0800 (PST)
Date: Thu, 19 Dec 2019 08:29:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/24] vhost-user-scsi: reset the device if supported
Message-ID: <20191219132621.16595-25-mst@redhat.com>
References: <20191219132621.16595-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: gTKy-oztPteuJYrrVEe3jw-1
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Vrabel <david.vrabel@nutanix.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

If the vhost-user-scsi backend supports the VHOST_USER_F_RESET_DEVICE
protocol feature, then the device can be reset when requested.

If this feature is not supported, do not try a reset as this will send
a VHOST_USER_RESET_OWNER that the backend is not expecting,
potentially putting into an inoperable state.

Signed-off-by: David Vrabel <david.vrabel@nutanix.com>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1572385083-5254-3-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/scsi/vhost-user-scsi.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index 6a6c15dd32..23f972df59 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -39,6 +39,10 @@ static const int user_feature_bits[] =3D {
     VHOST_INVALID_FEATURE_BIT
 };
=20
+enum VhostUserProtocolFeature {
+    VHOST_USER_PROTOCOL_F_RESET_DEVICE =3D 13,
+};
+
 static void vhost_user_scsi_set_status(VirtIODevice *vdev, uint8_t status)
 {
     VHostUserSCSI *s =3D (VHostUserSCSI *)vdev;
@@ -62,6 +66,25 @@ static void vhost_user_scsi_set_status(VirtIODevice *vde=
v, uint8_t status)
     }
 }
=20
+static void vhost_user_scsi_reset(VirtIODevice *vdev)
+{
+    VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(vdev);
+    struct vhost_dev *dev =3D &vsc->dev;
+
+    /*
+     * Historically, reset was not implemented so only reset devices
+     * that are expecting it.
+     */
+    if (!virtio_has_feature(dev->protocol_features,
+                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
+        return;
+    }
+
+    if (dev->vhost_ops->vhost_reset_device) {
+        dev->vhost_ops->vhost_reset_device(dev);
+    }
+}
+
 static void vhost_dummy_handle_output(VirtIODevice *vdev, VirtQueue *vq)
 {
 }
@@ -182,6 +205,7 @@ static void vhost_user_scsi_class_init(ObjectClass *kla=
ss, void *data)
     vdc->get_features =3D vhost_scsi_common_get_features;
     vdc->set_config =3D vhost_scsi_common_set_config;
     vdc->set_status =3D vhost_user_scsi_set_status;
+    vdc->reset =3D vhost_user_scsi_reset;
     fwc->get_dev_path =3D vhost_scsi_common_get_fw_dev_path;
 }
=20
--=20
MST


