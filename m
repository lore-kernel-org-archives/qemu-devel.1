Received: from eggs.gnu.org ([2001:4830:134:3::10]:59225)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURf-0003pr-UF
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURc-0003EU-Oo
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQURc-0003E2-IN
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:04:56 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Jun 2017 16:04:45 +0800
Message-Id: <20170629080452.26470-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/7] qdev: Introduce DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

v2: Create a new header for link properties. [Paolo]
    Don't wrap, use PropertyInfo.create() (much better diffstat, yay!).
    [Paolo]

Link properties of devices created with object_property_add_link() are not
reflected in HMP "info qtree". For example, whether a virtio-blk device has an
iothread (i.e. has enabled data plane) can not be introspected easily.

Introduce a new type of qdev property macro to fix that.

Fam Zheng (7):
  qom: Make link property API public
  qom: Handle property lookup failure in object_resolve_link
  qdev: Introduce PropertyInfo.create
  qdev: Introduce DEFINE_PROP_LINK
  virtio-blk: Use DEFINE_PROP_LINK
  virtio-scsi: Use DEFINE_PROP_LINK
  virtio-rng: Use DEFINE_PROP_LINK

 hw/block/dataplane/virtio-blk.c |  2 +-
 hw/block/virtio-blk.c           |  7 +++----
 hw/core/qdev-properties.c       | 16 ++++++++++++++++
 hw/core/qdev.c                  | 31 +++++++++++++++++++------------
 hw/scsi/virtio-scsi-dataplane.c |  2 +-
 hw/scsi/virtio-scsi.c           | 15 ++++-----------
 hw/virtio/virtio-pci.c          |  6 ------
 hw/virtio/virtio-rng.c          | 16 ++++------------
 include/hw/qdev-core.h          |  6 ++++++
 include/hw/qdev-properties.h    | 11 +++++++++++
 include/hw/virtio/virtio-blk.h  |  2 +-
 include/hw/virtio/virtio-rng.h  |  2 +-
 include/hw/virtio/virtio-scsi.h |  2 +-
 include/qom/link-property.h     | 31 +++++++++++++++++++++++++++++++
 qom/object.c                    | 24 +++++++++++-------------
 15 files changed, 110 insertions(+), 63 deletions(-)
 create mode 100644 include/qom/link-property.h

-- 
2.9.4
