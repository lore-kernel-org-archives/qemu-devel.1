Received: from eggs.gnu.org ([2001:4830:134:3::10]:47112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCP0-0002on-15
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCOx-00015X-06
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33238)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCOw-00014z-Qr
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:48:58 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:43 +0800
Message-Id: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 0/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Link properties of devices created with object_property_add_link() are not
reflected in HMP "info qtree". For example, whether a virtio-blk device has an
iothread (i.e. has enabled data plane) can not be introspected easily.

Introduce a new type of qdev property to fix that.

Because QOM is not my most familiar area, only virtio devices are converted in
this version. If the new API is okay, other devices can be worked on either in
v2 or in a follow up series.

Fam Zheng (7):
  qom: Make link property API public
  qom: Handle property lookup failure in object_resolve_link
  qom: Save type name in LinkProperty
  qdev: Introduce DEFINE_PROP_LINK
  virtio-blk: Use DEFINE_PROP_LINK
  virtio-scsi: Use DEFINE_PROP_LINK
  virtio-rng: Use DEFINE_PROP_LINK

 hw/block/dataplane/virtio-blk.c |  2 +-
 hw/block/virtio-blk.c           |  7 ++--
 hw/core/qdev-properties.c       | 81 +++++++++++++++++++++++++++++++++++++++++
 hw/scsi/virtio-scsi-dataplane.c |  2 +-
 hw/scsi/virtio-scsi.c           | 15 ++------
 hw/virtio/virtio-pci.c          |  6 ---
 hw/virtio/virtio-rng.c          | 16 ++------
 include/hw/qdev-core.h          |  3 ++
 include/hw/qdev-properties.h    | 11 ++++++
 include/hw/virtio/virtio-blk.h  |  2 +-
 include/hw/virtio/virtio-rng.h  |  2 +-
 include/hw/virtio/virtio-scsi.h |  2 +-
 include/qom/object.h            | 14 +++++++
 qom/object.c                    | 24 ++++++------
 14 files changed, 136 insertions(+), 51 deletions(-)

-- 
2.9.4
