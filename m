Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20D5C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:11:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72372176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 13:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9E/eNuX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72372176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihZ6z-0007SS-IB
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 08:11:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY45-0007bG-7i
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY43-0004EI-8c
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:29 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433]:46600)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY42-0004AE-UA
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:27 -0500
Received: by mail-wr1-x433.google.com with SMTP id z7so1965963wrl.13
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=f03cV1xZMlUyzeguprQnKHNJAtwUBVsYj3upmIv2MNo=;
 b=C9E/eNuX0u/6KxxqEUSL4OSCf5GM5sRaZW37Sw2bVK9ZQfcXOFOTHSQhr2mqGTY6aJ
 PQkw1YViEw1ZaI1XJ0Fxae84HVW2VwShRovb7EOE46djkCrVwhS29MZU+VwrfMt9OF10
 q+rljaxc1Chch9Gr9p6z1n+Psnv2dvkvJNg4KUGfUi1GvpVSeU7wJtAkql59LOYy1IRg
 PniQWjZ3fAq+PE1xqUIaxb0yBv2fEnND6hbvnGJ9PwEY8jKLb3upc4IC/mQGN4ZoR/p9
 pbjjBWV3xxOlww4ldBFcgwx9gg0PlOWJywZ55jDG7IiU/mvg2Xq/NBiurJ3o/MQ5CCp2
 bZGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=f03cV1xZMlUyzeguprQnKHNJAtwUBVsYj3upmIv2MNo=;
 b=iQsTn7led247ELlS+UgF/w3Nsq69YTpcurM151VUmNxwh9FBlZAhArrT6FZjB/jGyg
 aUxBqgjrW9oln7SmSKkJSWrMszexLP/X9sb2iltIvJ7TMV33iABRLyGBytHKtdRIu1d1
 Jk6aSbq4DSoKnZk8Eqv1J3OwWj8tHJ3ef+hQcsFqVdgEk6oLOm/bZJNgVvZ5ETLqHCuH
 XRiDAvCKwoavYFxVYaszaRHLWm9ugs5m5nwZHTkYyf+5PkDO5WYhVMbCVdxcndkyhXMd
 DDxmyG0I11X3GPOytLhNgZbjWAbZ3TwiSLdmEyy7SDJvhYkA4TP3pW2WFVEIHHcX2XQo
 abLw==
X-Gm-Message-State: APjAAAXua+DtvkmfQOfsjQFFG1WhwgGyhoATGAS3EhGAZWzD6LUFf8up
 KochJleir0vx+VC/DtGo1SDMwgJ0
X-Google-Smtp-Source: APXvYqwYrKy4pDL/rg63/uQw/XxfP1JszfQW8hGIgw7RjuiZyON7hgvye/8FkxnPPfvlZfv2SVzdNA==
X-Received: by 2002:a5d:4085:: with SMTP id o5mr2392019wrp.321.1576670665687; 
 Wed, 18 Dec 2019 04:04:25 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 83/87] hw/i386: Remove the deprecated machines 0.12 up to 0.15
Date: Wed, 18 Dec 2019 13:02:49 +0100
Message-Id: <1576670573-48048-84-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::433
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

These machines can't be used reliably for migration anymore, quoting
https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html :

"
 due to the introduction of the memory API, the firmware is not
 migrated correctly from source to destination.  On QEMU <1.3 the
 0xf0000-0xfffff area is basically a copy of the higher
 0xffff0000-0xffffffff area, while on more recent versions it is
 initialized with zeroes and the firmware copies from 0xffff0000 to
 0xf0000.  When you migrate from old to new QEMU, after reboot there's
 nothing at 0xf0000 and bugs ensue.
"

The pc-0.x machines have been marked as deprecated since QEMU v4.0, so
it is time to remove them now.

And while we're at it, mark the remaining pc-1.x machine types
as deprecated now, too, so that we finally only have "pc-i440fx"
and "pc-q35" machine types left (apart from the non-versioned
"isapc" and "microvm") once we remove them in a couple of releases.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20191209125248.5849-2-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc_piix.c     | 85 ++-------------------------------------------------
 qemu-deprecated.texi  |  2 +-
 tests/cpu-plug-test.c |  6 +---
 3 files changed, 4 insertions(+), 89 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b3f0304..721c7aa 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -357,19 +357,13 @@ static void pc_compat_1_3(MachineState *machine)
     pc_compat_1_4_fn(machine);
 }
 
-/* PC compat function for pc-0.14 to pc-1.2 */
+/* PC compat function for pc-1.0 to pc-1.2 */
 static void pc_compat_1_2(MachineState *machine)
 {
     pc_compat_1_3(machine);
     x86_cpu_change_kvm_default("kvm-pv-eoi", NULL);
 }
 
-/* PC compat function for pc-0.12 and pc-0.13 */
-static void pc_compat_0_13(MachineState *machine)
-{
-    pc_compat_1_2(machine);
-}
-
 static void pc_init_isa(MachineState *machine)
 {
     pc_init1(machine, TYPE_I440FX_PCI_HOST_BRIDGE, TYPE_I440FX_PCI_DEVICE);
@@ -745,6 +739,7 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
 
     pc_i440fx_1_4_machine_options(m);
     m->hw_version = "1.3.0";
+    m->deprecation_reason = "use a newer machine type instead";
     x86mc->compat_apic_id_mode = true;
     compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
 }
@@ -813,82 +808,6 @@ DEFINE_I440FX_MACHINE(v1_0, "pc-1.0", pc_compat_1_2,
                       pc_i440fx_1_0_machine_options);
 
 
-static void pc_i440fx_0_15_machine_options(MachineClass *m)
-{
-    static GlobalProperty compat[] = {
-        PC_CPU_MODEL_IDS("0.15")
-    };
-
-    pc_i440fx_1_0_machine_options(m);
-    m->hw_version = "0.15";
-    m->deprecation_reason = "use a newer machine type instead";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_I440FX_MACHINE(v0_15, "pc-0.15", pc_compat_1_2,
-                      pc_i440fx_0_15_machine_options);
-
-
-static void pc_i440fx_0_14_machine_options(MachineClass *m)
-{
-    static GlobalProperty compat[] = {
-        PC_CPU_MODEL_IDS("0.14")
-        { "virtio-blk-pci", "event_idx", "off" },
-        { "virtio-serial-pci", "event_idx", "off" },
-        { "virtio-net-pci", "event_idx", "off" },
-        { "virtio-balloon-pci", "event_idx", "off" },
-        { "qxl", "revision", "2" },
-        { "qxl-vga", "revision", "2" },
-    };
-
-    pc_i440fx_0_15_machine_options(m);
-    m->hw_version = "0.14";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_I440FX_MACHINE(v0_14, "pc-0.14", pc_compat_1_2,
-                      pc_i440fx_0_14_machine_options);
-
-static void pc_i440fx_0_13_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] = {
-        PC_CPU_MODEL_IDS("0.13")
-        { TYPE_PCI_DEVICE, "command_serr_enable", "off" },
-        { "AC97", "use_broken_id", "1" },
-        { "virtio-9p-pci", "vectors", "0" },
-        { "VGA", "rombar", "0" },
-        { "vmware-svga", "rombar", "0" },
-    };
-
-    pc_i440fx_0_14_machine_options(m);
-    m->hw_version = "0.13";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-    pcmc->kvmclock_enabled = false;
-}
-
-DEFINE_I440FX_MACHINE(v0_13, "pc-0.13", pc_compat_0_13,
-                      pc_i440fx_0_13_machine_options);
-
-static void pc_i440fx_0_12_machine_options(MachineClass *m)
-{
-    static GlobalProperty compat[] = {
-        PC_CPU_MODEL_IDS("0.12")
-        { "virtio-serial-pci", "max_ports", "1" },
-        { "virtio-serial-pci", "vectors", "0" },
-        { "usb-mouse", "serial", "1" },
-        { "usb-tablet", "serial", "1" },
-        { "usb-kbd", "serial", "1" },
-    };
-
-    pc_i440fx_0_13_machine_options(m);
-    m->hw_version = "0.12";
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_I440FX_MACHINE(v0_12, "pc-0.12", pc_compat_0_13,
-                      pc_i440fx_0_12_machine_options);
-
 typedef struct {
     uint16_t gpu_device_id;
     uint16_t pch_device_id;
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index e88f6d1..97ba3cb 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -265,7 +265,7 @@ The 'scsi-disk' device is deprecated. Users should use 'scsi-hd' or
 This machine type is very old and unmaintained. Users should use the 'malta'
 machine type instead.
 
-@subsection pc-0.12, pc-0.13, pc-0.14 and pc-0.15 (since 4.0)
+@subsection pc-1.0, pc-1.1, pc-1.2 and pc-1.3 (since 5.0)
 
 These machine types are very old and likely can not be used for live migration
 from old QEMU versions anymore. A newer machine type should be used instead.
diff --git a/tests/cpu-plug-test.c b/tests/cpu-plug-test.c
index 30e514b..e8ffbbc 100644
--- a/tests/cpu-plug-test.c
+++ b/tests/cpu-plug-test.c
@@ -148,11 +148,7 @@ static void add_pc_test_case(const char *mname)
         (strcmp(mname, "pc-1.3") == 0) ||
         (strcmp(mname, "pc-1.2") == 0) ||
         (strcmp(mname, "pc-1.1") == 0) ||
-        (strcmp(mname, "pc-1.0") == 0) ||
-        (strcmp(mname, "pc-0.15") == 0) ||
-        (strcmp(mname, "pc-0.14") == 0) ||
-        (strcmp(mname, "pc-0.13") == 0) ||
-        (strcmp(mname, "pc-0.12") == 0)) {
+        (strcmp(mname, "pc-1.0") == 0)) {
         path = g_strdup_printf("cpu-plug/%s/init/%ux%ux%u&maxcpus=%u",
                                mname, data->sockets, data->cores,
                                data->threads, data->maxcpus);
-- 
1.8.3.1



