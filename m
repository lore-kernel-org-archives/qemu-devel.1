Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A6FC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9720E2073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 09:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R0zTNpiF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9720E2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokpr-0003iJ-Po
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 04:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojQW-0006hC-3d
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojQU-00005R-Kc
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:19 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33410
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojQU-0008WK-GH
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EhLJ8ESaItKzPeue3PIZ6PBy1w7sicN5shNVXQfGIo=;
 b=R0zTNpiFzFzCekl+tFMgbbeCJ5piH+3iUFGwSA0B0DYy4DU3K6BhtkvV7ZAjYEyEaVbEEk
 /SMiXBqcOZR0zYFcx1pvw7AaQW4tFrnoe/cDhYqKmLJGPGdX0nk1726417j9VujGOcIWyU
 dlhG8EjA8TZPoFs/MAlDcodJe6ia41c=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-290-JTX6WB2VN0mMeu8uGfm9Hg-1; Tue, 07 Jan 2020 02:37:16 -0500
Received: by mail-qt1-f200.google.com with SMTP id d18so19070208qtp.16
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wp7IEacTPDnbh2fT1ey9LJUjRbVmj0GN0bCAT90OXe4=;
 b=JbXt0AT1D13pB1CPI7xq8u2x9QFMzXsOMwVQOpBRDrowbNI0XNGJnlbe2YL4jqseUk
 PBKVY9oehjakV1jaQWpDafPx9ieZQnoiVNKEUSYcieCiGaT+ZgEgeV+YmpeGrYOx/WCY
 8tLcC/ZUOloA1Q8urkKuKkE/VWpMKnRbN3P4E17mmWf3TsMJPFciad3+pISXo5SZI2XN
 aVDBr5qDFH3kSg0hjDw89NLs5Es0fneVFukNT5FVDv0rQvUbWYvHTFooGRtC+H5rOobS
 HPv2lBPDBio/Mmx/7T+DtT/SyO/lTgZXcBfnYoyRVn09+tklSMssnbUA/G4VNV5SDJYl
 XoTA==
X-Gm-Message-State: APjAAAWhBbgYEuooif0tMB/hyh8gycmB6ZOot+vp7pkM6F7NUCag/s+A
 qmo7dmV7crmYwuohs7kWAmKL19jLGJmHtsgCVMAiXKsO4SB5n/k5D/qvzxL1s1ACTtv49fggxs5
 lhPzxiolMO90DLLI=
X-Received: by 2002:ac8:454c:: with SMTP id z12mr78356990qtn.123.1578382636023; 
 Mon, 06 Jan 2020 23:37:16 -0800 (PST)
X-Google-Smtp-Source: APXvYqx3Vwgep2tNLi6KTR/rSWiF9ixPIZ1K02S9NiBerJDf87G5XHEOqFQ4DZoRzCZfzZ3974koeA==
X-Received: by 2002:ac8:454c:: with SMTP id z12mr78356982qtn.123.1578382635847; 
 Mon, 06 Jan 2020 23:37:15 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id p19sm25008954qte.81.2020.01.06.23.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:37:15 -0800 (PST)
Date: Tue, 7 Jan 2020 02:37:11 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 24/32] vhost-user-scsi: reset the device if supported
Message-ID: <20200107073451.298261-25-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: JTX6WB2VN0mMeu8uGfm9Hg-1
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


