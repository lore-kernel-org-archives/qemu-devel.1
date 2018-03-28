Received: from eggs.gnu.org ([2001:4830:134:3::10]:33634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1DRv-0005kt-Nk
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:57:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1f1DRs-0002Hl-Md
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:57:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58058 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1f1DRs-0002HL-Ig
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 11:57:16 -0400
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Date: Wed, 28 Mar 2018 17:56:55 +0200
Message-Id: <20180328155657.6434-1-maxime.coquelin@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vhost-user: Back SET/GET_CONFIG with a
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

Hi,

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

Maxime Coquelin (2):
  vhost-user-blk: set config ops before vhost-user init
  vhost-user: back SET/GET_CONFIG requests with a protocol feature

 docs/interop/vhost-user.txt | 21 ++++++++++++---------
 hw/block/vhost-user-blk.c   |  4 ++--
 hw/virtio/vhost-user.c      | 17 +++++++++++++++++
 3 files changed, 31 insertions(+), 11 deletions(-)

-- 
2.14.3
