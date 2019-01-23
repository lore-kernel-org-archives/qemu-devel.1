Received: from eggs.gnu.org ([209.51.188.92]:34823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZn-0001ls-8M
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1gmFZm-0007W4-5O
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 05:16:07 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 23 Jan 2019 11:14:50 +0100
Message-Id: <20190123101458.12478-11-eric.auger@redhat.com>
In-Reply-To: <20190123101458.12478-1-eric.auger@redhat.com>
References: <20190123101458.12478-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 10/18] hw/arm/virt: Bump the 255GB initial
 RAM limit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com, david@redhat.com
Cc: dgilbert@redhat.com, david@gibson.dropbear.id.au, drjones@redhat.com

Now we have the extended memory map (high IO regions beyond the
scalable RAM) and dynamic IPA range support at KVM/ARM level
we can bump the legacy 255GB initial RAM limit. The actual maximum
RAM size now depends on the physical CPU and host kernel.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/virt.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a89ffbf4d7..61c3bb1cef 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -93,22 +93,9 @@
=20
 #define PLATFORM_BUS_NUM_IRQS 64
=20
-/* RAM limit in GB. Since VIRT_MEM starts at the 1GB mark, this means
- * RAM can go up to the 256GB mark, leaving 256GB of the physical
- * address space unallocated and free for future use between 256G and 51=
2G.
- * If we need to provide more RAM to VMs in the future then we need to:
- *  * allocate a second bank of RAM starting at 2TB and working up
- *  * fix the DT and ACPI table generation code in QEMU to correctly
- *    report two split lumps of RAM to the guest
- *  * fix KVM in the host kernel to allow guests with >40 bit address sp=
aces
- * (We don't want to fill all the way up to 512GB with RAM because
- * we might want it for non-RAM purposes later. Conversely it seems
- * reasonable to assume that anybody configuring a VM with a quarter
- * of a terabyte of RAM will be doing it on a host with more than a
- * terabyte of physical address space.)
- */
-#define RAMLIMIT_GB 255
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * 1024ULL * 1024 * 1024)
+/* Legacy RAM limit in GB (< version 4.0) */
+#define LEGACY_RAMLIMIT_GB 255
+#define LEGACY_RAMLIMIT_BYTES (LEGACY_RAMLIMIT_GB * GiB)
=20
 /* Addresses and sizes of our components.
  * 0..128MB is space for a flash device so we can run bootrom code such =
as UEFI.
@@ -149,7 +136,7 @@ static const MemMapEntry a15memmap[] =3D {
     [VIRT_PCIE_MMIO] =3D          { 0x10000000, 0x2eff0000 },
     [VIRT_PCIE_PIO] =3D           { 0x3eff0000, 0x00010000 },
     [VIRT_PCIE_ECAM] =3D          { 0x3f000000, 0x01000000 },
-    [VIRT_MEM] =3D                { 0x40000000, RAMLIMIT_BYTES },
+    [VIRT_MEM] =3D                { 0x40000000, LEGACY_RAMLIMIT_BYTES },
 };
=20
 /* Memory map beyond the RAM */
@@ -1456,8 +1443,9 @@ static void machvirt_init(MachineState *machine)
=20
     vms->smp_cpus =3D smp_cpus;
=20
-    if (machine->ram_size > vms->memmap[VIRT_MEM].size) {
-        error_report("mach-virt: cannot model more than %dGB RAM", RAMLI=
MIT_GB);
+    if (!vms->extended_memmap && machine->ram_size > LEGACY_RAMLIMIT_GB)=
 {
+        error_report("mach-virt: cannot model more than %dGB RAM",
+                     LEGACY_RAMLIMIT_GB);
         exit(1);
     }
=20
--=20
2.20.1
