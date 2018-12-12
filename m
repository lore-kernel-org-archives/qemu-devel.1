Received: from eggs.gnu.org ([2001:4830:134:3::10]:53922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCOu-0003AV-4g
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCOs-0006mz-59
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCOn-0006cP-9h
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 16:50:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92E6330023FB
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 21:50:25 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 01:48:38 +0400
Message-Id: <20181212214850.29953-17-marcandre.lureau@redhat.com>
In-Reply-To: <20181212214850.29953-1-marcandre.lureau@redhat.com>
References: <20181212214850.29953-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 16/28] compat: replace PC_COMPAT_2_4 &
 HW_COMPAT_2_4 macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, ehabkost@redhat.com

Use static arrays instead.

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/hw/boards.h        |  3 ++
 include/hw/compat.h        | 27 --------------
 include/hw/i386/pc.h       | 74 ++------------------------------------
 hw/core/machine.c          | 29 +++++++++++++++
 hw/i386/pc.c               | 71 ++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c          |  6 ++--
 hw/i386/pc_q35.c           |  6 ++--
 hw/ppc/spapr.c             |  5 +--
 hw/s390x/s390-virtio-ccw.c |  2 +-
 9 files changed, 112 insertions(+), 111 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 36e1269eb1..053e362f28 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -317,4 +317,7 @@ extern const size_t hw_compat_2_6_len;
 extern GlobalProperty hw_compat_2_5[];
 extern const size_t hw_compat_2_5_len;
=20
+extern GlobalProperty hw_compat_2_4[];
+extern const size_t hw_compat_2_4_len;
+
 #endif
diff --git a/include/hw/compat.h b/include/hw/compat.h
index a6eced34c6..05ff05e159 100644
--- a/include/hw/compat.h
+++ b/include/hw/compat.h
@@ -1,33 +1,6 @@
 #ifndef HW_COMPAT_H
 #define HW_COMPAT_H
=20
-#define HW_COMPAT_2_4 \
-    {\
-        .driver   =3D "virtio-blk-device",\
-        .property =3D "scsi",\
-        .value    =3D "true",\
-    },{\
-        .driver   =3D "e1000",\
-        .property =3D "extra_mac_registers",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "x-disable-pcie",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "virtio-pci",\
-        .property =3D "migrate-extra",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "fw_cfg_mem",\
-        .property =3D "dma_enabled",\
-        .value    =3D "off",\
-    },{\
-        .driver   =3D "fw_cfg_io",\
-        .property =3D "dma_enabled",\
-        .value    =3D "off",\
-    },
-
 #define HW_COMPAT_2_3 \
     {\
         .driver   =3D "virtio-blk-pci",\
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 9a32031f25..a9045f6bea 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -324,6 +324,9 @@ extern const size_t pc_compat_2_6_len;
 extern GlobalProperty pc_compat_2_5[];
 extern const size_t pc_compat_2_5_len;
=20
+extern GlobalProperty pc_compat_2_4[];
+extern const size_t pc_compat_2_4_len;
+
 /* Helper for setting model-id for CPU models that changed model-id
  * depending on QEMU versions up to QEMU 2.4.
  */
@@ -344,77 +347,6 @@ extern const size_t pc_compat_2_5_len;
         .value    =3D "QEMU Virtual CPU version " v,\
     },
=20
-#define PC_COMPAT_2_4 \
-    HW_COMPAT_2_4 \
-    PC_CPU_MODEL_IDS("2.4.0") \
-    {\
-        .driver   =3D "Haswell-" TYPE_X86_CPU,\
-        .property =3D "abm",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "Haswell-noTSX-" TYPE_X86_CPU,\
-        .property =3D "abm",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "Broadwell-" TYPE_X86_CPU,\
-        .property =3D "abm",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "Broadwell-noTSX-" TYPE_X86_CPU,\
-        .property =3D "abm",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "host" "-" TYPE_X86_CPU,\
-        .property =3D "host-cache-info",\
-        .value    =3D "on",\
-    },\
-    {\
-        .driver   =3D TYPE_X86_CPU,\
-        .property =3D "check",\
-        .value    =3D "off",\
-    },\
-    {\
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,\
-        .property =3D "sse4a",\
-        .value    =3D "on",\
-    },\
-    {\
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,\
-        .property =3D "abm",\
-        .value    =3D "on",\
-    },\
-    {\
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,\
-        .property =3D "popcnt",\
-        .value    =3D "on",\
-    },\
-    {\
-        .driver   =3D "qemu32" "-" TYPE_X86_CPU,\
-        .property =3D "popcnt",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "Opteron_G2" "-" TYPE_X86_CPU,\
-        .property =3D "rdtscp",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,\
-        .property =3D "rdtscp",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "Opteron_G4" "-" TYPE_X86_CPU,\
-        .property =3D "rdtscp",\
-        .value    =3D "on",\
-    },{\
-        .driver   =3D "Opteron_G5" "-" TYPE_X86_CPU,\
-        .property =3D "rdtscp",\
-        .value    =3D "on",\
-    },
-
-
 #define PC_COMPAT_2_3 \
     HW_COMPAT_2_3 \
     PC_CPU_MODEL_IDS("2.3.0") \
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 1022b538a5..a14e343cba 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -226,6 +226,35 @@ GlobalProperty hw_compat_2_5[] =3D {
 };
 const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
=20
+GlobalProperty hw_compat_2_4[] =3D {
+    {
+        .driver   =3D "virtio-blk-device",
+        .property =3D "scsi",
+        .value    =3D "true",
+    },{
+        .driver   =3D "e1000",
+        .property =3D "extra_mac_registers",
+        .value    =3D "off",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "x-disable-pcie",
+        .value    =3D "on",
+    },{
+        .driver   =3D "virtio-pci",
+        .property =3D "migrate-extra",
+        .value    =3D "off",
+    },{
+        .driver   =3D "fw_cfg_mem",
+        .property =3D "dma_enabled",
+        .value    =3D "off",
+    },{
+        .driver   =3D "fw_cfg_io",
+        .property =3D "dma_enabled",
+        .value    =3D "off",
+    }
+};
+const size_t hw_compat_2_4_len =3D G_N_ELEMENTS(hw_compat_2_4);
+
 static char *machine_get_accel(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 27757ec93f..e4410767c9 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -278,6 +278,77 @@ const size_t pc_compat_2_6_len =3D G_N_ELEMENTS(pc_c=
ompat_2_6);
 GlobalProperty pc_compat_2_5[] =3D {};
 const size_t pc_compat_2_5_len =3D G_N_ELEMENTS(pc_compat_2_5);
=20
+GlobalProperty pc_compat_2_4[] =3D {
+    PC_CPU_MODEL_IDS("2.4.0")
+    {
+        .driver   =3D "Haswell-" TYPE_X86_CPU,
+        .property =3D "abm",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "Haswell-noTSX-" TYPE_X86_CPU,
+        .property =3D "abm",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "Broadwell-" TYPE_X86_CPU,
+        .property =3D "abm",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "Broadwell-noTSX-" TYPE_X86_CPU,
+        .property =3D "abm",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "host" "-" TYPE_X86_CPU,
+        .property =3D "host-cache-info",
+        .value    =3D "on",
+    },
+    {
+        .driver   =3D TYPE_X86_CPU,
+        .property =3D "check",
+        .value    =3D "off",
+    },
+    {
+        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
+        .property =3D "sse4a",
+        .value    =3D "on",
+    },
+    {
+        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
+        .property =3D "abm",
+        .value    =3D "on",
+    },
+    {
+        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
+        .property =3D "popcnt",
+        .value    =3D "on",
+    },
+    {
+        .driver   =3D "qemu32" "-" TYPE_X86_CPU,
+        .property =3D "popcnt",
+        .value    =3D "on",
+    },{
+        .driver   =3D "Opteron_G2" "-" TYPE_X86_CPU,
+        .property =3D "rdtscp",
+        .value    =3D "on",
+    },{
+        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
+        .property =3D "rdtscp",
+        .value    =3D "on",
+    },{
+        .driver   =3D "Opteron_G4" "-" TYPE_X86_CPU,
+        .property =3D "rdtscp",
+        .value    =3D "on",
+    },{
+        .driver   =3D "Opteron_G5" "-" TYPE_X86_CPU,
+        .property =3D "rdtscp",
+        .value    =3D "on",
+    }
+};
+const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
+
 void gsi_handler(void *opaque, int n, int level)
 {
     GSIState *s =3D opaque;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 4f5168534a..1465d367d1 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -553,14 +553,12 @@ DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5", NULL,
 static void pc_i440fx_2_4_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_4
-    };
=20
     pc_i440fx_2_5_machine_options(m);
     m->hw_version =3D "2.4.0";
     pcmc->broken_reserved_end =3D true;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
+    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
=20
 DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index a33d5d3610..418a6f9b8f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -438,14 +438,12 @@ DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
 static void pc_q35_2_4_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
-    static GlobalProperty compat[] =3D {
-        PC_COMPAT_2_4
-    };
=20
     pc_q35_2_5_machine_options(m);
     m->hw_version =3D "2.4.0";
     pcmc->broken_reserved_end =3D true;
-    compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
+    compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
=20
 DEFINE_Q35_MACHINE(v2_4, "pc-q35-2.4", NULL,
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c808ec90f0..9ab8484579 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4248,13 +4248,10 @@ DEFINE_SPAPR_MACHINE(2_5, "2.5", false);
 static void spapr_machine_2_4_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
-    static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_4
-    };
=20
     spapr_machine_2_5_class_options(mc);
     smc->dr_lmb_enabled =3D false;
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
+    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len)=
;
 }
=20
 DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 44a3f897ec..0b62f1dec9 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -837,7 +837,6 @@ static void ccw_machine_2_4_instance_options(MachineS=
tate *machine)
 static void ccw_machine_2_4_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        HW_COMPAT_2_4
         {
             .driver   =3D TYPE_S390_SKEYS,
             .property =3D "migration-enabled",
@@ -878,6 +877,7 @@ static void ccw_machine_2_4_class_options(MachineClas=
s *mc)
     };
=20
     ccw_machine_2_5_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_2_4, hw_compat_2_4_len)=
;
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
 }
 DEFINE_CCW_MACHINE(2_4, "2.4", false);
--=20
2.20.0
