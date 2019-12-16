Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3627C2D0C3
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:40:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80A54206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 16:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHV42kkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80A54206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtQC-0002ZH-3s
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 11:40:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56734)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF9-00052K-Af
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtF6-0007O0-P6
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:11 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:39549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtF6-0007Mf-En
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:08 -0500
Received: by mail-wm1-x32f.google.com with SMTP id b72so5374516wme.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=c33Vy+gSy0BQfnMrdNTPn+iZ4SZhWxCKgMAwbd7J4Uw=;
 b=HHV42kkdfnP48tg+i3B+3MY1JcfNmpukYAed7LJOHdymHNwzke2ZrwpP+zLWW2WEzi
 RFRWBXDqgGEvYOUkj25Q7TIl6TvfRR6DRCtuReiUOpLtJW9pgJJO2PwCghtasPPt5EVD
 NqF+fybBqnaEVG1+VQAGeZ0Wa3L1iFf/JMkFe79h/7XnqFJs0VLaDgn7+YzhqYm4dEpA
 YPq+elQgqgA1GRX4hr0a2ZlhuaLkFqRBj060OIb2qxRrlx9L8/fJ5XDmUy4B5sQxVoiM
 rLqsoGeS3MTEOcAYeEguwuuxbRcTxsJvAjNoe6Pu+u2/vxgGDXHC3M7LmaE9ukNFO8Ho
 Duxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=c33Vy+gSy0BQfnMrdNTPn+iZ4SZhWxCKgMAwbd7J4Uw=;
 b=TcGRVSKlwwxXFncjQpScUKO/RK1Z/qM6gFsNiQDsmg5XOv8kH1lEsoEzw1mSOtLzma
 b8LBh4X0+vi8JkZmvyUkStV39hMh/o2HKpbtBFXLGZDR9d6Yt3ri3xazxqvj3jDwailA
 7iYkGbbo/3lYX8xZOrB1mYpIeQ9NyPdEFxZs5bGQWySA/YQ+DzPcV6JGtOGiPW4B9j4Y
 5xFt+VHkGqwha2und6cwsshLcycb0naNJl6Ykcwoi8ka1zDDZgbngJdR++NnYv+TfDoc
 A9rwRrnWuXOYXE2qk0PiEqMu/MmtYG98zgl/TxmtG3ArNML1ueWLZ8ygC66772WCqEVN
 LxwA==
X-Gm-Message-State: APjAAAWLuOX+CsWE1grT5ZrvjcBQXL6HqT9uHo2cOPFvUjw1NXsJTa5+
 l/wKlLb4R/KGJQgs/p6gmrcqgrxk
X-Google-Smtp-Source: APXvYqyxaiRs/Y9zfxVgmvz7Zvbz9B4V6ypwiYUp3+b2ntL1TTMvIRmHQan+vudrK2XT9s/xi/1Z6Q==
X-Received: by 2002:a1c:486:: with SMTP id 128mr32219688wme.163.1576513746850; 
 Mon, 16 Dec 2019 08:29:06 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 19/62] vl: configure accelerators from -accel options
Date: Mon, 16 Dec 2019 17:28:03 +0100
Message-Id: <1576513726-53700-20-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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

Drop the "accel" property from MachineState, and instead desugar
"-machine accel=" to a list of "-accel" options.

This has a semantic change due to removing merge_lists from -accel.
For example:

- "-accel kvm -accel tcg" all but ignored "-accel kvm".  This is a bugfix.

- "-accel kvm -accel thread=single" ignored "thread=single", since it
  applied the option to KVM.  Now it fails due to not specifying the
  accelerator on "-accel thread=single".

- "-accel tcg -accel thread=single" chose single-threaded TCG, while now
  it will fail due to not specifying the accelerator on "-accel
  thread=single".

Also, "-machine accel" and "-accel" become incompatible.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/machine.c         | 21 -----------
 include/hw/boards.h       |  1 -
 tests/arm-cpu-features.c  |  4 +-
 tests/bios-tables-test.c  | 16 ++++----
 tests/boot-serial-test.c  |  4 +-
 tests/cdrom-test.c        |  2 +-
 tests/libqtest.c          |  4 +-
 tests/migration-test.c    | 23 +++++-------
 tests/pflash-cfi02-test.c |  4 +-
 tests/pnv-xscom-test.c    |  4 +-
 tests/prom-env-test.c     |  2 +-
 tests/pxe-test.c          |  2 +-
 tests/vmgenid-test.c      |  2 +-
 vl.c                      | 93 +++++++++++++++++++++++++++--------------------
 14 files changed, 85 insertions(+), 97 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 023548b..e661fa6 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -178,21 +178,6 @@ GlobalProperty hw_compat_2_1[] = {
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
-static char *machine_get_accel(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return g_strdup(ms->accel);
-}
-
-static void machine_set_accel(Object *obj, const char *value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    g_free(ms->accel);
-    ms->accel = g_strdup(value);
-}
-
 static void machine_set_kernel_irqchip(Object *obj, Visitor *v,
                                        const char *name, void *opaque,
                                        Error **errp)
@@ -813,11 +798,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_align_shift = 23;
     mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
-    object_class_property_add_str(oc, "accel",
-        machine_get_accel, machine_set_accel, &error_abort);
-    object_class_property_set_description(oc, "accel",
-        "Accelerator list", &error_abort);
-
     object_class_property_add(oc, "kernel-irqchip", "on|off|split",
         NULL, machine_set_kernel_irqchip,
         NULL, NULL, &error_abort);
@@ -976,7 +956,6 @@ static void machine_finalize(Object *obj)
 {
     MachineState *ms = MACHINE(obj);
 
-    g_free(ms->accel);
     g_free(ms->kernel_filename);
     g_free(ms->initrd_filename);
     g_free(ms->kernel_cmdline);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 24cbeec..96f2084 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -275,7 +275,6 @@ struct MachineState {
 
     /*< public >*/
 
-    char *accel;
     bool kernel_irqchip_allowed;
     bool kernel_irqchip_required;
     bool kernel_irqchip_split;
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 6e99aa9..bef3ed2 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -20,8 +20,8 @@
  */
 #define SVE_MAX_VQ 16
 
-#define MACHINE     "-machine virt,gic-version=max,accel=tcg "
-#define MACHINE_KVM "-machine virt,gic-version=max,accel=kvm:tcg "
+#define MACHINE     "-machine virt,gic-version=max -accel tcg "
+#define MACHINE_KVM "-machine virt,gic-version=max -accel kvm -accel tcg "
 #define QUERY_HEAD  "{ 'execute': 'query-cpu-model-expansion', " \
                     "  'arguments': { 'type': 'full', "
 #define QUERY_TAIL  "}}"
diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
index 79f5da0..bc0ad59 100644
--- a/tests/bios-tables-test.c
+++ b/tests/bios-tables-test.c
@@ -51,7 +51,7 @@
 #define ACPI_REBUILD_EXPECTED_AML "TEST_ACPI_REBUILD_AML"
 
 typedef struct {
-    const char *accel;
+    bool tcg_only;
     const char *machine;
     const char *variant;
     const char *uefi_fl1;
@@ -607,19 +607,19 @@ static void test_acpi_one(const char *params, test_data *data)
          * TODO: convert '-drive if=pflash' to new syntax (see e33763be7cd3)
          * when arm/virt boad starts to support it.
          */
-        args = g_strdup_printf("-machine %s,accel=%s -nodefaults -nographic "
+        args = g_strdup_printf("-machine %s %s -accel tcg -nodefaults -nographic "
             "-drive if=pflash,format=raw,file=%s,readonly "
             "-drive if=pflash,format=raw,file=%s,snapshot=on -cdrom %s %s",
-            data->machine, data->accel ? data->accel : "kvm:tcg",
+            data->machine, data->tcg_only ? "" : "-accel kvm",
             data->uefi_fl1, data->uefi_fl2, data->cd, params ? params : "");
 
     } else {
         /* Disable kernel irqchip to be able to override apic irq0. */
-        args = g_strdup_printf("-machine %s,accel=%s,kernel-irqchip=off "
+        args = g_strdup_printf("-machine %s,kernel-irqchip=off %s -accel tcg "
             "-net none -display none %s "
             "-drive id=hd0,if=none,file=%s,format=raw "
             "-device ide-hd,drive=hd0 ",
-             data->machine, data->accel ? data->accel : "kvm:tcg",
+             data->machine, data->tcg_only ? "" : "-accel kvm",
              params ? params : "", disk);
     }
 
@@ -904,7 +904,7 @@ static void test_acpi_virt_tcg_memhp(void)
 {
     test_data data = {
         .machine = "virt",
-        .accel = "tcg",
+        .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
@@ -929,7 +929,7 @@ static void test_acpi_virt_tcg_numamem(void)
 {
     test_data data = {
         .machine = "virt",
-        .accel = "tcg",
+        .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
@@ -951,7 +951,7 @@ static void test_acpi_virt_tcg(void)
 {
     test_data data = {
         .machine = "virt",
-        .accel = "tcg",
+        .tcg_only = true,
         .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
         .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
         .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index d3a54a0..05c7f44 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -215,9 +215,9 @@ static void test_machine(const void *data)
      * Make sure that this test uses tcg if available: It is used as a
      * fast-enough smoketest for that.
      */
-    qts = qtest_initf("%s %s -M %s,accel=tcg:kvm -no-shutdown "
+    qts = qtest_initf("%s %s -M %s -no-shutdown "
                       "-chardev file,id=serial0,path=%s "
-                      "-serial chardev:serial0 %s",
+                      "-serial chardev:serial0 -accel tcg -accel kvm %s",
                       codeparam, code ? codetmp : "", test->machine,
                       serialtmp, test->extra);
     if (code) {
diff --git a/tests/cdrom-test.c b/tests/cdrom-test.c
index 34e9974..67635e3 100644
--- a/tests/cdrom-test.c
+++ b/tests/cdrom-test.c
@@ -120,7 +120,7 @@ static void test_cdboot(gconstpointer data)
 {
     QTestState *qts;
 
-    qts = qtest_initf("-M accel=kvm:tcg -no-shutdown %s%s", (const char *)data,
+    qts = qtest_initf("-accel kvm -accel tcg -no-shutdown %s%s", (const char *)data,
                       isoimage);
     boot_sector_test(qts);
     qtest_quit(qts);
diff --git a/tests/libqtest.c b/tests/libqtest.c
index 91e9cb2..a17391d 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -241,9 +241,9 @@ QTestState *qtest_init_without_qmp_handshake(const char *extra_args)
                               "-qtest-log %s "
                               "-chardev socket,path=%s,id=char0 "
                               "-mon chardev=char0,mode=control "
-                              "-accel qtest "
                               "-display none "
-                              "%s", qemu_binary, socket_path,
+                              "%s"
+                              " -accel qtest", qemu_binary, socket_path,
                               getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
                               qmp_socket_path,
                               extra_args ?: "");
diff --git a/tests/migration-test.c b/tests/migration-test.c
index 4a19211..9b1b6fd 100644
--- a/tests/migration-test.c
+++ b/tests/migration-test.c
@@ -577,8 +577,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     char *shmem_opts;
     char *shmem_path;
     const char *arch = qtest_get_arch();
-    const char *machine_type;
-    const char *machine_args;
+    const char *machine_opts = NULL;
     const char *memory_size;
 
     if (args->use_shmem) {
@@ -594,8 +593,6 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         /* the assembled x86 boot sector should be exactly one sector large */
         assert(sizeof(x86_bootsect) == 512);
         init_bootfile(bootpath, x86_bootsect, sizeof(x86_bootsect));
-        machine_type = "";
-        machine_args = "";
         memory_size = "150M";
         arch_source = g_strdup_printf("-drive file=%s,format=raw", bootpath);
         arch_target = g_strdup(arch_source);
@@ -603,16 +600,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         end_address = X86_TEST_MEM_END;
     } else if (g_str_equal(arch, "s390x")) {
         init_bootfile(bootpath, s390x_elf, sizeof(s390x_elf));
-        machine_type = "";
-        machine_args = "";
         memory_size = "128M";
         arch_source = g_strdup_printf("-bios %s", bootpath);
         arch_target = g_strdup(arch_source);
         start_address = S390_TEST_MEM_START;
         end_address = S390_TEST_MEM_END;
     } else if (strcmp(arch, "ppc64") == 0) {
-        machine_type = "";
-        machine_args = ",vsmt=8";
+        machine_opts = "vsmt=8";
         memory_size = "256M";
         arch_source = g_strdup_printf("-nodefaults "
                                       "-prom-env 'use-nvramrc?=true' -prom-env "
@@ -624,8 +618,7 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         end_address = PPC_TEST_MEM_END;
     } else if (strcmp(arch, "aarch64") == 0) {
         init_bootfile(bootpath, aarch64_kernel, sizeof(aarch64_kernel));
-        machine_type = "virt,";
-        machine_args = "gic-version=max";
+        machine_opts = "virt,gic-version=max";
         memory_size = "150M";
         arch_source = g_strdup_printf("-cpu max "
                                       "-kernel %s",
@@ -658,12 +651,13 @@ static int test_migrate_start(QTestState **from, QTestState **to,
         shmem_opts = g_strdup("");
     }
 
-    cmd_source = g_strdup_printf("-machine %saccel=kvm:tcg%s "
+    cmd_source = g_strdup_printf("-accel kvm -accel tcg%s%s "
                                  "-name source,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/src_serial "
                                  "%s %s %s %s",
-                                 machine_type, machine_args,
+                                 machine_opts ? " -machine " : "",
+                                 machine_opts ? machine_opts : "",
                                  memory_size, tmpfs,
                                  arch_source, shmem_opts, args->opts_source,
                                  ignore_stderr);
@@ -671,13 +665,14 @@ static int test_migrate_start(QTestState **from, QTestState **to,
     *from = qtest_init(cmd_source);
     g_free(cmd_source);
 
-    cmd_target = g_strdup_printf("-machine %saccel=kvm:tcg%s "
+    cmd_target = g_strdup_printf("-accel kvm -accel tcg%s%s "
                                  "-name target,debug-threads=on "
                                  "-m %s "
                                  "-serial file:%s/dest_serial "
                                  "-incoming %s "
                                  "%s %s %s %s",
-                                 machine_type, machine_args,
+                                 machine_opts ? " -machine " : "",
+                                 machine_opts ? machine_opts : "",
                                  memory_size, tmpfs, uri,
                                  arch_target, shmem_opts,
                                  args->opts_target, ignore_stderr);
diff --git a/tests/pflash-cfi02-test.c b/tests/pflash-cfi02-test.c
index d3b23f4..17aa669 100644
--- a/tests/pflash-cfi02-test.c
+++ b/tests/pflash-cfi02-test.c
@@ -260,7 +260,7 @@ static void test_geometry(const void *opaque)
 {
     const FlashConfig *config = opaque;
     QTestState *qtest;
-    qtest = qtest_initf("-M musicpal,accel=qtest"
+    qtest = qtest_initf("-M musicpal"
                         " -drive if=pflash,file=%s,format=raw,copy-on-read"
                         /* Device geometry properties. */
                         " -global driver=cfi.pflash02,"
@@ -580,7 +580,7 @@ static void test_cfi_in_autoselect(const void *opaque)
 {
     const FlashConfig *config = opaque;
     QTestState *qtest;
-    qtest = qtest_initf("-M musicpal,accel=qtest"
+    qtest = qtest_initf("-M musicpal"
                         " -drive if=pflash,file=%s,format=raw,copy-on-read",
                         image_path);
     FlashConfig explicit_config = expand_config_defaults(config);
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 9fddc7d..2c46d5c 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -84,7 +84,7 @@ static void test_cfam_id(const void *data)
         machine = "powernv9";
     }
 
-    qts = qtest_initf("-M %s,accel=tcg -cpu %s",
+    qts = qtest_initf("-M %s -accel tcg -cpu %s",
                       machine, chip->cpu_model);
     test_xscom_cfam_id(qts, chip);
     qtest_quit(qts);
@@ -125,7 +125,7 @@ static void test_core(const void *data)
         machine = "powernv9";
     }
 
-    qts = qtest_initf("-M %s,accel=tcg -cpu %s",
+    qts = qtest_initf("-M %s -accel tcg -cpu %s",
                       machine, chip->cpu_model);
     test_xscom_core(qts, chip);
     qtest_quit(qts);
diff --git a/tests/prom-env-test.c b/tests/prom-env-test.c
index 61bc1d1..9be52c7 100644
--- a/tests/prom-env-test.c
+++ b/tests/prom-env-test.c
@@ -57,7 +57,7 @@ static void test_machine(const void *machine)
             " -machine cap-cfpc=broken,cap-sbbc=broken,cap-ibs=broken";
     }
 
-    qts = qtest_initf("-M %s,accel=tcg %s -prom-env 'use-nvramrc?=true' "
+    qts = qtest_initf("-M %s -accel tcg %s -prom-env 'use-nvramrc?=true' "
                       "-prom-env 'nvramrc=%x %x l!' ", (const char *)machine,
                       extra_args, MAGIC, ADDRESS);
     check_guest_memory(qts);
diff --git a/tests/pxe-test.c b/tests/pxe-test.c
index aaae54f..f68d0aa 100644
--- a/tests/pxe-test.c
+++ b/tests/pxe-test.c
@@ -74,7 +74,7 @@ static void test_pxe_one(const testdef_t *test, bool ipv6)
     }
 
     args = g_strdup_printf(
-        "-machine %s,accel=kvm:tcg -nodefaults -boot order=n "
+        "-accel kvm -accel tcg -machine %s -nodefaults -boot order=n "
         "-netdev user,id=" NETNAME ",tftp=./,bootfile=%s,ipv4=%s,ipv6=%s "
         "-device %s,bootindex=1,netdev=" NETNAME " %s",
         test->machine, disk, ipv6 ? "off" : "on", ipv6 ? "on" : "off",
diff --git a/tests/vmgenid-test.c b/tests/vmgenid-test.c
index 85d8e64..efba76e 100644
--- a/tests/vmgenid-test.c
+++ b/tests/vmgenid-test.c
@@ -109,7 +109,7 @@ static void read_guid_from_monitor(QTestState *qts, QemuUUID *guid)
 static char disk[] = "tests/vmgenid-test-disk-XXXXXX";
 
 #define GUID_CMD(guid)                          \
-    "-machine accel=kvm:tcg "                   \
+    "-accel kvm -accel tcg "                    \
     "-device vmgenid,id=testvgid,guid=%s "      \
     "-drive id=hd0,if=none,file=%s,format=raw " \
     "-device ide-hd,drive=hd0 ", guid, disk
diff --git a/vl.c b/vl.c
index 2f6b0dd..9bd27e1 100644
--- a/vl.c
+++ b/vl.c
@@ -294,7 +294,6 @@ static QemuOptsList qemu_accel_opts = {
     .name = "accel",
     .implied_opt_name = "accel",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_accel_opts.head),
-    .merge_lists = true,
     .desc = {
         {
             .name = "accel",
@@ -2648,6 +2647,11 @@ static int machine_set_property(void *opaque,
         }
     }
 
+    /* Legacy options do not correspond to MachineState properties.  */
+    if (g_str_equal(qom_name, "accel")) {
+        return 0;
+    }
+
     return object_parse_property_opt(opaque, name, value, "type", errp);
 }
 
@@ -2838,74 +2842,88 @@ static int do_configure_icount(void *opaque, QemuOpts *opts, Error **errp)
 
 static int do_configure_accelerator(void *opaque, QemuOpts *opts, Error **errp)
 {
+    bool *p_init_failed = opaque;
+    const char *acc = qemu_opt_get(opts, "accel");
+    AccelClass *ac = accel_find(acc);
+    int ret;
+
+    if (!ac) {
+        return 0;
+    }
+    ret = accel_init_machine(ac, current_machine);
+    if (ret < 0) {
+        *p_init_failed = true;
+        error_report("failed to initialize %s: %s",
+                     acc, strerror(-ret));
+        return 0;
+    }
+
     if (tcg_enabled()) {
         qemu_tcg_configure(opts, &error_fatal);
     }
-    return 0;
+    return 1;
 }
 
 static void configure_accelerators(const char *progname)
 {
     const char *accel;
     char **accel_list, **tmp;
-    int ret;
     bool accel_initialised = false;
     bool init_failed = false;
-    AccelClass *acc = NULL;
 
     qemu_opts_foreach(qemu_find_opts("icount"),
                       do_configure_icount, NULL, &error_fatal);
 
     accel = qemu_opt_get(qemu_get_machine_opts(), "accel");
-    if (accel == NULL) {
-        /* Select the default accelerator */
-        if (!accel_find("tcg") && !accel_find("kvm")) {
-            error_report("No accelerator selected and"
-                         " no default accelerator available");
-            exit(1);
-        } else {
-            int pnlen = strlen(progname);
-            if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
-                /* If the program name ends with "kvm", we prefer KVM */
-                accel = "kvm:tcg";
+    if (QTAILQ_EMPTY(&qemu_accel_opts.head)) {
+        if (accel == NULL) {
+            /* Select the default accelerator */
+            if (!accel_find("tcg") && !accel_find("kvm")) {
+                error_report("No accelerator selected and"
+                             " no default accelerator available");
+                exit(1);
             } else {
-                accel = "tcg:kvm";
+                int pnlen = strlen(progname);
+                if (pnlen >= 3 && g_str_equal(&progname[pnlen - 3], "kvm")) {
+                    /* If the program name ends with "kvm", we prefer KVM */
+                    accel = "kvm:tcg";
+                } else {
+                    accel = "tcg:kvm";
+                }
             }
         }
-    }
 
-    accel_list = g_strsplit(accel, ":", 0);
+        accel_list = g_strsplit(accel, ":", 0);
 
-    for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
-        acc = accel_find(*tmp);
-        if (!acc) {
-            continue;
+        for (tmp = accel_list; !accel_initialised && tmp && *tmp; tmp++) {
+            /*
+             * Filter invalid accelerators here, to prevent obscenities
+             * such as "-machine accel=tcg,,thread=single".
+             */
+            if (accel_find(*tmp)) {
+                qemu_opts_parse_noisily(qemu_find_opts("accel"), *tmp, true);
+            }
         }
-        ret = accel_init_machine(acc, current_machine);
-        if (ret < 0) {
-            init_failed = true;
-            error_report("failed to initialize %s: %s",
-                         acc->name, strerror(-ret));
-        } else {
-            accel_initialised = true;
+    } else {
+        if (accel != NULL) {
+            error_report("The -accel and \"-machine accel=\" options are incompatible");
+            exit(1);
         }
     }
-    g_strfreev(accel_list);
 
-    if (!accel_initialised) {
+    if (!qemu_opts_foreach(qemu_find_opts("accel"),
+                           do_configure_accelerator, &init_failed, &error_fatal)) {
         if (!init_failed) {
-            error_report("-machine accel=%s: No accelerator found", accel);
+            error_report("no accelerator found");
         }
         exit(1);
     }
 
     if (init_failed) {
-        error_report("Back to %s accelerator", acc->name);
+        AccelClass *ac = ACCEL_GET_CLASS(current_machine->accelerator);
+        error_report("Back to %s accelerator", ac->name);
     }
 
-    qemu_opts_foreach(qemu_find_opts("accel"),
-                      do_configure_accelerator, NULL, &error_fatal);
-
     if (use_icount && !(tcg_enabled() || qtest_enabled())) {
         error_report("-icount is not allowed with hardware virtualization");
         exit(1);
@@ -3593,9 +3611,6 @@ int main(int argc, char **argv, char **envp)
                                  "use -M accel=... for now instead");
                     exit(1);
                 }
-                opts = qemu_opts_create(qemu_find_opts("machine"), NULL,
-                                        false, &error_abort);
-                qemu_opt_set(opts, "accel", optarg, &error_abort);
                 break;
             case QEMU_OPTION_usb:
                 olist = qemu_find_opts("machine");
-- 
1.8.3.1



