Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A5EC33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:10:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C4A214AF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ghj5MQ/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C4A214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56440 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlFC-0000DE-LK
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:10:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkL4-0000zH-4k
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkL2-0000UV-7E
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:10 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22523
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkL2-0000Sq-1c
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7/tKdqv8NSQDBGn/UcnwQ41bkab2+yfmpSVp40RoQA=;
 b=ghj5MQ/OKAA7CMPE7ncZglv7fBop3WGsOYywdbzVGtZFucarNipiEMdpTLhOk3ZLhG7cWj
 1Oqs5hTDMStobNRUN9f1EeVFXPbJZsPSkSfwRikY3XWA+k/kmU3AVPMyTHABQPmwCp5PN+
 BS7xpoqLLGZpkIy7wx1sZGWEIvwPIIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-TBxA8Ou7MPu_9FkLl1OzOg-1; Wed, 15 Jan 2020 10:12:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1664E113FF9B;
 Wed, 15 Jan 2020 15:12:00 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72002196AE;
 Wed, 15 Jan 2020 15:11:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 66/86] ppc/{ppc440_bamboo,sam460x}: drop RAM size fixup
Date: Wed, 15 Jan 2020 16:07:21 +0100
Message-Id: <1579100861-73692-67-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: TBxA8Ou7MPu_9FkLl1OzOg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported or sometimes
crash like this:
  %QEMU -M bamboo -m 1
    exec.c:1926: find_ram_offset: Assertion `size !=3D 0' failed.
    Aborted (core dumped)
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.
That also fixes crash issue, since wrongly calculated size
isn't used to allocate RAM

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
v2:
  * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
     (BALATON Zoltan <balaton@eik.bme.hu>)
  * print possible valid ram size id not all RAM was distributed
  * initialize ram_bases/ram_bases at the same time we are checking
    that user supplied RAM would fit available banks and drop nested
    loop that were duplicating the same calculations.
  * coincidentally fix crash when -m is less than minimal bank size

CC: balaton@eik.bme.hu
CC: david@gibson.dropbear.id.au
CC: qemu-ppc@nongnu.org
---
 include/hw/ppc/ppc4xx.h |  9 ++++----
 hw/ppc/ppc440_bamboo.c  | 11 ++++------
 hw/ppc/ppc4xx_devs.c    | 56 +++++++++++++++++++++++++--------------------=
----
 hw/ppc/sam460ex.c       |  5 ++---
 4 files changed, 39 insertions(+), 42 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 7d82259..103c875 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -42,11 +42,10 @@ enum {
 qemu_irq *ppcuic_init (CPUPPCState *env, qemu_irq *irqs,
                        uint32_t dcr_base, int has_ssr, int has_vr);
=20
-ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
-                               MemoryRegion ram_memories[],
-                               hwaddr ram_bases[],
-                               hwaddr ram_sizes[],
-                               const ram_addr_t sdram_bank_sizes[]);
+void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
+                       MemoryRegion ram_memories[],
+                       hwaddr ram_bases[], hwaddr ram_sizes[],
+                       const ram_addr_t sdram_bank_sizes[]);
=20
 void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         MemoryRegion ram_memories[],
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index b782641..c162598 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -158,7 +158,6 @@ static void main_cpu_reset(void *opaque)
=20
 static void bamboo_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -203,10 +202,8 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ram_size =3D ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
-                                   ram_memories,
-                                   ram_bases, ram_sizes,
-                                   ppc440ep_sdram_bank_sizes);
+    ppc4xx_sdram_prep(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
+                      ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0=
. */
     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
                       ram_bases, ram_sizes, 1);
@@ -268,7 +265,7 @@ static void bamboo_init(MachineState *machine)
     /* Load initrd. */
     if (initrd_filename) {
         initrd_size =3D load_image_targphys(initrd_filename, RAMDISK_ADDR,
-                                          ram_size - RAMDISK_ADDR);
+                                          machine->ram_size - RAMDISK_ADDR=
);
=20
         if (initrd_size < 0) {
             error_report("could not load ram disk '%s' at %x",
@@ -279,7 +276,7 @@ static void bamboo_init(MachineState *machine)
=20
     /* If we're loading a kernel directly, we must load the device tree to=
o. */
     if (kernel_filename) {
-        if (bamboo_load_device_tree(FDT_ADDR, ram_size, RAMDISK_ADDR,
+        if (bamboo_load_device_tree(FDT_ADDR, machine->ram_size, RAMDISK_A=
DDR,
                                     initrd_size, kernel_cmdline) < 0) {
             error_report("couldn't load device tree");
             exit(1);
diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
index c2e5013..92d33a4 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -673,16 +673,16 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
  * The 4xx SDRAM controller supports a small number of banks, and each ban=
k
  * must be one of a small set of sizes. The number of banks and the suppor=
ted
  * sizes varies by SoC. */
-ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
-                               MemoryRegion ram_memories[],
-                               hwaddr ram_bases[],
-                               hwaddr ram_sizes[],
-                               const ram_addr_t sdram_bank_sizes[])
+void ppc4xx_sdram_prep(ram_addr_t ram_size, int nr_banks,
+                       MemoryRegion ram_memories[],
+                       hwaddr ram_bases[], hwaddr ram_sizes[],
+                       const ram_addr_t sdram_bank_sizes[])
 {
     MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     ram_addr_t size_left =3D ram_size;
     ram_addr_t base =3D 0;
     ram_addr_t bank_size;
+    int last_bank =3D 0;
     int i;
     int j;
=20
@@ -690,7 +690,11 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, in=
t nr_banks,
         for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
             bank_size =3D sdram_bank_sizes[j];
             if (bank_size <=3D size_left) {
+                ram_bases[i] =3D base;
+                ram_sizes[i] =3D bank_size;
+                base +=3D bank_size;
                 size_left -=3D bank_size;
+                last_bank =3D i;
             }
         }
         if (!size_left) {
@@ -699,34 +703,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, i=
nt nr_banks,
         }
     }
=20
-    ram_size -=3D size_left;
     if (size_left) {
-        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
-                     " controller limits", ram_size / MiB);
+        ram_addr_t used_size =3D ram_size - size_left;
+        GString *s =3D g_string_new(NULL);
+
+        for (i =3D 0; sdram_bank_sizes[i]; i++) {
+            g_string_append_printf(s, "%" PRIi64 "%s",
+                                   sdram_bank_sizes[i] / MiB,
+                                   sdram_bank_sizes[i + 1] ? " ," : "");
+        }
+        error_report("Max %d banks of %s MB DIMM/bank supported",
+            nr_banks, s->str);
+        error_report("Possible valid RAM size: %" PRIi64,
+            used_size ? used_size / MiB : sdram_bank_sizes[i - 1] / MiB);
+
+        g_string_free(s, true);
+        exit(EXIT_FAILURE);
     }
=20
     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_si=
ze);
=20
-    size_left =3D ram_size;
-    for (i =3D 0; i < nr_banks && size_left; i++) {
-        for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
-            bank_size =3D sdram_bank_sizes[j];
-
-            if (bank_size <=3D size_left) {
-                char name[32];
-                snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
-                memory_region_init_alias(&ram_memories[i], NULL, name, ram=
,
-                                         base, bank_size);
-                ram_bases[i] =3D base;
-                ram_sizes[i] =3D bank_size;
-                base +=3D bank_size;
-                size_left -=3D bank_size;
-                break;
-            }
-        }
+    for (i =3D 0; i <=3D last_bank; i++) {
+        char name[32];
+        snprintf(name, sizeof(name), "ppc4xx.sdram%d", i);
+        memory_region_init_alias(&ram_memories[i], NULL, name, ram,
+                                 ram_bases[i], ram_sizes[i]);
     }
-
-    return ram_size;
 }
=20
 /*************************************************************************=
****/
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 437e214..ec7ac1f 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size, 1,
-                                   ram_memories, ram_bases, ram_sizes,
-                                   ppc460ex_sdram_bank_sizes);
+    ppc4xx_sdram_prep(machine->ram_size, 1, ram_memories, ram_bases, ram_s=
izes,
+                      ppc460ex_sdram_bank_sizes);
=20
     /* FIXME: does 460EX have ECC interrupts? */
     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
--=20
2.7.4


