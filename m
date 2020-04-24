Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E662BC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:27:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE56720857
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VsV4S2lz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE56720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3z5-0002pS-Pw
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:27:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52992)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sO-0003VF-EG
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sN-00045e-UQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:40 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32892
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jS3sN-000454-EQ
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587756037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hUT/cU4Bd/vQ2eU3ozZI3eDINyvVVCGQcwfYZ9hnxlk=;
 b=VsV4S2lz9YOTbqh7UtpN7EjoHgBTSEdZioEmBrIIKltMlke72fc+EMyF7fy6f5cxy0vLx3
 Be1yI1ZOtm3BlzBEQxvufUAVP/j9fvo/TEDqZrzvzoDc9v0Qe2oBobz552baYnosHJ3Lrc
 mcDnCu+FqdjfU0rqp1dywZcOhxC6Skw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-Fnp2PKMzPcuEGJe5uuQNuw-1; Fri, 24 Apr 2020 15:20:34 -0400
X-MC-Unique: Fnp2PKMzPcuEGJe5uuQNuw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B0484B8A2;
 Fri, 24 Apr 2020 19:20:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5CD15D9CC;
 Fri, 24 Apr 2020 19:20:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4490F11358C5; Fri, 24 Apr 2020 21:20:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 09/11] mips/boston: Plug memory leak in boston_mach_init()
Date: Fri, 24 Apr 2020 21:20:25 +0200
Message-Id: <20200424192027.11404-10-armbru@redhat.com>
In-Reply-To: <20200424192027.11404-1-armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 13:45:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fixes: df1d8a1f29f567567b9d20be685a4241282e7005
Cc: Paul Burton <pburton@wavecomp.com>
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/mips/boston.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 2832dfa6ae..a896056be1 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -426,7 +426,6 @@ static void boston_mach_init(MachineState *machine)
 {
     DeviceState *dev;
     BostonState *s;
-    Error *err =3D NULL;
     MemoryRegion *flash, *ddr_low_alias, *lcd, *platreg;
     MemoryRegion *sys_mem =3D get_system_memory();
     XilinxPCIEHost *pcie2;
@@ -467,7 +466,8 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
=20
     flash =3D  g_new(MemoryRegion, 1);
-    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB, &err);
+    memory_region_init_rom(flash, NULL, "boston.flash", 128 * MiB,
+                           &error_fatal);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
=20
     memory_region_add_subregion_overlap(sys_mem, 0x80000000, machine->ram,=
 0);
--=20
2.21.1


