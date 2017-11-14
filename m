Received: from eggs.gnu.org ([2001:4830:134:3::10]:38459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEbSZ-0000MI-Ko
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eEbSX-0006QX-0B
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:41:03 -0500
Received: from indium.canonical.com ([91.189.90.7]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eEbSW-0006Ld-QI
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 08:41:00 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eEbSV-0000da-1G
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 13:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 07A1C2E80CC
	for <qemu-devel@nongnu.org>; Tue, 14 Nov 2017 13:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Nov 2017 13:35:41 -0000
From: Googulator <1717708@bugs.launchpad.net>
Reply-To: Bug 1717708 <1717708@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
Message-Id: <151066654138.28580.6738883568716000930.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1717708] Re: QEMU aarch64 can't run Windows ARM64
 iso's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

virtio-gpu-pci will not work for booting Windows.

Per https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup
/uefi-requirements-that-apply-to-all-windows-platforms, Windows
currently requires a linear framebuffer to be exposed through the UEFI
Graphics Output Protocol:

"Windows requires the Graphics Output Protocol (GOP). Specific frame
buffer requirements are:

    For integrated displays, HorizontalResolution and VerticalResoluton
must be the native resolution of the panel.

    For External displays, HorizontalResolution and VerticalResoluton
must be the native resolution of the display, or, if this is not
supported, then the highest values supported by both the video adapter
and the connected display.

    PixelsPerScanLine must be equal to HorizontalResolution.

    PixelFormat must be PixelBlueGreenRedReserved8BitPerColor. Note that
a physical frame buffer is required; PixelBltOnly is not supported.

When execution is handed off to a UEFI boot application, the firmware
boot manager and firmware must not use the frame buffer for any purpose.
The frame buffer must continue to be scanned out after boot services
have exited."

The virtio-gpu driver uses PixelBltOnly, which Windows explicitly
doesn't support. Also, IIRC the Gop->Blt() handler of virtio-gpu is only
available while UEFI Boot Services are active (before ExitBootServices()
is called, which is something the Windows boot manager does very early),
so even if Microsoft tried to implement Gop->Blt() support in the MSBDA
driver, it couldn't be used with virtio-gpu, as its Gop->Blt() is not
available at run time.

Instead, "-device VGA" is required.

Mainline edk2 is currently unable to boot any Windows images due to some
required features being removed as they aren't compatible with KVM (I
don't quite get it - UEFI for aarch64 virt is supposed to be for qemu in
general, not exclusive to KVM...), however I actually have a fork with
these features restored, available at
https://github.com/Googulator/edk2/releases. This is able to boot the
leaked Windows Server 2016 beta builds 14282, 14324 and 14877, but not
14901 or any of the Windows 10 Insider builds, due to an exception loop
very similar to that seen when trying to run SBSA-ACS.

Also, the only storage option Windows can actually read and boot from is
USB mass storage over EHCI - anything else is either lacking drivers
(virtio-scsi and the various emulated LSI Logic adapters) or fails to
start due to a resource conflict (AHCI, UAS, USB mass storage over
XHCI). Detailed instructions for booting the leaked builds are available
here: https://www.betaarchive.com/forum/viewtopic.php?p=3D426768#p426768
The same instructions cause the previously mentioned exception loop when
tried with the Insider builds.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1717708

Title:
  QEMU aarch64 can't run Windows ARM64 iso's

Status in QEMU:
  New

Bug description:
  Hi,
  recently Windows ARM64 ISOs have been posted on the internet..
  just checked with latest QEMU 2.10 release from =

  https://qemu.weilnetz.de/w64/qemu-w64-setup-20170830.exe =

  "h:\qemu\qemu-system-aarch64.exe" -boot d -cdrom h:\iso\16353.1000.170825=
-1423.RS_PRERELEASE_CLIENTPRO_OEMRET_ARM64FRE_ES-ES.ISO -m 2048 -cpu cortex=
-a57 -smp 1 -machine virt
  seems no video output..
  checked various machine options for example versatilepb (says guest has n=
ot initialized the guest)..

  so don't know if it's a QEMU bug or lacking feature but can support
  running Windows ARM64 builds (would be nice if you can add a
  Snapdragon835 machine type which is which first machines will be
  running..)

  =

  note running a Windows x64 ISO with similar parameters works (removing -c=
pu and -machine as not needed)

  thanks..

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1717708/+subscriptions
