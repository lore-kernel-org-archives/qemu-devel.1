Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9ABC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:19:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5253A20674
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjSL3PLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5253A20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvHF-0000aB-Hs
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDuu7-0002As-Sd
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDuu6-0005W3-Jt
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:55:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDuu6-0005Ta-FU
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 14:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584384958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DAKyL7Tqa+fBdxrFOnKvFsx39GH2EjqIV6ZKoapzE/Q=;
 b=GjSL3PLrj9fAmuW+nx2MGrmE32jaQgDv9dojpDR6vLOlBAJ0U3Td7LSNDDhdNm0lDO4Uly
 SOjbXuZTmFJO6DIWEE/PSclvyECOHxGxA1zhd0Zuh3neICxUW2Q0QKTn+TCBWQDLmIMM8h
 pnCy3RvsakUeU7pADFCLa1cE5bUCpOE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-_6iVTF7mM-KFfMqd3opASg-1; Mon, 16 Mar 2020 14:55:56 -0400
X-MC-Unique: _6iVTF7mM-KFfMqd3opASg-1
Received: by mail-wm1-f71.google.com with SMTP id n25so4985680wmi.5
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 11:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kHrh7HRUxq+j6HbASfjSpjwX0NBi+3mUfkSXhbTFwJw=;
 b=KUCXkNWhFFloUjiSw7rNJGnd7VsGA5iBBFFUfqCPxZyfuwS4m6M4yaElMKSILtPnY0
 kkwThhSB2VqQuLnt+paDadf8EDJwnJLhGc1ij9AkfeFaqPOh9QEkqqYk5RTrhzFePP5b
 LqXOQuSqGnEfNzmHhlgfypRYCVPG2t0f9rIehQdUiKRyQcUw3DZsozpv4qxwA5dRxd1k
 lSg1mepNpVnp3v9U4rsgE67GCZPsWwG+PrkgBWuZ/XHe26z+zKMKwLvJf4+dUW4D0U7Q
 DiBzqrA18HQr6i7jbw0egI9rUNAzzcZzPmabwi9OZd2O2wC3Vj8P+L62qN7ShfOuxRpu
 hN/g==
X-Gm-Message-State: ANhLgQ1VPRLuWNtwZLoni4PF0VfWIPwA0uiuySDJJQwfBtMkRphRjCwm
 P0S68sJ3koh05abTMQttbBOgI2hNvvnY3oqhYM02zNqJljICmL0gshgsd8E5da+5mz4HJ9bADzx
 heWl8mJkPZ42DRco=
X-Received: by 2002:a5d:5090:: with SMTP id a16mr771486wrt.191.1584384639541; 
 Mon, 16 Mar 2020 11:50:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsnjqSjZ0/ioyXpDCNFGMeNZtB/AcCe7pOm2OH3Lx5oF5X62lXQNhyzJTltZ/cUHzDv3+1buw==
X-Received: by 2002:a5d:5090:: with SMTP id a16mr771474wrt.191.1584384639375; 
 Mon, 16 Mar 2020 11:50:39 -0700 (PDT)
Received: from localhost.localdomain (96.red-83-59-163.dynamicip.rima-tde.net.
 [83.59.163.96])
 by smtp.gmail.com with ESMTPSA id b10sm1100611wrm.30.2020.03.16.11.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 11:50:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v3 06/25] hw/display: Use memory_region_init_rom() with
 read-only regions
Date: Mon, 16 Mar 2020 19:49:47 +0100
Message-Id: <20200316185006.576-7-philmd@redhat.com>
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
 [fuzzy]
X-Received-From: 216.205.24.74
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
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/display/cg3.c | 5 ++---
 hw/display/tcx.c | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index 4fb67c6b1c..a1ede10394 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -287,9 +287,8 @@ static void cg3_initfn(Object *obj)
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     CG3State *s =3D CG3(obj);
=20
-    memory_region_init_ram_nomigrate(&s->rom, obj, "cg3.prom", FCODE_MAX_R=
OM_SIZE,
-                           &error_fatal);
-    memory_region_set_readonly(&s->rom, true);
+    memory_region_init_rom_nomigrate(&s->rom, obj, "cg3.prom",
+                                     FCODE_MAX_ROM_SIZE, &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
=20
     memory_region_init_io(&s->reg, obj, &cg3_reg_ops, s, "cg3.reg",
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index ca458f94fe..76de16e8ea 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -755,9 +755,8 @@ static void tcx_initfn(Object *obj)
     SysBusDevice *sbd =3D SYS_BUS_DEVICE(obj);
     TCXState *s =3D TCX(obj);
=20
-    memory_region_init_ram_nomigrate(&s->rom, obj, "tcx.prom", FCODE_MAX_R=
OM_SIZE,
-                           &error_fatal);
-    memory_region_set_readonly(&s->rom, true);
+    memory_region_init_rom_nomigrate(&s->rom, obj, "tcx.prom",
+                                     FCODE_MAX_ROM_SIZE, &error_fatal);
     sysbus_init_mmio(sbd, &s->rom);
=20
     /* 2/STIP : Stippler */
--=20
2.21.1


