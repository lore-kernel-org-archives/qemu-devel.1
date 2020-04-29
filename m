Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EAC5C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:56:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB96208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UHITsNIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB96208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlKV-0004fE-Fv
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:56:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGn-0005zd-KW
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGn-00020U-7B
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTlGm-00020L-Re
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fOuUDLYZ45AHPnCIWp/al4iAPJBJrcFw0e2TQJnEVQk=;
 b=UHITsNIphWlVrhj2R9VmPJ9bOrjqiyJubEZCURCNz27HM8+5kZ5TPSJXJx6oNxOGruDvus
 3jkFJko67dblVsZe2JxOGIH60srbwVGc7cMx4r0OHDjRXYqP3VRWIQtDuwcrdu3EC+6654
 Q81xTCOh4r3R22N7lD918qbpCT1d/SA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-XlklErG0NqWY5YyvuKxcZw-1; Wed, 29 Apr 2020 07:52:50 -0400
X-MC-Unique: XlklErG0NqWY5YyvuKxcZw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B04FB107ACCD;
 Wed, 29 Apr 2020 11:52:49 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 44B4E66064;
 Wed, 29 Apr 2020 11:52:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 220C29D9E; Wed, 29 Apr 2020 13:52:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] ramfb: add sanity checks to
 ramfb_create_display_surface
Date: Wed, 29 Apr 2020 13:52:35 +0200
Message-Id: <20200429115236.28709-6-kraxel@redhat.com>
In-Reply-To: <20200429115236.28709-1-kraxel@redhat.com>
References: <20200429115236.28709-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:18:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ramfb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index eb8b4bc49a2f..be884c9ea837 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -15,6 +15,7 @@
 #include "qapi/error.h"
 #include "hw/loader.h"
 #include "hw/display/ramfb.h"
+#include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
 #include "sysemu/reset.h"
=20
@@ -49,6 +50,11 @@ static DisplaySurface *ramfb_create_display_surface(int =
width, int height,
     hwaddr size;
     void *data;
=20
+    if (width < 16 || width > VBE_DISPI_MAX_XRES ||
+        height < 16 || height > VBE_DISPI_MAX_YRES ||
+        format =3D=3D 0 /* unknown format */)
+        return NULL;
+
     if (linesize =3D=3D 0) {
         linesize =3D width * PIXMAN_FORMAT_BPP(format) / 8;
     }
--=20
2.18.2


