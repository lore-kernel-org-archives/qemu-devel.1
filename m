Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167E2C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D04ED208FE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 11:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NPXMb3dr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D04ED208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTlLb-0006TS-V6
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 07:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGq-000679-5C
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jTlGp-00020q-JG
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jTlGp-00020j-6G
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 07:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588161174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d4q+KifWSZPbMSYrgLgimhuL+cOeqDgd6Vd41sgzUZY=;
 b=NPXMb3drjEkHlk+kBA1phkp7iRbWR72UigrMN3S8Oo5x6V73XieyvXEyBrGHcbKdpnviQo
 79b9WcPzzwKUbbHVxNlFQnTZFIguHGUGVeTM9Q2qJ8VXNbF/Aw7VC9XGykHOl7P7FisQrV
 yKMkKm32o7b1x1lm3G8dG4W7lZFeyVA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-BXJ98XCWODeT-r7X1NVrTQ-1; Wed, 29 Apr 2020 07:52:53 -0400
X-MC-Unique: BXJ98XCWODeT-r7X1NVrTQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C71E1005510;
 Wed, 29 Apr 2020 11:52:52 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-193.ams2.redhat.com
 [10.36.113.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB725C1BE;
 Wed, 29 Apr 2020 11:52:44 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2A9989D9F; Wed, 29 Apr 2020 13:52:37 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] ramfb: fix size calculation
Date: Wed, 29 Apr 2020 13:52:36 +0200
Message-Id: <20200429115236.28709-7-kraxel@redhat.com>
In-Reply-To: <20200429115236.28709-1-kraxel@redhat.com>
References: <20200429115236.28709-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 01:42:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, lersek@redhat.com,
 Gerd Hoffmann <kraxel@redhat.com>, hqm03ster@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

size calculation isn't correct with guest-supplied stride, the last
display line isn't accounted for correctly.

For the typical case of stride > linesize (add padding) we error on the
safe side (calculated size is larger than actual size).

With stride < linesize (scanlines overlap) the calculated size is
smaller than the actual size though so our guest memory mapping might
end up being too small.

While being at it also fix ramfb_create_display_surface to use hwaddr
for the parameters.  That way all calculation are done with hwaddr type
and we can't get funny effects from type castings.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Acked-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/display/ramfb.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index be884c9ea837..928d74d10bc7 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -44,10 +44,10 @@ static void ramfb_unmap_display_surface(pixman_image_t =
*image, void *unused)
=20
 static DisplaySurface *ramfb_create_display_surface(int width, int height,
                                                     pixman_format_code_t f=
ormat,
-                                                    int linesize, uint64_t=
 addr)
+                                                    hwaddr stride, hwaddr =
addr)
 {
     DisplaySurface *surface;
-    hwaddr size;
+    hwaddr size, mapsize, linesize;
     void *data;
=20
     if (width < 16 || width > VBE_DISPI_MAX_XRES ||
@@ -55,19 +55,20 @@ static DisplaySurface *ramfb_create_display_surface(int=
 width, int height,
         format =3D=3D 0 /* unknown format */)
         return NULL;
=20
-    if (linesize =3D=3D 0) {
-        linesize =3D width * PIXMAN_FORMAT_BPP(format) / 8;
+    linesize =3D width * PIXMAN_FORMAT_BPP(format) / 8;
+    if (stride =3D=3D 0) {
+        stride =3D linesize;
     }
=20
-    size =3D (hwaddr)linesize * height;
-    data =3D cpu_physical_memory_map(addr, &size, false);
-    if (size !=3D (hwaddr)linesize * height) {
-        cpu_physical_memory_unmap(data, size, 0, 0);
+    mapsize =3D size =3D stride * (height - 1) + linesize;
+    data =3D cpu_physical_memory_map(addr, &mapsize, false);
+    if (size !=3D mapsize) {
+        cpu_physical_memory_unmap(data, mapsize, 0, 0);
         return NULL;
     }
=20
     surface =3D qemu_create_displaysurface_from(width, height,
-                                              format, linesize, data);
+                                              format, stride, data);
     pixman_image_set_destroy_function(surface->image,
                                       ramfb_unmap_display_surface, NULL);
=20
--=20
2.18.2


