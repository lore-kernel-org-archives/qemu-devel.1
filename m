Received: from eggs.gnu.org ([2001:4830:134:3::10]:52778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dGjfW-0004lH-O2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dGjfR-0001oj-UJ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:18:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dGjfR-0001nz-OQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:18:53 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri,  2 Jun 2017 12:18:26 +0200
Message-Id: <20170602101831.26576-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 0/5] vhost-user: Specify and implement
 device IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, peterx@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org, jfreiman@redhat.com
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This series aims at specifying ans implementing the protocol update
required to support device IOTLB with user backends.

In this third non-RFC version, main change is mandating the slave to be a=
ble
to send IOTLB miss requests for any addresses it needs to access. It impl=
ies
the removal of patch 3, which is no more necessary, and the related spec
update in patch 6. Also, a check is added in vhost-user init to ensure th=
at
the slave does not advertise VIRTIO_F_IOMMU_PLATFORM if it does not suppo=
rt
both VHOST_USER_PROTOCOL_F_SLAVE_REQ and VHOST_USER_PROTOCOL_F_REPLY_ACK
protcol features.

The slave requests channel part is re-used from Marc-Andr=C3=A9's series =
submitted
last year[1], with main changes from original version being request/featu=
re
names renaming and addition of the REPLY_ACK feature support.

Regarding IOTLB protocol, one noticeable change is the IOTLB miss request
reply made optionnal (i.e. only if slave requests it by setting the
VHOST_USER_NEED_REPLY flag in the message header). This change provides
more flexibility in the backend implementation of the feature.

The protocol is very close to kernel backends, except that a new
communication channel is introduced to enable the slave to send
requests to the master.

[1]: https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.html

Marc-Andr=C3=A9 Lureau (2):
  vhost-user: add vhost_user to hold the chr
  vhost-user: add slave-req-fd support

Maxime Coquelin (3):
  vhost: propagate errors in vhost_device_iotlb_miss()
  vhost: rework IOTLB messaging
  spec/vhost-user spec: Add IOMMU support

 docs/specs/vhost-user.txt         | 116 ++++++++++++++++++++++-
 hw/net/vhost_net.c                |   1 +
 hw/virtio/vhost-backend.c         | 130 ++++++++++++++-----------
 hw/virtio/vhost-user.c            | 194 ++++++++++++++++++++++++++++++++=
++++--
 hw/virtio/vhost.c                 |  19 ++--
 include/hw/virtio/vhost-backend.h |  23 +++--
 include/hw/virtio/vhost.h         |   2 +-
 7 files changed, 404 insertions(+), 81 deletions(-)

--=20
2.9.4
