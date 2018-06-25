Received: from eggs.gnu.org ([2001:4830:134:3::10]:58193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXl4-0002g1-42
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fXXkz-0002M2-Hf
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:42 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40227 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fXXkz-00023I-AK
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 16:06:37 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 25 Jun 2018 22:05:58 +0200
Message-Id: <1529957164-4744-4-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/9] hw/mips/mips_malta: don't make bios region
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
the "bios.1fc" memory region, and we don't manually register
it with vmstate_register_ram(). This currently means that its
contents are migrated but as a ram block whose name is the empty
string; in future it may mean they are not migrated at all. Use
memory_region_init_ram() instead.

Note that this is a a cross-version migration compatibility break
for the "malta" machine.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 494f84e..b9d92bf 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1152,7 +1152,7 @@ void mips_malta_init(MachineState *machine)
      * handled by an overlapping region as the resulting ROM code subpag=
e
      * regions are not executable.
      */
-    memory_region_init_ram_nomigrate(bios_copy, NULL, "bios.1fc", BIOS_S=
IZE,
+    memory_region_init_ram(bios_copy, NULL, "bios.1fc", BIOS_SIZE,
                            &error_fatal);
     if (!rom_copy(memory_region_get_ram_ptr(bios_copy),
                   FLASH_ADDRESS, BIOS_SIZE)) {
--=20
2.7.4
