Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45ADC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C618206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 17:37:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WZtsBo62"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C618206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5CF0-00068Z-RR
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 12:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j5C8s-0006Ix-5M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j5C8q-00081s-Ut
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29710
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j5C8q-00081Z-QG
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 12:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582306268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5SCSWK+x3Mgxa8dMA1mlI9fXFXh3qxL+ElfqjZu1bX0=;
 b=WZtsBo62pOqsEOLGDP5B9xiOJacChv6pBFCBrUinOizltsIlwh7BCPOk64iHwznWjnfYSd
 Vqv85NSk+191WiBUeajJ45Ie0/1LxIJslnRtyZT2eDcnJiYSJitI1DbTy9doUURVR5XMS7
 X8raF3pBAZbUXhTNWxWYNyrNEy6ldr0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-suUOqT6dN0KxFDFXFGzS8A-1; Fri, 21 Feb 2020 12:31:06 -0500
X-MC-Unique: suUOqT6dN0KxFDFXFGzS8A-1
Received: by mail-wr1-f71.google.com with SMTP id 90so1320202wrq.6
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 09:31:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uT16+Xkl8LuYgM/9VDKdGjve7Io5iSq3xRh//xaioN4=;
 b=YwmCCQ3z27xnQxGc70nCEbamBJJuFFWipRE0nWJEoLH+2/IYOeEjBlA4Ztt+iWvQx4
 cs46pHt6AEuiKA76F7os6+wEJqgG1BKgp1vvMmo8QYMRqSJDInTcUVBpDN8gKexO5nBm
 NlufNFzB4qYFKqqztrnhxS7mAMDmjDlwOupoyDiUa8dUf2PE77sCsih4XSk6qd5EvIk4
 tZvDKF8RZUx6k1VvVLZ3oeJAWMiMBx9T2bC8fTq2mhNBSb7KoR1fkF0lMPJE37obNpKA
 QodBSAIvK/6rTf++/ehupuxnC/YJxLLR/vush+FsqLYNyrn1t3QBjmnBb79AmcUTlUM+
 bMVg==
X-Gm-Message-State: APjAAAUM8AzxuQGrHwcXgHc4EPa8XDus7mbZB4e4LHUENslOO8J/R0eS
 OU9pLPgWFYUGpl9wf4Hxxk6yZMlr5+dJYBfYRU/mcgAkxOxsFKtmM3Kwh0LQsvYdb7vW3kIZyDB
 tGjspfSXVvP3revs=
X-Received: by 2002:a1c:f717:: with SMTP id v23mr5024094wmh.172.1582306265265; 
 Fri, 21 Feb 2020 09:31:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwPvt3TF/zPnf7stsTmNpxIiEO+ICSYWHDYXBQCMP2TTK3YwUaChff0LmYEe/BwApgSAvw4TQ==
X-Received: by 2002:a1c:f717:: with SMTP id v23mr5024074wmh.172.1582306265019; 
 Fri, 21 Feb 2020 09:31:05 -0800 (PST)
Received: from x1w.redhat.com (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id h18sm5000871wrv.78.2020.02.21.09.31.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 09:31:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] hw/riscv: Let devices own the MemoryRegion they create
Date: Fri, 21 Feb 2020 18:30:49 +0100
Message-Id: <20200221173049.18134-8-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200221173049.18134-1-philmd@redhat.com>
References: <20200221173049.18134-1-philmd@redhat.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>, qemu-riscv@nongnu.org,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Laurent Vivier <laurent@vivier.eu>, Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To avoid orphean memory regions being added in the /unattached
QOM container, use the memory_region_owner_nonnull.cocci script
to set the correct ownership.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/riscv/sifive_e.c | 8 ++++----
 hw/riscv/sifive_u.c | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index 8a6b0348df..583015c247 100644
--- a/hw/riscv/sifive_e.c
+++ b/hw/riscv/sifive_e.c
@@ -145,8 +145,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
                             &error_abort);
=20
     /* Mask ROM */
-    memory_region_init_rom(&s->mask_rom, NULL, "riscv.sifive.e.mrom",
-        memmap[SIFIVE_E_MROM].size, &error_fatal);
+    memory_region_init_rom(&s->mask_rom, OBJECT(dev), "riscv.sifive.e.mrom=
",
+                           memmap[SIFIVE_E_MROM].size, &error_fatal);
     memory_region_add_subregion(sys_mem,
         memmap[SIFIVE_E_MROM].base, &s->mask_rom);
=20
@@ -208,8 +208,8 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
=20
     /* Flash memory */
-    memory_region_init_ram(&s->xip_mem, NULL, "riscv.sifive.e.xip",
-        memmap[SIFIVE_E_XIP].size, &error_fatal);
+    memory_region_init_ram(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
+                           memmap[SIFIVE_E_XIP].size, &error_fatal);
     memory_region_set_readonly(&s->xip_mem, true);
     memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
         &s->xip_mem);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 0e12b3ccef..592830a3a2 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -497,7 +497,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev=
, Error **errp)
                              &error_abort);
=20
     /* boot rom */
-    memory_region_init_rom(mask_rom, NULL, "riscv.sifive.u.mrom",
+    memory_region_init_rom(mask_rom, OBJECT(dev), "riscv.sifive.u.mrom",
                            memmap[SIFIVE_U_MROM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_MROM].base,
                                 mask_rom);
@@ -511,7 +511,7 @@ static void riscv_sifive_u_soc_realize(DeviceState *dev=
, Error **errp)
      * leave it enabled all the time. This won't break anything, but will =
be
      * too generous to misbehaving guests.
      */
-    memory_region_init_ram(l2lim_mem, NULL, "riscv.sifive.u.l2lim",
+    memory_region_init_ram(l2lim_mem, OBJECT(dev), "riscv.sifive.u.l2lim",
                            memmap[SIFIVE_U_L2LIM].size, &error_fatal);
     memory_region_add_subregion(system_memory, memmap[SIFIVE_U_L2LIM].base=
,
                                 l2lim_mem);
--=20
2.21.1


