Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5AAC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:18:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A8020679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q78H+IVF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A8020679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvFl-00060t-4K
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:18:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuqd-0002jb-88
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuqc-0004BO-1J
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:43807)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuqb-000444-To
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HttrlD9lCEsMBP0W9znyLPVsPA+6bjyfUNmOA7cXo6c=;
 b=Q78H+IVF2mCNPMkTrl3vuTI5CYCP5uC2hxC7pIOuZSO4ak4rfwjdKhTlHLSE7uHwD51Z2u
 qly62kz0u0syEYb27H6leR/EpqWBOTyK1Jkp1sJCw5gw9uUy1WKiw8QPZ+I11qdMho1GSl
 f/3v+JXd5NNfW4sRBiPMv0vm98hAOe4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-HXE6KNYnOdm_5w6uVGxVxA-1; Mon, 16 Mar 2020 14:52:08 -0400
X-MC-Unique: HXE6KNYnOdm_5w6uVGxVxA-1
Received: by mail-wr1-f72.google.com with SMTP id g4so1811197wrv.12
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:52:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tYfa1Hf7U/2ml3JMTg2AwntL/E669AKHYCa9fz5AtEA=;
 b=o9CPhKS4AHUuSmwR7SMttRbhYn4HmTvOZQWbHBdV0g5vkBcGavVJJrBaewhzNc9Hq+
 xUu9YKrCIB3CM68HLotqfmgrqEPbwsiUQTt9sdLnJDIIzpMczwZl2sFPXQwj+tPL4RLd
 mi+LCYuJCjDBlbuwK/eNAyrVsDwWGROFC8xSWAz9fv7ajnQZhUYtyzr5nCL+xh1NHZ8d
 2nBIljGKdYXvhpRo0/jbwCcrkTNkW49t1QvQvCZ27Y9j2YkE82Ti1bITeBlmTCc4b7Ic
 5brt07Ryoj1lmL+3MKR5Naifjug46a67f/H91tIbp0Ry+5r4Yelrz3sB6DFAp/WukHB7
 L90g==
X-Gm-Message-State: ANhLgQ3EFIdf7riy3UgWzFw6AVo00u7PdgwGKrJpGNBqweqfm1Evo/e4
 2LNqtfd+dnMXcjEziEprT7fK/cIsWDXfUgV/rJNauy+6TiSHrTKgZQVPGe44nG0WKFRBy97kHko
 FWE2kiu2mUjNuCyA=
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr535852wmk.160.1584384727478; 
 Mon, 16 Mar 2020 11:52:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvoJUVwD0BxKlnO6sB3V8r22Mhun1i+av8ikletTQazuOpWsoxjcRElP92FIznS3RwH5tSC3g==
X-Received: by 2002:a7b:c5d9:: with SMTP id n25mr535833wmk.160.1584384727293; 
 Mon, 16 Mar 2020 11:52:07 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id v8sm1166744wrw.2.2020.03.16.11.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:52:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 23/25] hw/ppc/ppc405: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 19:50:04 +0100
Message-Id: <20200316185006.576-24-philmd@redhat.com>
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
Cc: "open list:ppc4xx" <qemu-ppc@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
index de93c40f1a..e6bffb9e1a 100644
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
2.21.1


