Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2297BC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFE2E20673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 10:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE2E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHn9q-0003qC-Dr
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iHn7b-0001uT-D0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iHn7Z-0003ro-MJ
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56338)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iHn7Z-0003rE-ER
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 06:53:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7AD703175281;
 Tue,  8 Oct 2019 10:53:36 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-109.rdu2.redhat.com
 [10.10.120.109])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 789375D9C9;
 Tue,  8 Oct 2019 10:53:34 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
To: qemu devel list <qemu-devel@nongnu.org>
Subject: [PATCH 4/4] hw/i386/pc: expose CPU topology over fw-cfg
Date: Tue,  8 Oct 2019 12:52:59 +0200
Message-Id: <20191008105259.5378-5-lersek@redhat.com>
In-Reply-To: <20191008105259.5378-1-lersek@redhat.com>
References: <20191008105259.5378-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 08 Oct 2019 10:53:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable the small feature added in the last patch on 4.2+ PC machine types=
.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Ref: https://bugzilla.tianocore.org/show_bug.cgi?id=3D1515
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 include/hw/i386/pc.h | 3 +++
 hw/i386/pc.c         | 3 ++-
 hw/i386/pc_piix.c    | 2 ++
 hw/i386/pc_q35.c     | 2 ++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 6df4f4b6fbe7..96af441453bc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -144,6 +144,9 @@ typedef struct PCMachineClass {
=20
     /* Enables contiguous-apic-ID mode */
     bool compat_apic_id_mode;
+
+    /* expose x86 CPU topology over fw_cfg */
+    bool fwcfg_topology;
 } PCMachineClass;
=20
 #define TYPE_PC_MACHINE "generic-pc-machine"
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb72b12edad2..12b13ba0e1c5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1739,7 +1739,7 @@ void pc_memory_init(PCMachineState *pcms,
                                         1);
=20
     fw_cfg =3D fw_cfg_arch_create(machine, pcms->boot_cpus, pcms->apic_i=
d_limit,
-                                pcms->smp_dies, false);
+                                pcms->smp_dies, pcmc->fwcfg_topology);
=20
     rom_set_fw(fw_cfg);
=20
@@ -2798,6 +2798,7 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
     pcmc->save_tsc_khz =3D true;
     pcmc->linuxboot_dma_enabled =3D true;
     pcmc->pvh_enabled =3D true;
+    pcmc->fwcfg_topology =3D true;
     assert(!mc->get_hotplug_handler);
     mc->get_hotplug_handler =3D pc_get_hotplug_handler;
     mc->hotplug_allowed =3D pc_hotplug_allowed;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 6824b72124de..7fb87452889b 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,9 +445,11 @@ DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
=20
 static void pc_i440fx_4_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_4_2_machine_options(m);
     m->alias =3D NULL;
     m->is_default =3D 0;
+    pcmc->fwcfg_topology =3D false;
     compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 8fad20f3146a..3ec45659da02 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -377,8 +377,10 @@ DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
=20
 static void pc_q35_4_1_machine_options(MachineClass *m)
 {
+    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_4_2_machine_options(m);
     m->alias =3D NULL;
+    pcmc->fwcfg_topology =3D false;
     compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
--=20
2.19.1.3.g30247aa5d201


