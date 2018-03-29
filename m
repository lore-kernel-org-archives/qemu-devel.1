Received: from eggs.gnu.org ([2001:4830:134:3::10]:46333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1SMp-0008T0-2d
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1SMm-0001Xq-1f
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:53:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1f1SMl-0001Xd-TT
	for qemu-devel@nongnu.org; Thu, 29 Mar 2018 03:52:59 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Thu, 29 Mar 2018 09:52:31 +0200
Message-Id: <20180329075233.524-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] vhost-user: Back SET/GET_CONFIG with a
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, changpeng.liu@intel.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>


V3 removes the assert of vhost_dev's vhost_ops, as it is not yet
set at that time.

While reviewing DPDK series adding support to VHOST_USER_SET_CONFIG
and VHOST_USER_GET_CONFIG request, I found that it was not backed
with a dedicated protocol feature.

This series addresses this by adding a new protocol feature bit,
and by only negotiating it if the device supports it, as suggested
by Michael. Indeed, if the feature is supported by other type of
devices in the future, it would confuse the backends as it couldn't
know whether the device really support it or not.

To know whether the vhost device support config feature, the trick
is to check whether it implemented the config_ops. That's the 
reason why the first patch moves setting the config ops in
vhost-user-blk befoire calling vhost_user_init().

The series targets v2.12 release, else we may have to disable these
requests in this release.

*NOTE*: The series has only been tested as I don't have the
environment to try it. Changpeng, can you please test it?

Thanks,
Maxime

Changes since v2:
=================
 - Remove assert (Changpeng)
 - Fix typo in comment

Changes since v1:
=================
 - Fail vhost-user init if device implements config
   feature but the backend doesn't. (mst)

Maxime Coquelin (2):
  vhost-user-blk: set config ops before vhost-user init
  vhost-user: back SET/GET_CONFIG requests with a protocol feature

 docs/interop/vhost-user.txt | 21 ++++++++++++---------
 hw/block/vhost-user-blk.c   |  4 ++--
 hw/virtio/vhost-user.c      | 22 ++++++++++++++++++++++
 hw/virtio/vhost.c           |  1 -
 4 files changed, 36 insertions(+), 12 deletions(-)

-- 
2.14.3
