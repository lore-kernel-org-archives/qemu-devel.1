Received: from eggs.gnu.org ([209.51.188.92]:49158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1CwE-0006jH-8a
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1CwD-0002hD-IM
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1CwD-0002gW-Ao
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:29:05 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue,  5 Mar 2019 17:28:27 +0100
Message-Id: <20190305162829.20079-4-philmd@redhat.com>
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
References: <20190305162829.20079-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/5] hw/mips/malta: Restrict 'bios_size'
 variable scope
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

The 'bios_size' variable is only used in the 'if (!kernel_filename &&
!dinfo)' clause. This is the case when we don't provide -pflash command
line option, and also don't provide a -kernel option. In this case we
will check for the -bios option, or use the default BIOS_FILENAME file.

The 'bios' term is valid in this if statement, but is confuse in the
whole mips_malta_init() scope. Restrict his scope.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 00e5aac98b..396645b1a9 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1196,7 +1196,6 @@ void mips_malta_init(MachineState *machine)
     MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_postio;
     MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
-    target_long bios_size =3D FLASH_SIZE;
     const size_t smbus_eeprom_size =3D 8 * 256;
     uint8_t *smbus_eeprom_buf =3D g_malloc0(smbus_eeprom_size);
     int64_t kernel_entry, bootloader_run_addr;
@@ -1314,6 +1313,7 @@ void mips_malta_init(MachineState *machine)
                              bootloader_run_addr, kernel_entry);
         }
     } else {
+        target_long bios_size =3D FLASH_SIZE;
         /* The flash region isn't executable from a KVM guest */
         if (kvm_enabled()) {
             error_report("KVM enabled but no -kernel argument was specif=
ied. "
--=20
2.20.1
