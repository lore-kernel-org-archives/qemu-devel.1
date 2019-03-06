Received: from eggs.gnu.org ([209.51.188.92]:32932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1WRG-0000m9-Dn
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1WRF-0001DB-CV
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:18:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1h1WRF-0001Cn-35
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 08:18:25 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
	<87k1hcywup.fsf@dusky.pond.sub.org>
Date: Wed, 06 Mar 2019 14:18:20 +0100
In-Reply-To: <87k1hcywup.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Wed, 06 Mar 2019 14:07:58 +0100")
Message-ID: <875zswywdf.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Markus Armbruster <armbru@redhat.com> writes:

> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
>> Hi Markus,
>>
>> this is a rework of your 'mips_malta: Clean up definition of flash memor=
y size somewhat' patch:
>> https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html
>
> Diff between my patch and your series:
>
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 9ade9b194c..2827074e9b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>      if (dinfo) {
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>                 "addr %08llx '%s' %x\n",
> -               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
> +               fl_idx, bios_size, FLASH_ADDRESS,
>                 blk_name(dinfo->bdrv), fl_sectors);
>      }
>  #endif
>      fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
> -                               FLASH_SIZE,
> +                               BIOS_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                 65536, fl_sectors,
>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
>
> We have in include/hw/mips/bios.h
>
>     #define BIOS_SIZE (4 * MiB)
>
> and locally
>
>     #define FLASH_SIZE    0x400000
>
>     target_long bios_size =3D FLASH_SIZE;
>
> Three names for the same value.  Therefore, there's no functional
> difference, just more cleanup.  Good to know.

Wrong diff, sorry.

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 9ade9b194c..a5726edaa7 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -40,6 +40,7 @@
 #include "hw/pci/pci.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/block-backend.h"
 #include "qemu/log.h"
 #include "hw/mips/bios.h"
 #include "hw/ide.h"
@@ -1195,7 +1196,6 @@ void mips_malta_init(MachineState *machine)
     MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_postio;
     MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
-    target_long bios_size =3D FLASH_SIZE;
     const size_t smbus_eeprom_size =3D 8 * 256;
     uint8_t *smbus_eeprom_buf =3D g_malloc0(smbus_eeprom_size);
     int64_t kernel_entry, bootloader_run_addr;
@@ -1205,10 +1205,10 @@ void mips_malta_init(MachineState *machine)
     qemu_irq cbus_irq, i8259_irq;
     int piix4_devfn;
     I2CBus *smbus;
+    BlockBackend *pflash_blk =3D NULL;
     DriveInfo *dinfo;
     DriveInfo *hd[MAX_IDE_BUS * MAX_IDE_DEVS];
     int fl_idx =3D 0;
-    int fl_sectors =3D bios_size >> 16;
     int be;
=20
     DeviceState *dev =3D qdev_create(NULL, TYPE_MIPS_MALTA);
@@ -1265,18 +1265,24 @@ void mips_malta_init(MachineState *machine)
=20
     /* Load firmware in flash / BIOS. */
     dinfo =3D drive_get(IF_PFLASH, 0, fl_idx);
-#ifdef DEBUG_BOARD_INIT
     if (dinfo) {
+        pflash_blk =3D blk_by_legacy_dinfo(dinfo);
+
+        if (blk_getlength(pflash_blk) !=3D FLASH_SIZE) {
+                error_report("Malta CoreLV card expects a bios of 4MB");
+                exit(1);
+        }
+#ifdef DEBUG_BOARD_INIT
         printf("Register parallel flash %d size " TARGET_FMT_lx " at "
-               "addr %08llx '%s' %x\n",
-               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
-               blk_name(dinfo->bdrv), fl_sectors);
-    }
+               "addr %08llx '%s'\n",
+               fl_idx, blk_getlength(pflash_blk), FLASH_ADDRESS,
+               blk_name(pflash_blk));
 #endif
+    }
     fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
                                FLASH_SIZE,
-                               dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
-                               65536, fl_sectors,
+                               pflash_blk,
+                               65536, FLASH_SIZE >> 16,
                                4, 0x0000, 0x0000, 0x0000, 0x0000, be);
     bios =3D pflash_cfi01_get_memory(fl);
     fl_idx++;
@@ -1312,6 +1318,7 @@ void mips_malta_init(MachineState *machine)
                              bootloader_run_addr, kernel_entry);
         }
     } else {
+        target_long bios_size =3D FLASH_SIZE;
         /* The flash region isn't executable from a KVM guest */
         if (kvm_enabled()) {
             error_report("KVM enabled but no -kernel argument was specifie=
d. "
