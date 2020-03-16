Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E8BC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F6CA206C0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gale8slg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F6CA206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxiA-0002K5-7B
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43795)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIU-0004zs-6Z
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIT-0000Wv-1f
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43879)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxIS-0000VN-Ss
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:29:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6PKvm39WMHGkOwAElWbBY5ZrDFHI3cu1c06ixH6pGI=;
 b=Gale8slgeI9an2bcgWytu6glLI6vjb36te8ZqhDdlFRhcFoK0xZu88SEBz5yh3YDWYDzG6
 r4w08vDri70O3b3xPU0tVJ3Y56532QLD3lQLF3sjpv2m8M4HYxkjarruE3QbB/HS7Rk/1U
 d5pDYL2OpRkvV758UNHsAoZmwl8spHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-cfAM7r9iMHiYnsP8T4tSlw-1; Mon, 16 Mar 2020 17:29:12 -0400
X-MC-Unique: cfAM7r9iMHiYnsP8T4tSlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6A7A800EBC
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:29:11 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B2CE319C4F;
 Mon, 16 Mar 2020 21:29:08 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 56/61] hw/riscv: Let devices own the MemoryRegion they create
Date: Mon, 16 Mar 2020 22:27:23 +0100
Message-Id: <1584394048-44994-57-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Avoid orphan memory regions being added in the /unattached QOM
container.

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/riscv/sifive_e.c | 6 +++---
 hw/riscv/sifive_u.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
index a1974ef..646553a 100644
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
@@ -208,7 +208,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev=
, Error **errp)
         memmap[SIFIVE_E_PWM2].base, memmap[SIFIVE_E_PWM2].size);
=20
     /* Flash memory */
-    memory_region_init_rom(&s->xip_mem, NULL, "riscv.sifive.e.xip",
+    memory_region_init_rom(&s->xip_mem, OBJECT(dev), "riscv.sifive.e.xip",
                            memmap[SIFIVE_E_XIP].size, &error_fatal);
     memory_region_add_subregion(sys_mem, memmap[SIFIVE_E_XIP].base,
         &s->xip_mem);
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 156a003..662d42a 100644
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
--=20
1.8.3.1



