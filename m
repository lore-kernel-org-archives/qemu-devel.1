Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7AAC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C91ED20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:05:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ58MaKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C91ED20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41856 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNv6t-0003iW-8U
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:05:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNv63-0003Kn-Hw
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hNv62-0006w9-Hp
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:05:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35239)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hNv62-0006vW-BL
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:05:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id y197so18585652wmd.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 01:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=zRVYaahXFZub+pLBX05CDpqghvAbHlfQwSW5bGZxzk0=;
	b=NJ58MaKNmv3Haz/LUm2+GMlMbjWBfOCNSq4Qjz5iWcL4eVxjy3bKqPZKXhgEzCtvGU
	PrmdvzOQL/lyP5h5wXGFj4OEzzkR5C8cFe8r1lnlxwSJY5Lk6iSusvTYd+QkNOEjrfgZ
	k9O59ZBYT4qaPpoDE8ZRvo7W7tdV/1ZffPmnMo7fTYZtsqysGvh4n4tpZ1jjUGJmkiwO
	vC1adsbXUr7V31QupyfjK7cvGr9R872AfwlYQW+j2MH5uNSTJ3Np/wfpla0oF2Vt68uy
	OUFBWeWl6wSKuUHUHsnfi/mMhx47JULTqfPwwpZhgW9FLFYS0iCz5wrrEQZfiqIL3jnQ
	1KUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=zRVYaahXFZub+pLBX05CDpqghvAbHlfQwSW5bGZxzk0=;
	b=HWbtHk5oxSydnj68hRa1qDaANC2m7IoocOcfCXlw9TDWS01DwYEoainlqkuxR+dL40
	Ez3INEgER15IITZBorcsZEnNpNRi0MxdhySPJRAJDqsCMEyhmosLGK6HFCDaX74ylH0D
	mAKmv8PWZxY4POXzKDcYR5KI9Nl/4epO2cpHiKNx9jUG5DipF/cU/WgJZA0xDx5QUkhs
	3e7D5d+WnTc8pClH5zw+LGWEXhGOqiHiTCRBxqOIuWXYLVTSfyzDDBbWD9Zjgau4uzok
	HGi1imEQBcXQlSWVZx3Ie7mW6c+wbTmvLeutDEiRPxnuYlV+Cn7qyrB3lNQLWgYwi8Fk
	3IzQ==
X-Gm-Message-State: APjAAAUP8QBo17Iz0xTARNKKKe1bmKzblQMUpSyIjSfntG6P8RzdV2Ez
	bZ8NPqgrl6ZQjhXAmO4o0JmYCWLK
X-Google-Smtp-Source: APXvYqy6v9GNyHuCSN50CKomrsXUtT2ygB9IYUSavY5z2YhvQzGuoWgAu+USFHdDMiokZlyyH2wUpQ==
X-Received: by 2002:a1c:c785:: with SMTP id x127mr5149683wmf.90.1557216305170; 
	Tue, 07 May 2019 01:05:05 -0700 (PDT)
Received: from localhost.localdomain ([37.142.144.27])
	by smtp.gmail.com with ESMTPSA id a125sm72166wmc.47.2019.05.07.01.05.03
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 07 May 2019 01:05:04 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 11:05:01 +0300
Message-Id: <20190507080501.26712-1-marcel.apfelbaum@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v3] ui/console: Precautionary glBindTexture and
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
Cc: philmd@redhat.com, kraxel@redhat.com, hqm03ster@gmail.com
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
[fixed malformed patch, rebase to master]
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---

v3:
 - Fixed contributor name (Philippe)

v2:
 - fixed malformed patch
 - rebased to master

 ui/console-gl.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ui/console-gl.c b/ui/console-gl.c
index a56e1cd8eb..c1cb3bd673 100644
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
2.17.1


