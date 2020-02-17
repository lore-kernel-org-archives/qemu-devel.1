Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE4AC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:14:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1762070B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bLMLFpEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1762070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kuR-0002Gu-O5
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:14:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38834)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kJr-0003dA-Py
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kJp-0002cj-Tp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27791
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kJp-0002cH-NV
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sHWMUFa73lTUQEd0sw2Y9Y0Wd20BoHklb9WnclL5faA=;
 b=bLMLFpEMkCBmqsBg8mgiScBiO1QpvMJQZ8ycBK5XX7rPWbjGaUT6Q5Zfb+NdIlcETEqIhl
 rUqWUYJ1+ZTPQQ8+6mdqMSHJ3IcKTJ2FSOTrZ+hI6oHrOtkVeYe6is0fDU/rkDolAVIZ6U
 B2+r4x/uy947JMYhtHY6rreotwfcaIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-fgnx6BP9MRqMTMlnR0Qk4A-1; Mon, 17 Feb 2020 12:36:26 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1BEF107ACC9
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 17:36:25 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D3F990508;
 Mon, 17 Feb 2020 17:36:25 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 65/79] ppc/{ppc440_bamboo, sam460ex}: drop RAM size fixup
Date: Mon, 17 Feb 2020 12:34:38 -0500
Message-Id: <20200217173452.15243-66-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: fgnx6BP9MRqMTMlnR0Qk4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
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
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
v2:
  * s/ppc4xx_sdram_adjust/ppc4xx_sdram_prep/
     (BALATON Zoltan <balaton@eik.bme.hu>)
  * print possible valid ram size id not all RAM was distributed
  * initialize ram_bases/ram_bases at the same time we are checking
    that user supplied RAM would fit available banks and drop nested
    loop that were duplicating the same calculations.
  * coincidentally fix crash when -m is less than minimal bank size
v3:
  * s/ppc4xx_sdram_prep/ppc4xx_sdram_banks/
      (BALATON Zoltan <balaton@eik.bme.hu>)
  * fix subject line in commit message
v3.1:
  * add lost 'break' statement in 'j' loop
v3.2:
  * replace global ram_size with machine->ram_size in ppc4xx_sdram_banks() =
call
  * add a comment about the expected sorting order within sdram_bank_sizes[=
]
    (BALATON Zoltan <balaton@eik.bme.hu>)
---
 include/hw/ppc/ppc4xx.h |  9 +++----
 hw/ppc/ppc440_bamboo.c  | 11 +++-----
 hw/ppc/ppc4xx_devs.c    | 60 ++++++++++++++++++++++-------------------
 hw/ppc/sam460ex.c       |  5 ++--
 4 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 7d82259051..b8c8f324b4 100644
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
+void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+                        MemoryRegion ram_memories[],
+                        hwaddr ram_bases[], hwaddr ram_sizes[],
+                        const ram_addr_t sdram_bank_sizes[]);
=20
 void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         MemoryRegion ram_memories[],
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index da777ef9c2..7e3bc0ec7f 100644
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
+    ppc4xx_sdram_banks(machine->ram_size, PPC440EP_SDRAM_NR_BANKS, ram_mem=
ories,
+                       ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
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
index c2e50138aa..d89008a2a4 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -668,21 +668,22 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
q, int nbanks,
=20
 /* Fill in consecutive SDRAM banks with 'ram_size' bytes of memory.
  *
- * sdram_bank_sizes[] must be 0-terminated.
+ * sdram_bank_sizes[] must be in descending order, that is sizes[i] > size=
s[i+1]
+ * and must be 0-terminated.
  *
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
+void ppc4xx_sdram_banks(ram_addr_t ram_size, int nr_banks,
+                        MemoryRegion ram_memories[],
+                        hwaddr ram_bases[], hwaddr ram_sizes[],
+                        const ram_addr_t sdram_bank_sizes[])
 {
     MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     ram_addr_t size_left =3D ram_size;
     ram_addr_t base =3D 0;
     ram_addr_t bank_size;
+    int last_bank =3D 0;
     int i;
     int j;
=20
@@ -690,7 +691,12 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, in=
t nr_banks,
         for (j =3D 0; sdram_bank_sizes[j] !=3D 0; j++) {
             bank_size =3D sdram_bank_sizes[j];
             if (bank_size <=3D size_left) {
+                ram_bases[i] =3D base;
+                ram_sizes[i] =3D bank_size;
+                base +=3D bank_size;
                 size_left -=3D bank_size;
+                last_bank =3D i;
+                break;
             }
         }
         if (!size_left) {
@@ -699,34 +705,32 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, i=
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
index 89bc70eb94..17d40bd672 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size, 1,
-                                   ram_memories, ram_bases, ram_sizes,
-                                   ppc460ex_sdram_bank_sizes);
+    ppc4xx_sdram_banks(machine->ram_size, 1, ram_memories, ram_bases, ram_=
sizes,
+                       ppc460ex_sdram_bank_sizes);
=20
     /* FIXME: does 460EX have ECC interrupts? */
     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
--=20
2.18.1


