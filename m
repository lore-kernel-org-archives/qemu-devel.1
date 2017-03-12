Received: from eggs.gnu.org ([2001:4830:134:3::10]:54882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cmwWf-0005R1-Ou
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:58:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <phil@philjordan.eu>) id 1cmwWb-0004Nz-3f
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:58:41 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <phil@philjordan.eu>) id 1cmwWa-0004Nf-SX
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 00:58:37 -0500
Received: by mail-pf0-x241.google.com with SMTP id j5so15446846pfb.3
	for <qemu-devel@nongnu.org>; Sat, 11 Mar 2017 21:58:34 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
Date: Sun, 12 Mar 2017 18:58:09 +1300
Message-Id: <1489298291-25154-1-git-send-email-phil@philjordan.eu>
Subject: [Qemu-devel] [PATCH v2 0/2] hw/i386: Update FADT to Revision 3
 (ACPI 2.0)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>
Cc: Phil Dennis-Jordan <phil@philjordan.eu>

This updates the FADT generated for x86/64 machine types from Revision 1 to 3. (Based on ACPI standard 2.0 instead of 1.0) As previously, the goal is to make running macOS/OS X guests smoother. With a Rev1 FADT, rebooting such a guest doesn't work, as the OS uses the reset register information from the FADT. Switching to a Rev3 (ACPI 2.0) FADT solves this problem.

The previous discussion of this raised a bunch of points, which I'll address/clarify here as well:

 1. No runtime option. The preference was expressed that we try to stay backwards-compatible with legacy guests as opposed to adding a runtime option for different APCI versions. ACPI 2.0/FADT Rev3 is the minimum version required for exposing the reset register, and it is also backwards-compatible with 1.0/Rev1, so that seemed a good version to target.

 2. Legacy guest testing. I've tested this successfully (no apparent regressions) with:
   * Windows XP x86 (both "pc" and "q35" machine types, the latter using -device piix4-ide)
   * Windows 7, both 32-bit and 64-bit editions
   * Windows 10 x64
   * Fedora 7 x86 Live image
   * Fedora 25 x86_64 Live image
   * Ubuntu 10.04.4 AMD64 Live image
Any other specific OSes and versions I should check?


 3. 64-bit and 32-bit pointer fields.

Only very recent versions of the ACPI spec (6.1 and various errata of 5.1 and 6.0) are clear about mutual exclusion of the FADT's 32-bit and 64-bit variants of pointers to tables and registers. The 2.0 version simply states "This is a required field" for both PM1a_EVT_BLK and X_PM1a_EVT_BLK, for example, although it does also state for the former that "This field is superseded in ACPI 2.0 by the X_PM1a_EVT_BLK field." No requirement is specified explicitly for the DSDT and X_DSDT fields.

In practice, I have found that Windows 10 will fail to boot with a Rev3 FADT unless BOTH the 32-bit and 64-bit variants are filled. The exception is X_FIRMWARE_CTRL, which is the first to be explicitly marked as mutually exclusive with FIRMWARE_CTRL in an ACPI spec - with a preference for FIRMWARE_CTRL if the pointer fits in a 32-bit field. Satisfying Windows 10 in this way does not contradict the 2.0 specification, and it also complies with the 1.0 standard for the fields which Rev1 of the FADT already has, so that's what I've gone with in the implementation.

The only problem is that upstream OVMF cannot deal with multiple pointers to the same table in the linker commands. This turns out to be a bug in OVMF/EDK2[1], and I am submitting a separate patch to EDK2 to fix that problem. The fix for a second issue where OVMF would rewrite the FADT so the DSDT is erroneously set to 0 has already been upstreamed.[2] I don't see a workaround to this other than fixing the OVMF code.

 4. i440FX vs Q35

Both machine types have the reset register, and it's at the same I/O port. To illustrate/document this, the second patch in the series adds a build-time assertion that this is indeed so.

Changelog
=========

v1 -> v2:
 * v1 Thread was "[PATCH RFC] acpi: add reset register to fadt"
 * Instead of just adding the reset register, set up a fully standards compliant Rev3 FADT. (ACPI 2.0)
 * A compile-time assertion has been added for the PC/Q35 reset register equivalence.


[1]: https://bugzilla.tianocore.org/show_bug.cgi?id=368
[2]: EDK2 commit range e0e1cfcbbb24..198a46d768fb


Phil Dennis-Jordan (2):
  hw/i386: Use Rev3 FADT (ACPI 2.0) instead of Rev1 to improve guest OS
    support.
  hw/i386: Build-time assertion on pc/q35 reset register being
    identical.

 hw/i386/acpi-build.c        | 35 +++++++++++++++++++--
 hw/pci-host/piix.c          |  6 ----
 include/hw/acpi/acpi-defs.h | 77 +++++++++++++++++++++------------------------
 include/hw/i386/pc.h        |  6 ++++
 tests/bios-tables-test.c    |  4 +--
 5 files changed, 76 insertions(+), 52 deletions(-)

-- 
2.3.2 (Apple Git-55)
