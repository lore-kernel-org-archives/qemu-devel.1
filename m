Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D3C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:33:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE83206E2
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 16:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GdZXc/6V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE83206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4SHg-0004wa-Sq
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 11:33:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw9-0003sN-IH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j4Rw8-00011Y-Ce
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33699
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j4Rw8-00011D-8f
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 11:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582128655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I1FJzf/4rzqFwbobu1ahrpu+97R1R5qzA8eDq0+8jXo=;
 b=GdZXc/6VERET4k21fXhcw4G64eXs9eTv1SSsbu4rbdBodegENyJY28SrTf4QuPPOQ7XJUW
 sCvPiiXGXidAYJgoGT9Vjt9M8IUEs1ADhzHnd5qWWITVRX0h8vzFSWkViphLwYrag3bpBg
 tMRvpP6IkRbol1/wA9+sUMWbCeWbge0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-ukAtlxiCOKGJgQAbPRjrTA-1; Wed, 19 Feb 2020 11:10:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6000810A48B3
 for <qemu-devel@nongnu.org>; Wed, 19 Feb 2020 16:10:51 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AEE088ED00;
 Wed, 19 Feb 2020 16:10:50 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 47/79] m68k/q800: use memdev for RAM
Date: Wed, 19 Feb 2020 11:09:21 -0500
Message-Id: <20200219160953.13771-48-imammedo@redhat.com>
In-Reply-To: <20200219160953.13771-1-imammedo@redhat.com>
References: <20200219160953.13771-1-imammedo@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: ukAtlxiCOKGJgQAbPRjrTA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch to using generic main RAM allocation. To do this set
MachineClass::default_ram_id to m68k_mac.ram and use
MachineState::ram instead of manually initializing
RAM memory region.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Acked-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/m68k/q800.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1e32363688..a4c4bc14cb 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -160,7 +160,6 @@ static void q800_init(MachineState *machine)
     ram_addr_t initrd_base;
     int32_t initrd_size;
     MemoryRegion *rom;
-    MemoryRegion *ram;
     MemoryRegion *io;
     const int io_slice_nb =3D (IO_SIZE / IO_SLICE) - 1;
     int i;
@@ -194,9 +193,7 @@ static void q800_init(MachineState *machine)
     qemu_register_reset(main_cpu_reset, cpu);
=20
     /* RAM */
-    ram =3D g_malloc(sizeof(*ram));
-    memory_region_init_ram(ram, NULL, "m68k_mac.ram", ram_size, &error_abo=
rt);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
=20
     /*
      * Memory from IO_BASE to IO_BASE + IO_SLICE is repeated
@@ -443,6 +440,7 @@ static void q800_machine_class_init(ObjectClass *oc, vo=
id *data)
     mc->max_cpus =3D 1;
     mc->is_default =3D 0;
     mc->block_default_type =3D IF_SCSI;
+    mc->default_ram_id =3D "m68k_mac.ram";
 }
=20
 static const TypeInfo q800_machine_typeinfo =3D {
--=20
2.18.1


