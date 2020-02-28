Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE52C3F2D1
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EBD246A3
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 12:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ee4eIO0j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EBD246A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7fAW-0006bJ-N3
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 07:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j7f9X-0004zj-W1
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j7f9X-0002oA-0m
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:03 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45050
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j7f9W-0002o1-Ti
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 07:54:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582894442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XwDs7eB7yM8J9r+WDDmjIGrx6VK50GLopC5M52Cl3uU=;
 b=ee4eIO0jrLywUxQexV2zM5LSOcs+43XFQjbyZgerV1PUGlDpYRTzEoiQ+cbQYc0m9X2X2w
 5rMbM3niqICCTq2/EwuTLq6iF8RuOjrqZ5Whtv30dS0SGds/0hbQGi4Q2VN41JcrXwrtYG
 JeRWwAAhbixPe325u8IlZQIn7el226A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-2gz3hXYlO4ChF49ddIzr0g-1; Fri, 28 Feb 2020 07:54:00 -0500
X-MC-Unique: 2gz3hXYlO4ChF49ddIzr0g-1
Received: by mail-wm1-f72.google.com with SMTP id t17so658903wmi.7
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2020 04:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=0FgPL1xTyWyfSBALtTC0/9engcqp/M7CptMznNnbZK0=;
 b=JEzreu9yRWVvZqjcX3sf9UzR+PQLn+o9UHau65F2cTbvC1wuEQHrqWk4GcaPdlWdRA
 nrLd0FrxjjBYZ+KSyOK+Suw6NpDm93W1yzsTHu8yUfDAsNWrFcXuIfzIrJ8rBAdYcXgH
 Ongg7zakSvRRWMVfsAe4u5AMCGHKLgbd3PgqOO1Odgqj2SQGKqHqrA4g3kxNkcWvUVtU
 DE+x0jw9OwhuMXwBB3qKMpvLH74+DnZ1iqd/TE0HEOPTZDRDaHR8R2QKK4kjuIWwxMw/
 eF5fvbuVVSMSMY7zbkLh7m85XivEAUrBx94Usb6vCY0ZGZtRMWC+4XTawLyA7zUz++N6
 nTdA==
X-Gm-Message-State: APjAAAWVeG+81/tYjV3gPVQeOmY4M6flhiE2Eg1CKitVfNwdXyLSRSe9
 fY8Hwkdi9jpkfWDtkXwe8qGM7KhjtoL417t06hBoighBL/7DuXFF3YQ+kOFLYE7b0LKqCnS6mmO
 huEX3+UBUPFI808c=
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4600425wmg.169.1582894439246; 
 Fri, 28 Feb 2020 04:53:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqx7v06HKBq9Kj6vX/A4DZnr1ikzdcav5IYjqnCsm3Y5qrj16y5xbXFeAyBP8EzWUBXymLUZTw==
X-Received: by 2002:a7b:cf08:: with SMTP id l8mr4600406wmg.169.1582894439000; 
 Fri, 28 Feb 2020 04:53:59 -0800 (PST)
Received: from x1w.moovbox.local ([185.102.219.36])
 by smtp.gmail.com with ESMTPSA id d9sm12398979wrx.94.2020.02.28.04.53.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2020 04:53:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/5] hw/arm/mainstone: Simplify since the machines are
 little-endian only
Date: Fri, 28 Feb 2020 13:53:48 +0100
Message-Id: <20200228125351.29482-3-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228125351.29482-1-philmd@redhat.com>
References: <20200228125351.29482-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We only build the little-endian softmmu configurations. Checking
for big endian is pointless, remove the unused code.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/arm/mainstone.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/hw/arm/mainstone.c b/hw/arm/mainstone.c
index 6e64dfab50..1042017086 100644
--- a/hw/arm/mainstone.c
+++ b/hw/arm/mainstone.c
@@ -119,7 +119,6 @@ static void mainstone_common_init(MemoryRegion *address=
_space_mem,
     DeviceState *mst_irq;
     DriveInfo *dinfo;
     int i;
-    int be;
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
=20
     /* Setup CPU & memory */
@@ -130,11 +129,6 @@ static void mainstone_common_init(MemoryRegion *addres=
s_space_mem,
     memory_region_set_readonly(rom, true);
     memory_region_add_subregion(address_space_mem, 0, rom);
=20
-#ifdef TARGET_WORDS_BIGENDIAN
-    be =3D 1;
-#else
-    be =3D 0;
-#endif
     /* There are two 32MiB flash devices on the board */
     for (i =3D 0; i < 2; i ++) {
         dinfo =3D drive_get(IF_PFLASH, 0, i);
@@ -142,7 +136,7 @@ static void mainstone_common_init(MemoryRegion *address=
_space_mem,
                                    i ? "mainstone.flash1" : "mainstone.fla=
sh0",
                                    MAINSTONE_FLASH,
                                    dinfo ? blk_by_legacy_dinfo(dinfo) : NU=
LL,
-                                   sector_len, 4, 0, 0, 0, 0, be)) {
+                                   sector_len, 4, 0, 0, 0, 0, 0)) {
             error_report("Error registering flash memory");
             exit(1);
         }
--=20
2.21.1


