Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0BDC33CAA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:20:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0554924655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 07:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgcNktff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0554924655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuWmW-00085z-Qg
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 02:20:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iuWdZ-0006FU-Pb
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iuWdY-0008Gu-L0
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46630
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iuWdY-0008Gb-H1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 02:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579763444;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7X8PjfcFHzdyIHec4OG6du8gOrCYueQPk/uwOaIht1o=;
 b=KgcNktffRDUUXeEPOywAIeDhYmcJzvR+USkYIKBD7Qq6TB2RB2rZAIdChJD/7510j3brxl
 70pZ/GBoE1UaOvK9VCEsrKkhVlcV+H5/4nJeDU+D4WKcAKYm9UxQQdxD7xe2eIenQMke4H
 R0E6uoM0G2CFNtTBDDIjvqJlNVSmg0Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-6N3gqnW8PHS1P5tzNg9wqQ-1; Thu, 23 Jan 2020 02:10:42 -0500
Received: by mail-wr1-f69.google.com with SMTP id z15so1327349wrw.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 23:10:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dKz9Yp7TsPHys5pVT0H9YPlrICr7T8Twac2SXPW2Rdw=;
 b=HGhvHKWFQtdugSjL8XJFg6O5QS7vxPYT3uIUTh7KvlyCMoT0YlMmlNKDWdRlCnYwxQ
 x+bGBbH8gWEzt5t0Fr34L48JVchjNSFfy4+VmI3g5X+RVXa878TmwPOLsHIKvc5X3Vd5
 KPvXyUCCqzHQ9RFFFav8hqPpvQhuT4si0NVkhnpNS0U9rzSIz3OkHrhD1X5F1V/RZ8r5
 gs3lJiGCtARnOZBM71MFyWOC1UycSwyMmpn5R31auoqmdTS4J4vIkooiyrJjirvsrzOM
 0AsHnW3t0zqftlkFGKKvzBZ1JUVS72pMbxE+HiEyMRh97rekYnzwRfrpVbXDZfEInsnU
 nA7Q==
X-Gm-Message-State: APjAAAUcznQ2vxaacCHDrab5SgIEugVjJnV5IvPGXNvjGz+mvK0u4W9i
 FF9jp53o49gtsGWvxtZzxTZpEcIAA0CDOxV/vXBIF+OcFcmfKutz1jC4ubzzlj0pX+Z5z8tXBgA
 SNKM+2/ELPXk8UWo=
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr15325031wrs.369.1579763440659; 
 Wed, 22 Jan 2020 23:10:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqzl4O84SI0buRHLFNMhF+WhO00ttiWcJjo+dmPXyU6bx5rIrFPh57ygI6ZyhG6ygl4+zDLi+A==
X-Received: by 2002:a5d:49c7:: with SMTP id t7mr15325009wrs.369.1579763440413; 
 Wed, 22 Jan 2020 23:10:40 -0800 (PST)
Received: from redhat.com (bzq-79-176-0-156.red.bezeqint.net. [79.176.0.156])
 by smtp.gmail.com with ESMTPSA id
 d23sm1845357wra.30.2020.01.22.23.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 23:10:39 -0800 (PST)
Date: Thu, 23 Jan 2020 02:10:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 10/18] virtio-9p-device: fix memleak in
 virtio_9p_device_unrealize
Message-ID: <20200123070913.626488-11-mst@redhat.com>
References: <20200123070913.626488-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200123070913.626488-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 6N3gqnW8PHS1P5tzNg9wqQ-1
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
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Pan Nengyuan <pannengyuan@huawei.com>, Greg Kurz <groug@kaod.org>,
 Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

v->vq forgot to cleanup in virtio_9p_device_unrealize, the memory leak
stack is as follow:

Direct leak of 14336 byte(s) in 2 object(s) allocated from:
  #0 0x7f819ae43970 (/lib64/libasan.so.5+0xef970)  ??:?
  #1 0x7f819872f49d (/lib64/libglib-2.0.so.0+0x5249d)  ??:?
  #2 0x55a3a58da624 (./x86_64-softmmu/qemu-system-x86_64+0x2c14624)  /mnt/s=
db/qemu/hw/virtio/virtio.c:2327
  #3 0x55a3a571bac7 (./x86_64-softmmu/qemu-system-x86_64+0x2a55ac7)  /mnt/s=
db/qemu/hw/9pfs/virtio-9p-device.c:209
  #4 0x55a3a58e7bc6 (./x86_64-softmmu/qemu-system-x86_64+0x2c21bc6)  /mnt/s=
db/qemu/hw/virtio/virtio.c:3504
  #5 0x55a3a5ebfb37 (./x86_64-softmmu/qemu-system-x86_64+0x31f9b37)  /mnt/s=
db/qemu/hw/core/qdev.c:876

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Message-Id: <20200117060927.51996-2-pannengyuan@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Acked-by: Greg Kurz <groug@kaod.org>
---
 hw/9pfs/virtio-9p-device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 991e175c82..ba35892940 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -218,6 +218,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev=
, Error **errp)
     V9fsVirtioState *v =3D VIRTIO_9P(dev);
     V9fsState *s =3D &v->state;
=20
+    virtio_del_queue(vdev, 0);
     virtio_cleanup(vdev);
     v9fs_device_unrealize_common(s, errp);
 }
--=20
MST


