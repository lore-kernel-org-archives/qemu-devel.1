Received: from eggs.gnu.org ([2001:4830:134:3::10]:48681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCI-0007Ks-Pv
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fYFCF-0000kx-GP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:47438 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fYFCF-00008B-1E
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 14:29:39 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 27 Jun 2018 20:29:02 +0200
Message-Id: <1530124149-3900-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530124149-3900-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 2/9] hw/mips/boston: don't make flash region
 'nomigrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Peter Maydell <peter.maydell@linaro.org>

Currently we use memory_region_init_rom_nomigrate() to create
the "boston.flash" memory region, and we don't manually register
it with vmstate_register_ram(). This currently means that its
contents are migrated but as a ram block whose name is the empty
string; in future it may mean they are not migrated at all. Use
memory_region_init_ram() instead.

Note that this is a a cross-version migration compatibility break
for the "boston" machine.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 hw/mips/boston.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 52cce19..14e6f95 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -471,8 +471,7 @@ static void boston_mach_init(MachineState *machine)
     sysbus_mmio_map_overlap(SYS_BUS_DEVICE(s->cps), 0, 0, 1);
=20
     flash =3D  g_new(MemoryRegion, 1);
-    memory_region_init_rom_nomigrate(flash, NULL,
-                                     "boston.flash", 128 * M_BYTE, &err)=
;
+    memory_region_init_rom(flash, NULL, "boston.flash", 128 * M_BYTE, &e=
rr);
     memory_region_add_subregion_overlap(sys_mem, 0x18000000, flash, 0);
=20
     ddr =3D g_new(MemoryRegion, 1);
--=20
2.7.4
