Received: from eggs.gnu.org ([209.51.188.92]:58552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1WHE-0003ke-W0
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:08:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1WHE-0003iC-61
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:08:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1WHD-0003hw-Vp
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:08:04 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
Date: Wed, 06 Mar 2019 14:07:58 +0100
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 17:28:24
	+0100")
Message-ID: <87k1hcywup.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] mips_malta: Clean up definition of
 flash memory size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Hi Markus,
>
> this is a rework of your 'mips_malta: Clean up definition of flash memory=
 size somewhat' patch:
> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html

Diff between my patch and your series:

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 9ade9b194c..2827074e9b 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
     if (dinfo) {
         printf("Register parallel flash %d size " TARGET_FMT_lx " at "
                "addr %08llx '%s' %x\n",
-               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
+               fl_idx, bios_size, FLASH_ADDRESS,
                blk_name(dinfo->bdrv), fl_sectors);
     }
 #endif
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
-                               FLASH_SIZE,
+                               BIOS_SIZE,
                                dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
                                65536, fl_sectors,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);

We have in include/hw/mips/bios.h

    #define BIOS_SIZE (4 * MiB)

and locally

    #define FLASH_SIZE    0x400000

    target_long bios_size =3D FLASH_SIZE;

Three names for the same value.  Therefore, there's no functional
difference, just more cleanup.  Good to know.
