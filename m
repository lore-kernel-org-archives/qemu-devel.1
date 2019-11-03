Return-Path: <SRS0=n1BB=Y3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF2BCA9EB0
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 131822190F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2019 22:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1gwGDj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 131822190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iROKn-0005ZB-42
	for qemu-devel@archiver.kernel.org; Sun, 03 Nov 2019 17:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iROJO-0004Rn-8B
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iROJN-0002R5-4q
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:30 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57847
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iROJN-0002QF-1Y
 for qemu-devel@nongnu.org; Sun, 03 Nov 2019 17:25:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572819928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CLHKIKG3hHAjCkZGDoKRl5er4nims8GO1xNI5OW3jBU=;
 b=J1gwGDj4RWMHsAO8aePPUnPyw0ObmeFlAP6G8nYLbcrHcI6Iu3+Url4I3k0Sk8QUpvN3Gz
 TK3DO9LTbH9hxfsvCuvl5DHzFh46LZKDJ+XYrJAJF8lzMz0+B/ok/1grfYXzcMzeeHwzQx
 jzLPhBK4fSgtxCgvPS35S4ooJjgHknA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-jsTQzBuaNjK4ulIjNxu8zg-1; Sun, 03 Nov 2019 17:25:25 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7E3F800C61
 for <qemu-devel@nongnu.org>; Sun,  3 Nov 2019 22:25:24 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-75.brq.redhat.com [10.40.204.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6992B600C1;
 Sun,  3 Nov 2019 22:25:22 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] fw_cfg: Allow reboot-timeout=-1 again
Date: Sun,  3 Nov 2019 23:25:10 +0100
Message-Id: <20191103222511.17478-2-philmd@redhat.com>
In-Reply-To: <20191103222511.17478-1-philmd@redhat.com>
References: <20191103222511.17478-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: jsTQzBuaNjK4ulIjNxu8zg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
to only allow the range 0..65535; however both qemu and libvirt document
the special value -1  to mean don't reboot.
Allow it again.

Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error checki=
ng")
RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=3D1765443
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20191025165706.177653-1-dgilbert@redhat.com>
Suggested-by: Laszlo Ersek <lersek@redhat.com>
Message-Id: <37ac197c-f20e-dd05-ff6a-13a2171c7148@redhat.com>
[PMD: Applied Laszlo's suggestions]
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/nvram/fw_cfg.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index aef1727250..14f8437983 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -237,7 +237,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
 static void fw_cfg_reboot(FWCfgState *s)
 {
     const char *reboot_timeout =3D NULL;
-    int64_t rt_val =3D -1;
+    uint64_t rt_val =3D -1;
     uint32_t rt_le32;
=20
     /* get user configuration */
@@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
=20
     if (reboot_timeout) {
         rt_val =3D qemu_opt_get_number(opts, "reboot-timeout", -1);
+
         /* validate the input */
-        if (rt_val < 0 || rt_val > 0xffff) {
+        if (rt_val > 0xffff && rt_val !=3D (uint64_t)-1) {
             error_report("reboot timeout is invalid,"
-                         "it should be a value between 0 and 65535");
+                         "it should be a value between -1 and 65535");
             exit(1);
         }
     }
--=20
2.21.0


