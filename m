Received: from eggs.gnu.org ([2001:4830:134:3::10]:39101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eFPDv-00080a-JL
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:49:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1eFPDs-0000WC-GG
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:49:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1eFPDs-0000U9-AD
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 13:49:12 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 16 Nov 2017 19:48:33 +0100
Message-Id: <20171116184835.28556-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] virtio-net: Fix TX data discard on backend
 disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, yuri.benditovich@daynix.com, yvugenfi@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This series fixes TX data discard when backend disconnects.

On backend disconnection, QEMU cannot retrieve its internal
avail index, which makes the virtio queue internal state
inconsistent (last_avail_idx will always be 0, whereas used_idx
is correct).

It results in discarding TX data to corrupt the vring state, by
completing descriptors already completed by the backend.

This series fixes this by restoring last_avail_idx to the vring
used idx, as some backends used to do on reconnection.

Maxime Coquelin (2):
  virtio: Add queue interface to restore avail index from vring used
    index
  vhost: restore avail index from vring used index on disconnection

 hw/virtio/vhost.c          |  4 ++++
 hw/virtio/virtio.c         | 10 ++++++++++
 include/hw/virtio/virtio.h |  1 +
 3 files changed, 15 insertions(+)

-- 
2.14.3
