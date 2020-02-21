Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C5FC11D27
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:45:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 498B4208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="h3iZ76KY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 498B4208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zFa-00078Q-D0
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:45:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49212)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z81-0002HX-QA
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1j4z7z-0008OY-Ex
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:37:24 -0500
Received: from ozlabs.org ([203.11.71.1]:49617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1j4z7x-00087W-K5; Thu, 20 Feb 2020 22:37:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 48NxwH2SYVz9sSY; Fri, 21 Feb 2020 14:37:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1582256223;
 bh=679p0oB90Jzdlrd9gKZJDXD9oLUKx+0Uo2DSC+DQzZE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h3iZ76KYrJaZvZ0aWP7m5yztFVAkFQ1Y8Dqw4ZHyjofk8h2Ci2Bm0TMrkHA6MuCBA
 Zi7HLWgvuguZrHFHcZSqEHZq88OfTYNP/JnadZp1dcyijlmQPny//ZD9h0kWKu+lvp
 qz4QQdfzPOf99uus6KqCfNaK90secBkmOt1S77/I=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/20] spapr: Allow changing offset for -kernel image
Date: Fri, 21 Feb 2020 14:36:43 +1100
Message-Id: <20200221033650.444386-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200221033650.444386-1-david@gibson.dropbear.id.au>
References: <20200221033650.444386-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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
Cc: lvivier@redhat.com, Fabiano Rosas <farosas@linux.ibm.com>, aik@ozlabs.ru,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, clg@kaod.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

This allows moving the kernel in the guest memory. The option is useful
for step debugging (as Linux is linked at 0x0); it also allows loading
grub which is normally linked to run at 0x20000.

This uses the existing kernel address by default.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-Id: <20200203032943.121178-6-aik@ozlabs.ru>
Reviewed-by: Fabiano Rosas <farosas@linux.ibm.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         | 38 +++++++++++++++++++++++++++++++-------
 include/hw/ppc/spapr.h |  1 +
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cb220fde45..828e2cc135 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1064,7 +1064,7 @@ static void spapr_dt_chosen(SpaprMachineState *spap=
r, void *fdt)
     }
=20
     if (spapr->kernel_size) {
-        uint64_t kprop[2] =3D { cpu_to_be64(KERNEL_LOAD_ADDR),
+        uint64_t kprop[2] =3D { cpu_to_be64(spapr->kernel_addr),
                               cpu_to_be64(spapr->kernel_size) };
=20
         _FDT(fdt_setprop(fdt, chosen, "qemu,boot-kernel",
@@ -1252,7 +1252,8 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
     /* Build memory reserve map */
     if (reset) {
         if (spapr->kernel_size) {
-            _FDT((fdt_add_mem_rsv(fdt, KERNEL_LOAD_ADDR, spapr->kernel_s=
ize)));
+            _FDT((fdt_add_mem_rsv(fdt, spapr->kernel_addr,
+                                  spapr->kernel_size)));
         }
         if (spapr->initrd_size) {
             _FDT((fdt_add_mem_rsv(fdt, spapr->initrd_base,
@@ -1285,7 +1286,9 @@ void *spapr_build_fdt(SpaprMachineState *spapr, boo=
l reset, size_t space)
=20
 static uint64_t translate_kernel_address(void *opaque, uint64_t addr)
 {
-    return (addr & 0x0fffffff) + KERNEL_LOAD_ADDR;
+    SpaprMachineState *spapr =3D opaque;
+
+    return (addr & 0x0fffffff) + spapr->kernel_addr;
 }
=20
 static void emulate_spapr_hypercall(PPCVirtualHypervisor *vhyp,
@@ -2967,14 +2970,15 @@ static void spapr_machine_init(MachineState *mach=
ine)
         uint64_t lowaddr =3D 0;
=20
         spapr->kernel_size =3D load_elf(kernel_filename, NULL,
-                                      translate_kernel_address, NULL,
+                                      translate_kernel_address, spapr,
                                       NULL, &lowaddr, NULL, NULL, 1,
                                       PPC_ELF_MACHINE, 0, 0);
         if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
             spapr->kernel_size =3D load_elf(kernel_filename, NULL,
-                                          translate_kernel_address, NULL=
, NULL,
+                                          translate_kernel_address, spap=
r, NULL,
                                           &lowaddr, NULL, NULL, 0,
-                                          PPC_ELF_MACHINE, 0, 0);
+                                          PPC_ELF_MACHINE,
+                                          0, 0);
             spapr->kernel_le =3D spapr->kernel_size > 0;
         }
         if (spapr->kernel_size < 0) {
@@ -2988,7 +2992,7 @@ static void spapr_machine_init(MachineState *machin=
e)
             /* Try to locate the initrd in the gap between the kernel
              * and the firmware. Add a bit of space just in case
              */
-            spapr->initrd_base =3D (KERNEL_LOAD_ADDR + spapr->kernel_siz=
e
+            spapr->initrd_base =3D (spapr->kernel_addr + spapr->kernel_s=
ize
                                   + 0x1ffff) & ~0xffff;
             spapr->initrd_size =3D load_image_targphys(initrd_filename,
                                                      spapr->initrd_base,
@@ -3234,6 +3238,18 @@ static void spapr_set_vsmt(Object *obj, Visitor *v=
, const char *name,
     visit_type_uint32(v, name, (uint32_t *)opaque, errp);
 }
=20
+static void spapr_get_kernel_addr(Object *obj, Visitor *v, const char *n=
ame,
+                                  void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
+}
+
+static void spapr_set_kernel_addr(Object *obj, Visitor *v, const char *n=
ame,
+                                  void *opaque, Error **errp)
+{
+    visit_type_uint64(v, name, (uint64_t *)opaque, errp);
+}
+
 static char *spapr_get_ic_mode(Object *obj, Error **errp)
 {
     SpaprMachineState *spapr =3D SPAPR_MACHINE(obj);
@@ -3339,6 +3355,14 @@ static void spapr_instance_init(Object *obj)
     object_property_add_bool(obj, "vfio-no-msix-emulation",
                              spapr_get_msix_emulation, NULL, NULL);
=20
+    object_property_add(obj, "kernel-addr", "uint64", spapr_get_kernel_a=
ddr,
+                        spapr_set_kernel_addr, NULL, &spapr->kernel_addr=
,
+                        &error_abort);
+    object_property_set_description(obj, "kernel-addr",
+                                    stringify(KERNEL_LOAD_ADDR)
+                                    " for -kernel is the default",
+                                    NULL);
+    spapr->kernel_addr =3D KERNEL_LOAD_ADDR;
     /* The machine class defines the default interrupt controller mode *=
/
     spapr->irq =3D smc->irq;
     object_property_add_str(obj, "ic-mode", spapr_get_ic_mode,
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index d557fc1f35..09110961a5 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -162,6 +162,7 @@ struct SpaprMachineState {
     void *fdt_blob;
     long kernel_size;
     bool kernel_le;
+    uint64_t kernel_addr;
     uint32_t initrd_base;
     long initrd_size;
     uint64_t rtc_offset; /* Now used only during incoming migration */
--=20
2.24.1


