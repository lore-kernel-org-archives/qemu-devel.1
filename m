Received: from eggs.gnu.org ([209.51.188.92]:35891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6X-0000GQ-Lb
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h3T6V-0004i1-Ns
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h3T6T-0004en-MB
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 18:09:03 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 11 Mar 2019 23:08:29 +0100
Message-Id: <20190311220843.4026-14-armbru@redhat.com>
In-Reply-To: <20190311220843.4026-1-armbru@redhat.com>
References: <20190311220843.4026-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/27] mips_malta: Clean up definition of flash
 memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>

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
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20190308094610.21210-14-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 4dfe06a1a0..2f20f56458 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1262,7 +1262,7 @@ void mips_malta_init(MachineState *machine)
     /* Load firmware in flash / BIOS. */
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
-                               BIOS_SIZE,
+                               FLASH_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL=
,
                                65536, FLASH_SIZE >> 16,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
--=20
2.17.2
