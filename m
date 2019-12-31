Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A914C2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:05:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12122205ED
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPucoMhm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12122205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imI98-0007t1-FN
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 09:05:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCe-00065g-IA
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCc-0004ov-Jp
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36890
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCc-0004ke-6e
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797489;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J0A2mz5UYFmaLRsSSfn2Dx/kjyL1tRnOEZsBJXdeXIo=;
 b=WPucoMhmmbZwO7BrRupv+GVmcDRWHRgHwCFb6DpR05Pvk3QnogQrS2rghA+MMSJJ8xWDdy
 eyPnzov/6G57Mxptw+dRW7WINDpES2BXF7FG0bITwqP5wIZdOmxplsxieXlbcGzOFT+KoC
 3Sydis26o8Fu9ZBGTTu9sZTX0AexiaY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-BR6PyMxVPkmNTfkmX5TkMQ-1; Tue, 31 Dec 2019 08:04:44 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEF8010054E3
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:42 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65EDB78E96
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:42 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 66/86] ppc:ppc440_bamboo/sam460ex: drop RAM size fixup
Date: Tue, 31 Dec 2019 14:03:50 +0100
Message-Id: <1577797450-88458-67-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: BR6PyMxVPkmNTfkmX5TkMQ-1
X-Mimecast-Spam-Score: 0
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If user provided non-sense RAM size, board will complain and
continue running with max RAM size supported.
Also RAM is going to be allocated by generic code, so it won't be
possible for board to fix things up for user.

Make it error message and exit to force user fix CLI,
instead of accepting non-sense CLI values.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/ppc/ppc4xx.h |  9 ++++-----
 hw/ppc/ppc440_bamboo.c  | 11 ++++-------
 hw/ppc/ppc4xx_devs.c    | 26 ++++++++++++++++----------
 hw/ppc/sam460ex.c       |  5 ++---
 4 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index 7d82259..1a28127 100644
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
+void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
+                         MemoryRegion ram_memories[],
+                         hwaddr ram_bases[], hwaddr ram_sizes[],
+                         const ram_addr_t sdram_bank_sizes[]);
=20
 void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq irq, int nbanks,
                         MemoryRegion ram_memories[],
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 4d95c0f..66dee89 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -162,7 +162,6 @@ static void main_cpu_reset(void *opaque)
=20
 static void bamboo_init(MachineState *machine)
 {
-    ram_addr_t ram_size =3D machine->ram_size;
     const char *kernel_filename =3D machine->kernel_filename;
     const char *kernel_cmdline =3D machine->kernel_cmdline;
     const char *initrd_filename =3D machine->initrd_filename;
@@ -207,10 +206,8 @@ static void bamboo_init(MachineState *machine)
     /* SDRAM controller */
     memset(ram_bases, 0, sizeof(ram_bases));
     memset(ram_sizes, 0, sizeof(ram_sizes));
-    ram_size =3D ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS,
-                                   ram_memories,
-                                   ram_bases, ram_sizes,
-                                   ppc440ep_sdram_bank_sizes);
+    ppc4xx_sdram_adjust(ram_size, PPC440EP_SDRAM_NR_BANKS, ram_memories,
+                        ram_bases, ram_sizes, ppc440ep_sdram_bank_sizes);
     /* XXX 440EP's ECC interrupts are on UIC1, but we've only created UIC0=
. */
     ppc4xx_sdram_init(env, pic[14], PPC440EP_SDRAM_NR_BANKS, ram_memories,
                       ram_bases, ram_sizes, 1);
@@ -272,7 +269,7 @@ static void bamboo_init(MachineState *machine)
     /* Load initrd. */
     if (initrd_filename) {
         initrd_size =3D load_image_targphys(initrd_filename, RAMDISK_ADDR,
-                                          ram_size - RAMDISK_ADDR);
+                                          machine->ram_size - RAMDISK_ADDR=
);
=20
         if (initrd_size < 0) {
             error_report("could not load ram disk '%s' at %x",
@@ -283,7 +280,7 @@ static void bamboo_init(MachineState *machine)
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
index c2e5013..54af296 100644
--- a/hw/ppc/ppc4xx_devs.c
+++ b/hw/ppc/ppc4xx_devs.c
@@ -673,11 +673,10 @@ void ppc4xx_sdram_init (CPUPPCState *env, qemu_irq ir=
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
+void ppc4xx_sdram_adjust(ram_addr_t ram_size, int nr_banks,
+                         MemoryRegion ram_memories[],
+                         hwaddr ram_bases[], hwaddr ram_sizes[],
+                         const ram_addr_t sdram_bank_sizes[])
 {
     MemoryRegion *ram =3D g_malloc0(sizeof(*ram));
     ram_addr_t size_left =3D ram_size;
@@ -699,10 +698,19 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, i=
nt nr_banks,
         }
     }
=20
-    ram_size -=3D size_left;
     if (size_left) {
-        error_report("Truncating memory to %" PRId64 " MiB to fit SDRAM"
-                     " controller limits", ram_size / MiB);
+        char *s =3D g_strdup("");
+        for (i =3D 0; sdram_bank_sizes[i]; i++) {
+            char *t =3D g_strdup_printf("%s%" PRIi64 "%s", s, sdram_bank_s=
izes[i],
+                                      sdram_bank_sizes[i + 1] ? " ," : "")=
;
+            g_free(s);
+            s =3D t;
+        }
+        error_report("Invalid RAM size, unable to fit all RAM into RAM ban=
ks"
+                     " (unassigned RAM: %" PRIi64 ")",  size_left);
+        error_report("Supported: %d banks and sizes/bank: %s", nr_banks, s=
);
+        g_free(s);
+        exit(EXIT_FAILURE);
     }
=20
     memory_region_allocate_system_memory(ram, NULL, "ppc4xx.sdram", ram_si=
ze);
@@ -725,8 +733,6 @@ ram_addr_t ppc4xx_sdram_adjust(ram_addr_t ram_size, int=
 nr_banks,
             }
         }
     }
-
-    return ram_size;
 }
=20
 /*************************************************************************=
****/
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 437e214..f592816 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -324,9 +324,8 @@ static void sam460ex_init(MachineState *machine)
     /* SDRAM controller */
     /* put all RAM on first bank because board has one slot
      * and firmware only checks that */
-    machine->ram_size =3D ppc4xx_sdram_adjust(machine->ram_size, 1,
-                                   ram_memories, ram_bases, ram_sizes,
-                                   ppc460ex_sdram_bank_sizes);
+    ppc4xx_sdram_adjust(machine->ram_size, 1, ram_memories, ram_bases,
+                        ram_sizes, ppc460ex_sdram_bank_sizes);
=20
     /* FIXME: does 460EX have ECC interrupts? */
     ppc440_sdram_init(env, SDRAM_NR_BANKS, ram_memories,
--=20
2.7.4


