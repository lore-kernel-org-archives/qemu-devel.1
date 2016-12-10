Received: from eggs.gnu.org ([2001:4830:134:3::10]:35005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFjc2-0000QR-8U
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:30:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cFjbz-0007OG-3l
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:30:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cFjby-0007O4-UZ
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 10:30:55 -0500
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Sat, 10 Dec 2016 16:30:35 +0100
Message-Id: <20161210153038.9184-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/3] virtio-net: Add support to MTU feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, aconole@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, jasowang@redhat.com, yuanhan.liu@linux.intel.com
Cc: fbl@redhat.com, berrange@redhat.com, mlureau@redhat.com, ktraynor@redhat.com, Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks for the reviews,

This series implements Virtio spec update from Aaron Conole which
defines a way for the host to expose its max MTU to the guest.

"host_mtu" parameter is added to provide QEMU with the MTU value,
and the backend, if supported, gets notified of the MTU value when the
MTU feature neogotiation succeeds.

Only user backend currently supports MTU notification. A new protocol
feature has been implemented for sending MTU value to the backend.

For kernel backend, it is expected the management tool also configures
the tap/macvtap interface with same MTU value.
Daniel, I would be interrested about your feedback on this implementation
from management tool point of view.

Changes since RFC v3:
---------------------
 - No more RFC as consensus seems found on design
 - No more report an error if backend not implemented
 - Instead, check reply from the backend if REPLY_ACK supported
 - Add NET previx to new protocol feature & request names
 - Add return value to vhost_net_set_mtu() when !CONFIG_VHOST_NET

Changes since RFC v2:
---------------------
 - host_mtu propoerty is now used to specify the MTU value
 - update vhost-user spec with MTU additions

Changes since RFC v1:
---------------------
 - Rebased on top of v2.8.0-rc0 (2.7.90)
 - Write MTU unconditionnaly in netcfg to avoid memory leak (Paolo)
 - Add host_mtu property to be able to disable the feature from QEMU

Maxime Coquelin (3):
  vhost-user: Add MTU protocol feature and op
  vhost-net: Notify the backend about the host MTU
  virtio-net: Add MTU feature support

 docs/specs/vhost-user.txt         | 16 ++++++++++++++++
 hw/net/vhost_net.c                | 18 ++++++++++++++++++
 hw/net/virtio-net.c               | 19 +++++++++++++++++++
 hw/virtio/vhost-user.c            | 34 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-backend.h |  2 ++
 include/hw/virtio/virtio-net.h    |  1 +
 include/net/vhost_net.h           |  2 ++
 7 files changed, 92 insertions(+)

-- 
2.9.3
