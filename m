Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F4EC35670
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30E6820880
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 23:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZluuA7O4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30E6820880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j60Pk-0002fT-AD
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 18:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36638)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j60Ok-0001Hu-91
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j60Oj-00089p-0l
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50148
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j60Oi-000897-Tt
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 18:10:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582499452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NyXYVtWhp6qL8hE5dy2LdXvwOXEHU2mr4RpD1naeFOQ=;
 b=ZluuA7O41WJmekFyt9UYvHWRRMcJUEeLXR74RyJCXSKX8xZee15oKmkS41sYaRjQZ8alcu
 2teMvu99JJ4A6CKvMdg1XCC48JcBxDHCFJkGnkp+FWsSkXYJQIbXgYZnr93/Mz9ZfxwECG
 Y1NZZLCjWN/TenHsHmNQphPN+U58o/c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-443-NmbosiP5MW-m2wq_0Emxtw-1; Sun, 23 Feb 2020 18:10:50 -0500
X-MC-Unique: NmbosiP5MW-m2wq_0Emxtw-1
Received: by mail-wr1-f71.google.com with SMTP id t3so2852942wrp.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2020 15:10:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mQ+Dd+23qu9EG86MqcX+Rg8VXyUHQRNEJK1Q2ZO2kEM=;
 b=Yk+v6KHAhktW/rUrheaNajbNOcPrynTpuQapJRFdvRicoDyxSKuevQXh9Hp2hihOyQ
 rvQjgNzbR7dDXqx/hCPdLtvKXuwIiMyWEoBkPoV1Y+uNIVTjVVFbYAOFcSvVKW1Psdw7
 m9JhfQSVWUOPGd/d2UYdHVVlUvKThhRg+EZhWciFTs1DGRpi/xXXNiZ5BhW9CtmMvSLz
 xSbxWSal2gx4o/X8cfD1pPvsWJb+C2Le/K2jA20VbDRWcw+SMtF6xUuda+XhiLNwnsM5
 noVol+nH5aYjM32s8XBOJz2t/PZDMbEAA1c96W34dgv7PVhyTcwAAQJtt0w7AUaiexpH
 lYyw==
X-Gm-Message-State: APjAAAVU75C8nv+m+AEuAalF6X/C62g0Rrtp5iAxo2UyBKFF9sfTbAH/
 PqanElv9vx+OdNj5ZybwB4OF/J2E+0tomaNESsyX/ipy5EuGGL07uEAfqQlTw8CV3ZeynEG8Bjr
 uvs70HJgdPeb+u64=
X-Received: by 2002:adf:ee01:: with SMTP id y1mr66197019wrn.152.1582499449149; 
 Sun, 23 Feb 2020 15:10:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZoQ700ID/waMVgYsmMsEiFTbrkAh6K3jfcjsVa16gmVRAtqj696JoZxW8/TlEBfZU8DnFLA==
X-Received: by 2002:adf:ee01:: with SMTP id y1mr66196999wrn.152.1582499448921; 
 Sun, 23 Feb 2020 15:10:48 -0800 (PST)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id r6sm15777598wrp.95.2020.02.23.15.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2020 15:10:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/2] hw/arm/gumstix: Simplify since the machines are
 little-endian only
Date: Mon, 24 Feb 2020 00:10:43 +0100
Message-Id: <20200223231044.8003-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200223231044.8003-1-philmd@redhat.com>
References: <20200223231044.8003-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

As the Connex and Verdex machines only boot in little-endian,
we can simplify the code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
---
 hw/arm/gumstix.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
index f26a0e8010..94904d717b 100644
--- a/hw/arm/gumstix.c
+++ b/hw/arm/gumstix.c
@@ -51,7 +51,6 @@ static void connex_init(MachineState *machine)
 {
     PXA2xxState *cpu;
     DriveInfo *dinfo;
-    int be;
     MemoryRegion *address_space_mem =3D get_system_memory();
=20
     uint32_t connex_rom =3D 0x01000000;
@@ -66,14 +65,9 @@ static void connex_init(MachineState *machine)
         exit(1);
     }
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
     if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               sector_len, 2, 0, 0, 0, 0, be)) {
+                               sector_len, 2, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
         exit(1);
     }
@@ -87,7 +81,6 @@ static void verdex_init(MachineState *machine)
 {
     PXA2xxState *cpu;
     DriveInfo *dinfo;
-    int be;
     MemoryRegion *address_space_mem =3D get_system_memory();
=20
     uint32_t verdex_rom =3D 0x02000000;
@@ -102,14 +95,9 @@ static void verdex_init(MachineState *machine)
         exit(1);
     }
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
     if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               sector_len, 2, 0, 0, 0, 0, be)) {
+                               sector_len, 2, 0, 0, 0, 0, 0)) {
         error_report("Error registering flash memory");
         exit(1);
     }
@@ -152,6 +140,9 @@ static const TypeInfo verdex_type =3D {
=20
 static void gumstix_machine_init(void)
 {
+    if (target_words_bigendian()) {
+        return;
+    }
     type_register_static(&connex_type);
     type_register_static(&verdex_type);
 }
--=20
2.21.1


