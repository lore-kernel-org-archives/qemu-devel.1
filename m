Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FB5C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDB732087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 16:14:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB732087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRfUw-00056i-TA
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 12:14:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTh-000420-0W
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hRfTf-000827-9h
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:13:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hRfTf-0007v7-3T
	for qemu-devel@nongnu.org; Fri, 17 May 2019 12:12:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1E3AA30BBE84;
	Fri, 17 May 2019 16:12:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-74.ams2.redhat.com
	[10.36.117.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9988A5D719;
	Fri, 17 May 2019 16:12:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
	id BB54F17534; Fri, 17 May 2019 18:12:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 18:12:40 +0200
Message-Id: <20190517161241.11813-4-kraxel@redhat.com>
In-Reply-To: <20190517161241.11813-1-kraxel@redhat.com>
References: <20190517161241.11813-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.49]);
	Fri, 17 May 2019 16:12:50 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 3/4] ui/console: Precautionary glBindTexture and
 surface->texture validation in surface_gl_update_texture
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, HOU Qiming <hqm03ster@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: HOU Qiming <hqm03ster@gmail.com>

In a GVT-g setup with dmabuf and GTK GUI, the current 2D texture at
surface_gl_update_texture is not necessarily
surface->texture. Adding a glBindTexture fixes related crashes and
artifacts, and is generally more secure.

Signed-off-by: HOU Qiming <hqm03ster@gmail.com>
Tested-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-id: 20190507080501.26712-1-marcel.apfelbaum@gmail.com
[fixed malformed patch, rebase to master]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/console-gl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ui/console-gl.c b/ui/console-gl.c
index a56e1cd8ebce..c1cb3bd67359 100644
--- a/ui/console-gl.c
+++ b/ui/console-gl.c
@@ -92,13 +92,17 @@ void surface_gl_update_texture(QemuGLShader *gls,
 
     assert(gls);
 
-    glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
-                  surface_stride(surface) / surface_bytes_per_pixel(surface));
-    glTexSubImage2D(GL_TEXTURE_2D, 0,
-                    x, y, w, h,
-                    surface->glformat, surface->gltype,
-                    data + surface_stride(surface) * y
-                    + surface_bytes_per_pixel(surface) * x);
+    if (surface->texture) {
+        glBindTexture(GL_TEXTURE_2D, surface->texture);
+        glPixelStorei(GL_UNPACK_ROW_LENGTH_EXT,
+                      surface_stride(surface)
+                      / surface_bytes_per_pixel(surface));
+        glTexSubImage2D(GL_TEXTURE_2D, 0,
+                        x, y, w, h,
+                        surface->glformat, surface->gltype,
+                        data + surface_stride(surface) * y
+                        + surface_bytes_per_pixel(surface) * x);
+    }
 }
 
 void surface_gl_render_texture(QemuGLShader *gls,
-- 
2.18.1


