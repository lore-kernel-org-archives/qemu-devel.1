Received: from eggs.gnu.org ([2001:4830:134:3::10]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fez0o-0000sJ-FF
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:37:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fez0i-0004YM-UZ
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:37:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40248 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fez0i-0004XK-05
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 04:37:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 16 Jul 2018 09:37:30 +0100
Message-Id: <20180716083732.3347-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/2] virtio-scsi: fix hotplug ->reset() vs
 event race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: l00284672 <lizhengui@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

v2:
 * Drop Error **errp argument to post_plug() handler [Paolo]
 * Move post_plug() call outside if (dev->hotplugged)

The virtio-scsi command virtqueues run during hotplug.  This creates the
possibility of race conditions since the guest can submit commands while the
monitor is performing hotplug.

See Patch 2 for a fix for the ->reset() vs event race condition that Zhengui Li
encountered.

Stefan Hajnoczi (2):
  qdev: add HotplugHandler->post_plug() callback
  virtio-scsi: fix hotplug ->reset() vs event race

 include/hw/hotplug.h  | 11 +++++++++++
 hw/core/hotplug.c     | 10 ++++++++++
 hw/core/qdev.c        |  4 ++++
 hw/scsi/virtio-scsi.c | 11 ++++++++++-
 4 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.17.1
