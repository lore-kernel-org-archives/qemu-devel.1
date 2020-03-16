Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC17C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6E3620719
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:57:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WJABzxt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E3620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxjs-0005ez-U0
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43921)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIY-000559-FT
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIX-0000qC-6d
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:22 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxIX-0000gD-0s
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZO4UQvxnSQ50fOctevsrcsWiSa/9rRrHMPOif7BTXI=;
 b=WJABzxt/LH+0xkwcEkbBvvFBSyAkqgaBOF2f0wNHHr9o69kVSCFSNTJlMBZY7RleMazGjH
 Zui4iK9YjPP82yvEQUm9mOx9KN2Oj4kt+wiZHkf7pQOsnneIOVvuBkn9oZvWj2SaDlhg+J
 kYrGfPpNDvhKZccvH/JGJlRDtQ37f5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-avo8ONVDPe2wNeaGikNv4Q-1; Mon, 16 Mar 2020 17:29:16 -0400
X-MC-Unique: avo8ONVDPe2wNeaGikNv4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19925107ACC7
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:29:16 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25DE119C4F;
 Mon, 16 Mar 2020 21:29:14 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 59/61] hw/ppc/ppc405: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 22:27:26 +0100
Message-Id: <1584394048-44994-60-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The scripts/coccinelle/memory-region-housekeeping.cocci reported:
* TODO [[view:./hw/ppc/ppc405_boards.c::face=3Dovl-face1::linb=3D195::colb=
=3D8::cole=3D30][potential use of memory_region_init_rom*() in  ./hw/ppc/pp=
c405_boards.c::195]]
* TODO [[view:./hw/ppc/ppc405_boards.c::face=3Dovl-face1::linb=3D464::colb=
=3D8::cole=3D30][potential use of memory_region_init_rom*() in  ./hw/ppc/pp=
c405_boards.c::464]]

We can indeed replace the memory_region_init_ram() and
memory_region_set_readonly() calls by memory_region_init_rom().

Acked-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/ppc/ppc405_boards.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index de93c40..e6bffb9 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -199,7 +199,7 @@ static void ref405ep_init(MachineState *machine)
 #endif
     {
         bios =3D g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "ef405ep.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "ef405ep.bios", BIOS_SIZE,
                                &error_fatal);
=20
         if (bios_name =3D=3D NULL)
@@ -223,7 +223,6 @@ static void ref405ep_init(MachineState *machine)
             /* Avoid an uninitialized variable warning */
             bios_size =3D -1;
         }
-        memory_region_set_readonly(bios, true);
     }
     /* Register FPGA */
     ref405ep_fpga_init(sysmem, 0xF0300000);
@@ -471,7 +470,7 @@ static void taihu_405ep_init(MachineState *machine)
         if (bios_name =3D=3D NULL)
             bios_name =3D BIOS_FILENAME;
         bios =3D g_new(MemoryRegion, 1);
-        memory_region_init_ram(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
+        memory_region_init_rom(bios, NULL, "taihu_405ep.bios", BIOS_SIZE,
                                &error_fatal);
         filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
         if (filename) {
@@ -489,7 +488,6 @@ static void taihu_405ep_init(MachineState *machine)
             error_report("Could not load PowerPC BIOS '%s'", bios_name);
             exit(1);
         }
-        memory_region_set_readonly(bios, true);
     }
     /* Register Linux flash */
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
--=20
1.8.3.1



