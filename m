Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB0C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:11:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45A1207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CGReUHVs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45A1207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlG9-0001Z2-AF
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:11:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49722)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkKw-0000lX-EQ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkKv-0000Na-8s
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26674
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkKv-0000NG-5h
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zjNS95uc7AhBhlRJHq5s8Vl+WFTInn7spO/tnWuOWEw=;
 b=CGReUHVsGJwdD9e5P1nbJoeiJXm3spyxMMEtDOhUFIHaWaYQq9apLErYdj9Wcx9qxcvHgN
 FNmeiEvdtS5CxZysXpJrSkB7JGgMCmXNJl6lDHf7kLDaTFMB2KB/iIYESVBvNDWBpeI00N
 78OTfPmR7BrMvoRXaPe0XPGr6p4FBzs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-RtuYjqbhMlyyt-pwWUQfFw-1; Wed, 15 Jan 2020 10:11:57 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E434E109E407;
 Wed, 15 Jan 2020 15:11:55 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E8A8619757;
 Wed, 15 Jan 2020 15:11:54 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 63/86] ppc:pnv: use memdev for RAM
Date: Wed, 15 Jan 2020 16:07:18 +0100
Message-Id: <1579100861-73692-64-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: RtuYjqbhMlyyt-pwWUQfFw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-ppc@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au
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
---
CC: clg@kaod.org
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
---
 hw/ppc/pnv.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e2735bb..a85a5fc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -676,7 +676,6 @@ static void pnv_init(MachineState *machine)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(machine);
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
-    MemoryRegion *ram;
     char *fw_filename;
     long fw_size;
     int i;
@@ -688,11 +687,7 @@ static void pnv_init(MachineState *machine)
     if (machine->ram_size < (1 * GiB)) {
         warn_report("skiboot may not work with < 1GB of RAM");
     }
-
-    ram =3D g_new(MemoryRegion, 1);
-    memory_region_allocate_system_memory(ram, NULL, "pnv.ram",
-                                         machine->ram_size);
-    memory_region_add_subregion(get_system_memory(), 0, ram);
+    memory_region_add_subregion(get_system_memory(), 0, machine->ram);
=20
     /*
      * Create our simple PNOR device
@@ -1785,6 +1780,7 @@ static void pnv_machine_class_init(ObjectClass *oc, v=
oid *data)
      * enough to fit the maximum initrd size at it's load address
      */
     mc->default_ram_size =3D INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
+    mc->default_ram_id =3D "pnv.ram";
     ispc->print_info =3D pnv_pic_print_info;
 }
=20
--=20
2.7.4


