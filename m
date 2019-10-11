Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E646C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:21:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7333F214E0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 11:21:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7333F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIszG-0006sD-G1
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 07:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iIsyG-0005yP-Ub
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:20:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iIsyC-0001VE-Rp
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:20:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41318)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iIsyC-0001Ub-If
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 07:20:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7595B10CC1ED;
 Fri, 11 Oct 2019 11:20:26 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EF1D60872;
 Fri, 11 Oct 2019 11:20:17 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 0/10] add failover feature for assigned network devices
Date: Fri, 11 Oct 2019 13:20:05 +0200
Message-Id: <20191011112015.11785-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 11 Oct 2019 11:20:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: parav@mellanox.com, mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is implementing the host side of the net_failover concept
(https://www.kernel.org/doc/html/latest/networking/net_failover.html)

Changes since v2:
* back out of creating failover pair when it is a non-networking
  vfio-pci device (Alex W)
* handle migration state change from within the migration thread. I do a
  timed wait on a semaphore and then check if all unplugs were
  succesful. Added a new function to each device that checks the device
  if the unplug for it has happened. When all devices report the succesfu=
l
  unplug *or* the time/retries is up, continue with the migration or
  cancel. When not all devices could be unplugged I am cancelling at the
  moment. It is likely that we can't plug it back at the destination whic=
h
  would result in degraded network performance.
* fix a few bugs regarding re-plug on migration source and target=20
* run full set of tests including migration tests
* add patch for libqos to tolerate new migration state
* squashed patch 1 and 2, added patch 8=20
=20
The general idea is that we have a pair of devices, a vfio-pci and a
virtio-net device. Before migration the vfio device is unplugged and data
flows to the virtio-net device, on the target side another vfio-pci devic=
e
is plugged in to take over the data-path. In the guest the net_failover
module will pair net devices with the same MAC address.

* Patch 1 adds the infrastructure to hide the device for the qbus and qde=
v APIs

* Patch 2 sets a new flag for PCIDevice 'partially_hotplugged' which we
  use to skip the unrealize code path when doing a unplug of the primary
  device

* Patch 3 sets the pending_deleted_event before triggering the guest
  unplug request

* Patch 4 and 5 add new qmp events, one sends the device id of a device
  that was just requested to be unplugged from the guest and another one
  to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated

* Patch 6 make sure that we can unplug the vfio-device before
  migration starts

* Patch 7 adds a new migration state that is entered while we wait for
  devices to be unplugged by guest OS

* Patch 8 just adds the new migration state to a check in libqos code

* Patch 9 In the second patch the virtio-net uses the API to defer adding=
 the vfio
  device until the VIRTIO_NET_F_STANDBY feature is acked. It also
  implements the migration handler to unplug the device from the guest an=
d
  re-plug in case of migration failure

* Patch 10 allows migration for failover vfio-pci devices, but only when =
it is
  a networking device=20

Previous discussion:
  RFC v1 https://patchwork.ozlabs.org/cover/989098/
  RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.htm=
l
  v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03968.html
  v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg635214.html

To summarize concerns/feedback from previous discussion:
1.- guest OS can reject or worse _delay_ unplug by any amount of time.
  Migration might get stuck for unpredictable time with unclear reason.
  This approach combines two tricky things, hot/unplug and migration.
  -> We need to let libvirt know what's happening. Add new qmp events
     and a new migration state. When a primary device is (partially)
     unplugged (only from guest) we send a qmp event with the device id. =
When
     it is unplugged from the guest the DEVICE_DELETED event is sent.
     Migration will enter the wait-unplug state while waiting for the gue=
st
     os to unplug all primary devices and then move on with migration.
2. PCI devices are a precious ressource. The primary device should never
  be added to QEMU if it won't be used by guest instead of hiding it in
  QEMU.
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
     One of the problems that stopped management software and libvirt fro=
m
     implementing this idea is that it can't be sure that it's possible t=
o
     re-plug the primary device. By not freeing the devices resources in =
QEMU
     and only asking the guest OS to unplug it is possible to re-plug the
     device in case of a migration failure.
4. Hotplugging a device and then making it part of a failover setup is
   not possible
  -> addressed by extending qdev hotplug functions to check for hidden
     attribute, so e.g. device_add can be used to plug a device.


I have tested this with a mlx5 and igb NIC and was able to migrate the VM=
.

Command line example:

qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
        -machine q35,kernel-irqchip=3Dsplit -cpu host   \
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
:6f:55:cc,bus=3Droot2,failover=3Don \
	-device vfio-pci,host=3D5e:00.2,id=3Dhostdev0,bus=3Droot1,net_failover_p=
air_id =3Dnet1 \
        /root/rhel-guest-image-8.0-1781.x86_64.qcow2

I'm grateful for any remarks or ideas!

Thanks!

regards,
Jens=20


Jens Freimann (10):
  qdev/qbus: add hidden device support
  pci: mark devices partially unplugged
  pci: mark device having guest unplug request pending
  qapi: add unplug primary event
  qapi: add failover negotiated event
  migration: allow unplug during migration for failover devices
  migration: add new migration state wait-unplug
  libqos: tolerate wait-unplug migration state
  net/virtio: add failover support
  vfio: unplug failover primary device before migration

 hw/core/qdev.c                 |  20 +++
 hw/net/virtio-net.c            | 267 +++++++++++++++++++++++++++++++++
 hw/pci/pci.c                   |   2 +
 hw/pci/pcie.c                  |   6 +
 hw/vfio/pci.c                  |  35 ++++-
 hw/vfio/pci.h                  |   2 +
 include/hw/pci/pci.h           |   1 +
 include/hw/qdev-core.h         |  10 ++
 include/hw/virtio/virtio-net.h |  12 ++
 include/hw/virtio/virtio.h     |   1 +
 include/migration/vmstate.h    |   2 +
 migration/migration.c          |  34 +++++
 migration/migration.h          |   3 +
 migration/savevm.c             |  36 +++++
 migration/savevm.h             |   1 +
 qapi/migration.json            |  24 ++-
 qapi/net.json                  |  16 ++
 qdev-monitor.c                 |  43 +++++-
 tests/libqos/libqos.c          |   3 +-
 vl.c                           |   6 +-
 20 files changed, 515 insertions(+), 9 deletions(-)

--=20
2.21.0


