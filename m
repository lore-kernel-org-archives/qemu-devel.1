Received: from eggs.gnu.org ([209.51.188.92]:52478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sgW-0004zT-Au
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sgQ-0003be-En
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 08:03:40 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  7 Mar 2019 14:03:21 +0100
Message-Id: <20190307130323.9353-13-armbru@redhat.com>
In-Reply-To: <20190307130323.9353-1-armbru@redhat.com>
References: <20190307130323.9353-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 12/14] mips_malta: Clean up definition of
 flash memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

pflash_cfi01_register() takes a size in bytes, a block size in bytes
and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
locally as 0x400000).  Confusing all the same.

Pass FLASH_SIZE instead of BIOS_SIZE.

Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index e6a67bab1d..f63b1c4776 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1275,7 +1275,7 @@ void mips_malta_init(MachineState *machine)
 #endif
     }
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
-                               BIOS_SIZE,
+                               FLASH_SIZE,
                                pflash_blk,
                                65536, FLASH_SIZE >> 16,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
--=20
2.17.2
