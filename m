Return-Path: <SRS0=Lm/k=22=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC0DC33C8C
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:15:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 640DA207FD
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jan 2020 13:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzFADBfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 640DA207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1io5kg-00062X-GL
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 08:15:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1io5VE-00039Q-4s
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1io5VC-00050q-Nr
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:32 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20941
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1io5VC-00050Z-BT
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 07:59:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578229169;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5EhLJ8ESaItKzPeue3PIZ6PBy1w7sicN5shNVXQfGIo=;
 b=XzFADBfPi//VV0Ai7NsP6gFNyHIhfSwWxD7ack2wx1beSxMR9kr+cG+/shF6eskbkMvJFo
 +KT0u5V/oWqruFIAbKdcl6jzt6o0FnPgCaGekBv7U/z6duPtKwdeAODoNo1J7sAfP6fOCA
 uhQiZzNUA9UsLnscPYyYaenldciyBbU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-446R_KkeNHS8sGuEDRlUtg-1; Sun, 05 Jan 2020 07:59:28 -0500
Received: by mail-qv1-f71.google.com with SMTP id dw11so9423063qvb.16
 for <qemu-devel@nongnu.org>; Sun, 05 Jan 2020 04:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wp7IEacTPDnbh2fT1ey9LJUjRbVmj0GN0bCAT90OXe4=;
 b=cI6YHn22ZcgIQgSmZoCPnI4jhEJLS3UfMMCYzQaEq9SMKuuyUjywSfzstUInALGgz+
 xd8jcG3RJn7jX4uBGZya7pumNVl8Kjqh+Ub8kb+9L1iEURVGSQvHufOLKQObApyfDkEk
 8JyEKJJhH8PEy+HAcJ9j+I6zcn6HQ84q55iK+mcvssJ4+NCwTStNAtlzmGlNKGLtF025
 Jn9hXknzUXT2euEg0SKMlMom4hNiCr8nY9jeF7X2mNO9eQOclFvZ18lVKJRCwwreSsUJ
 lPMEm3+EoYB+x0r68z02S7nJZuLbb2ZBOEdTo02MLYPYnvVXSrIeMb5CPqpRKx09fg2e
 4L0w==
X-Gm-Message-State: APjAAAXAwNs7QQE5RiSBX5oiA/D/dQtZrzrqATSaSXcniJC0VCG114Ct
 YzeqgQMd7DwFzf7P0xyGtoT3erqQwogcp/FfZZEMjB9HFXEjysQFK2NWAzCf2RBsjTunLQ1avJx
 9jpnPanYnI+V7mCQ=
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr69716430qtv.102.1578229167660; 
 Sun, 05 Jan 2020 04:59:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqxCgE25FG/Tf/Z2EBEsHhuhHaNSKyMSSfLa3+wZKPDw2XksJHT87pj5XBG8KWsUHS+nqUXNlA==
X-Received: by 2002:ac8:6f73:: with SMTP id u19mr69716422qtv.102.1578229167500; 
 Sun, 05 Jan 2020 04:59:27 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id i2sm21781164qte.87.2020.01.05.04.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jan 2020 04:59:26 -0800 (PST)
Date: Sun, 5 Jan 2020 07:59:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 24/32] vhost-user-scsi: reset the device if supported
Message-ID: <20200105125622.27231-25-mst@redhat.com>
References: <20200105125622.27231-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 446R_KkeNHS8sGuEDRlUtg-1
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


