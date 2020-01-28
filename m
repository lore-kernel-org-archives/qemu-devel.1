Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0BBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ACA6206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 20:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ACA6206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwXO5-0003Xh-DU
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 15:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKi-0005Ny-7f
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iwXKe-0001GY-Li
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:36 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:41808 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iwXKe-0001BB-4Y
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 15:19:32 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id CF7D81A2006;
 Tue, 28 Jan 2020 21:09:58 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 9BCB51A1E9A;
 Tue, 28 Jan 2020 21:09:58 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/6] hw/core/loader: Let load_elf() populate the
 processor-specific flags
Date: Tue, 28 Jan 2020 21:09:19 +0100
Message-Id: <1580242161-20333-5-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
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
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, Jia Liu <proljc@gmail.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 Michael Rolnik <mrolnik@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Michael Walle <michael@walle.cc>, Artyom Tarasenko <atar4qemu@gmail.com>,
 amarkovic@wavecomp.com, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

While loading the executable, some platforms (like AVR) need to
determine CPU type that executable is built for by reading the
field 'e_flags' of the ELF header of tha executable.

This patch enables such discovery of that field while using any
of the following functions:

  - load_elf()
  - load_elf_as()
  - load_elf_ram()
  - load_elf_ram_sym()

The argument added to these functions is called 'pflags' and is of
type 'uint32_t*' (that matches the the pointer to the 'elf_word' -
the type of the field 'e_flags' in both 32-bit and 64-bit variants
of ELF header). Callers are allowed to pass NULL as that argument,
and in such case no lookup to the field 'e_flags' will happen, and
no information will be returned, of course.

CC: Richard Henderson <rth@twiddle.net>
CC: Peter Maydell <peter.maydell@linaro.org>
CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
CC: Michael Walle <michael@walle.cc>
CC: Thomas Huth <huth@tuxfamily.org>
CC: Laurent Vivier <laurent@vivier.eu>
CC: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
CC: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>
CC: Aurelien Jarno <aurelien@aurel32.net>
CC: Jia Liu <proljc@gmail.com>
CC: David Gibson <david@gibson.dropbear.id.au>
CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
CC: BALATON Zoltan <balaton@eik.bme.hu>
CC: Christian Borntraeger <borntraeger@de.ibm.com>
CC: Thomas Huth <thuth@redhat.com>
CC: Artyom Tarasenko <atar4qemu@gmail.com>
CC: Fabien Chouteau <chouteau@adacore.com>
CC: KONRAD Frederic <frederic.konrad@adacore.com>
CC: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Message-Id: <1580079311-20447-24-git-send-email-aleksandar.markovic@rt-rk=
.com>
---
 hw/alpha/dp264.c               |  4 ++--
 hw/arm/armv7m.c                |  2 +-
 hw/arm/boot.c                  |  2 +-
 hw/core/generic-loader.c       |  2 +-
 hw/core/loader.c               | 37 +++++++++++++++++++-----------------=
-
 hw/cris/boot.c                 |  2 +-
 hw/hppa/machine.c              |  4 ++--
 hw/i386/multiboot.c            |  2 +-
 hw/i386/x86.c                  |  2 +-
 hw/lm32/lm32_boards.c          |  4 ++--
 hw/lm32/milkymist.c            |  2 +-
 hw/m68k/an5206.c               |  2 +-
 hw/m68k/mcf5208.c              |  2 +-
 hw/m68k/q800.c                 |  2 +-
 hw/microblaze/boot.c           |  4 ++--
 hw/mips/mips_fulong2e.c        |  2 +-
 hw/mips/mips_malta.c           |  3 ++-
 hw/mips/mips_mipssim.c         |  2 +-
 hw/mips/mips_r4k.c             |  2 +-
 hw/moxie/moxiesim.c            |  2 +-
 hw/nios2/boot.c                |  4 ++--
 hw/openrisc/openrisc_sim.c     |  2 +-
 hw/pci-host/prep.c             |  3 ++-
 hw/ppc/e500.c                  |  2 +-
 hw/ppc/mac_newworld.c          |  4 ++--
 hw/ppc/mac_oldworld.c          |  4 ++--
 hw/ppc/ppc440_bamboo.c         |  2 +-
 hw/ppc/sam460ex.c              |  3 ++-
 hw/ppc/spapr.c                 |  6 +++---
 hw/ppc/virtex_ml507.c          |  2 +-
 hw/riscv/boot.c                |  4 ++--
 hw/s390x/ipl.c                 |  7 ++++---
 hw/sparc/leon3.c               |  2 +-
 hw/sparc/sun4m.c               |  4 ++--
 hw/sparc64/sun4u.c             |  5 +++--
 hw/tricore/tricore_testboard.c |  2 +-
 hw/xtensa/sim.c                |  2 +-
 hw/xtensa/xtfpga.c             |  2 +-
 include/hw/elf_ops.h           |  6 +++++-
 include/hw/loader.h            | 21 ++++++++++++---------
 40 files changed, 92 insertions(+), 79 deletions(-)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index f2026fd..a8f9a89 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -115,7 +115,7 @@ static void clipper_init(MachineState *machine)
         exit(1);
     }
     size =3D load_elf(palcode_filename, NULL, cpu_alpha_superpage_to_phy=
s,
-                    NULL, &palcode_entry, &palcode_low, &palcode_high,
+                    NULL, &palcode_entry, &palcode_low, &palcode_high, N=
ULL,
                     0, EM_ALPHA, 0, 0);
     if (size < 0) {
         error_report("could not load palcode '%s'", palcode_filename);
@@ -134,7 +134,7 @@ static void clipper_init(MachineState *machine)
         uint64_t param_offset;
=20
         size =3D load_elf(kernel_filename, NULL, cpu_alpha_superpage_to_=
phys,
-                        NULL, &kernel_entry, &kernel_low, &kernel_high,
+                        NULL, &kernel_entry, &kernel_low, &kernel_high, =
NULL,
                         0, EM_ALPHA, 0, 0);
         if (size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index 5d4a581..7531b97 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -331,7 +331,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kern=
el_filename, int mem_size)
=20
     if (kernel_filename) {
         image_size =3D load_elf_as(kernel_filename, NULL, NULL, NULL,
-                                 &entry, &lowaddr,
+                                 &entry, &lowaddr, NULL,
                                  NULL, big_endian, EM_ARM, 1, 0, as);
         if (image_size < 0) {
             image_size =3D load_image_targphys_as(kernel_filename, 0,
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 8fb4a63..0c213ca 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -903,7 +903,7 @@ static int64_t arm_load_elf(struct arm_boot_info *inf=
o, uint64_t *pentry,
     }
=20
     ret =3D load_elf_as(info->kernel_filename, NULL, NULL, NULL,
-                      pentry, lowaddr, highaddr, big_endian, elf_machine=
,
+                      pentry, lowaddr, highaddr, NULL, big_endian, elf_m=
achine,
                       1, data_swab, as);
     if (ret <=3D 0) {
         /* The header loaded but the image didn't */
diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index e7eb57e..b9aaa52 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -140,7 +140,7 @@ static void generic_loader_realize(DeviceState *dev, =
Error **errp)
=20
         if (!s->force_raw) {
             size =3D load_elf_as(s->file, NULL, NULL, NULL, &entry, NULL=
, NULL,
-                               big_endian, 0, 0, 0, as);
+                               NULL, big_endian, 0, 0, 0, as);
=20
             if (size < 0) {
                 size =3D load_uimage_as(s->file, &entry, NULL, NULL, NUL=
L, NULL,
diff --git a/hw/core/loader.c b/hw/core/loader.c
index 5099f27..d1b78f6 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -406,12 +406,12 @@ int load_elf(const char *filename,
              uint64_t (*elf_note_fn)(void *, void *, bool),
              uint64_t (*translate_fn)(void *, uint64_t),
              void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr=
,
-             uint64_t *highaddr, int big_endian, int elf_machine,
-             int clear_lsb, int data_swab)
+             uint64_t *highaddr, uint32_t *pflags, int big_endian,
+             int elf_machine, int clear_lsb, int data_swab)
 {
     return load_elf_as(filename, elf_note_fn, translate_fn, translate_op=
aque,
-                       pentry, lowaddr, highaddr, big_endian, elf_machin=
e,
-                       clear_lsb, data_swab, NULL);
+                       pentry, lowaddr, highaddr, pflags, big_endian,
+                       elf_machine, clear_lsb, data_swab, NULL);
 }
=20
 /* return < 0 if error, otherwise the number of bytes loaded in memory *=
/
@@ -419,12 +419,12 @@ int load_elf_as(const char *filename,
                 uint64_t (*elf_note_fn)(void *, void *, bool),
                 uint64_t (*translate_fn)(void *, uint64_t),
                 void *translate_opaque, uint64_t *pentry, uint64_t *lowa=
ddr,
-                uint64_t *highaddr, int big_endian, int elf_machine,
-                int clear_lsb, int data_swab, AddressSpace *as)
+                uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                int elf_machine, int clear_lsb, int data_swab, AddressSp=
ace *as)
 {
     return load_elf_ram(filename, elf_note_fn, translate_fn, translate_o=
paque,
-                        pentry, lowaddr, highaddr, big_endian, elf_machi=
ne,
-                        clear_lsb, data_swab, as, true);
+                        pentry, lowaddr, highaddr, pflags, big_endian,
+                        elf_machine, clear_lsb, data_swab, as, true);
 }
=20
 /* return < 0 if error, otherwise the number of bytes loaded in memory *=
/
@@ -432,13 +432,13 @@ int load_elf_ram(const char *filename,
                  uint64_t (*elf_note_fn)(void *, void *, bool),
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *low=
addr,
-                 uint64_t *highaddr, int big_endian, int elf_machine,
-                 int clear_lsb, int data_swab, AddressSpace *as,
-                 bool load_rom)
+                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                 int elf_machine, int clear_lsb, int data_swab,
+                 AddressSpace *as, bool load_rom)
 {
     return load_elf_ram_sym(filename, elf_note_fn,
                             translate_fn, translate_opaque,
-                            pentry, lowaddr, highaddr, big_endian,
+                            pentry, lowaddr, highaddr, pflags, big_endia=
n,
                             elf_machine, clear_lsb, data_swab, as,
                             load_rom, NULL);
 }
@@ -448,8 +448,9 @@ int load_elf_ram_sym(const char *filename,
                      uint64_t (*elf_note_fn)(void *, void *, bool),
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
-                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
-                     int elf_machine, int clear_lsb, int data_swab,
+                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pf=
lags,
+                     int big_endian, int elf_machine,
+                     int clear_lsb, int data_swab,
                      AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
)
 {
     int fd, data_order, target_data_order, must_swab, ret =3D ELF_LOAD_F=
AILED;
@@ -490,13 +491,13 @@ int load_elf_ram_sym(const char *filename,
     if (e_ident[EI_CLASS] =3D=3D ELFCLASS64) {
         ret =3D load_elf64(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
-                         pentry, lowaddr, highaddr, elf_machine, clear_l=
sb,
-                         data_swab, as, load_rom, sym_cb);
+                         pentry, lowaddr, highaddr, pflags, elf_machine,
+                         clear_lsb, data_swab, as, load_rom, sym_cb);
     } else {
         ret =3D load_elf32(filename, fd, elf_note_fn,
                          translate_fn, translate_opaque, must_swab,
-                         pentry, lowaddr, highaddr, elf_machine, clear_l=
sb,
-                         data_swab, as, load_rom, sym_cb);
+                         pentry, lowaddr, highaddr, pflags, elf_machine,
+                         clear_lsb, data_swab, as, load_rom, sym_cb);
     }
=20
  fail:
diff --git a/hw/cris/boot.c b/hw/cris/boot.c
index 2d2cc0c..b8947bc 100644
--- a/hw/cris/boot.c
+++ b/hw/cris/boot.c
@@ -76,7 +76,7 @@ void cris_load_image(CRISCPU *cpu, struct cris_load_inf=
o *li)
        devboard SDK.  */
     image_size =3D load_elf(li->image_filename, NULL,
                           translate_kernel_address, NULL,
-                          &entry, NULL, &high, 0, EM_CRIS, 0, 0);
+                          &entry, NULL, &high, NULL, 0, EM_CRIS, 0, 0);
     li->entry =3D entry;
     if (image_size < 0) {
         /* Takes a kimage from the axis devboard SDK.  */
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2d62a24..d8755ec 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState *machine)
     }
=20
     size =3D load_elf(firmware_filename, NULL, NULL, NULL,
-                    &firmware_entry, &firmware_low, &firmware_high,
+                    &firmware_entry, &firmware_low, &firmware_high, NULL=
,
                     true, EM_PARISC, 0, 0);
=20
     /* Unfortunately, load_elf sign-extends reading elf32.  */
@@ -184,7 +184,7 @@ static void machine_hppa_init(MachineState *machine)
     /* Load kernel */
     if (kernel_filename) {
         size =3D load_elf(kernel_filename, NULL, &cpu_hppa_to_phys,
-                        NULL, &kernel_entry, &kernel_low, &kernel_high,
+                        NULL, &kernel_entry, &kernel_low, &kernel_high, =
NULL,
                         true, EM_PARISC, 0, 0);
=20
         /* Unfortunately, load_elf sign-extends reading elf32.  */
diff --git a/hw/i386/multiboot.c b/hw/i386/multiboot.c
index 9a59f95..9e7d69d 100644
--- a/hw/i386/multiboot.c
+++ b/hw/i386/multiboot.c
@@ -199,7 +199,7 @@ int load_multiboot(FWCfgState *fw_cfg,
         }
=20
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf=
_entry,
-                               &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                               &elf_low, &elf_high, NULL, 0, I386_ELF_MA=
CHINE,
                                0, 0);
         if (kernel_size < 0) {
             error_report("Error while loading elf kernel");
diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 9b9a4d5..7f38e6b 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -413,7 +413,7 @@ static bool load_elfboot(const char *kernel_filename,
     uint64_t elf_note_type =3D XEN_ELFNOTE_PHYS32_ENTRY;
     kernel_size =3D load_elf(kernel_filename, read_pvh_start_addr,
                            NULL, &elf_note_type, &elf_entry,
-                           &elf_low, &elf_high, 0, I386_ELF_MACHINE,
+                           &elf_low, &elf_high, NULL, 0, I386_ELF_MACHIN=
E,
                            0, 0);
=20
     if (kernel_size < 0) {
diff --git a/hw/lm32/lm32_boards.c b/hw/lm32/lm32_boards.c
index 5ae308b..d1894ad 100644
--- a/hw/lm32/lm32_boards.c
+++ b/hw/lm32/lm32_boards.c
@@ -138,7 +138,7 @@ static void lm32_evr_init(MachineState *machine)
         int kernel_size;
=20
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, NULL, NULL,
+                               &entry, NULL, NULL, NULL,
                                1, EM_LATTICEMICO32, 0, 0);
         reset_info->bootstrap_pc =3D entry;
=20
@@ -232,7 +232,7 @@ static void lm32_uclinux_init(MachineState *machine)
         int kernel_size;
=20
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, NULL, NULL,
+                               &entry, NULL, NULL, NULL,
                                1, EM_LATTICEMICO32, 0, 0);
         reset_info->bootstrap_pc =3D entry;
=20
diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 460d322..6d46134 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -177,7 +177,7 @@ milkymist_init(MachineState *machine)
=20
         /* Boots a kernel elf binary.  */
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, NULL, NULL,
+                               &entry, NULL, NULL, NULL,
                                1, EM_LATTICEMICO32, 0, 0);
         reset_info->bootstrap_pc =3D entry;
=20
diff --git a/hw/m68k/an5206.c b/hw/m68k/an5206.c
index 54ccbe1..bed43a9 100644
--- a/hw/m68k/an5206.c
+++ b/hw/m68k/an5206.c
@@ -65,7 +65,7 @@ static void an5206_init(MachineState *machine)
     }
=20
     kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf_ent=
ry,
-                           NULL, NULL, 1, EM_68K, 0, 0);
+                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
     entry =3D elf_entry;
     if (kernel_size < 0) {
         kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NULL,
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 158c5e4..a999c21 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -329,7 +329,7 @@ static void mcf5208evb_init(MachineState *machine)
     }
=20
     kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf_ent=
ry,
-                           NULL, NULL, 1, EM_68K, 0, 0);
+                           NULL, NULL, NULL, 1, EM_68K, 0, 0);
     entry =3D elf_entry;
     if (kernel_size < 0) {
         kernel_size =3D load_uimage(kernel_filename, &entry, NULL, NULL,
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 12491ec..1e32363 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -342,7 +342,7 @@ static void q800_init(MachineState *machine)
     if (linux_boot) {
         uint64_t high;
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &elf_entry, NULL, &high, 1,
+                               &elf_entry, NULL, &high, NULL, 1,
                                EM_68K, 0, 0);
         if (kernel_size < 0) {
             error_report("could not load kernel '%s'", kernel_filename);
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index d1d7dfb..925e3f7 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -145,13 +145,13 @@ void microblaze_load_kernel(MicroBlazeCPU *cpu, hwa=
ddr ddr_base,
=20
         /* Boots a kernel elf binary.  */
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, &low, &high,
+                               &entry, &low, &high, NULL,
                                big_endian, EM_MICROBLAZE, 0, 0);
         base32 =3D entry;
         if (base32 =3D=3D 0xc0000000) {
             kernel_size =3D load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
-                                   &entry, NULL, NULL,
+                                   &entry, NULL, NULL, NULL,
                                    big_endian, EM_MICROBLAZE, 0, 0);
         }
         /* Always boot into physical ram.  */
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 9eaa6e2..2e043cb 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -119,7 +119,7 @@ static int64_t load_kernel(CPUMIPSState *env)
                            cpu_mips_kseg0_to_phys, NULL,
                            (uint64_t *)&kernel_entry,
                            (uint64_t *)&kernel_low, (uint64_t *)&kernel_=
high,
-                           0, EM_MIPS, 1, 0);
+                           NULL, 0, EM_MIPS, 1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 5aaeaa8..34b76bb 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1039,7 +1039,8 @@ static int64_t load_kernel(void)
     kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            (uint64_t *)&kernel_entry, NULL,
-                           (uint64_t *)&kernel_high, big_endian, EM_MIPS=
, 1, 0);
+                           (uint64_t *)&kernel_high, NULL, big_endian, E=
M_MIPS,
+                           1, 0);
     if (kernel_size < 0) {
         error_report("could not load kernel '%s': %s",
                      loaderparams.kernel_filename,
diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
index 84c03dd..b934ca9 100644
--- a/hw/mips/mips_mipssim.c
+++ b/hw/mips/mips_mipssim.c
@@ -74,7 +74,7 @@ static int64_t load_kernel(void)
     kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            (uint64_t *)&entry, NULL,
-                           (uint64_t *)&kernel_high, big_endian,
+                           (uint64_t *)&kernel_high, NULL, big_endian,
                            EM_MIPS, 1, 0);
     if (kernel_size >=3D 0) {
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index fd926a3..b2aec43 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -98,7 +98,7 @@ static int64_t load_kernel(void)
     kernel_size =3D load_elf(loaderparams.kernel_filename, NULL,
                            cpu_mips_kseg0_to_phys, NULL,
                            (uint64_t *)&entry, NULL,
-                           (uint64_t *)&kernel_high, big_endian,
+                           (uint64_t *)&kernel_high, NULL, big_endian,
                            EM_MIPS, 1, 0);
     if (kernel_size >=3D 0) {
         if ((entry & ~0x7fffffffULL) =3D=3D 0x80000000) {
diff --git a/hw/moxie/moxiesim.c b/hw/moxie/moxiesim.c
index 57af1b4..1d06e39 100644
--- a/hw/moxie/moxiesim.c
+++ b/hw/moxie/moxiesim.c
@@ -58,7 +58,7 @@ static void load_kernel(MoxieCPU *cpu, LoaderParams *lo=
ader_params)
     ram_addr_t initrd_offset;
=20
     kernel_size =3D load_elf(loader_params->kernel_filename,  NULL, NULL=
, NULL,
-                           &entry, &kernel_low, &kernel_high, 1, EM_MOXI=
E,
+                           &entry, &kernel_low, &kernel_high, NULL, 1, E=
M_MOXIE,
                            0, 0);
=20
     if (kernel_size <=3D 0) {
diff --git a/hw/nios2/boot.c b/hw/nios2/boot.c
index d78bc9e..46b8349 100644
--- a/hw/nios2/boot.c
+++ b/hw/nios2/boot.c
@@ -147,7 +147,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base=
,
=20
         /* Boots a kernel elf binary. */
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, &low, &high,
+                               &entry, &low, &high, NULL,
                                big_endian, EM_ALTERA_NIOS2, 0, 0);
         if ((uint32_t)entry =3D=3D 0xc0000000) {
             /*
@@ -158,7 +158,7 @@ void nios2_load_kernel(Nios2CPU *cpu, hwaddr ddr_base=
,
              */
             kernel_size =3D load_elf(kernel_filename, NULL,
                                    translate_kernel_address, NULL,
-                                   &entry, NULL, NULL,
+                                   &entry, NULL, NULL, NULL,
                                    big_endian, EM_ALTERA_NIOS2, 0, 0);
             boot_info.bootstrap_pc =3D ddr_base + 0xc0000000 +
                 (entry & 0x07ffffff);
diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
index 79e7049..ad53712 100644
--- a/hw/openrisc/openrisc_sim.c
+++ b/hw/openrisc/openrisc_sim.c
@@ -98,7 +98,7 @@ static void openrisc_load_kernel(ram_addr_t ram_size,
=20
     if (kernel_filename && !qtest_enabled()) {
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &elf_entry, NULL, NULL, 1, EM_OPENRISC,
+                               &elf_entry, NULL, NULL, NULL, 1, EM_OPENR=
ISC,
                                1, 0);
         entry =3D elf_entry;
         if (kernel_size < 0) {
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index f2f8821..1aff72b 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -335,7 +335,8 @@ static void raven_realize(PCIDevice *d, Error **errp)
         if (filename) {
             if (s->elf_machine !=3D EM_NONE) {
                 bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
-                                     NULL, NULL, 1, s->elf_machine, 0, 0=
);
+                                     NULL, NULL, NULL, 1, s->elf_machine=
,
+                                     0, 0);
             }
             if (bios_size < 0) {
                 bios_size =3D get_image_size(filename);
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 12b6a5b..886442e 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1049,7 +1049,7 @@ void ppce500_init(MachineState *machine)
     filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, payload_name);
=20
     payload_size =3D load_elf(filename, NULL, NULL, NULL,
-                            &bios_entry, &loadaddr, NULL,
+                            &bios_entry, &loadaddr, NULL, NULL,
                             1, PPC_ELF_MACHINE, 0, 0);
     if (payload_size < 0) {
         /*
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 3594517..464d012 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -168,7 +168,7 @@ static void ppc_core99_init(MachineState *machine)
     /* Load OpenBIOS (ELF) */
     if (filename) {
         bios_size =3D load_elf(filename, NULL, NULL, NULL, NULL,
-                             NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0);
+                             NULL, NULL, NULL, 1, PPC_ELF_MACHINE, 0, 0)=
;
=20
         g_free(filename);
     } else {
@@ -192,7 +192,7 @@ static void ppc_core99_init(MachineState *machine)
=20
         kernel_size =3D load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
-                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
+                               NULL, &lowaddr, NULL, NULL, 1, PPC_ELF_MA=
CHINE,
                                0, 0);
         if (kernel_size < 0)
             kernel_size =3D load_aout(kernel_filename, kernel_base,
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 0fa680b..7318d7e 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -143,7 +143,7 @@ static void ppc_heathrow_init(MachineState *machine)
=20
     /* Load OpenBIOS (ELF) */
     if (filename) {
-        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL=
,
+        bios_size =3D load_elf(filename, NULL, 0, NULL, NULL, NULL, NULL=
, NULL,
                              1, PPC_ELF_MACHINE, 0, 0);
         g_free(filename);
     } else {
@@ -166,7 +166,7 @@ static void ppc_heathrow_init(MachineState *machine)
         kernel_base =3D KERNEL_LOAD_ADDR;
         kernel_size =3D load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
-                               NULL, &lowaddr, NULL, 1, PPC_ELF_MACHINE,
+                               NULL, &lowaddr, NULL, NULL, 1, PPC_ELF_MA=
CHINE,
                                0, 0);
         if (kernel_size < 0)
             kernel_size =3D load_aout(kernel_filename, kernel_base,
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index b782641..da777ef 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -253,7 +253,7 @@ static void bamboo_init(MachineState *machine)
                               NULL, NULL);
         if (success < 0) {
             success =3D load_elf(kernel_filename, NULL, NULL, NULL, &elf=
_entry,
-                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE,
+                               &elf_lowaddr, NULL, NULL, 1, PPC_ELF_MACH=
INE,
                                0, 0);
             entry =3D elf_entry;
             loadaddr =3D elf_lowaddr;
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 437e214..89bc70e 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -439,7 +439,8 @@ static void sam460ex_init(MachineState *machine)
=20
             success =3D load_elf(machine->kernel_filename, NULL,
                                NULL, NULL, &elf_entry,
-                               &elf_lowaddr, NULL, 1, PPC_ELF_MACHINE, 0=
, 0);
+                               &elf_lowaddr, NULL, NULL, 1, PPC_ELF_MACH=
INE, 0,
+                               0);
             entry =3D elf_entry;
             loadaddr =3D elf_lowaddr;
         }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 02cf53f..a0076e5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2895,13 +2895,13 @@ static void spapr_machine_init(MachineState *mach=
ine)
=20
         spapr->kernel_size =3D load_elf(kernel_filename, NULL,
                                       translate_kernel_address, NULL,
-                                      NULL, &lowaddr, NULL, 1,
+                                      NULL, &lowaddr, NULL, NULL, 1,
                                       PPC_ELF_MACHINE, 0, 0);
         if (spapr->kernel_size =3D=3D ELF_LOAD_WRONG_ENDIAN) {
             spapr->kernel_size =3D load_elf(kernel_filename, NULL,
                                           translate_kernel_address, NULL=
, NULL,
-                                          &lowaddr, NULL, 0, PPC_ELF_MAC=
HINE,
-                                          0, 0);
+                                          &lowaddr, NULL, NULL, 0,
+                                          PPC_ELF_MACHINE, 0, 0);
             spapr->kernel_le =3D spapr->kernel_size > 0;
         }
         if (spapr->kernel_size < 0) {
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 6862552..7526947 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -259,7 +259,7 @@ static void virtex_init(MachineState *machine)
=20
         /* Boots a kernel elf binary.  */
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, &low, &high, 1, PPC_ELF_MACHINE,
+                               &entry, &low, &high, NULL, 1, PPC_ELF_MAC=
HINE,
                                0, 0);
         boot_info.bootstrap_pc =3D entry & 0x00ffffff;
=20
diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
index 027303d..b8e7652 100644
--- a/hw/riscv/boot.c
+++ b/hw/riscv/boot.c
@@ -101,7 +101,7 @@ target_ulong riscv_load_firmware(const char *firmware=
_filename,
     uint64_t firmware_entry, firmware_start, firmware_end;
=20
     if (load_elf(firmware_filename, NULL, NULL, NULL, &firmware_entry,
-                 &firmware_start, &firmware_end, 0, EM_RISCV, 1, 0) > 0)=
 {
+                 &firmware_start, &firmware_end, NULL, 0, EM_RISCV, 1, 0=
) > 0) {
         return firmware_entry;
     }
=20
@@ -119,7 +119,7 @@ target_ulong riscv_load_kernel(const char *kernel_fil=
ename, symbol_fn_t sym_cb)
     uint64_t kernel_entry, kernel_high;
=20
     if (load_elf_ram_sym(kernel_filename, NULL, NULL, NULL,
-                         &kernel_entry, NULL, &kernel_high, 0,
+                         &kernel_entry, NULL, &kernel_high, NULL, 0,
                          EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
         return kernel_entry;
     }
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b3ae901..ca8e7db 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -139,7 +139,7 @@ static void s390_ipl_realize(DeviceState *dev, Error =
**errp)
=20
         bios_size =3D load_elf(bios_filename, NULL,
                              bios_translate_addr, &fwbase,
-                             &ipl->bios_start_addr, NULL, NULL, 1,
+                             &ipl->bios_start_addr, NULL, NULL, NULL, 1,
                              EM_S390, 0, 0);
         if (bios_size > 0) {
             /* Adjust ELF start address to final location */
@@ -164,7 +164,7 @@ static void s390_ipl_realize(DeviceState *dev, Error =
**errp)
     if (ipl->kernel) {
         kernel_size =3D load_elf(ipl->kernel, NULL, NULL, NULL,
                                &pentry, NULL,
-                               NULL, 1, EM_S390, 0, 0);
+                               NULL, NULL, 1, EM_S390, 0, 0);
         if (kernel_size < 0) {
             kernel_size =3D load_image_targphys(ipl->kernel, 0, ram_size=
);
             if (kernel_size < 0) {
@@ -473,7 +473,8 @@ static int load_netboot_image(Error **errp)
=20
     img_size =3D load_elf_ram(netboot_filename, NULL, NULL, NULL,
                             &ipl->start_addr,
-                            NULL, NULL, 1, EM_S390, 0, 0, NULL, false);
+                            NULL, NULL, NULL, 1, EM_S390, 0, 0, NULL,
+                            false);
=20
     if (img_size < 0) {
         img_size =3D load_image_size(netboot_filename, ram_ptr, ram_size=
);
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 8038887..f5a087d 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -297,7 +297,7 @@ static void leon3_generic_hw_init(MachineState *machi=
ne)
         uint64_t entry;
=20
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL,
-                               &entry, NULL, NULL,
+                               &entry, NULL, NULL, NULL,
                                1 /* big endian */, EM_SPARC, 0, 0);
         if (kernel_size < 0) {
             kernel_size =3D load_uimage(kernel_filename, NULL, &entry,
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index df33b32..25e96db 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -270,7 +270,7 @@ static unsigned long sun4m_load_kernel(const char *ke=
rnel_filename,
 #endif
         kernel_size =3D load_elf(kernel_filename, NULL,
                                translate_kernel_address, NULL,
-                               NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
+                               NULL, NULL, NULL, NULL, 1, EM_SPARC, 0, 0=
);
         if (kernel_size < 0)
             kernel_size =3D load_aout(kernel_filename, KERNEL_LOAD_ADDR,
                                     RAM_size - KERNEL_LOAD_ADDR, bswap_n=
eeded,
@@ -721,7 +721,7 @@ static void prom_init(hwaddr addr, const char *bios_n=
ame)
     if (filename) {
         ret =3D load_elf(filename, NULL,
                        translate_prom_address, &addr, NULL,
-                       NULL, NULL, 1, EM_SPARC, 0, 0);
+                       NULL, NULL, NULL, 1, EM_SPARC, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
             ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
         }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 5d710d6..b7ac42f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -175,7 +175,8 @@ static uint64_t sun4u_load_kernel(const char *kernel_=
filename,
         bswap_needed =3D 0;
 #endif
         kernel_size =3D load_elf(kernel_filename, NULL, NULL, NULL, kern=
el_entry,
-                               kernel_addr, &kernel_top, 1, EM_SPARCV9, =
0, 0);
+                               kernel_addr, &kernel_top, NULL, 1, EM_SPA=
RCV9, 0,
+                               0);
         if (kernel_size < 0) {
             *kernel_addr =3D KERNEL_LOAD_ADDR;
             *kernel_entry =3D KERNEL_LOAD_ADDR;
@@ -439,7 +440,7 @@ static void prom_init(hwaddr addr, const char *bios_n=
ame)
     filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
     if (filename) {
         ret =3D load_elf(filename, NULL, translate_prom_address, &addr,
-                       NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
+                       NULL, NULL, NULL, NULL, 1, EM_SPARCV9, 0, 0);
         if (ret < 0 || ret > PROM_SIZE_MAX) {
             ret =3D load_image_targphys(filename, addr, PROM_SIZE_MAX);
         }
diff --git a/hw/tricore/tricore_testboard.c b/hw/tricore/tricore_testboar=
d.c
index aef3289..20c9ccb 100644
--- a/hw/tricore/tricore_testboard.c
+++ b/hw/tricore/tricore_testboard.c
@@ -42,7 +42,7 @@ static void tricore_load_kernel(CPUTriCoreState *env)
=20
     kernel_size =3D load_elf(tricoretb_binfo.kernel_filename, NULL,
                            NULL, NULL, &entry, NULL,
-                           NULL, 0,
+                           NULL, NULL, 0,
                            EM_TRICORE, 1, 0);
     if (kernel_size <=3D 0) {
         error_report("no kernel file '%s'",
diff --git a/hw/xtensa/sim.c b/hw/xtensa/sim.c
index a22743a..aeb46d8 100644
--- a/hw/xtensa/sim.c
+++ b/hw/xtensa/sim.c
@@ -108,7 +108,7 @@ void xtensa_sim_load_kernel(XtensaCPU *cpu, MachineSt=
ate *machine)
         uint64_t elf_entry;
         uint64_t elf_lowaddr;
         int success =3D load_elf(kernel_filename, NULL, translate_phys_a=
ddr, cpu,
-                               &elf_entry, &elf_lowaddr, NULL, big_endia=
n,
+                               &elf_entry, &elf_lowaddr, NULL, NULL, big=
_endian,
                                EM_XTENSA, 0, 0);
=20
         if (success > 0) {
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 8220c7a..8e2dd13 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -415,7 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board,=
 MachineState *machine)
         uint64_t elf_entry;
         uint64_t elf_lowaddr;
         int success =3D load_elf(kernel_filename, NULL, translate_phys_a=
ddr, cpu,
-                &elf_entry, &elf_lowaddr, NULL, be, EM_XTENSA, 0, 0);
+                &elf_entry, &elf_lowaddr, NULL, NULL, be, EM_XTENSA, 0, =
0);
         if (success > 0) {
             entry_point =3D elf_entry;
         } else {
diff --git a/include/hw/elf_ops.h b/include/hw/elf_ops.h
index e07d276..a1411bf 100644
--- a/include/hw/elf_ops.h
+++ b/include/hw/elf_ops.h
@@ -316,7 +316,8 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
                               void *translate_opaque,
                               int must_swab, uint64_t *pentry,
                               uint64_t *lowaddr, uint64_t *highaddr,
-                              int elf_machine, int clear_lsb, int data_s=
wab,
+                              uint32_t *pflags, int elf_machine,
+                              int clear_lsb, int data_swab,
                               AddressSpace *as, bool load_rom,
                               symbol_fn_t sym_cb)
 {
@@ -389,6 +390,9 @@ static int glue(load_elf, SZ)(const char *name, int f=
d,
             }
     }
=20
+    if (pflags) {
+        *pflags =3D (elf_word)ehdr.e_flags;
+    }
     if (pentry)
         *pentry =3D (uint64_t)(elf_sword)ehdr.e_entry;
=20
diff --git a/include/hw/loader.h b/include/hw/loader.h
index 48a96cd..a9eeea3 100644
--- a/include/hw/loader.h
+++ b/include/hw/loader.h
@@ -101,6 +101,7 @@ const char *load_elf_strerror(int error);
  * @pentry: Populated with program entry point. Ignored if NULL.
  * @lowaddr: Populated with lowest loaded address. Ignored if NULL.
  * @highaddr: Populated with highest loaded address. Ignored if NULL.
+ * @pflags: Populated with ELF processor-specific flags. Ignore if NULL.
  * @bigendian: Expected ELF endianness. 0 for LE otherwise BE
  * @elf_machine: Expected ELF machine type
  * @clear_lsb: Set to mask off LSB of addresses (Some architectures use
@@ -131,8 +132,9 @@ int load_elf_ram_sym(const char *filename,
                      uint64_t (*elf_note_fn)(void *, void *, bool),
                      uint64_t (*translate_fn)(void *, uint64_t),
                      void *translate_opaque, uint64_t *pentry,
-                     uint64_t *lowaddr, uint64_t *highaddr, int big_endi=
an,
-                     int elf_machine, int clear_lsb, int data_swab,
+                     uint64_t *lowaddr, uint64_t *highaddr, uint32_t *pf=
lags,
+                     int big_endian, int elf_machine,
+                     int clear_lsb, int data_swab,
                      AddressSpace *as, bool load_rom, symbol_fn_t sym_cb=
);
=20
 /** load_elf_ram:
@@ -143,9 +145,9 @@ int load_elf_ram(const char *filename,
                  uint64_t (*elf_note_fn)(void *, void *, bool),
                  uint64_t (*translate_fn)(void *, uint64_t),
                  void *translate_opaque, uint64_t *pentry, uint64_t *low=
addr,
-                 uint64_t *highaddr, int big_endian, int elf_machine,
-                 int clear_lsb, int data_swab, AddressSpace *as,
-                 bool load_rom);
+                 uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                 int elf_machine, int clear_lsb, int data_swab,
+                 AddressSpace *as, bool load_rom);
=20
 /** load_elf_as:
  * Same as load_elf_ram(), but always loads the elf as ROM
@@ -154,8 +156,9 @@ int load_elf_as(const char *filename,
                 uint64_t (*elf_note_fn)(void *, void *, bool),
                 uint64_t (*translate_fn)(void *, uint64_t),
                 void *translate_opaque, uint64_t *pentry, uint64_t *lowa=
ddr,
-                uint64_t *highaddr, int big_endian, int elf_machine,
-                int clear_lsb, int data_swab, AddressSpace *as);
+                uint64_t *highaddr, uint32_t *pflags, int big_endian,
+                int elf_machine, int clear_lsb, int data_swab,
+                AddressSpace *as);
=20
 /** load_elf:
  * Same as load_elf_as(), but doesn't allow the caller to specify an
@@ -165,8 +168,8 @@ int load_elf(const char *filename,
              uint64_t (*elf_note_fn)(void *, void *, bool),
              uint64_t (*translate_fn)(void *, uint64_t),
              void *translate_opaque, uint64_t *pentry, uint64_t *lowaddr=
,
-             uint64_t *highaddr, int big_endian, int elf_machine,
-             int clear_lsb, int data_swab);
+             uint64_t *highaddr, uint32_t *pflags, int big_endian,
+             int elf_machine, int clear_lsb, int data_swab);
=20
 /** load_elf_hdr:
  * @filename: Path of ELF file
--=20
2.7.4



