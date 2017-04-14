Received: from eggs.gnu.org ([2001:4830:134:3::10]:48640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cz5Dz-0004MU-0O
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:41:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1cz5Dv-0005cl-31
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:41:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1cz5Du-0005b8-T2
	for qemu-devel@nongnu.org; Fri, 14 Apr 2017 13:41:31 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 14 Apr 2017 19:40:52 +0200
Message-Id: <20170414174056.28946-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 0/4] vhost-user: Specify and implement device
 IOTLB support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcandre.lureau@gmail.com, vkaplans@redhat.com, jasowang@redhat.com, wexu@redhat.com, peterx@redhat.com, yuanhan.liu@linux.intel.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>

This series aims at specifying ans implementing the protocol update
required to support device IOTLB with user backends.

In this second version, the slave requests channel part is re-used
from Marc-Andr=C3=A9's series submitted last year[0], with main changes
from original version being request/feature names renaming and addition
of the REPLY_ACK feature support.

Regarding IOTLB protocol, one noticeable change is the IOTLB miss request
reply made optionnal (i.e. only if slave requests it by setting the
VHOST_USER_NEED_REPLY flag in the message header). This change provides
more flexibility in the backend implementation of the feature.

The protocol is very close to kernel backends, except that a new
communication channel is introduced to enable the slave to send
requests to the master.

[0]: https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.html

Marc-Andr=C3=A9 Lureau (2):
  vhost-user: add vhost_user to hold the chr
  vhost-user: add slave-req-fd support

Maxime Coquelin (2):
  vhost: propagate errors in vhost_device_iotlb_miss()
  spec/vhost-user spec: Add IOMMU support

 docs/specs/vhost-user.txt | 104 ++++++++++++++++++++-
 hw/virtio/vhost-user.c    | 234 ++++++++++++++++++++++++++++++++++++++++=
+++++-
 hw/virtio/vhost.c         |  15 ++-
 include/hw/virtio/vhost.h |   2 +-
 4 files changed, 344 insertions(+), 11 deletions(-)

--=20
2.9.3
