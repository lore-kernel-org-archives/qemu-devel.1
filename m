Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61010C34033
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 308CD20659
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 09:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DGdbktdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 308CD20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3zY4-0006HO-8g
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 04:52:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43541)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3zQa-0001mL-C7
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3zQZ-00061G-C2
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52700
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3zQZ-00060J-7d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 04:44:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582019066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=02HoXPXFSTUgu0KD081ip91ymagPAPyI1gRkeiKZ3KI=;
 b=DGdbktdcRzYdjDl8JFrbslXD8NAxlHL46zsXdAc0B97+K0NIznZyY81v71JW4k4LCOHeqy
 fBGeOv9QY84+k7EVtOeHbet5a0f6eGFHa+F4/JQ0rejbT79mjhXmkK6IxnUBtMC1YB86Xb
 XdLDFhMgIUsckUPDiIUJY7dXcAUg8vQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-NLUESvb4OKSdE7F2JMN2Cw-1; Tue, 18 Feb 2020 04:44:23 -0500
Received: by mail-wm1-f72.google.com with SMTP id w12so793908wmc.3
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 01:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vA3IsJyKAQofk6HtSuxZl4Ss0klNULH/CRlFylcfG4k=;
 b=duRmhXM7nOBE6ERVkBllOUhWCiXm62CA2+7/tXMGI5wqH8rjpHsw+5MaiGDNdy7lCC
 MkNj5Sb/1hkX1bobeEbSvb0Ay+zyk0ErhZyJp2+pZRDF7GVVVVO/6nyYjICompRAUAMY
 gFLZYK5yrq6p3xzXqDO9jdeu8wVUYe3Xy61W8kzQG6FMjOnp9o2PPmdVWh3d3P9KqVJq
 XnYLGp6Ggl9KgGSSLbbbz6ajMLilsTv6QJzJdJlPoB00TgrLm/myAQuGswsMoiFhrPlw
 Ht1im3st5JbDeLFfQmGX3NGJh3hlYN4Kov/K5WT40Vx15R0/ZNBv7EOAacDkQuKubw0y
 DQHQ==
X-Gm-Message-State: APjAAAVd1XqVjnMz2Q7nAR6e503uYCthrt8EBT/MYMiHoTRemZwQPUev
 enqi7NldLIkdjgkaGyexQC9sQNk9K93ce2OSWZUgZu6Am5Ox5b3Asd7pBJgslK8fvQLmi2dRtSd
 pBJJpYS87kRo5teE=
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr2165454wmk.49.1582019061856; 
 Tue, 18 Feb 2020 01:44:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqy8AbM+RIvcf/JidHyXET+T174lnqvGndepiY9TnyXwDDhIhbfvoUB66i95qLpgeQifSxpRFw==
X-Received: by 2002:a7b:c76a:: with SMTP id x10mr2165430wmk.49.1582019061660; 
 Tue, 18 Feb 2020 01:44:21 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id z10sm2735588wmk.31.2020.02.18.01.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2020 01:44:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND 08/13] hw/vfio/display: Remove superfluous semicolon
Date: Tue, 18 Feb 2020 10:43:57 +0100
Message-Id: <20200218094402.26625-9-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200218094402.26625-1-philmd@redhat.com>
References: <20200218094402.26625-1-philmd@redhat.com>
MIME-Version: 1.0
X-MC-Unique: NLUESvb4OKSdE7F2JMN2Cw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Julia Suvorova <jusual@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta <mehta.aaru20@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: 8b818e059bf
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Cc: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/display.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index a5a608c5b2..f4977c66e1 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -287,7 +287,7 @@ static void vfio_display_dmabuf_update(void *opaque)
     VFIOPCIDevice *vdev =3D opaque;
     VFIODisplay *dpy =3D vdev->dpy;
     VFIODMABuf *primary, *cursor;
-    bool free_bufs =3D false, new_cursor =3D false;;
+    bool free_bufs =3D false, new_cursor =3D false;
=20
     primary =3D vfio_display_get_dmabuf(vdev, DRM_PLANE_TYPE_PRIMARY);
     if (primary =3D=3D NULL) {
--=20
2.21.1


