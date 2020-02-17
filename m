Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0492C34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7B22070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJSC6tsh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7B22070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kpu-00008x-OC
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:09:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38835)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJr-0003dB-QN
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJq-0002cx-9y
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:31 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46093
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJq-0002cd-60
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIvXF1g7RR3fK96YF93V0MMaB2ZgeTiydFjTSzEIFLU=;
 b=AJSC6tshh7sLG/3n+0G02kXDy1LltmCFYisQNhqoHYnRQE0HzAQgDxFQN+WVgGiNcHUYjK
 9+hmOf7ooySzLM1M0steVzD4CuWYtTjaxWFt/PrJzwl9Dm1++NUCf2eSBny34mn65KcF4D
 d6C+OFuagryzRscUrMe14Hr7ZnVMcDM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-EaSWewPcOxa5mGEziQAc4A-1; Mon, 17 Feb 2020 12:36:27 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0732DB22
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:26 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2901490533;
 Mon, 17 Feb 2020 17:36:26 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 66/79] ppc/{ppc440_bamboo, sam460ex}: use memdev for RAM
Date: Mon, 17 Feb 2020 12:34:39 -0500
Message-Id: <20200217173452.15243-67-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: EaSWewPcOxa5mGEziQAc4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
v3:
  * drop ram_size from comment above ppc4xx_sdram_banks
     (BALATON Zoltan <balaton@eik.bme.hu>)
  * move memory alias initialization into the same loop
    where RAM is split on banks.
     (BALATON Zoltan <balaton@eik.bme.hu>)
v3.1
  * rebase on top of previous patch due to changed context
---
 include/hw/ppc/ppc4xx.h |  2 +-
 hw/ppc/ppc440_bamboo.c  |  3 ++-
 hw/ppc/ppc4xx_devs.c    | 25 +++++++++----------------
 hw/ppc/sam460ex.c       |  3 ++-
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index b8c8f324b4..cc19c8da5b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -42,7 +42,7 @@ enum {
 qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
                        uint32_t dcr_base, int has_ssr, int has_vr);
=20
-void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
                         MemoryRegion ram_memories[],
                         hwaddr ram_bases[], hwaddr ram_sizes[],
                         const ram_addr_t sdram_bank_sizes[]);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 7e3bc0ec7f..4c5e9e4373 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -202,7 +202,7 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_mem=
ories,
+    ppc4xx_sdram_banks(machine->ram, PPC440EP_SDRAM_NR_BANKS, ram_memories=
,
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
index d89008a2a4..0e2f81c4f7 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -666,7 +666,7 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq,=
 int nbanks,
         sdram_map_bcr(sdram);
 }
=20
-/* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
+/* Split RAM between SDRAM banks.
  *
  * sdram_bank_sizes[] must be in descending order, that is sizes[i] > size=
s[i+1]
  * and must be 0-terminated.
@@ -674,16 +674,14 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
  * The 4xx SDRAM controller supports a small number of banks, and each ban=
k
  * must be one of a small set of sizes. The number of banks and the suppor=
ted
  * sizes varies by SoC. */
-void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_banks(MemoryRegion *ram, int nr_banks,
                         MemoryRegion ram_memories[],
                         hwaddr ram_bases[], hwaddr ram_sizes[],
                         const ram_addr_t sdram_bank_sizes[])
 {
-    MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
-    ram_addr_t size_left =3D ram_size;
+    ram_addr_t size_left =3D memory_region_size(ram);
     ram_addr_t base =3D 0;
     ram_addr_t bank_size;
-    int last_bank =3D 0;
     int i;
     int j;
=20
@@ -691,11 +689,15 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_b=
anks,
         for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
             bank_size =3D sdram_bank_sizes[j];
             if (bank_size <=3D size_left) {
+                char name[32];
+
                 ram_bases[i] =3D base;
                 ram_sizes[i] =3D bank_size;
                 base +=3D bank_size;
                 size_left -=3D bank_size;
-                last_bank =3D i;
+                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
+                memory_region_init_alias(&ram_memories[i], NULL, name, ram=
,
+                                         ram_bases[i], ram_sizes[i]);
                 break;
             }
         }
@@ -706,7 +708,7 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_ban=
ks,
     }
=20
     if (size_left) {
-        ram_addr_t used_size =3D ram_size - size_left;
+        ram_addr_t used_size =3D memory_region_size(ram) - size_left;
         GString *s =3D g_string_new(NULL);
=20
         for (i =3D 0; sdram_bank_sizes[i]; i++) {
@@ -722,15 +724,6 @@ void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_ba=
nks,
         g_string_free(s, true);
         exit(EXIT_FAILURE);
     }
-
-    memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_si=
ze);
-
-    for (i =3D 0; i <=3D last_bank; i++) {
-        char name[32];
-        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
-        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
-                                 ram_bases[i], ram_sizes[i]);
-    }
 }
=20
 /*************************************************************************=
****/
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 17d40bd672..898453cf30 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,7 +324,7 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_=
sizes,
+    ppc4xx_sdram_banks(machine->ram, 1, ram_memories, ram_bases, ram_sizes=
,
                        ppc460ex_sdram_bank_sizes);
=20
     /* FIXME: does 460EX have ECC interrupts? */
@@ -484,6 +484,7 @@ static void sam460ex_machine_init(MachineClass *mc)
     mc->init =3D sam460ex_init;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("460exb");
     mc->default_ram_size =3D 512 * MiB;
+    mc->default_ram_id =3D "ppc4xx.sdram";
 }
=20
 DEFINE_MACHINE("sam460ex", sam460ex_machine_init)
--=20
2.18.1


