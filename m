Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B080C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 564022187F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 15:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUG5duDz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 564022187F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irkyP-00024j-DI
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 10:52:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49855)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkL4-0000yj-1N
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkL2-0000UJ-3G
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43014
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkL1-0000TM-VG
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFocPLsxX9YDrZFgytvz47uLlKHKZTB5GR32HEzkFic=;
 b=CUG5duDznqksMScEGpS4vdumowKy0Dj6d475X4Mfan91UTFr5NStze/60uWs1nvJ0/zYUB
 KZuEKAMP1VMnQHGPLqewJL9oKfgE756gPgPQtEcjrCzlRitdId/3FJ8XMod0N1SMMmZYxv
 iDiLzrxd3tu34C//J8RdjkvqSnkCtHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-90E9P1BiOqmnzcKzLjtx2Q-1; Wed, 15 Jan 2020 10:12:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 58D621140DA5;
 Wed, 15 Jan 2020 15:12:01 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E1A219757;
 Wed, 15 Jan 2020 15:12:00 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 67/86] ppc:ppc440_bamboo/sam460ex: use memdev for RAM
Date: Wed, 15 Jan 2020 16:07:22 +0100
Message-Id: <1579100861-73692-68-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 90E9P1BiOqmnzcKzLjtx2Q-1
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org
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
CC: balaton@eik.bme.hu
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
---
 include/hw/ppc/ppc4xx.h | 2 +-
 hw/ppc/ppc440_bamboo.c  | 3 ++-
 hw/ppc/ppc4xx_devs.c    | 9 +++------
 hw/ppc/sam460ex.c       | 3 ++-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 103c875..f0bef46 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -42,7 +42,7 @@ enum {
 qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
                        uint32_t dcr_base, int has_ssr, int has_vr);
=20
-void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_prep(MemoryRegion *ram, int nr_banks,
                        MemoryRegion ram_memories[],
                        hwaddr ram_bases[], hwaddr ram_sizes[],
                        const ram_addr_t sdram_bank_sizes[]);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index c162598..cb4a1ad 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -202,7 +202,7 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ppc4xx_sdram_prep(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
+    ppc4xx_sdram_prep(machine->ram, PPC440EP_SDRAM_NR_BANKS, ram_memories,
                       ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0=
. */
     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
@@ -289,6 +289,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->desc =3D "bamboo";
     mc->init =3D bamboo_init;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440epb");
+    mc->default_ram_id =3D "ppc4xx.sdram";
 }
=20
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 92d33a4..9c3762d 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -673,13 +673,12 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
  * The 4xx SDRAM controller supports a small number of banks, and each ban=
k
  * must be one of a small set of sizes. The number of banks and the suppor=
ted
  * sizes varies by SoC. */
-void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_prep(MemoryRegion *ram, int nr_banks,
                        MemoryRegion ram_memories[],
                        hwaddr ram_bases[], hwaddr ram_sizes[],
                        const ram_addr_t sdram_bank_sizes[])
 {
-    MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
-    ram_addr_t size_left =3D ram_size;
+    ram_addr_t size_left =3D memory_region_size(ram);
     ram_addr_t base =3D 0;
     ram_addr_t bank_size;
     int last_bank =3D 0;
@@ -704,7 +703,7 @@ void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_bank=
s,
     }
=20
     if (size_left) {
-        ram_addr_t used_size =3D ram_size - size_left;
+        ram_addr_t used_size =3D memory_region_size(ram) - size_left;
         GString *s =3D g_string_new(NULL);
=20
         for (i =3D 0; sdram_bank_sizes[i]; i++) {
@@ -721,8 +720,6 @@ void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_bank=
s,
         exit(EXIT_FAILURE);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_si=
ze);
-
     for (i =3D 0; i <=3D last_bank; i++) {
         char name[32];
         snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index ec7ac1f..8d27a3f 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,7 +324,7 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    ppc4xx_sdram_prep(machine->ram_size, 1, ram_memories, ram_bases, ram_s=
izes,
+    ppc4xx_sdram_prep(machine->ram, 1, ram_memories, ram_bases, ram_sizes,
                       ppc460ex_sdram_bank_sizes);
=20
     /* FIXME: does 460EX have ECC interrupts? */
@@ -483,6 +483,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->init =3D sam460ex_init;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size =3D 512 * MiB;
+    mc->default_ram_id =3D "ppc4xx.sdram";
 }
=20
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
--=20
2.7.4


