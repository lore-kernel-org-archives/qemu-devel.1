Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F95C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:54:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25EB320661
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 15:54:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/uHmGt7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25EB320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixYcg-0004Lg-6G
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 10:54:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39913)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ixXys-0005Ka-8V
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ixXyr-0005YE-BX
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ixXyr-0005Wi-7X
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 10:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580483592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N5dK9wKgEZzA+7aNL3OJSRdYpKQmq/nb/tAWzoaID24=;
 b=Y/uHmGt78zyZNLAPcvPXLU1TjC4sKszqXIZwMIAe9RhzDQlj+RlLw0CT0Q7z3YmhVsspON
 qDfOKKQrglkyw0ypkDIwvIVLOKICWs6JUjAlRy9Qu0lXdfgHGzCIqVbWcnzBszLIudg/Rp
 13v4QlZJG2/Qe99vUBRvaAzOXRnJ9Tk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-PSeOSQcLOtKBilb2NVZzjA-1; Fri, 31 Jan 2020 10:13:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5AB518C43C0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:09 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF1D86C4B
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2020 15:13:09 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 49/80] m68k/next-cube: use memdev for RAM
Date: Fri, 31 Jan 2020 16:09:19 +0100
Message-Id: <1580483390-131164-50-git-send-email-imammedo@redhat.com>
In-Reply-To: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: PSeOSQcLOtKBilb2NVZzjA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

memory_region_allocate_system_memory() API is going away, so
replace it with memdev allocated MemoryRegion. The later is
initialized by generic code, so board only needs to opt in
to memdev scheme by providing
  MachineClass::default_ram_id
and using MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 hw/m68k/next-cube.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e534334..cd93d9e 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -860,7 +860,6 @@ static void next_cube_init(MachineState *machine)
 {
     M68kCPU *cpu;
     CPUM68KState *env;
-    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
     MemoryRegion *rom =3D g_new(MemoryRegion, 1);
     MemoryRegion *mmiomem =3D g_new(MemoryRegion, 1);
     MemoryRegion *scrmem =3D g_new(MemoryRegion, 1);
@@ -893,8 +892,7 @@ static void next_cube_init(MachineState *machine)
     memcpy(ns->rtc.ram, rtc_ram2, 32);
=20
     /* 64MB RAM starting at 0x04000000  */
-    memory_region_allocate_system_memory(ram, NULL, "next.ram", ram_size);
-    memory_region_add_subregion(sysmem, 0x04000000, ram);
+    memory_region_add_subregion(sysmem, 0x04000000, machine->ram);
=20
     /* Framebuffer */
     dev =3D qdev_create(NULL, TYPE_NEXTFB);
@@ -967,6 +965,7 @@ static void next_machine_class_init(ObjectClass *oc, vo=
id *data)
     mc->desc =3D "NeXT Cube";
     mc->init =3D next_cube_init;
     mc->default_ram_size =3D RAM_SIZE;
+    mc->default_ram_id =3D "next.ram";
     mc->default_cpu_type =3D M68K_CPU_TYPE_NAME("m68040");
 }
=20
--=20
2.7.4


