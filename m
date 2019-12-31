Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6626DC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:47:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3222C206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 13:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bUroSu09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3222C206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imHrY-0001hY-Ok
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 08:47:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCb-0005zX-2c
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCZ-0004Z0-8S
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47044
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCY-0004Vd-VP
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g+h+u9gYsFlLicKSN4chMEr82/G6v49q6m4/6FD8tfI=;
 b=bUroSu09AYP9+eWsOxiYFHZAEscg7p3/o0FmKaiZG42r/CXrS2OfSrCxE80M4/Tdx3BtkW
 zGrSqnoOqaqN3umu+nrlCtugOefOoHzg8v3CsyxZ4JOMNPSYEIAgJQktPLiQg1Ke50Nwsb
 HSkEgZqTKLDFWuaH5RlUXxBYkyipG50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-NbmfB515PSarxNM-E3RmmA-1; Tue, 31 Dec 2019 08:04:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADDC4DB62
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:43 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3382C78E99
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:43 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 67/86] ppc:ppc440_bamboo/sam460ex: use memdev for RAM
Date: Tue, 31 Dec 2019 14:03:51 +0100
Message-Id: <1577797450-88458-68-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: NbmfB515PSarxNM-E3RmmA-1
X-Mimecast-Spam-Score: 0
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
---
 include/hw/ppc/ppc4xx.h | 2 +-
 hw/ppc/ppc440_bamboo.c  | 3 ++-
 hw/ppc/ppc4xx_devs.c    | 6 ++----
 hw/ppc/sam460ex.c       | 3 ++-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 1a28127..896b1b1 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -42,7 +42,7 @@ enum {
 qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
                        uint32_t dcr_base, int has_ssr, int has_vr);
=20
-void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_adjust(MemoryRegion *ram, int nr_banks,
                          MemoryRegion ram_memories[],
                          hwaddr ram_bases[], hwaddr ram_sizes[],
                          const ram_addr_t sdram_bank_sizes[]);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 66dee89..73e5b23 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -206,7 +206,7 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
+    ppc4xx_sdram_adjust(machine->ram, PPC440EP_SDRAM_NR_BANKS, ram_memorie=
s,
                         ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0=
. */
     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
@@ -293,6 +293,7 @@ static void bamboo_machine_init(MachineClass *mc)
     mc->desc =3D "bamboo";
     mc->init =3D bamboo_init;
     mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440epb");
+    mc->default_ram_id =3D "ppc4xx.sdram";
 }
=20
 DEFINE_MACHINE("bamboo", bamboo_machine_init)
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index 54af296..515e462 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -673,12 +673,12 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
  * The 4xx SDRAM controller supports a small number of banks, and each ban=
k
  * must be one of a small set of sizes. The number of banks and the suppor=
ted
  * sizes varies by SoC. */
-void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
+void ppc4xx_sdram_adjust(MemoryRegion *ram, int nr_banks,
                          MemoryRegion ram_memories[],
                          hwaddr ram_bases[], hwaddr ram_sizes[],
                          const ram_addr_t sdram_bank_sizes[])
 {
-    MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
+    ram_addr_t ram_size =3D memory_region_size(ram);
     ram_addr_t size_left =3D ram_size;
     ram_addr_t base =3D 0;
     ram_addr_t bank_size;
@@ -713,8 +713,6 @@ void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_ba=
nks,
         exit(EXIT_FAILURE);
     }
=20
-    memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_si=
ze);
-
     size_left =3D ram_size;
     for (i =3D 0; i < nr_banks && size_left; i++) {
         for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index f592816..2d75719 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,7 +324,7 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    ppc4xx_sdram_adjust(machine->ram_size, 1, ram_memories, ram_bases,
+    ppc4xx_sdram_adjust(machine->ram, 1, ram_memories, ram_bases,
                         ram_sizes, ppc460ex_sdram_bank_sizes);
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


