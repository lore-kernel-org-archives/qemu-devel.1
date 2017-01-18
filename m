Received: from eggs.gnu.org ([2001:4830:134:3::10]:58755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cToiP-0005Ja-Id
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cToiM-000542-FE
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:47:45 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:37607)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cToiM-00053M-7h
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:47:42 -0500
Received: by mail-wm0-x22d.google.com with SMTP id c206so21044646wme.0
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 03:47:40 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Wed, 18 Jan 2017 12:45:54 +0100
Message-Id: <1484739954-86833-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH RFC] acpi: add reset register to fadt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>

About 2 years ago, Reza Jelveh submitted essentially this same patch:
https://lists.gnu.org/archive/html/qemu-devel/2015-03/msg05832.html

It adds the reset register defined in ACPI 2.0 to the x86 FADT, which fixes rebooting for Darwin/OS X/macOS guests.

I'm trying to revive this as part of an effort to get recent versions of OS X/macOS working in Qemu/KVM with OVMF and without the need for out-of-tree patches. I've adapted the original patch so it cleanly applies on current master. The unaddressed issues last time around were:

 1. Does this work with a range of Windows versions?

I've tested this new version of the patch with KVM from Ubuntu's 4.4.0-51-generic kernel, using the following guests:

 * Windows XP SP2 and SP3, x86. "pc" (FX440) machine, IDE disk, SeaBIOS.
 * Windows 7 SP 1, x86. "pc" (FX440) machine, AHCI disk, SeaBIOS.
 * Windows 10 1607, x86-64, q35 machine, AHCI disk, OVMF from 2017-01-17 EDK2 master.
 * OS X 10.9 to 10.11, macOS 10.12; patched OVMF [1]

In all cases I went through a fresh install, checked basic functionality, and rebooting. I noticed nothing different in any of the Windows VMs, and of course the Darwin-based ones no longer hang when attempting to reboot.


 2. The reset register is defined in ACPI 2.0, this still advertises 1.0.

I have to admit, I know very little about how ACPI works, so I'm not sure I got this right, but: I subsequently added a line
    rsdp->revision = 0x02;
to build_rsdp() in acpi-build.c, then booted the aforementioned Windows VMs, and the macOS 10.12 one with this change. I noticed no change or ill effect whatsoever.

I suspect more might be involved in enabling ACPI 2.0, and it should probably be an option so as to avoid regressions. I don't know what the best approach would be for this, so comments welcome. Should adding the reset register to the FADT also be configurable?


Additionally, please suggest any further guest OSes and configurations I should test which seem likely to exhibit regressions with this change.

(First post to this list - apologies if I messed up any of the conventions! Thanks, phil)

[1] EDK2 fork with OS X/macOS compatibility patches: https://github.com/pmj/edk2/tree/mac-patches

---
 hw/i386/acpi-build.c        | 5 +++++
 include/hw/acpi/acpi-defs.h | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0c8912f..93781a0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -296,6 +296,11 @@ static void fadt_setup(AcpiFadtDescriptorRev1 *fadt, AcpiPmInfo *pm)
                               (1 << ACPI_FADT_F_SLP_BUTTON) |
                               (1 << ACPI_FADT_F_RTC_S4));
     fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_USE_PLATFORM_CLOCK);
+    fadt->flags |= cpu_to_le32(1 << ACPI_FADT_F_RESET_REG_SUP);
+    fadt->reset_val = 0xf;
+    fadt->reset_reg.address_space_id   = 1;
+    fadt->reset_reg.register_bit_width = 8;
+    fadt->reset_reg.address            = ICH9_RST_CNT_IOPORT;
     /* APIC destination mode ("Flat Logical") has an upper limit of 8 CPUs
      * For more than 8 CPUs, "Clustered Logical" mode has to be used
      */
diff --git a/include/hw/acpi/acpi-defs.h b/include/hw/acpi/acpi-defs.h
index 4cc3630..5755570 100644
--- a/include/hw/acpi/acpi-defs.h
+++ b/include/hw/acpi/acpi-defs.h
@@ -140,6 +140,8 @@ struct AcpiFadtDescriptorRev1
     uint8_t  reserved4a;             /* Reserved */
     uint8_t  reserved4b;             /* Reserved */
     uint32_t flags;
+    Acpi20GenericAddress reset_reg;
+    uint8_t reset_val;
 } QEMU_PACKED;
 typedef struct AcpiFadtDescriptorRev1 AcpiFadtDescriptorRev1;
 
-- 
2.3.2 (Apple Git-55)
