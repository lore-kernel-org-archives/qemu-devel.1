Received: from eggs.gnu.org ([2001:4830:134:3::10]:59702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dEGF6-0001CH-0h
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:29:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1dEGF2-0007q5-2i
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:29:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1dEGF1-0007nr-Sh
	for qemu-devel@nongnu.org; Fri, 26 May 2017 10:29:24 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Fri, 26 May 2017 16:28:52 +0200
Message-Id: <20170526142858.19931-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 0/6] vhost-user: Specify and implement
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

In this second non-RFC version, main changes are:
 - spec fixes and clarification
 - rings information update has been restored back to ring enablement tim=
e
 - Work around GCC 4.4.7 limitation wrt assignment in unnamed union at
declaration time.

The series can be tested with vhost_iotlb_proto_v2 branch on my gitlab
account[0].

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

[0]: https://gitlab.com/mcoquelin/dpdk-next-virtio/commits/vhost_iotlb_pr=
oto_v2
[1]: https://lists.gnu.org/archive/html/qemu-devel/2016-04/msg00095.html

Marc-Andr=C3=A9 Lureau (2):
  vhost-user: add vhost_user to hold the chr
  vhost-user: add slave-req-fd support

Maxime Coquelin (4):
  vhost: propagate errors in vhost_device_iotlb_miss()
  vhost: rework IOTLB messaging
  vhost: extend ring information update for IOTLB to all rings
  spec/vhost-user spec: Add IOMMU support

 docs/specs/vhost-user.txt         | 118 ++++++++++++++++++++++++-
 hw/virtio/vhost-backend.c         | 130 ++++++++++++++++------------
 hw/virtio/vhost-user.c            | 177 ++++++++++++++++++++++++++++++++=
+++++-
 hw/virtio/vhost.c                 |  27 ++++--
 include/hw/virtio/vhost-backend.h |  23 +++--
 include/hw/virtio/vhost.h         |   2 +-
 6 files changed, 397 insertions(+), 80 deletions(-)

--=20
2.9.4
