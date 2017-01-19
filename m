Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDed-0005Uv-Co
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDea-0005Ih-6k
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:25:31 -0500
Received: from indium.canonical.com ([91.189.90.7]:34568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDea-0005IL-1O
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:25:28 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDeY-00027L-Vk
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:25:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ED9962E80BF
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:25:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:15:30 -0000
From: Thomas Huth <1422285@bugs.launchpad.net>
Reply-To: Bug 1422285 <1422285@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150216084539.20665.82421.malonedeb@wampee.canonical.com>
Message-Id: <20170119141532.19993.2653.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1422285] Re: The guest will be destroyed when hot
 plug the VF to guest for the second time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1422285

Title:
  The guest will be destroyed when hot plug the VF to guest for the
  second time.

Status in QEMU:
  Fix Released

Bug description:
  Environment:
  ------------
  Host OS (ia32/ia32e/IA64):ia32e
  Guest OS (ia32/ia32e/IA64):ia32e
  Guest OS Type (Linux/Windows):linux
  kvm.git Commit: 6557bada461afeaa920a189fae2cff7c8fdce39f
  qemu.kvm Commit: cd2d5541271f1934345d8ca42f5fafff1744eee7
  Host Kernel Version:3.19.0-rc3
  Hardware:Haswell_EP,Ivytown_EP

  =

  Bug detailed description:
  --------------------------
  create guest , then hot plug the VF to the guest for the second time, the=
 guest will be destroyed.

  note:
  1. hot plug the device to guest with vfio, the guest works fine
  2.this should be a qemu bug:
  kvm      +  qemu     =3D result
  6557bada +  cd2d5541 =3D bad
  6557bada +  a805ca54 =3D good

  =

  Reproduce steps:
  ----------------
  1. qemu-system-x86_64 -enable-kvm -m 2G -net none -monitor pty rhel6u5.qc=
ow
  2. echo "device_add pci-assign,host=3D03:10.1,id=3Dnic" >/dev/pts/2
  3. cat /dev/pts/2 &
  4. echo "device_del nic" >/dev/pts/2
  5. echo "device_add pci-assign,host=3D03:10.0,id=3Dnic" >/dev/pts/2

  Current result:
  ----------------
  guest will be destroyed when hot plug the vf to guest for the second time.

  Expected result:
  ----------------
  guest works fine when hot plug the vf to guest for the second time

  Basic root-causing log:
  ----------------------
  [root@vt-hsw2 cathy]# qemu-system-x86_64 -enable-kvm -m 2G -net none -mon=
itor pty rhel6u5.qcow =

  char device redirected to /dev/pts/2 (label compat_monitor0)
  Segmentation fault (core dumped)

  =

  some dmesg log:

  pci-stub 0000:03:10.1: kvm deassign device
  pci-stub 0000:03:10.1: enabling device (0000 -> 0002)
  qemu-system-x86[9894]: segfault at 0 ip           (null) sp 00007fa73df0c=
ae8 error 14
  pci-stub 0000:03:10.1: kvm assign device

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1422285/+subscriptions
