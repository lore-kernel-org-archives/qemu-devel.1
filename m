Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9906C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:35:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7525A24655
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRY/vK0A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7525A24655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iubhU-0003tp-CT
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 07:35:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36333)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iuatg-0008Iu-DK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iuate-00059a-RB
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:40 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22726
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iuate-00058q-Mh
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:43:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579779818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wf3kyqw/t+gCM0ccU30bUDQQt5xR3px+LmkdFS3wH18=;
 b=XRY/vK0AZ6Mk7oof5Mjj/itSsrR5jk+PmethxAx1LCm3UJZd5pPQiZmfsqmZAsbP+tnVDE
 3rDI1psDrzgkGmWN4cwulpqldR+tPMVX2Nnme6HVjumWXR1IlFUPTIryJwj+XQE6/M6gzz
 ZjCJjvYaLeue+UAbrRPb2o3j0jYsPoI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-9R5Kt5U-N3my55I1kzuwSw-1; Thu, 23 Jan 2020 06:43:34 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30627DB22;
 Thu, 23 Jan 2020 11:43:33 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 35E8010016E8;
 Thu, 23 Jan 2020 11:43:32 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH REPOST v3 65/80] ppc/{ppc440_bamboo,
 sam460ex}: use memdev for RAM
Date: Thu, 23 Jan 2020 12:38:30 +0100
Message-Id: <1579779525-20065-66-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 9R5Kt5U-N3my55I1kzuwSw-1
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
v3:
  * drop ram_size from comment above ppc4xx_sdram_banks
     (BALATON Zoltan <balaton@eik.bme.hu>)
  * move memory alias initialization into the same loop
    where RAM is split on banks.
     (BALATON Zoltan <balaton@eik.bme.hu>)
v3.1
  * rebase on top of previous patch due to changed context

CC: balaton@eik.bme.hu
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
---
 include/hw/ppc/ppc4xx.h |  2 +-
 hw/ppc/ppc440_bamboo.c  |  3 ++-
 hw/ppc/ppc4xx_devs.c    | 25 +++++++++----------------
 hw/ppc/sam460ex.c       |  3 ++-
 4 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index b8c8f32..cc19c8d 100644
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
index 29a9642..1d4a11d 100644
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
index d89008a..0e2f81c 100644
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
index 949acba..b48aea5 100644
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


