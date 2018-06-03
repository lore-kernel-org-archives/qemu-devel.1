Received: from eggs.gnu.org ([2001:4830:134:3::10]:55049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fPPHj-00024x-0x
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 05:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fPPHf-0008Dh-Px
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 05:26:47 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fPPHf-0008Cs-JR
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 05:26:43 -0400
Received: by mail-wm0-x243.google.com with SMTP id m129-v6so9305916wmb.3
	for <qemu-devel@nongnu.org>; Sun, 03 Jun 2018 02:26:43 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sun,  3 Jun 2018 12:27:49 +0300
Message-Id: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net, marcel.apfelbaum@gmail.com

Moving to QEMU 3.0 seems like a good opportunity for such a change.

I440FX is really old and does not support modern features like IOMMU.
Q35's SATA emulation is faster than pc's IDE, native PCI express hotplug
is cleaner than ACPI based one and so on...

Also the libvirt guys added very good support for the Q35 machine (thanks!).

Management software should always specify the machine type and for the
current setups, adding '-machine pc' to the command line is not such a
big deal.

In time the pc machine will fade out and we will probably stop adding
new versions at some point.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/i386/pc_piix.c | 2 --
 hw/i386/pc_q35.c  | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index b4c5b03274..16dd65198f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -429,7 +429,6 @@ static void pc_i440fx_3_0_machine_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
-    m->is_default = 1;
 }
 
 DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
@@ -438,7 +437,6 @@ DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
 static void pc_i440fx_2_12_machine_options(MachineClass *m)
 {
     pc_i440fx_3_0_machine_options(m);
-    m->is_default = 0;
     m->alias = NULL;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 83d6d75efa..b33c235d49 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -312,6 +312,7 @@ static void pc_q35_3_0_machine_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
+    m->is_default = 1;
 }
 
 DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
@@ -321,6 +322,7 @@ static void pc_q35_2_12_machine_options(MachineClass *m)
 {
     pc_q35_3_0_machine_options(m);
     m->alias = NULL;
+    m->is_default = 0;
     SET_MACHINE_COMPAT(m, PC_COMPAT_2_12);
 }
 
-- 
2.13.6
