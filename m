Received: from eggs.gnu.org ([209.51.188.92]:51049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1wT-0008WJ-39
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gm1wS-0001a2-6Y
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:42:37 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Tue, 22 Jan 2019 17:53:20 +0200
Message-Id: <cover.1548171741.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH 0/3] iothread-related fixes for virtio-scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hi,

here are three patches with iothread-related fixes for virtio-scsi,
with their test cases.

This series fixes the following bugs:

   https://bugzilla.redhat.com/show_bug.cgi?id=1656276

   https://bugzilla.redhat.com/show_bug.cgi?id=1662508

I also wanted to do prepare a similar one for virtio-blk but I'm
unsure about how to proceed, because I'm unable to detect during
realize() that the blockdev is using a different iothread. This
crashes QEMU:

{ "execute": "qmp_capabilities" }
{ "execute": "blockdev-add", "arguments": {"driver": "null-co", "node-name": "hd0", "read-only": true}}
{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread0"}}
{ "execute": "object-add", "arguments": {"qom-type": "iothread", "id": "iothread1"}}
{ "execute": "device_add", "arguments": {"id": "virtio-blk0", "driver": "virtio-blk", "iothread": "iothread0", "drive": "hd0"}}
{ "execute": "system_reset"}
  (wait for the events)
{ "execute": "device_add", "arguments": {"id": "virtio-blk1", "driver": "virtio-blk", "iothread": "iothread1", "drive": "hd0"}}

Regards,

Berto

Alberto Garcia (3):
  virtio-scsi: Move BlockBackend back to the main AioContext on unplug
  scsi-disk: Acquire the AioContext in scsi_*_realize()
  virtio-scsi: Forbid devices with different iothreads sharing a
    blockdev

 hw/scsi/scsi-disk.c        |  23 ++++++--
 hw/scsi/virtio-scsi.c      |  13 +++++
 tests/qemu-iotests/240     | 129 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/240.out |  54 +++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 5 files changed, 217 insertions(+), 3 deletions(-)
 create mode 100755 tests/qemu-iotests/240
 create mode 100644 tests/qemu-iotests/240.out

-- 
2.11.0
