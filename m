Received: from eggs.gnu.org ([2001:4830:134:3::10]:55331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1efyyv-0004Kr-5m
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 21:15:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1efyys-0004ud-06
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 21:15:37 -0500
Received: from indium.canonical.com ([91.189.90.7]:48924)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1efyyr-0004uB-Ph
	for qemu-devel@nongnu.org; Sun, 28 Jan 2018 21:15:33 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1efyyq-00074V-Qw
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 02:15:32 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C90062E8025
	for <qemu-devel@nongnu.org>; Mon, 29 Jan 2018 02:15:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jan 2018 02:08:34 -0000
From: Michael Chapman <launchpad@very.puzzling.org>
Reply-To: Bug 1745895 <1745895@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151719171489.17422.7852330772200128264.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1745895] [NEW] Unable to migrate vhost-net to
 virtio-1.0-capable kernel
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

I am running QEMU 2.11 (from upstream source, not Red Hat package) on
stock RHEL 6 and RHEL 7 kernels. Only the RHEL 7 kernel supports
VIRTIO_F_VERSION_1 in its vhost-net driver.

When migrating a guest using vhost-net from the RHEL 6 host to RHEL 7,
the PCI config is rejected by QEMU on the target machine.

A simple test case:

1. On the RHEL 7 host, prepare for an incoming migration:

  rhel7# qemu-system-x86_64 -S -accel kvm -nographic -monitor stdio
-nodefaults -netdev tap,id=3Dnet0,vhost=3Don,script=3Dno,downscript=3Dno -d=
evice
virtio-net-pci,netdev=3Dnet0,mac=3D54:52:00:ff:ff:ff -incoming
tcp:0.0.0.0:12345

2. On the RHEL 6 host, start a guest and migrate it to the RHEL 7 host:

  rhel6# qemu-system-x86_64 -S -accel kvm -nographic -monitor stdio -nodefa=
ults -netdev tap,id=3Dnet0,vhost=3Don,script=3Dno,downscript=3Dno -device v=
irtio-net-pci,netdev=3Dnet0,mac=3D54:52:00:ff:ff:ff
QEMU 2.11.0 monitor - type 'help' for more information
  (qemu) migrate tcp:rhel7:12345

The RHEL 7 QEMU errors out:

  qemu-system-x86_64: get_pci_config_device: Bad config data: i=3D0x20 read=
: 0 device: c cmask: ff wmask: 0 w1cmask:0
  qemu-system-x86_64: Failed to load PCIDevice:config
  qemu-system-x86_64: Failed to load virtio-net:virtio
  qemu-system-x86_64: error while loading state for instance 0x0 of device =
'0000:00:02.0/virtio-net'
  qemu-system-x86_64: load of migration failed: Invalid argument

If I start the source QEMU with vhost=3Doff, or the target QEMU with
disable-modern=3Dtrue, the migration is successful.

My hunch here is that the target QEMU prepares the PCI device to support
VIRTIO_F_VERSION_1, as that's available in the kernel there, but then
fails to (or does not know to) disable this during the migration.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1745895

Title:
  Unable to migrate vhost-net to virtio-1.0-capable kernel

Status in QEMU:
  New

Bug description:
  I am running QEMU 2.11 (from upstream source, not Red Hat package) on
  stock RHEL 6 and RHEL 7 kernels. Only the RHEL 7 kernel supports
  VIRTIO_F_VERSION_1 in its vhost-net driver.

  When migrating a guest using vhost-net from the RHEL 6 host to RHEL 7,
  the PCI config is rejected by QEMU on the target machine.

  A simple test case:

  1. On the RHEL 7 host, prepare for an incoming migration:

    rhel7# qemu-system-x86_64 -S -accel kvm -nographic -monitor stdio
  -nodefaults -netdev tap,id=3Dnet0,vhost=3Don,script=3Dno,downscript=3Dno
  -device virtio-net-pci,netdev=3Dnet0,mac=3D54:52:00:ff:ff:ff -incoming
  tcp:0.0.0.0:12345

  2. On the RHEL 6 host, start a guest and migrate it to the RHEL 7
  host:

    rhel6# qemu-system-x86_64 -S -accel kvm -nographic -monitor stdio -node=
faults -netdev tap,id=3Dnet0,vhost=3Don,script=3Dno,downscript=3Dno -device=
 virtio-net-pci,netdev=3Dnet0,mac=3D54:52:00:ff:ff:ff
  QEMU 2.11.0 monitor - type 'help' for more information
    (qemu) migrate tcp:rhel7:12345

  The RHEL 7 QEMU errors out:

    qemu-system-x86_64: get_pci_config_device: Bad config data: i=3D0x20 re=
ad: 0 device: c cmask: ff wmask: 0 w1cmask:0
    qemu-system-x86_64: Failed to load PCIDevice:config
    qemu-system-x86_64: Failed to load virtio-net:virtio
    qemu-system-x86_64: error while loading state for instance 0x0 of devic=
e '0000:00:02.0/virtio-net'
    qemu-system-x86_64: load of migration failed: Invalid argument

  If I start the source QEMU with vhost=3Doff, or the target QEMU with
  disable-modern=3Dtrue, the migration is successful.

  My hunch here is that the target QEMU prepares the PCI device to
  support VIRTIO_F_VERSION_1, as that's available in the kernel there,
  but then fails to (or does not know to) disable this during the
  migration.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1745895/+subscriptions
