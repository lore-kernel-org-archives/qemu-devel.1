Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4767FC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:03:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2255021841
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:03:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2255021841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4ET-0004vW-EL
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:03:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU4Cp-00044h-1N
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hU4Cn-0005Gj-Dw
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52606)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hU4Cn-0005G3-0r
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:01:29 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C189A3081244
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 07:01:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-101.ams2.redhat.com
	[10.36.116.101])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D89E560C9E;
	Fri, 24 May 2019 07:01:21 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id 9AA2617538; Fri, 24 May 2019 09:01:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 24 May 2019 09:01:16 +0200
Message-Id: <20190524070118.30157-3-kraxel@redhat.com>
In-Reply-To: <20190524070118.30157-1-kraxel@redhat.com>
References: <20190524070118.30157-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 24 May 2019 07:01:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 2/4] vfio/display: set dmabuf modifier field
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alex Williamson <alex.williamson@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fill the new QemuDmaBuf->modifier field properly from plane info.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/vfio/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index a3d9c8f5beac..13969180b2dd 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -248,6 +248,7 @@ static VFIODMABuf *vfio_display_get_dmabuf(VFIOPCIDev=
ice *vdev,
     dmabuf->buf.height =3D plane.height;
     dmabuf->buf.stride =3D plane.stride;
     dmabuf->buf.fourcc =3D plane.drm_format;
+    dmabuf->buf.modifier =3D plane.drm_format_mod;
     dmabuf->buf.fd     =3D fd;
     if (plane_type =3D=3D DRM_PLANE_TYPE_CURSOR) {
         vfio_display_update_cursor(dmabuf, &plane);
--=20
2.18.1


