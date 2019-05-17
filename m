Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C558FC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C6A2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 13:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C6A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48322 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRcVo-0003Jp-GF
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 09:03:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRk-0000Pr-88
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1hRcRi-00037c-PD
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32816)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1hRcRi-0002qT-GS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:58:46 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5CFBEC074EE5
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 12:58:27 +0000 (UTC)
Received: from localhost (dhcp-192-241.str.redhat.com [10.33.192.241])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 35ECE61479;
	Fri, 17 May 2019 12:58:22 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 14:58:16 +0200
Message-Id: <20190517125820.2885-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Fri, 17 May 2019 12:58:27 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 0/4] add failover feature for assigned network
 devices
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
	mst@redhat.com, aadam@redhat.com, laine@redhat.com, ailan@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is another attempt at implementing the host side of the
net_failover concept
(https://www.kernel.org/doc/html/latest/networking/net_failover.html)

Changes since last RFC:
- work around circular dependency of commandline options. Just add
  failover=3Don to the virtio-net standby options and reference it from
  primary (vfio-pci) device with standby=3D<id> =20
- add patch 3/4 to allow migration of vfio-pci device when it is part of =
a
  failover pair, still disallow for all other devices
- add patch 4/4 to allow unplug of device during migrationm, make an
  exception for failover primary devices. I'd like feedback on how to
  solve this more elegant. I added a boolean to DeviceState, have it
  default to false for all devices except for primary devices.=20
- not tested yet with surprise removal
- I don't expect this to go in as it is, still needs more testing but
  I'd like to get feedback on above mentioned changes.

The general idea is that we have a pair of devices, a vfio-pci and a
emulated device. Before migration the vfio device is unplugged and data
flows to the emulated device, on the target side another vfio-pci device
is plugged in to take over the data-path. In the guest the net_failover
module will pair net devices with the same MAC address.

* In the first patch the infrastructure for hiding the device is added
  for the qbus and qdev APIs.=20

* In the second patch the virtio-net uses the API to defer adding the vfi=
o
  device until the VIRTIO_NET_F_STANDBY feature is acked.

Previous discussion:=20
  RFC v1 https://patchwork.ozlabs.org/cover/989098/
  RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.htm=
l

To summarize concerns/feedback from previous discussion:
1.- guest OS can reject or worse _delay_ unplug by any amount of time.
  Migration might get stuck for unpredictable time with unclear reason.
  This approach combines two tricky things, hot/unplug and migration.=20
  -> We can surprise-remove the PCI device and in QEMU we can do all
     necessary rollbacks transparent to management software. Will it be
     easy, probably not.
2. PCI devices are a precious ressource. The primary device should never
  be added to QEMU if it won't be used by guest instead of hiding it in
  QEMU.=20
  -> We only hotplug the device when the standby feature bit was
     negotiated. We save the device cmdline options until we need it for
     qdev_device_add()
     Hiding a device can be a useful concept to model. For example a
     pci device in a powered-off slot could be marked as hidden until the=
 slot is
     powered on (mst).
3. Management layer software should handle this. Open Stack already has
  components/code to handle unplug/replug VFIO devices and metadata to
  provide to the guest for detecting which devices should be paired.
  -> An approach that includes all software from firmware to
     higher-level management software wasn't tried in the last years. Thi=
s is
     an attempt to keep it simple and contained in QEMU as much as possib=
le.
4. Hotplugging a device and then making it part of a failover setup is
   not possible
  -> addressed by extending qdev hotplug functions to check for hidden
     attribute, so e.g. device_add can be used to plug a device.


I have tested this with a mlx5 NIC and was able to migrate the VM with
above mentioned workarounds for open problems.

Command line example:

qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
        -machine q35,kernel-irqchip=3Dsplit -cpu host   \
        -k fr   \
        -serial stdio   \
        -net none \
        -qmp unix:/tmp/qmp.socket,server,nowait \
        -monitor telnet:127.0.0.1:5555,server,nowait \
        -device pcie-root-port,id=3Droot0,multifunction=3Don,chassis=3D0,=
addr=3D0xa \
        -device pcie-root-port,id=3Droot1,bus=3Dpcie.0,chassis=3D1 \
        -device pcie-root-port,id=3Droot2,bus=3Dpcie.0,chassis=3D2 \
        -netdev tap,script=3D/root/bin/bridge.sh,downscript=3Dno,id=3Dhos=
tnet1,vhost=3Don \
        -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00=
:6f:55:cc,bus=3Droot2,failover=3Don \                                    =
                                               =20
        /root/rhel-guest-image-8.0-1781.x86_64.qcow2

Then the primary device can be hotplugged via
 (qemu) device_add vfio-pci,host=3D5e:00.2,id=3Dhostdev0,bus=3Droot1,stan=
dby=3Dnet1


I'm grateful for any remarks or ideas!

Thanks!


Jens Freimann (4):
  migration: allow unplug during migration for failover devices
  qdev/qbus: Add hidden device support
  net/virtio: add failover support
  vfio: unplug failover primary device before migration

 hw/core/qdev.c                 |  20 ++++++
 hw/net/virtio-net.c            | 117 +++++++++++++++++++++++++++++++++
 hw/vfio/pci.c                  |  25 ++++++-
 hw/vfio/pci.h                  |   2 +
 include/hw/qdev-core.h         |  10 +++
 include/hw/virtio/virtio-net.h |  12 ++++
 qdev-monitor.c                 |  43 ++++++++++--
 vl.c                           |   6 +-
 8 files changed, 228 insertions(+), 7 deletions(-)

--=20
2.21.0


