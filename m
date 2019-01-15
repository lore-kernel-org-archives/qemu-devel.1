Received: from eggs.gnu.org ([209.51.188.92]:36038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjR99-0008Ek-50
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:01:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjR93-0000Xe-Ej
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:00:59 -0500
Received: from indium.canonical.com ([91.189.90.7]:34684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjR93-0000Wx-8T
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 11:00:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjR91-0007Em-HO
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 16:00:51 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 68C352E80D3
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 16:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Jan 2019 15:47:15 -0000
From: Michael Ablassmeier <1811862@bugs.launchpad.net>
Reply-To: Bug 1811862 <1811862@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <154756723569.32460.9318945599039422988.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811862] [NEW] microcode version stays 0x1 even
 if -cpu host is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

The microcode version of my host cpu has the following version:

grep microcode /proc/cpuinfo | head -1
microcode       : 0x3d

while trying to run ESXi in an nested VM, the boot bailed out with
error message that at least microcode version 0x19 is needed. It =

seems they have introduced such a check on certain CPU types.

The VM in question is using the "host-passthrough" option in libvirt
and the qemu command line reads as this:

21172 ?        Sl     0:09 /usr/libexec/qemu-kvm -name guest=3Dhpe-env-
client1,debug-threads=3Don -S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-33
-hpe-env-client1/master-key.aes -machine pc-i440fx-
rhel7.6.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu host <rest
stripped>

Running a regular Linux VM with `host-passthrough` shows that the
microcode version is still reported as 0x1.

Within the VM:

[root@hpe-env-client1 ~]# cat /proc/cpuinfo =

processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 63
model name      : Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz
stepping        : 2
microcode       : 0x1
cpu MHz         : 2397.222


My impression is qemu should copy the hosts microcode version in this case?

Running Qemu von RHEl8 beta here.

[root@3parserver ~]# /usr/libexec/qemu-kvm --version
QEMU emulator version 2.12.0 (qemu-kvm-2.12.0-41.el8+2104+3e32e6f8)

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811862

Title:
  microcode version stays 0x1 even if -cpu host is used

Status in QEMU:
  New

Bug description:
  The microcode version of my host cpu has the following version:

  grep microcode /proc/cpuinfo | head -1
  microcode       : 0x3d

  while trying to run ESXi in an nested VM, the boot bailed out with
  error message that at least microcode version 0x19 is needed. It =

  seems they have introduced such a check on certain CPU types.

  The VM in question is using the "host-passthrough" option in libvirt
  and the qemu command line reads as this:

  21172 ?        Sl     0:09 /usr/libexec/qemu-kvm -name guest=3Dhpe-env-
  client1,debug-threads=3Don -S -object
  secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-33
  -hpe-env-client1/master-key.aes -machine pc-i440fx-
  rhel7.6.0,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff -cpu host <rest
  stripped>

  Running a regular Linux VM with `host-passthrough` shows that the
  microcode version is still reported as 0x1.

  Within the VM:

  [root@hpe-env-client1 ~]# cat /proc/cpuinfo =

  processor       : 0
  vendor_id       : GenuineIntel
  cpu family      : 6
  model           : 63
  model name      : Intel(R) Xeon(R) CPU E5-2620 v3 @ 2.40GHz
  stepping        : 2
  microcode       : 0x1
  cpu MHz         : 2397.222

  =

  My impression is qemu should copy the hosts microcode version in this cas=
e?

  Running Qemu von RHEl8 beta here.

  [root@3parserver ~]# /usr/libexec/qemu-kvm --version
  QEMU emulator version 2.12.0 (qemu-kvm-2.12.0-41.el8+2104+3e32e6f8)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811862/+subscriptions
