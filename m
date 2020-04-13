Return-Path: <SRS0=kd+i=55=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDA2C2BA19
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB6182072C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2020 11:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gRlWLVGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB6182072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNwz9-0000Q0-1y
	for qemu-devel@archiver.kernel.org; Mon, 13 Apr 2020 07:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1jNwxk-0007PC-29
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1jNwxi-0006Rz-P5
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48803
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1jNwxi-0006OW-IY
 for qemu-devel@nongnu.org; Mon, 13 Apr 2020 07:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586776150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b70fwI1uKzBY3zR8ExZ5/UCKMs6OQTY0f1zHtfOQbi4=;
 b=gRlWLVGLA6x+jRofgi+PrkWPC4go+Bo1kv+EHjq4ysWSuaQSebFtqYy4ObQGpQadyj029w
 QdV/NQ5hgaoDjnCWdwwhL6FSaQ3H5eEJ4cyY3S6zJZaWbq9lyNkc9efVUUmsDpJXBb5xT5
 vGDczlve1QKNnXaDDq1mOd14Akndc9Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-fiA5O-MKOzCRz6p7VN3Pyw-1; Mon, 13 Apr 2020 07:09:08 -0400
X-MC-Unique: fiA5O-MKOzCRz6p7VN3Pyw-1
Received: by mail-wr1-f69.google.com with SMTP id d17so5533353wrr.17
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2020 04:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NEOsAd9JMpraVqoahrs8JKUiJrezriTLGts03bpTjhg=;
 b=hu9YFYi3wDBuRk0eUGNijTHqPUvEdBYhEcY34nUBGgKRlOQK9Dju52CApPLRayOcwf
 KDiy2BRtFM9zABJZi5H679slDspkRjTLdIwsyvvkivWQpjLepVRlgT0nZIwdh31SFNUC
 33CV0ReQoOukSOiLK+Rll2lTzFhFe2uWkWIQYXOkCcjK31mGBiB1hY7u9ktJ1JqLYpu1
 8/goeWgMEgb0jVe3WDv/YP0YsatNmGJeHLuzXktNBi0ItVhhEjyr9CPZqAdstJb8PAQ/
 OqdaYB37YoOaV+ZWmuuX6Qg0JSEQrfXhbtsk+yn2eFiQTwUKEkJT5RoZy9+vFEtJcWhR
 hf1g==
X-Gm-Message-State: AGi0PuYGDuwHXSvNdCvo5hW2CYdRUP9S7fY5LHuhVWeCloPpW1d70S3V
 V8e/Irr27g22CZJNcKZuc4wPSCll9npznvwx9OMJrXFvxm4rIPaRxA0h0YlZti2uUmHg4eaNZeX
 HJdPnBlIY4tNfnLc=
X-Received: by 2002:adf:eec8:: with SMTP id a8mr12900186wrp.28.1586776146620; 
 Mon, 13 Apr 2020 04:09:06 -0700 (PDT)
X-Google-Smtp-Source: APiQypLuwxTUq3jXZYVam/92ozqHCuJMCk8NvUiaDQ0muWPvyrQxkCj4skmIGrQUVncrMiWhpoqw4g==
X-Received: by 2002:adf:eec8:: with SMTP id a8mr12900171wrp.28.1586776146469; 
 Mon, 13 Apr 2020 04:09:06 -0700 (PDT)
Received: from redhat.com ([185.107.45.41])
 by smtp.gmail.com with ESMTPSA id b15sm14391055wru.70.2020.04.13.04.09.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2020 04:09:06 -0700 (PDT)
Date: Mon, 13 Apr 2020 07:09:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] MAINTAINERS: Add myself as vhost-user-blk maintainer
Message-ID: <20200413110838.151374-2-mst@redhat.com>
References: <20200413110838.151374-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200413110838.151374-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Raphael Norwitz <raphael.norwitz@nutanix.com>

As suggested by Michael, let's add me as a maintainer of
vhost-user-blk and vhost-user-scsi.

CC: Michael S. Tsirkin <mst@redhat.com>
CC Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
Message-Id: <1585213047-20089-1-git-send-email-raphael.norwitz@nutanix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 642c8e0b6b..5f93e8c01d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1853,6 +1853,18 @@ F: hw/display/virtio-gpu*
 F: hw/display/virtio-vga.*
 F: include/hw/virtio/virtio-gpu.h
=20
+vhost-user-blk
+M: Raphael Norwitz <raphael.norwitz@nutanix.com>
+S: Maintained
+F: contrib/vhost-user-blk/
+F: contrib/vhost-user-scsi/
+F: hw/block/vhost-user-blk.c
+F: hw/scsi/vhost-user-scsi.c
+F: hw/virtio/vhost-user-blk-pci.c
+F: hw/virtio/vhost-user-scsi-pci.c
+F: include/hw/virtio/vhost-user-blk.h
+F: include/hw/virtio/vhost-user-scsi.h
+
 vhost-user-gpu
 M: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
 M: Gerd Hoffmann <kraxel@redhat.com>
--=20
MST


