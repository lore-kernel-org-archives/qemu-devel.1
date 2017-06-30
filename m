Received: from eggs.gnu.org ([2001:4830:134:3::10]:47941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dQpIU-00033A-69
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:20:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dQpIQ-0000hi-QY
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:20:53 -0400
Received: from indium.canonical.com ([91.189.90.7]:55504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dQpIQ-0000h8-Jo
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 02:20:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dQpIN-0000tQ-Ew
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:20:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 643402E8194
	for <qemu-devel@nongnu.org>; Fri, 30 Jun 2017 06:20:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Jun 2017 06:09:33 -0000
From: Nick <nick@nine.ch>
Reply-To: Bug 1701449 <1701449@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <149880297386.6544.11962739093038956076.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1701449] [NEW] high memory usage when using rbd
 with client caching
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

Hi,
we are experiencing a quite high memory usage of a single qemu (used with K=
VM) process when using RBD with client caching as a disk backend. We are te=
sting with 3GB memory qemu virtual machines and 128MB RBD client cache. Whe=
n running 'fio' in the virtual machine you can see that after some time the=
 machine uses a lot more memory (RSS) on the hypervisor than she should. We=
 have seen values (in real production machines, no artificially fio tests) =
of 250% memory overhead. I reproduced this with qemu version 2.9 as well.

Here the contents of our ceph.conf on the hypervisor:
"""
[client]
rbd cache writethrough until flush =3D False
rbd cache max dirty =3D 100663296
rbd cache size =3D 134217728
rbd cache target dirty =3D 50331648
"""

How to reproduce:
* create a virtual machine with a RBD backed disk (100GB or so)
* install a linux distribution on it (we are using Ubuntu)
* install fio (apt-get install fio)
* run fio multiple times with (e.g.) the following test file:
"""
# This job file tries to mimic the Intel IOMeter File Server Access Pattern
[global]
description=3DEmulation of Intel IOmeter File Server Access Pattern
randrepeat=3D0
filename=3D/root/test.dat
# IOMeter defines the server loads as the following:
# iodepth=3D1     Linear
# iodepth=3D4     Very Light
# iodepth=3D8     Light
# iodepth=3D64    Moderate
# iodepth=3D256   Heavy
iodepth=3D8
size=3D80g
direct=3D0
ioengine=3Dlibaio

[iometer]
stonewall
bs=3D4M
rw=3Drandrw

[iometer_just_write]
stonewall
bs=3D4M
rw=3Dwrite

[iometer_just_read]
stonewall
bs=3D4M
rw=3Dread
"""

You can measure the virtual machine RSS usage on the hypervisor with:
  virsh dommemstat <machine name> | grep rss
or if you are not using libvirt:
  grep RSS /proc/<PID of qemu process>/status

When switching off the RBD client cache, all is ok again, as the process
does not use so much memory anymore.

There is already a ticket on the ceph bug tracker for this ([1]).
However I can reproduce that memory behaviour only when using qemu
(maybe it is using librbd in a special way?). Running directly 'fio'
with the rbd engine does not result in that high memory usage.

[1] http://tracker.ceph.com/issues/20054

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1701449

Title:
  high memory usage when using rbd with client caching

Status in QEMU:
  New

Bug description:
  Hi,
  we are experiencing a quite high memory usage of a single qemu (used with=
 KVM) process when using RBD with client caching as a disk backend. We are =
testing with 3GB memory qemu virtual machines and 128MB RBD client cache. W=
hen running 'fio' in the virtual machine you can see that after some time t=
he machine uses a lot more memory (RSS) on the hypervisor than she should. =
We have seen values (in real production machines, no artificially fio tests=
) of 250% memory overhead. I reproduced this with qemu version 2.9 as well.

  Here the contents of our ceph.conf on the hypervisor:
  """
  [client]
  rbd cache writethrough until flush =3D False
  rbd cache max dirty =3D 100663296
  rbd cache size =3D 134217728
  rbd cache target dirty =3D 50331648
  """

  How to reproduce:
  * create a virtual machine with a RBD backed disk (100GB or so)
  * install a linux distribution on it (we are using Ubuntu)
  * install fio (apt-get install fio)
  * run fio multiple times with (e.g.) the following test file:
  """
  # This job file tries to mimic the Intel IOMeter File Server Access Patte=
rn
  [global]
  description=3DEmulation of Intel IOmeter File Server Access Pattern
  randrepeat=3D0
  filename=3D/root/test.dat
  # IOMeter defines the server loads as the following:
  # iodepth=3D1     Linear
  # iodepth=3D4     Very Light
  # iodepth=3D8     Light
  # iodepth=3D64    Moderate
  # iodepth=3D256   Heavy
  iodepth=3D8
  size=3D80g
  direct=3D0
  ioengine=3Dlibaio

  [iometer]
  stonewall
  bs=3D4M
  rw=3Drandrw

  [iometer_just_write]
  stonewall
  bs=3D4M
  rw=3Dwrite

  [iometer_just_read]
  stonewall
  bs=3D4M
  rw=3Dread
  """

  You can measure the virtual machine RSS usage on the hypervisor with:
    virsh dommemstat <machine name> | grep rss
  or if you are not using libvirt:
    grep RSS /proc/<PID of qemu process>/status

  When switching off the RBD client cache, all is ok again, as the
  process does not use so much memory anymore.

  There is already a ticket on the ceph bug tracker for this ([1]).
  However I can reproduce that memory behaviour only when using qemu
  (maybe it is using librbd in a special way?). Running directly 'fio'
  with the rbd engine does not result in that high memory usage.

  [1] http://tracker.ceph.com/issues/20054

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1701449/+subscriptions
