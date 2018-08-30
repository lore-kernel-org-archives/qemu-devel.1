Received: from eggs.gnu.org ([2001:4830:134:3::10]:53877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvPCf-0006Y2-CB
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvOzK-0008AE-AU
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:36:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvOzK-00089u-4R
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:36:02 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvOzH-0006MM-TJ
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:36:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 239D92E80C9
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:35:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Aug 2018 15:21:26 -0000
From: Heiko Sieger <1788665@bugs.launchpad.net>
Reply-To: Bug 1788665 <1788665@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153504502595.30588.13203676939349086206.malonedeb@soybean.canonical.com>
Message-Id: <153564248684.31293.17131853207421098455.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1788665] Re: Low 2D graphics performance with
 Windows 10 (1803) VGA passthrough VM using "Spectre" protection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

>The possibilities left are that either your Windows guest is lacking
software updates that could perhaps improve its performance, or that 2D
graphics really is that awful in combination with spectre/meltdown
fixes.

Thanks Daniel. There are two problems with this explanation:

1. A native "bare metal" Windows 10 (1803) installation with all updates
applied does NOT have any 2D performance problems. See my attachment
(benchmarks) in the original post.

2. Both the Windows VM and the Linux VM do not see the microcode (version?)=
, and therefore do not know about the Spectre vulnerability mitigation in t=
he host kernel. However, the Microsoft document https://docs.microsoft.com/=
en-us/virtualization/hyper-v-on-windows/CVE-2017-5715-and-hyper-v-vms sugge=
sts that Microsoft Hyper-V can be configured to expose new processor capabi=
lities to guest virtual machines, specifically the ones made available thro=
ugh the microcode updates. Here a quote from the above Microsoft website:
"Firmware updates from your OEM may contain new processor capabilities that=
 can be used to protect against CVE-2017-5715 (IBRS, STIBP, IBPB). Once the=
 virtualization host's firmware has been updated, the hypervisor can make t=
hese additional capabilities available to guest virtual machines after taki=
ng the following steps."

The ideal behavior of qemu/kvm would be to expose the microcode
capabilities to the guest (I suppose this happens partially as seen by
the presence of the "pti  ssbd ibrs ibpb" flags), but obviously
something is missing.

But the real important question is this:
In the above scenario, are the VMs protected from Spectre vulnerabilities, =
simply by having the microcode installed in the host? Even when I disable t=
he Spectre protection inside the Windows VM?

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1788665

Title:
  Low 2D graphics performance with Windows 10 (1803) VGA passthrough VM
  using "Spectre" protection

Status in QEMU:
  New

Bug description:
  Windows 10 (1803) VM using VGA passthrough via qemu script.

  After upgrading Windows 10 Pro VM to version 1803, or possibly after
  applying the March/April security updates from Microsoft, the VM would
  show low 2D graphics performance (sluggishness in 2D applications and
  low Passmark results).

  Turning off Spectre vulnerability protection in Windows remedies the
  issue.

  Expected behavior:
  qemu/kvm hypervisor to expose firmware capabilities of host to guest OS -=
 see https://docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/CVE=
-2017-5715-and-hyper-v-vms

  Background:

  Starting in March or April Microsoft began to push driver updates in
  their updates / security updates. See https://support.microsoft.com
  /en-us/help/4073757/protect-your-windows-devices-against-spectre-
  meltdown

  One update concerns the Intel microcode - see
  https://support.microsoft.com/en-us/help/4100347. It is activated by
  default within Windows.

  Once the updates are applied within the Windows guest, 2D graphics
  performance drops significantly. Other performance benchmarks are not
  affected.

  A bare metal Windows installation does not display a performance loss
  after the update. See https://heiko-sieger.info/low-2d-graphics-
  benchmark-with-windows-10-1803-kvm-vm/

  Similar reports can be found here:
  https://www.reddit.com/r/VFIO/comments/97unx4/passmark_lousy_2d_graphics_=
performance_on_windows/

  Hardware:

  6 core Intel Core i7-3930K (-MT-MCP-)

  Host OS:
  Linux Mint 19/Ubuntu 18.04
  Kernel: 4.15.0-32-generic x86_64
  Qemu: QEMU emulator version 2.11.1
  Intel microcode (host): 0x714
  dmesg | grep microcode
  [    0.000000] microcode: microcode updated early to revision 0x714, date=
 =3D 2018-05-08
  [    2.810683] microcode: sig=3D0x206d7, pf=3D0x4, revision=3D0x714
  [    2.813340] microcode: Microcode Update Driver: v2.2.

  Note: I manually updated the Intel microcode on the host from 0x713 to
  0x714. However, both microcode versions produce the same result in the
  Windows guest.

  Guest OS:
  Windows 10 Pro 64 bit, release 1803

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1788665/+subscriptions
