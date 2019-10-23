Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF5CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 375172084C
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cSCy9ezk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 375172084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNC5I-0005W5-Ve
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 04:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48245)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iNBzP-0002r4-MN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iNBzN-0005jf-8v
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:31 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23598
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iNBzN-0005gZ-3j
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 04:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571819245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VKsS+5S1Bf5wcaKxnRQSdtP6pBejdgvzZ5N+9/bdZWQ=;
 b=cSCy9ezkrTV+dzmT0LsKpi9soYLXeCJK5CZ0IpZGOjLQQQNtzfpjc+DmITbqJSTlWi0kG5
 ER72aIq/ZTDR74DTXViV+346phb1C8lUSo76Vb+wL2jPy57ACCgrku9Xh/MkwUIGHLcyif
 /DcKTwe2jodHx7UiwuupfXwJAxrX7L0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-115-chPYwVCONPyXsV8HKl3TEA-1; Wed, 23 Oct 2019 04:27:21 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46DE2800D54;
 Wed, 23 Oct 2019 08:27:20 +0000 (UTC)
Received: from localhost (dhcp-192-217.str.redhat.com [10.33.192.217])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E5ECB5D6D0;
 Wed, 23 Oct 2019 08:27:12 +0000 (UTC)
From: Jens Freimann <jfreimann@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 0/11] add failover feature for assigned network devices
Date: Wed, 23 Oct 2019 10:27:00 +0200
Message-Id: <20191023082711.16694-1-jfreimann@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: chPYwVCONPyXsV8HKl3TEA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pkrempa@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 mst@redhat.com, aadam@redhat.com, dgilbert@redhat.com,
 alex.williamson@redhat.com, laine@redhat.com, ailan@redhat.com,
 parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is implementing the host side of the net_failover concept
(https://www.kernel.org/doc/html/latest/networking/net_failover.html)

Changes since v4:
* Patch 1, qdev, add comment to DeviceClass and qdev_should_hide_device
           function
* Patch 2  pci, set flag that allows unplug during migration in qdev
           code (aw)
* Patch 10 virtio, fix error handling
* Patch 11 vfio, fix error handling in vfio_realize (Conny)
           move allow_unplug_during_migraton flag to generic PCI=20

The general idea is that we have a pair of devices, a vfio-pci and a
virtio-net device. Before migration the vfio device is unplugged and data
flows to the virtio-net device, on the target side another vfio-pci device
is plugged in to take over the data-path. In the guest the net_failover
module will pair net devices with the same MAC address.

* Patch 1 adds the infrastructure to hide the device for the qbus and qdev =
APIs

* Patch 2 adds checks to PCIDevice for only allowing ethernet devices as
  failover primary and only PCIExpress capable devices

* Patch 3 sets a new flag for PCIDevice 'partially_hotplugged' which we
  use to skip the unrealize code path when doing a unplug of the primary
  device

* Patch 4 sets the pending_deleted_event before triggering the guest
  unplug request

* Patch 5 and 6 add new qmp events, one sends the device id of a device
  that was just requested to be unplugged from the guest and another one
  to let libvirt know if VIRTIO_NET_F_STANDBY was negotiated

* Patch 7 make sure that we can unplug the vfio-device before
  migration starts

* Patch 8 adds a new migration state that is entered while we wait for
  devices to be unplugged by guest OS

* Patch 9 just adds the new migration state to a check in libqos code

* Patch 10 In the second patch the virtio-net uses the API to defer adding =
the vfio
  device until the VIRTIO_NET_F_STANDBY feature is acked. It also
  implements the migration handler to unplug the device from the guest and
  re-plug in case of migration failure

* Patch 11 allows migration for failover vfio-pci devices

Previous discussion:
  RFC v1 https://patchwork.ozlabs.org/cover/989098/
  RFC v2 https://www.mail-archive.com/qemu-devel@nongnu.org/msg606906.html
  v1: https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg03968.html
  v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg635214.html
  v3: https://patchew.org/QEMU/20191011112015.11785-1-jfreimann@redhat.com/
  v4: https://patchew.org/QEMU/20191018202040.30349-1-jfreimann@redhat.com/

To summarize concerns/feedback from previous discussion:
1.- guest OS can reject or worse _delay_ unplug by any amount of time.
  Migration might get stuck for unpredictable time with unclear reason.
  This approach combines two tricky things, hot/unplug and migration.
  -> We need to let libvirt know what's happening. Add new qmp events
     and a new migration state. When a primary device is (partially)
     unplugged (only from guest) we send a qmp event with the device id. Wh=
en
     it is unplugged from the guest the DEVICE_DELETED event is sent.
     Migration will enter the wait-unplug state while waiting for the guest
     os to unplug all primary devices and then move on with migration.
2. PCI devices are a precious ressource. The primary device should never
  be added to QEMU if it won't be used by guest instead of hiding it in
  QEMU.
  -> We only hotplug the device when the standby feature bit was
     negotiated. We save the device cmdline options until we need it for
     qdev_device_add()
     Hiding a device can be a useful concept to model. For example a
     pci device in a powered-off slot could be marked as hidden until the s=
lot is
     powered on (mst).
3. Management layer software should handle this. Open Stack already has
  components/code to handle unplug/replug VFIO devices and metadata to
  provide to the guest for detecting which devices should be paired.
  -> An approach that includes all software from firmware to
     higher-level management software wasn't tried in the last years. This =
is
     an attempt to keep it simple and contained in QEMU as much as possible=
.
     One of the problems that stopped management software and libvirt from
     implementing this idea is that it can't be sure that it's possible to
     re-plug the primary device. By not freeing the devices resources in QE=
MU
     and only asking the guest OS to unplug it is possible to re-plug the
     device in case of a migration failure.
4. Hotplugging a device and then making it part of a failover setup is
   not possible
  -> addressed by extending qdev hotplug functions to check for hidden
     attribute, so e.g. device_add can be used to plug a device.


I have tested this with a mlx5 and igb NIC and was able to migrate the VM.

Command line example:

qemu-system-x86_64 -enable-kvm -m 3072 -smp 3 \
        -machine q35,kernel-irqchip=3Dsplit -cpu host   \
        -serial stdio   \
        -net none \
        -qmp unix:/tmp/qmp.socket,server,nowait \
        -monitor telnet:127.0.0.1:5555,server,nowait \
        -device pcie-root-port,id=3Droot0,multifunction=3Don,chassis=3D0,ad=
dr=3D0xa \
        -device pcie-root-port,id=3Droot1,bus=3Dpcie.0,chassis=3D1 \
        -device pcie-root-port,id=3Droot2,bus=3Dpcie.0,chassis=3D2 \
        -netdev tap,script=3D/root/bin/bridge.sh,downscript=3Dno,id=3Dhostn=
et1,vhost=3Don \
        -device virtio-net-pci,netdev=3Dhostnet1,id=3Dnet1,mac=3D52:54:00:6=
f:55:cc,bus=3Droot2,failover=3Don \
=09-device vfio-pci,host=3D5e:00.2,id=3Dhostdev0,bus=3Droot1,net_failover_p=
air_id =3Dnet1 \
        /root/rhel-guest-image-8.0-1781.x86_64.qcow2

I'm grateful for any remarks or ideas!

Thanks!

regards,
Jens=20

Jens Freimann (11):
  qdev/qbus: add hidden device support
  pci: add option for net failover
  pci: mark devices partially unplugged
  pci: mark device having guest unplug request pending
  qapi: add unplug primary event
  qapi: add failover negotiated event
  migration: allow unplug during migration for failover devices
  migration: add new migration state wait-unplug
  libqos: tolerate wait-unplug migration state
  net/virtio: add failover support
  vfio: unplug failover primary device before migration

 hw/core/qdev.c                 |  24 +++
 hw/net/virtio-net.c            | 302 +++++++++++++++++++++++++++++++++
 hw/pci/pci.c                   |  18 ++
 hw/pci/pcie.c                  |   6 +
 hw/vfio/pci.c                  |  26 ++-
 hw/vfio/pci.h                  |   1 +
 include/hw/pci/pci.h           |   4 +
 include/hw/qdev-core.h         |  30 ++++
 include/hw/virtio/virtio-net.h |  12 ++
 include/hw/virtio/virtio.h     |   1 +
 include/migration/vmstate.h    |   2 +
 migration/migration.c          |  21 +++
 migration/migration.h          |   3 +
 migration/savevm.c             |  36 ++++
 migration/savevm.h             |   2 +
 qapi/migration.json            |  24 ++-
 qapi/net.json                  |  16 ++
 qdev-monitor.c                 |  43 ++++-
 tests/libqos/libqos.c          |   3 +-
 vl.c                           |   6 +-
 20 files changed, 565 insertions(+), 15 deletions(-)

--=20
2.21.0


