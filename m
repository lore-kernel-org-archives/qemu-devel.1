Received: from eggs.gnu.org ([2001:4830:134:3::10]:58603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgW-0006Zx-NA
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cWlgV-0004tG-Aq
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 10:10:00 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 26 Jan 2017 16:09:41 +0100
Message-Id: <1485443388-27253-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1485443388-27253-1-git-send-email-armbru@redhat.com>
References: <1485443388-27253-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/8] hw: Default -drive to if=ide explicitly
 where it works
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Block backends defined with -drive if=ide are meant to be picked up by
machine initialization code: a suitable frontend gets created and
wired up automatically.

if=ide drives not picked up that way can still be used with -device as
if they had if=none, but that's unclean and best avoided.  Unused ones
produce an "Orphaned drive without device" warning.

-drive parameter "if" is optional, and the default depends on the
machine type.  If a machine type doesn't specify a default, the
default is "ide".

Many machine types default to if=ide, even though they don't actually
have an IDE controller.  A future patch will change these defaults to
something more sensible.  To prepare for it, this patch makes default
"ide" explicit for the machines that actually pick up if=ide drives:

* alpha: clipper
* arm/aarch64: spitz borzoi terrier tosa
* i386/x86_64: generic-pc-machine (with concrete subtypes pc-q35-*
  pc-i440fx-* pc-* isapc xenfv)
* mips64el: fulong2e
* mips/mipsel/mips64el: malta mips
* ppc/ppc64: mac99 g3beige prep
* sh4/sh4eb: r2d
* sparc64: sun4u sun4v

Note that ppc64 machine powernv already sets an "ide" default
explicitly.  Its IDE controller isn't implemented, yet.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/alpha/dp264.c        | 1 +
 hw/arm/spitz.c          | 3 +++
 hw/arm/tosa.c           | 1 +
 hw/i386/pc.c            | 1 +
 hw/mips/mips_fulong2e.c | 1 +
 hw/mips/mips_malta.c    | 1 +
 hw/mips/mips_r4k.c      | 1 +
 hw/ppc/mac_newworld.c   | 1 +
 hw/ppc/mac_oldworld.c   | 1 +
 hw/ppc/prep.c           | 1 +
 hw/sh4/r2d.c            | 1 +
 hw/sparc64/sun4u.c      | 2 ++
 12 files changed, 15 insertions(+)

diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
index d6431fd..85405da 100644
--- a/hw/alpha/dp264.c
+++ b/hw/alpha/dp264.c
@@ -177,6 +177,7 @@ static void clipper_machine_init(MachineClass *mc)
 {
     mc->desc = "Alpha DP264/CLIPPER";
     mc->init = clipper_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = 4;
     mc->is_default = 1;
 }
diff --git a/hw/arm/spitz.c b/hw/arm/spitz.c
index 949a15a..fe2d5a7 100644
--- a/hw/arm/spitz.c
+++ b/hw/arm/spitz.c
@@ -998,6 +998,7 @@ static void spitzpda_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Sharp SL-C3000 (Spitz) PDA (PXA270)";
     mc->init = spitz_init;
+    mc->block_default_type = IF_IDE;
 }
 
 static const TypeInfo spitzpda_type = {
@@ -1012,6 +1013,7 @@ static void borzoipda_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Sharp SL-C3100 (Borzoi) PDA (PXA270)";
     mc->init = borzoi_init;
+    mc->block_default_type = IF_IDE;
 }
 
 static const TypeInfo borzoipda_type = {
@@ -1026,6 +1028,7 @@ static void terrierpda_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Sharp SL-C3200 (Terrier) PDA (PXA270)";
     mc->init = terrier_init;
+    mc->block_default_type = IF_IDE;
 }
 
 static const TypeInfo terrierpda_type = {
diff --git a/hw/arm/tosa.c b/hw/arm/tosa.c
index c3db996..9f58a23 100644
--- a/hw/arm/tosa.c
+++ b/hw/arm/tosa.c
@@ -263,6 +263,7 @@ static void tosapda_machine_init(MachineClass *mc)
 {
     mc->desc = "Sharp SL-6000 (Tosa) PDA (PXA255)";
     mc->init = tosa_init;
+    mc->block_default_type = IF_IDE;
 }
 
 DEFINE_MACHINE("tosa", tosapda_machine_init)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 706e233..8d2a848 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2334,6 +2334,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->query_hotpluggable_cpus = pc_query_hotpluggable_cpus;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
     mc->reset = pc_machine_reset;
     hc->pre_plug = pc_machine_device_pre_plug_cb;
diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
index 9a4dae4..e636c3a 100644
--- a/hw/mips/mips_fulong2e.c
+++ b/hw/mips/mips_fulong2e.c
@@ -387,6 +387,7 @@ static void mips_fulong2e_machine_init(MachineClass *mc)
 {
     mc->desc = "Fulong 2e mini pc";
     mc->init = mips_fulong2e_init;
+    mc->block_default_type = IF_IDE;
 }
 
 DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index cf48f42..6b63179 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1264,6 +1264,7 @@ static void mips_malta_machine_init(MachineClass *mc)
 {
     mc->desc = "MIPS Malta Core LV";
     mc->init = mips_malta_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = 16;
     mc->is_default = 1;
 }
diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
index 27548c4..748586e 100644
--- a/hw/mips/mips_r4k.c
+++ b/hw/mips/mips_r4k.c
@@ -306,6 +306,7 @@ static void mips_machine_init(MachineClass *mc)
 {
     mc->desc = "mips r4k platform";
     mc->init = mips_r4k_init;
+    mc->block_default_type = IF_IDE;
 }
 
 DEFINE_MACHINE("mips", mips_machine_init)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index 2bfdb64..716aea6 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -518,6 +518,7 @@ static void core99_machine_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Mac99 based PowerMAC";
     mc->init = ppc_core99_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cd";
     mc->kvm_type = core99_kvm_type;
diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
index 56282c5..5df94e2 100644
--- a/hw/ppc/mac_oldworld.c
+++ b/hw/ppc/mac_oldworld.c
@@ -368,6 +368,7 @@ static void heathrow_machine_init(MachineClass *mc)
 {
     mc->desc = "Heathrow based PowerMAC";
     mc->init = ppc_heathrow_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = MAX_CPUS;
 #ifndef TARGET_PPC64
     mc->is_default = 1;
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 054af1e..ebf6af5 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -673,6 +673,7 @@ static void prep_machine_init(MachineClass *mc)
 {
     mc->desc = "PowerPC PREP platform";
     mc->init = ppc_prep_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = MAX_CPUS;
     mc->default_boot_order = "cad";
 }
diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index db373c7..6d06968 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -362,6 +362,7 @@ static void r2d_machine_init(MachineClass *mc)
 {
     mc->desc = "r2d-plus board";
     mc->init = r2d_init;
+    mc->block_default_type = IF_IDE;
 }
 
 DEFINE_MACHINE("r2d", r2d_machine_init)
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index d1a6bca..d347b66 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -579,6 +579,7 @@ static void sun4u_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Sun4u platform";
     mc->init = sun4u_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = 1; /* XXX for now */
     mc->is_default = 1;
     mc->default_boot_order = "c";
@@ -596,6 +597,7 @@ static void sun4v_class_init(ObjectClass *oc, void *data)
 
     mc->desc = "Sun4v platform";
     mc->init = sun4v_init;
+    mc->block_default_type = IF_IDE;
     mc->max_cpus = 1; /* XXX for now */
     mc->default_boot_order = "c";
 }
-- 
2.7.4
