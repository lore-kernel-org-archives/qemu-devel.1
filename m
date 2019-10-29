Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DEFCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B367820874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 17:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjmurQON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B367820874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPUun-0005kg-8s
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 13:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56810)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPUsb-0003mm-NB
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:02:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPUsZ-0003EF-2H
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:02:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22587
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPUsU-0003Bz-3X
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 13:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572368512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G7+BeeofiSo+flMQHWBPGzG1/SQWCPfqrK1CuHprhMU=;
 b=QjmurQON9q4UJMgPZC+hM+FDF065PERCG+e7knvuE89TS/eJoEIKsrhWHwkZB3wiVw7uPV
 kODl8LJXdjOBJ3RgWsFrUfDrU/rH9U/YaWyNlnMRiOoolueZYzEoFk967m27sjU5aSZ0b2
 L13sGUuVLVoko3JLnD+JRZOaAZ4MXsU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-DfYoYy0YO1mom5RW2GHDQg-1; Tue, 29 Oct 2019 13:01:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9F98801E6F
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 17:01:46 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-125.brq.redhat.com [10.40.204.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 774DC600F6;
 Tue, 29 Oct 2019 17:01:41 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 1/2] fw_cfg: Allow reboot-timeout=-1 again
Date: Tue, 29 Oct 2019 18:01:23 +0100
Message-Id: <20191029170124.27981-2-philmd@redhat.com>
In-Reply-To: <20191029170124.27981-1-philmd@redhat.com>
References: <20191029170124.27981-1-philmd@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: DfYoYy0YO1mom5RW2GHDQg-1
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
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


