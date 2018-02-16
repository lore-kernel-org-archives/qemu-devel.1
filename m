Received: from eggs.gnu.org ([2001:4830:134:3::10]:43036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp8-0002RS-2W
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1emjp4-0007hK-UR
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:26 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1emjp4-0007gP-Py
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 12:29:22 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0A5818182D11
	for <qemu-devel@nongnu.org>; Fri, 16 Feb 2018 17:29:18 +0000 (UTC)
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 16 Feb 2018 18:29:05 +0100
Message-Id: <20180216172910.8549-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [RFC 0/5] vhost-user: Forward virtio device status
 updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@redhat.com, mst@redhat.com, mlureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This series introduces a new vhost-user request to notify the
backend with virtio device status updates.

This is done to address the case when the guest driver only
intializes a subset of the virtqueues. For example, it happens
with Windows virtio-net driver, when the virtio-net device has
more queue pairs than vCPUs.

With Virtio 1.0 devices, the driver sets DRIVER_OK after having
intialized all queues, so the backend can use this information
to start the vhost port.

With legacy devices, this is not guaranteed as mentionned in
the spec, so the backend should not rely on DRIVER_OK.
A solution has yet to be found for legacy devices.

Maxime Coquelin (5):
  vhost: send virtio device status update to the backend
  vhost-user: Introduce new request to send virtio device status
  vhost_net: send virtio device status update to the backend
  vhost-user-blk: send virtio status to the backend
  vhost-user-scsi: send virtio status to the backend

 docs/interop/vhost-user.txt       | 14 ++++++++++++++
 hw/block/vhost-user-blk.c         |  1 +
 hw/net/vhost_net.c                | 10 ++++++++++
 hw/net/virtio-net.c               |  7 ++++++-
 hw/scsi/vhost-user-scsi.c         |  2 ++
 hw/virtio/vhost-user.c            | 35 +++++++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 | 11 +++++++++++
 include/hw/virtio/vhost-backend.h |  3 +++
 include/hw/virtio/vhost.h         |  3 +++
 include/net/vhost_net.h           |  2 ++
 10 files changed, 87 insertions(+), 1 deletion(-)

-- 
2.14.3
