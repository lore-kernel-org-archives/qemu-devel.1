Received: from eggs.gnu.org ([2001:4830:134:3::10]:56664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMx-0004GT-Hn
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fryMu-0000S9-AG
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 00:34:15 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 21 Aug 2018 14:33:37 +1000
Message-Id: <20180821043343.7514-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180821043343.7514-1-david@gibson.dropbear.id.au>
References: <20180821043343.7514-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/26] hw/ppc: deprecate the machine type 'prep',
 replaced by '40p'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, lvivier@redhat.com, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>

From: Herv=C3=A9 Poussineau <hpoussin@reactos.org>

- prep machine is a fictional machine, so has no specifications. Which
  devices can be changed/added/removed without impact? Are interrupts
  correctly mapped?
- prep firmware (OHW) has support only for IDE drives (no SCSI).
  Booting from IDE has been broken approximatively 3 years ago, and nobod=
y complained.
- OHW is limited on IDE boot to a specific set of OS loaders.
  These operating systems are of the 2004 time frame.
- OHW can use -kernel. Linux kernel freezes a long time after PS/2 mouse
  detection, and then screen becomes garbage. This was already broken in
  QEMU v2.7, 2 years ago, and nobody complained.

On the other side:
- 40p is a real machine, so emulation can be checked against
  hardware specifications
- OpenBIOS has support for SCSI block devices, including 40p LSI adapter
- OpenBIOS can start mostly all Linux kernels (including recent ones)
  and recent operating system (like NetBSD 7.1.2)

Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
[dwg: Drop prep from boot-serial test to avoid deprecation warnings]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/prep.c            | 1 +
 tests/boot-serial-test.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index b26138e5c4..83083e4f1b 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -587,6 +587,7 @@ static void ppc_prep_init(MachineState *machine)
=20
 static void prep_machine_init(MachineClass *mc)
 {
+    mc->deprecation_reason =3D "use 40p machine type instead";
     mc->desc =3D "PowerPC PREP platform";
     mc->init =3D ppc_prep_init;
     mc->block_default_type =3D IF_IDE;
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index fca5f2f5da..f123b15e3e 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -75,13 +75,11 @@ typedef struct testdef {
 static testdef_t tests[] =3D {
     { "alpha", "clipper", "", "PCI:" },
     { "ppc", "ppce500", "", "U-Boot" },
-    { "ppc", "prep", "-m 96", "Memory size: 96 MB" },
     { "ppc", "40p", "-boot d", "Booting from device d" },
     { "ppc", "g3beige", "", "PowerPC,750" },
     { "ppc", "mac99", "", "PowerPC,G4" },
     { "ppc", "sam460ex", "-m 256", "DRAM:  256 MiB" },
     { "ppc64", "ppce500", "", "U-Boot" },
-    { "ppc64", "prep", "-boot e", "Booting from device e" },
     { "ppc64", "40p", "-m 192", "Memory size: 192 MB" },
     { "ppc64", "mac99", "", "PowerPC,970FX" },
     { "ppc64", "pseries", "", "Open Firmware" },
--=20
2.17.1
