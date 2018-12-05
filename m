Received: from eggs.gnu.org ([2001:4830:134:3::10]:34985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUVYj-0002Iw-5t
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:41:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gUVYf-0005mC-4P
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:41:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:48736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gUVYe-0005lR-Sk
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 06:41:37 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gUVYd-0006by-Fh
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 11:41:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3E5AB2E80CC
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 11:41:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Dec 2018 11:32:50 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Reply-To: Bug 1804961 <1804961@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154309137717.32238.5287661827417174062.malonedeb@wampee.canonical.com>
Message-Id: <154400957075.32470.6106997050951996451.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1804961] Re: qemu-system-aarch64: Windows 10
 ARM64 BSoD on boot while using virt-3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Could it be related to:

commit 17ec075a651a3f9613429c2d97018fce459ed943
Author: Eric Auger <eric.auger@redhat.com>
Date:   Fri Jun 22 13:28:37 2018 +0100

    hw/arm/virt: Use 256MB ECAM region by default

    With this patch, virt-3.0 machine uses a new 256MB ECAM region
    by default instead of the legacy 16MB one, if highmem is set
    (LPAE supported by the guest) and (!firmware_loaded || aarch64).

    Indeed aarch32 mode FW may not support this high ECAM region.

As far as I can tell the only real differences between virt-2.12 and
later at the size of the ECAM region and the max number of CPUs it
supports:

static void virt_machine_2_12_options(MachineClass *mc)
{
    VirtMachineClass *vmc =3D VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));

    virt_machine_3_0_options(mc);
    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_12);
    vmc->no_highmem_ecam =3D true;
    mc->max_cpus =3D 255;
}


** Tags added: aarch64 acpi

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1804961

Title:
  qemu-system-aarch64: Windows 10 ARM64 BSoD on boot while using
  virt-3.0

Status in QEMU:
  New

Bug description:
  When I emulate a virt-3.0 machine, Windows 10 BSoD on boot, with the
  error code being ACPI_BIOS_ERROR(0x000000A5), virt-2.12 boots fine.

  Windows Build: 10.0.17134.1
  QEMU version: 3.0.0
  Commandline: qemu-system-aarch64 -M virt -accel tcg,thread=3Dmulti -cpu c=
ortex-a57 -smp 2 -m 2048 -bios QEMU_EFI.fd -device ramfb -device nec-usb-xh=
ci -device usb-kbd -device usb-tablet -hda disk.vhd -vnc :0

  By the way, the patch to add DBG2 table discussed here
  https://lists.gnu.org/archive/html/qemu-devel/2015-09/msg01719.html
  works (although minor change is required to adapt to the qemu 3.0.0
  code), the table is accepted by Windows (Windows require both DBG2 and
  SPCR to be valid for serial kernel debugging to work), so it may help
  further diagnosing this issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1804961/+subscriptions
