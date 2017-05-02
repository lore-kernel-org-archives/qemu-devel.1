Received: from eggs.gnu.org ([2001:4830:134:3::10]:34167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5VrV-0001tq-Hp
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:21:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5VrR-0002HA-Hn
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:20:57 -0400
Received: from indium.canonical.com ([91.189.90.7]:38000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5VrR-0002Gl-Bn
	for qemu-devel@nongnu.org; Tue, 02 May 2017 07:20:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5VrO-0001md-1Z
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 11:20:50 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1BAB92E80D6
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 11:20:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 May 2017 11:07:47 -0000
From: steeven <steeven@gmail.com>
Reply-To: Bug 1687599 <1687599@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170502110747.26349.38130.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687599] [NEW] Bind 2nd VM to same OVS vhost-user
 port caused 1st vm traffic broken
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

Binding 2nd VM to same OVS vhost-user port caused 1st vm traffic broken.
If it illegal to share same vhost port, how about the first VM open the
path exclusively?

#OVS side to create the vhost-user port:
ovs-vsctl add-br br0 -- set bridge br0 datapath_type=3Dnetdev
ovs-vsctl add-port br0 phy0 -- set Interface phy0 type=3Ddpdk options:dpdk-=
devargs=3D0000:0a:00.0
ovs-vsctl add-port br0 dpdkvhostuser0 -- set Interface dpdkvhostuser0 type=
=3Ddpdkvhostuser

#QEMU VM1
qemu-system-x86_64 -name vm1 -cpu host -enable-kvm -m 3072 -drive file=3D/o=
pt/ubuntu1.qcow2 -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,cor=
es=3D2 -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/hu=
gepages,share=3Don -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/ope=
nvswitch/dpdkvhostuser0 -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dcha=
r0,vhostforce -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmynet=
1,mrg_rxbuf=3Doff

#VM2
qemu-system-x86_64 -name vm2 -cpu host -enable-kvm -m 3072 -drive file=3D/o=
pt/ubuntu2.qcow2 -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,cor=
es=3D2 -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/hu=
gepages,share=3Don -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/ope=
nvswitch/dpdkvhostuser0 -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dcha=
r0,vhostforce -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmynet=
1,mrg_rxbuf=3Doff

** Affects: qemu
     Importance: Undecided
         Status: New

** Description changed:

  Binding 2nd VM to same OVS vhost-user port caused 1st vm traffic broken.
  If it illegal to share same vhost port, how about the first VM open the
  path exclusively?
- =

  =

  #OVS side to create the vhost-user port:
  ovs-vsctl add-br br0 -- set bridge br0 datapath_type=3Dnetdev
  ovs-vsctl add-port br0 phy0 -- set Interface phy0 type=3Ddpdk options:dpd=
k-devargs=3D0000:0a:00.0
  ovs-vsctl add-port br0 dpdkvhostuser0 -- set Interface dpdkvhostuser0 typ=
e=3Ddpdkvhostuser
  =

  #QEMU VM1
- qemu-system-x86_64 -name vm1 -cpu host -enable-kvm -m 3072 -drive file=3D=
/opt/ubuntu1.qcow2  \
-   -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,cores=3D2 \
-   -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/hugep=
ages,share=3Don \
-   -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/openvswitch/dpdkvh=
ostuser0 \  -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar0,vhostforc=
e \
-   -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmynet1,mrg_rxbu=
f=3Doff
+ qemu-system-x86_64 -name vm1 -cpu host -enable-kvm -m 3072 -drive file=3D=
/opt/ubuntu1.qcow2 -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,c=
ores=3D2 -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/=
hugepages,share=3Don -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/o=
penvswitch/dpdkvhostuser0 -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dc=
har0,vhostforce -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmyn=
et1,mrg_rxbuf=3Doff
  =

  #VM2
- qemu-system-x86_64 -name vm2 -cpu host -enable-kvm -m 3072 -drive file=3D=
/opt/ubuntu2.qcow2  \
-   -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,cores=3D2 \
-   -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/hugep=
ages,share=3Don \
-   -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/openvswitch/dpdkvh=
ostuser0 \  -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dchar0,vhostforc=
e \
-   -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmynet1,mrg_rxbu=
f=3Doff
+ qemu-system-x86_64 -name vm2 -cpu host -enable-kvm -m 3072 -drive file=3D=
/opt/ubuntu2.qcow2 -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,c=
ores=3D2 -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/=
hugepages,share=3Don -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/o=
penvswitch/dpdkvhostuser0 -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dc=
har0,vhostforce -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmyn=
et1,mrg_rxbuf=3Doff

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687599

Title:
  Bind 2nd VM to same OVS vhost-user port caused 1st vm traffic broken

Status in QEMU:
  New

Bug description:
  Binding 2nd VM to same OVS vhost-user port caused 1st vm traffic
  broken. If it illegal to share same vhost port, how about the first VM
  open the path exclusively?

  #OVS side to create the vhost-user port:
  ovs-vsctl add-br br0 -- set bridge br0 datapath_type=3Dnetdev
  ovs-vsctl add-port br0 phy0 -- set Interface phy0 type=3Ddpdk options:dpd=
k-devargs=3D0000:0a:00.0
  ovs-vsctl add-port br0 dpdkvhostuser0 -- set Interface dpdkvhostuser0 typ=
e=3Ddpdkvhostuser

  #QEMU VM1
  qemu-system-x86_64 -name vm1 -cpu host -enable-kvm -m 3072 -drive file=3D=
/opt/ubuntu1.qcow2 -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,c=
ores=3D2 -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/=
hugepages,share=3Don -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/o=
penvswitch/dpdkvhostuser0 -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dc=
har0,vhostforce -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmyn=
et1,mrg_rxbuf=3Doff

  #VM2
  qemu-system-x86_64 -name vm2 -cpu host -enable-kvm -m 3072 -drive file=3D=
/opt/ubuntu2.qcow2 -numa node,memdev=3Dmem -mem-prealloc -smp sockets=3D1,c=
ores=3D2 -object memory-backend-file,id=3Dmem,size=3D3072m,mem-path=3D/dev/=
hugepages,share=3Don -chardev socket,id=3Dchar0,path=3D/usr/local/var/run/o=
penvswitch/dpdkvhostuser0 -netdev type=3Dvhost-user,id=3Dmynet1,chardev=3Dc=
har0,vhostforce -device virtio-net-pci,mac=3D00:00:00:00:00:01,netdev=3Dmyn=
et1,mrg_rxbuf=3Doff

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687599/+subscriptions
