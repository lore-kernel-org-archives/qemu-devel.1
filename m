Received: from eggs.gnu.org ([2001:4830:134:3::10]:35876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvLdS-0001LY-4i
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvLdN-0002cA-8g
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:01:14 -0400
Received: from indium.canonical.com ([91.189.90.7]:49936)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvLdN-0002bg-3E
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 08:01:09 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvLdL-00036F-U9
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 12:01:07 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id E19BF2E802D
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 12:01:07 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Aug 2018 11:53:39 -0000
From: Daniel Berrange <1788665@bugs.launchpad.net>
Reply-To: Bug 1788665 <1788665@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <153504502595.30588.13203676939349086206.malonedeb@soybean.canonical.com>
Message-Id: <153563001927.31944.14104163906888378115.malone@soybean.canonical.com>
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

> Whew, after some hurdles I managed to install a Linux Mint 19 guest (Ubun=
tu 18.04). After all updates, here the output:
>
> $ dmesg | grep microcode
> [ 0.036780] core: PEBS disabled due to CPU errata, please upgrade microco=
de
>
> So the microcode in the guest is not loaded! But see below:

As mentioned earlier there is no concept of loading microcode in the
guest. Once it is loaded in the host it applies to everything running on
that host.

This message appears to be caused by fact that we do not expose the
current microcode version to the guest, so the guest always sees 0x1 as
the microcode version, causing this PEBS check to fail. I don't think
this is related to the meltdown/spectre fixes - you'd likely get that
error message even on older systems before meltdown/spectre

> $ cat /proc/cpuinfo | grep flags
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat=
 pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constan=
t_tsc arch_perfmon rep_good nopl xtopology cpuid pni pclmulqdq vmx ssse3 cx=
16 pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx hyperv=
isor lahf_lm cpuid_fault pti ssbd ibrs ibpb tpr_shadow vnmi flexpriority ep=
t vpid tsc_adjust xsaveopt arat

This looks correct - the guest has seen the ssbd, ibrs, ibpb features as
required.

> The microcode is NOT loaded in the Linux VM. However, the following
feature flags are listed: "pti > ssbd ibrs ibpb". The "stibp" flag is
missing.

The "stipb" flag is not relevant to guests, it is only needed by the
hypervisor, so it is to be expected that the guest doesn't see it.

Everything seen from this Linux guest says that QEMU / KVM is doing the
right thing and the guest has the features needed to mitigate
Spectre/Meltdown.

The possibilities left are that either your Windows guest is lacking
software updates that could perhaps improve its performance, or that 2D
graphics really is that awful in combination with spectre/meltdown
fixes.

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
