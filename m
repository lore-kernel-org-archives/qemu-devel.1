Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A0C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:12:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D474820658
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KiX1vxH4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D474820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDv9w-0005BL-0d
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:12:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDupO-0000DU-8b
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDupN-0003zH-2Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:06 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27971)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDupM-0003vz-Ti
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pY4c+GmzU3u8g8c7AEnnooJobRsrslPLMh6otl/Aa9k=;
 b=KiX1vxH4hMYbKD45IoCCtwuHZ6/1jIKGJkzyFHbPvfr4lqXU7t7PGRVrUyL1bDZ6G1GcR9
 OyZ9NVYuEf/BHixbkGpBNIitfFRIz4ZGRNPB6MXJRbI8H1KpUGdcNSNEcsPXutd100FPFi
 ue8HIczdG0ZQT4yzjcMcyUKZDNsM6sc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-rPMwwdN1MzKz74HXoSzNVQ-1; Mon, 16 Mar 2020 14:51:01 -0400
X-MC-Unique: rPMwwdN1MzKz74HXoSzNVQ-1
Received: by mail-wm1-f72.google.com with SMTP id n25so4986019wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:51:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5hL9ZjbXwspwyX5zsCIPRGL66Px5twVExOc9y+i/WDs=;
 b=m6WEqAeYQEJ8oraMcWbcc1H6frOl1SJdLyjIOj0wNNchANSuzf83v1RsvTr04+Wkha
 p6SP8mX9uKpRXbgVZ9+3erUkZx6N/vwekEchpHx+ScUYrzvJJxeOI3PCGisz43CYzC/5
 mCG0sqB0VMu5Ssdg0FhEe7CgM/pPQ+xCyrVDhvIbndwyC8QWBxU6t89ba8bQrgOIddQu
 bbmfpxIt3heua5PRTcLUKIff60P0xK+6AW3wc8GSkRPvuufT87TuvV6Ayw3UwCKMSpfj
 hZM0dTPPLKxMGNdiJc9LDauzoB8X5HznkbwJvrlukjRLQXteSKVJcebeRSun6IX6FExa
 edkA==
X-Gm-Message-State: ANhLgQ3UdST7iB1z95GS1jXRspG4PZ1FVi3vrZxpLU6K/bOd/LB6Tu8+
 fqzD/VOHJ2nFAqQQZVvAObwSMDVL4XeEB8W6xL1IYSHBKJ+bseZK4g83Yy1TA2uj4qcbE+aUhtn
 aE28N9+QTZgyGj6Q=
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr537632wmb.112.1584384660259; 
 Mon, 16 Mar 2020 11:51:00 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtYXWLIeUBJzV9zhJPiOLxS+CvAn577zEJ1lyarLKnKVezDA0uvW1XqIFwrYCLed9IjU6Pe2A==
X-Received: by 2002:a1c:62c5:: with SMTP id w188mr537609wmb.112.1584384660033; 
 Mon, 16 Mar 2020 11:51:00 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id w204sm753789wma.1.2020.03.16.11.50.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 10/25] hw/ppc: Use memory_region_init_rom() with read-only
 regions
Date: Mon, 16 Mar 2020 19:49:51 +0100
Message-Id: <20200316185006.576-11-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200316185006.576-1-philmd@redhat.com>
References: <20200316185006.576-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: "open list:New World mac99" <qemu-ppc@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/mac_newworld.c | 3 +--
 hw/ppc/mac_oldworld.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index b8189bf7a4..b2ec372958 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -155,13 +155,12 @@ static void ppc_core99_init(MachineState *machine)
     memory_region_add_subregion(get_system_memory(), 0, machine->ram);
=20
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "ppc_core99.bios", BIOS_SIZE,
                            &error_fatal);
=20
     if (bios_name =3D=3D NULL)
         bios_name =3D PROM_FILENAME;
     filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_set_readonly(bios, true);
     memory_region_add_subregion(get_system_memory(), PROM_ADDR, bios);
=20
     /* Load OpenBIOS (ELF) */
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 440c406eb4..faaa165f3f 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -129,13 +129,12 @@ static void ppc_heathrow_init(MachineState *machine)
     memory_region_add_subregion(sysmem, 0, machine->ram);
=20
     /* allocate and load BIOS */
-    memory_region_init_ram(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
+    memory_region_init_rom(bios, NULL, "ppc_heathrow.bios", BIOS_SIZE,
                            &error_fatal);
=20
     if (bios_name =3D=3D NULL)
         bios_name =3D PROM_FILENAME;
     filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
-    memory_region_set_readonly(bios, true);
     memory_region_add_subregion(sysmem, PROM_ADDR, bios);
=20
     /* Load OpenBIOS (ELF) */
--=20
2.21.1


