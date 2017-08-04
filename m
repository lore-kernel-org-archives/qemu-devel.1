Received: from eggs.gnu.org ([2001:4830:134:3::10]:50385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddYAK-0000c2-Bz
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ddYAG-0002Z7-PG
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:41:04 -0400
Received: from indium.canonical.com ([91.189.90.7]:52121)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ddYAG-0002YQ-IF
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 04:41:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1ddYAF-0002xk-4K
	for <qemu-devel@nongnu.org>; Fri, 04 Aug 2017 08:40:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 0983E2E80D2
	for <qemu-devel@nongnu.org>; Fri,  4 Aug 2017 08:40:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Aug 2017 08:33:20 -0000
From: jk <1708617@bugs.launchpad.net>
Reply-To: Bug 1708617 <1708617@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150183560010.4317.16234791379107519041.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1708617] [NEW] qemu2.9 meet a question using
 reconnect about ovs+dpdk
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

env:
qemu-2.9
dpdk-16.11
ovs-2.6.1
host os:Linux compute 3.10.0-514.el7.x86_64 #1 SMP Tue Nov 22 16:42:41 UTC =
2016 x86_64 x86_64 x86_64 GNU/Linux
guest os is same with host

1. ovs service is normal
2. start 2 qemu vm, using vhostuser port as server
taskset 0x3f qemu-system-x86_64 -cpu host -smp 2,cores=3D2 -drive file=3D$Q=
COW2_IMAGE -m 4096M --enable-kvm -name $VM_NAME -nographic -object memory-b=
ackend-file,id=3Dmem,size=3D$GUEST_MEM,mem-path=3D/dev/hugepages,share=3Don=
 -numa node,memdev=3Dmem -mem-prealloc -chardev socket,id=3Dchar1,path=3D$V=
HOST_SOCK_DIR/dpdkvhostuser0,server -netdev type=3Dvhost-user,id=3Dmynet1,c=
hardev=3Dchar1,vhostforce,queues=3D2 -device virtio-net-pci,mac=3D00:00:00:=
00:00:01,netdev=3Dmynet1,mq=3Don,vectors=3D6  -nographic -vnc :0 =

qemu-system-x86_64: -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/op=
envswitch/dpdkvhostuser0,server: QEMU waiting for connection on: disconnect=
ed:unix:/usr/local/var/run/openvswitch/dpdkvhostuser0,server

taskset 0x3f qemu-system-x86_64 -cpu host -smp 2,cores=3D2 -drive file=3D$Q=
COW2_IMAGE -m 4096M --enable-kvm -name $VM_NAME -nographic -object memory-b=
ackend-file,id=3Dmem,size=3D$GUEST_MEM,mem-path=3D/dev/hugepages,share=3Don=
 -numa node,memdev=3Dmem -mem-prealloc -chardev socket,id=3Dchar1,path=3D$V=
HOST_SOCK_DIR/dpdkvhostuser0,server -netdev type=3Dvhost-user,id=3Dmynet1,c=
hardev=3Dchar1,vhostforce,queues=3D2 -device virtio-net-pci,mac=3D00:00:00:=
00:00:01,netdev=3Dmynet1,mq=3Don,vectors=3D6  -nographic -vnc :0 =

qemu-system-x86_64: -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/op=
envswitch/dpdkvhostuser0,server: QEMU waiting for connection on: disconnect=
ed:unix:/usr/local/var/run/openvswitch/dpdkvhostuser1,server

3. add br and vhostuser port as client
ovs-vsctl add-br br1 -- set bridge br1 datapath_type=3Dnetdev
ovs-vsctl add-port br1 dpdkvhostuser0 -- set Interface dpdkvhostuser0 type=
=3Ddpdkvhostuserclient  options:vhost-server-path=3D"/usr/local/var/run/ope=
nvswitch/dpdkvhostuser0"			=

ovs-vsctl add-port br1 dpdkvhostuser1 -- set Interface dpdkvhostuser1 type=
=3Ddpdkvhostuserclient  options:vhost-server-path=3D"/usr/local/var/run/ope=
nvswitch/dpdkvhostuser1"			=

			=

4. ping between 2 vm is ok
5. restart ovs process
 systemctl restart openvswitch

6. there is a question ping between 2 vm error

7. change qemu from 2.9 to 2.7, everything become ok

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1708617

Title:
  qemu2.9 meet a question using reconnect about ovs+dpdk

Status in QEMU:
  New

Bug description:
  env:
  qemu-2.9
  dpdk-16.11
  ovs-2.6.1
  host os:Linux compute 3.10.0-514.el7.x86_64 #1 SMP Tue Nov 22 16:42:41 UT=
C 2016 x86_64 x86_64 x86_64 GNU/Linux
  guest os is same with host

  1. ovs service is normal
  2. start 2 qemu vm, using vhostuser port as server
  taskset 0x3f qemu-system-x86_64 -cpu host -smp 2,cores=3D2 -drive file=3D=
$QCOW2_IMAGE -m 4096M --enable-kvm -name $VM_NAME -nographic -object memory=
-backend-file,id=3Dmem,size=3D$GUEST_MEM,mem-path=3D/dev/hugepages,share=3D=
on -numa node,memdev=3Dmem -mem-prealloc -chardev socket,id=3Dchar1,path=3D=
$VHOST_SOCK_DIR/dpdkvhostuser0,server -netdev type=3Dvhost-user,id=3Dmynet1=
,chardev=3Dchar1,vhostforce,queues=3D2 -device virtio-net-pci,mac=3D00:00:0=
0:00:00:01,netdev=3Dmynet1,mq=3Don,vectors=3D6  -nographic -vnc :0 =

  qemu-system-x86_64: -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/=
openvswitch/dpdkvhostuser0,server: QEMU waiting for connection on: disconne=
cted:unix:/usr/local/var/run/openvswitch/dpdkvhostuser0,server

  taskset 0x3f qemu-system-x86_64 -cpu host -smp 2,cores=3D2 -drive file=3D=
$QCOW2_IMAGE -m 4096M --enable-kvm -name $VM_NAME -nographic -object memory=
-backend-file,id=3Dmem,size=3D$GUEST_MEM,mem-path=3D/dev/hugepages,share=3D=
on -numa node,memdev=3Dmem -mem-prealloc -chardev socket,id=3Dchar1,path=3D=
$VHOST_SOCK_DIR/dpdkvhostuser0,server -netdev type=3Dvhost-user,id=3Dmynet1=
,chardev=3Dchar1,vhostforce,queues=3D2 -device virtio-net-pci,mac=3D00:00:0=
0:00:00:01,netdev=3Dmynet1,mq=3Don,vectors=3D6  -nographic -vnc :0 =

  qemu-system-x86_64: -chardev socket,id=3Dchar1,path=3D/usr/local/var/run/=
openvswitch/dpdkvhostuser0,server: QEMU waiting for connection on: disconne=
cted:unix:/usr/local/var/run/openvswitch/dpdkvhostuser1,server

  3. add br and vhostuser port as client
  ovs-vsctl add-br br1 -- set bridge br1 datapath_type=3Dnetdev
  ovs-vsctl add-port br1 dpdkvhostuser0 -- set Interface dpdkvhostuser0 typ=
e=3Ddpdkvhostuserclient  options:vhost-server-path=3D"/usr/local/var/run/op=
envswitch/dpdkvhostuser0"			=

  ovs-vsctl add-port br1 dpdkvhostuser1 -- set Interface dpdkvhostuser1 typ=
e=3Ddpdkvhostuserclient  options:vhost-server-path=3D"/usr/local/var/run/op=
envswitch/dpdkvhostuser1"			=

  			=

  4. ping between 2 vm is ok
  5. restart ovs process
   systemctl restart openvswitch

  6. there is a question ping between 2 vm error

  7. change qemu from 2.9 to 2.7, everything become ok

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1708617/+subscriptions
