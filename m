Received: from eggs.gnu.org ([2001:4830:134:3::10]:53024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDpV-0006V5-08
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cUDpQ-0002Iz-2A
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:38279)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cUDpP-0002Ik-Sj
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:36:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cUDpO-0004pR-Vz
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EBAD62E80C1
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:36:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Jan 2017 14:16:05 -0000
From: Thomas Huth <1354279@bugs.launchpad.net>
Reply-To: Bug 1354279 <1354279@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20140808054714.5103.57594.malonedeb@gac.canonical.com>
Message-Id: <20170119141608.27094.92577.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1354279] Re: The guest will be destroyed after
 hot remove the VF from the guest.
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
https://bugs.launchpad.net/bugs/1354279

Title:
  The guest will be destroyed after hot remove the VF from the guest.

Status in QEMU:
  Fix Released

Bug description:
  Environment:
  ------------
  Host OS (ia32/ia32e/IA64):ia32e
  Guest OS (ia32/ia32e/IA64):ia32e
  Guest OS Type (Linux/Windows):Linux
  kvm.git Commit:9f6226a762c7ae02f6a23a3d4fc552dafa57ea23
  qemu.git Commit:5a7348045091a2bc15d85bb177e5956aa6114e5a
  Host Kernel Version:3.16.0-rc1
  Hardware:Romley_EP, Ivytown_EP,Haswell_EP

  =

  Bug detailed description:
  --------------------------
  hot add the VF to the guest, then hot remove the VF from the guest, the g=
uest will be destroyed.

  note:
  1. when hot add the VF with vfio, the hot remove the VF from the guest, t=
he guest works fine.
  2. this shoule be a qemu bug:
  kvm       +   qemu    =3D result
  9f6226a7  +  5a734804 =3D bad
  9f6226a7  +  9f862687 =3D good


  Reproduce steps:
  ----------------
  1. create guest
  qemu-system-x86_64 --enable-kvm -m 1024 -smp 4 -net none rhel6u5.qcow -mo=
nitor pty
  2. hot add the vf to guest
  echo "device_add pci-assign,host=3D05:10.0,id=3Dnic" >/dev/pts/x
  cat /dev/pts/x
  3. hot remove the VF froem guest
  echo "device_del nic" >/dev/pts/x

  Current result:
  ----------------
  the guest willl be destroyed after hot remove the VF from the guest

  Expected result:
  ----------------
  the guest works fine after hot remove the VF from the guest

  =

  Basic root-causing log:
  ----------------------
  [root@vt-snb9 qemu.git]# qemu-system-x86_64 -enable-kvm -m 1024 -smp 2 -n=
et none rhel6u5.qcow -monitor pty
  VNC server running on `::1:5900'
  **
  ERROR:qom/object.c:725:object_unref: assertion failed: (obj->ref > 0)
  Aborted (core dumped)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1354279/+subscriptions
