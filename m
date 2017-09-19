Received: from eggs.gnu.org ([2001:4830:134:3::10]:36638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duINk-0001Dm-I6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1duINe-0004sy-MB
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:16:08 -0400
Received: from indium.canonical.com ([91.189.90.7]:34810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1duINe-0004s6-GX
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 09:16:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1duINa-0006ex-EK
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:15:58 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 185B22E84E2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 13:15:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Sep 2017 13:05:09 -0000
From: "Laszlo Ersek \(Red Hat\)" <lersek@redhat.com>
Reply-To: Bug 1715700 <1715700@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150480187483.29281.9921794433489304819.malonedeb@chaenomeles.canonical.com>
	<150582231000.13645.13271569408662777261.malone@gac.canonical.com>
	<1505824695.12708.7.camel@redhat.com>
Message-Id: <a9147815-5ad0-525c-5d91-152a6ac4dc9d@redhat.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1715700] Re: Windows 7 guest won't boot on
 qemu 2.10 (works on 2.9)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 09/19/17 14:38, Gerd Hoffmann wrote:
>> (2) Build the SeaBIOS CSM (CONFIG_CSM=3Dy), and embed it into OVMF,
>> like described above. Then, boot Windows 7 in *UEFI Mode*.
> =

>> Option #1 and option #2 no longer work because the CSM infrastructure
>> in edk2 needs to be able to write 0xc0000.
> =

> Well, option #2 works for me.
> =


Correct, and that's because edk2 commit db27e9f3d8f0 fixed the PAM
register offsets for Q35, in the CSM platform support. At that time we
missed that the same should be done in the VBE Shim as well.

I'm going to do it for the VBE Shim now.

(I'm pretty sure UEFI Windows 7 boots fine with the VBE Shim right now,
on QEMU 2.10, if the machine type is i440fx, not q35.)

Thanks for the help!
Laszlo

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715700

Title:
  Windows 7 guest won't boot on qemu 2.10 (works on 2.9)

Status in QEMU:
  New

Bug description:
  Qemu version: 2.10 stable.
  Guest: Windows 7 SP1 x64, virtio drivers are already installed in the gue=
st.
  Command line:
  qemu-system-x86_64 \
      -nodefaults \
      -nodefconfig \
      -machine type=3Dq35,accel=3Dkvm \
      -enable-kvm \
      -cpu host \
      -m 2048 \
      -vga virtio \
      -boot menu=3Don \
      -smbios file=3D/path/dmidecode_BIOS.bin \
      -acpitable file=3D/path/acpi_slic.bin \
      -bios /path/OVMF_CODE.fd \
      -net none \
      -drive if=3Dvirtio,media=3Ddisk,file=3D/media/win7.qcow2 \
      -device pcie-root-port \
      -device ich9-usb-ehci1 \
      -device ich9-usb-uhci1 \
      -device ich9-usb-uhci2 \
      -device ich9-usb-uhci3

  Windows hangs at boot with waving flag screen (flag doesn't freeze,
  keeps waving indefinitely). Same command line boots fine with Qemu
  2.9. I tried changing machine type to pc-q35-2.9 - same result.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715700/+subscriptions
