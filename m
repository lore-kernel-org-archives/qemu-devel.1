Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB6CC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1DA52073D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 18:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bZQiSgGW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1DA52073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifTDy-0001KB-O1
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 13:30:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1ifSLR-0002Ki-MP
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1ifSLO-0002vc-Ot
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43525
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ifSLO-0002qS-JD
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 12:33:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576172017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VSHnNeve0nJFno0tiuZhETFw3aDOpI+ZqpQb8S6dcfM=;
 b=bZQiSgGWeIN4iwLOkEn0b91z9AxeSx8xMtztKEmbHnpW2mM0nf/SUZNYFlG5v4GNFwKTGT
 GBbq7v2O/ugOWiIJa8rrMsd7cIM6eFE4s/cJIEDgN08/Nyj1rH+JjE2eaw9L5FD2sbJ1O8
 nt0IC5yLP+WYsUlVA+RBg+gT2E3q0tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-7gC1GShBNBaKdNrdlOwHRQ-1; Thu, 12 Dec 2019 12:33:36 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71FBEDB20;
 Thu, 12 Dec 2019 17:33:33 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0511C19756;
 Thu, 12 Dec 2019 17:33:24 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v2 1/5] hw: add compat machines for 5.0
Date: Thu, 12 Dec 2019 18:33:16 +0100
Message-Id: <20191212173320.11610-2-drjones@redhat.com>
In-Reply-To: <20191212173320.11610-1-drjones@redhat.com>
References: <20191212173320.11610-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 7gC1GShBNBaKdNrdlOwHRQ-1
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
Cc: peter.maydell@linaro.org, Cornelia Huck <cohuck@redhat.com>,
 bijan.mottahedeh@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>,
 maz@kernel.org, Richard Henderson <rth@twiddle.net>,
 David Hildenbrand <david@redhat.com>, richard.henderson@linaro.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>,
 "open list:sPAPR" <qemu-ppc@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>, guoheyi@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>, msys.mizuma@gmail.com,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 5.0 machine types for arm/i440fx/q35/s390x/spapr.

Signed-off-by: Andrew Jones <drjones@redhat.com>

---

Hi Eduardo,

If we need to do something special for i440fx and q35, as
9aec2e52ce9d ("hw: add compat machines for 4.2") implies, then
I'll need guidance as to what.
---
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 14 +++++++++++++-
 hw/i386/pc_q35.c           | 13 ++++++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 15 ++++++++++++++-
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 9 files changed, 72 insertions(+), 6 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index d4bedc260712..cb7041e9677a 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2147,10 +2147,17 @@ static void machvirt_machine_init(void)
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
+    virt_machine_5_0_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
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
index ac08e6360437..58867f987d88 100644
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
index 1bd70d1abbc4..aa2c6147a7ea 100644
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
+                      pc_i440fx_5_0_machine_options)
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
index 385e5cffb167..ddd485d608c0 100644
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
index e076f6023c73..3ae7db156303 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4491,15 +4491,26 @@ static const TypeInfo spapr_machine_info =3D {
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
index d3edeef0ad92..a40f79e20733 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -639,14 +639,27 @@ bool css_migration_enabled(void)
     }                                                                     =
    \
     type_init(ccw_machine_register_##suffix)
=20
+
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
index 1f86eba3f998..61a998de4665 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -237,6 +237,9 @@ void pc_system_firmware_init(PCMachineState *pcms, Memo=
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


