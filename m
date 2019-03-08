Received: from eggs.gnu.org ([209.51.188.92]:43166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C5A-0002II-MA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2C59-0006H2-P2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:46:24 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 10:46:07 +0100
Message-Id: <20190308094610.21210-13-armbru@redhat.com>
In-Reply-To: <20190308094610.21210-1-armbru@redhat.com>
References: <20190308094610.21210-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 12/15] hw/mips/malta: Restrict 'bios_size'
 variable scope
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, philmd@redhat.com, balaton@eik.bme.hu

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

The 'bios_size' variable is only used in the 'if (!kernel_filename &&
!dinfo)' clause. This is the case when we don't provide -pflash command
line option, and also don't provide a -kernel option. In this case we
will check for the -bios option, or use the default BIOS_FILENAME file.

The 'bios' term is valid in this if statement, but is confuse in the
whole mips_malta_init() scope. Restrict his scope.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/mips/mips_malta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
index 51a3ecab59..4dfe06a1a0 100644
--- a/hw/mips/mips_malta.c
+++ b/hw/mips/mips_malta.c
@@ -1193,7 +1193,6 @@ void mips_malta_init(MachineState *machine)
     MemoryRegion *ram_low_preio =3D g_new(MemoryRegion, 1);
     MemoryRegion *ram_low_postio;
     MemoryRegion *bios, *bios_copy =3D g_new(MemoryRegion, 1);
-    target_long bios_size =3D FLASH_SIZE;
     const size_t smbus_eeprom_size =3D 8 * 256;
     uint8_t *smbus_eeprom_buf =3D g_malloc0(smbus_eeprom_size);
     int64_t kernel_entry, bootloader_run_addr;
@@ -1301,6 +1300,7 @@ void mips_malta_init(MachineState *machine)
                              bootloader_run_addr, kernel_entry);
         }
     } else {
+        target_long bios_size =3D FLASH_SIZE;
         /* The flash region isn't executable from a KVM guest */
         if (kvm_enabled()) {
             error_report("KVM enabled but no -kernel argument was specif=
ied. "
--=20
2.17.2
