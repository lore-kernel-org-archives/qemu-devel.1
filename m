Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7574EC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F1C22084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 10:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZgEze/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1C22084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUTjq-0002cK-C1
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 05:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58813)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iUTio-0001Fh-1M
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iUTim-0000UM-C6
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:48:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22836
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iUTil-0000RI-Rm
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 05:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573555707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dWdtdVSX4SXrv3pRMdhWS8ETD1vhi/BaRAPmhG1bYHE=;
 b=UZgEze/l06RZBz2/yxO3JBImYbCtKFl7vjYCu8QTp7qhiZ4lxDiQ1L68wZ/vZQs0e7Dkwq
 oZWID1DZFKkjMW+cxXgkuzqDrfMbSG7zZHFBJ5GWCT2XGq02UJeZ84yREm36Q4wZDeLZfa
 4ZE0x2vd9C37PczeqhfbyWguy3iwwBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-AvjgrY1VOuSsA1UYDmu95g-1; Tue, 12 Nov 2019 05:48:24 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5E59B8C656C;
 Tue, 12 Nov 2019 10:48:22 +0000 (UTC)
Received: from localhost (dhcp-192-218.str.redhat.com [10.33.192.218])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB98461081;
 Tue, 12 Nov 2019 10:48:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] hw: add compat machines for 5.0
Date: Tue, 12 Nov 2019 11:48:11 +0100
Message-Id: <20191112104811.30323-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: AvjgrY1VOuSsA1UYDmu95g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.

For i440fx and q35, unversioned cpu models are still translated
to -v1; I'll leave changing this (if desired) to the respective
maintainers.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---

also pushed out to https://github.com/cohuck/qemu machine-5.0

x86 folks: if you want to change the cpu model versioning, I
can do it in this patch, or just do it on top yourselves

---
 hw/arm/virt.c              |  7 ++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc260712..02f654b63278 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2147,10 +2147,15 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
=20
+static void virt_machine_5_0_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(5, 0)
+
 static void virt_machine_4_2_options(MachineClass *mc)
 {
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(4, 2)
+DEFINE_VIRT_MACHINE(4, 2)
=20
 static void virt_machine_4_1_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1689ad3bf8af..21fe2d974817 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -27,6 +27,9 @@
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
=20
+GlobalProperty hw_compat_4_2[] =3D {};
+const size_t hw_compat_4_2_len =3D G_N_ELEMENTS(hw_compat_4_2);
+
 GlobalProperty hw_compat_4_1[] =3D {
     { "virtio-pci", "x-pcie-flr-init", "off" },
 };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 96715f8a3f99..2126c49ee7c5 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -103,6 +103,9 @@
=20
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
+GlobalProperty pc_compat_4_2[] =3D {};
+const size_t pc_compat_4_2_len =3D G_N_ELEMENTS(pc_compat_4_2);
+
 GlobalProperty pc_compat_4_1[] =3D {};
 const size_t pc_compat_4_1_len =3D G_N_ELEMENTS(pc_compat_4_1);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 2aefa3b8dfe3..65915ea23c4a 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -424,7 +424,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
 }
=20
-static void pc_i440fx_4_2_machine_options(MachineClass *m)
+static void pc_i440fx_5_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_i440fx_machine_options(m);
@@ -433,6 +433,18 @@ static void pc_i440fx_4_2_machine_options(MachineClass=
 *m)
     pcmc->default_cpu_version =3D 1;
 }
=20
+DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0", NULL,
+                      pc_i440fx_5_0_machine_options);
+
+static void pc_i440fx_4_2_machine_options(MachineClass *m)
+{
+    pc_i440fx_5_0_machine_options(m);
+    m->alias =3D NULL;
+    m->is_default =3D 0;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
+}
+
 DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2", NULL,
                       pc_i440fx_4_2_machine_options);
=20
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d51f5247276d..c582a6f6a363 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -348,7 +348,7 @@ static void pc_q35_machine_options(MachineClass *m)
     m->max_cpus =3D 288;
 }
=20
-static void pc_q35_4_2_machine_options(MachineClass *m)
+static void pc_q35_5_0_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     pc_q35_machine_options(m);
@@ -356,6 +356,17 @@ static void pc_q35_4_2_machine_options(MachineClass *m=
)
     pcmc->default_cpu_version =3D 1;
 }
=20
+DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
+                   pc_q35_5_0_machine_options);
+
+static void pc_q35_4_2_machine_options(MachineClass *m)
+{
+    pc_q35_5_0_machine_options(m);
+    m->alias =3D NULL;
+    compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
+    compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
+}
+
 DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
                    pc_q35_4_2_machine_options);
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 94f9d27096af..d5c33f2c19d3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4486,15 +4486,26 @@ static const TypeInfo spapr_machine_info =3D {
     }                                                                \
     type_init(spapr_machine_register_##suffix)
=20
+/*
+ * pseries-5.0
+ */
+static void spapr_machine_5_0_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE(5_0, "5.0", true);
+
 /*
  * pseries-4.2
  */
 static void spapr_machine_4_2_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_5_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
=20
-DEFINE_SPAPR_MACHINE(4_2, "4.2", true);
+DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
=20
 /*
  * pseries-4.1
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d3edeef0ad92..01e7e209a5da 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -639,14 +639,26 @@ bool css_migration_enabled(void)
     }                                                                     =
    \
     type_init(ccw_machine_register_##suffix)
=20
+static void ccw_machine_5_0_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_5_0_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE(5_0, "5.0", true);
+
 static void ccw_machine_4_2_instance_options(MachineState *machine)
 {
+    ccw_machine_5_0_instance_options(machine);
 }
=20
 static void ccw_machine_4_2_class_options(MachineClass *mc)
 {
+    ccw_machine_5_0_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
 }
-DEFINE_CCW_MACHINE(4_2, "4.2", true);
+DEFINE_CCW_MACHINE(4_2, "4.2", false);
=20
 static void ccw_machine_4_1_instance_options(MachineState *machine)
 {
diff --git a/include/hw/boards.h b/include/hw/boards.h
index de45087f34cb..24cbeecbaecc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -329,6 +329,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
=20
+extern GlobalProperty hw_compat_4_2[];
+extern const size_t hw_compat_4_2_len;
+
 extern GlobalProperty hw_compat_4_1[];
 extern const size_t hw_compat_4_1_len;
=20
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e6fa8418ca61..0b23fc73c99b 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -239,6 +239,9 @@ void pc_system_firmware_init(PCMachineState *pcms, Memo=
ryRegion *rom_memory);
 void pc_madt_cpu_entry(AcpiDeviceIf *adev, int uid,
                        const CPUArchIdList *apic_ids, GArray *entry);
=20
+extern GlobalProperty pc_compat_4_2[];
+extern const size_t pc_compat_4_2_len;
+
 extern GlobalProperty pc_compat_4_1[];
 extern const size_t pc_compat_4_1_len;
=20
--=20
2.21.0


