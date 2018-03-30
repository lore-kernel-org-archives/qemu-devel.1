Received: from eggs.gnu.org ([2001:4830:134:3::10]:36220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1zM9-0002gf-QN
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:06:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f1zM5-0001cZ-E2
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:06:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:44606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f1zM5-0001bI-6n
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 15:06:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f1zM3-0003Uu-LL
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 19:06:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8D4AE2E80CB
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 19:06:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Mar 2018 18:53:21 -0000
From: Dmitrii Shcherbakov <1728256@bugs.launchpad.net>
Reply-To: Bug 1728256 <1728256@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150920686502.20214.12572544661418580428.malonedeb@soybean.canonical.com>
Message-Id: <152243600151.7880.2515926106742754794.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728256] Re: Memory corruption in Windows 10
 guest / amd64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Got similar behavior with windows server 2012r2 VMs.

Environment:

uname -a
Linux ubuntu-q87 4.13.0-37-generic #42~16.04.1-Ubuntu SMP Wed Mar 7 16:03:2=
8 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

ii  linux-image-4.13.0-36-generic
4.13.0-36.40~16.04.1                                               amd64
Linux kernel image for version 4.13.0 on 64 bit x86 SMP

apt policy qemu
qemu:
  Installed: (none)
  Candidate: 1:2.11+dfsg-1ubuntu5~cloud0
  Version table:
     1:2.11+dfsg-1ubuntu5~cloud0 500

Windows VMs error out and create a memory dump:

The computer has rebooted from a bugcheck.  The bugcheck was: 0x00000109
(0xa3a01f5891f186c5, 0xb3b72bdee47188a0, 0x0000032000000000,
0x0000000000000017). A dump was saved in: C:\Windows\MEMORY.DMP. Report
Id: 033018-31234-01.

Based on microsoft docs:

https://docs.microsoft.com/en-us/windows-hardware/drivers/debugger/bug-chec=
k-0x109---critical-structure-corruption
CRITICAL_STRUCTURE_CORRUPTION Parameters
Parameter  Description
1 Reserved
2 Reserved
3 Reserved
4 The type of the corrupted region. (See the following table later on this =
page.)

...
0x17 Local APIC modification <--- this


Which is the same as with other reports out there:

https://www.spinics.net/lists/kvm/msg159977.html
https://forum.proxmox.com/threads/new-windows-vm-keeps-dying.39145/#post-19=
3639


>From what I see the change was backported but there was no new build yet.
 =

http://kernel.ubuntu.com/git/ubuntu/ubuntu-xenial.git/commit/arch/x86/kvm/x=
86.c?h=3Dhwe&id=3D78d2542b88d16

See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1738972

I suggest this is marked as a duplicate to 1738972

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728256

Title:
  Memory corruption in Windows 10 guest / amd64

Status in QEMU:
  New
Status in linux package in Ubuntu:
  Confirmed

Bug description:
  I have a Win 10 Pro x64 guest inside a qemu/kvm running on an Arch x86_64=
 host. The VM has a physical GPU passed through, as well as the physical US=
B controllers, as well as a dedicated SSD attached via SATA; you can find t=
he complete libvirt xml here: https://pastebin.com/U1ZAXBNg
  I built qemu from source using the qemu-minimal-git AUR package; you can =
find the build script here: https://aur.archlinux.org/cgit/aur.git/tree/PKG=
BUILD?h=3Dqemu-minimal-git (if you aren't familiar with Arch, this is essen=
tially a bash script where build() and package() are run to build the files=
, and then install them into the $pkgdir to later tar them up.)

  Starting with qemu v2.10.0, Windows crashes randomly with a bluescreen
  about CRITICAL_STRUCTURE_CORRUPTION. I also tested the git heads
  f90ea7ba7c, 861cd431c9 and e822e81e35, before I went back to v2.9.0,
  which is running stable for over 50 hours right now.

  During my tests I found that locking the memory pages alleviates the
  problem somewhat, but never completely avoids it. However, with the
  crashes occuring randomly, that could as well be false conclusions; I
  had crashes within minutes after boot with that too.

  I will now start `git bisect`ing; if you have any other suggestions on
  what I could try or possible patches feel free to leave them with me.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728256/+subscriptions
