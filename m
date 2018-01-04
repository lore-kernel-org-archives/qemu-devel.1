Received: from eggs.gnu.org ([2001:4830:134:3::10]:50611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eWxty-0007vl-IR
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 00:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eWxtv-0008Aq-Db
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 00:17:14 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:58574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1eWxtv-00087c-4a
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 00:17:11 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  4 Jan 2018 00:16:42 -0500
Message-Id: <cover.1515041373.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v3 0/3] virtio_net: allow hypervisor to
 indicate linkspeed and duplex setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, davem@davemloft.net
Cc: jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

We have found it useful to be able to set the linkspeed and duplex
settings from the host-side for virtio_net. This obviates the need
for guest changes and settings for these fields, and does not require
custom ethtool commands for virtio_net.

The ability to set linkspeed and duplex is useful in various cases
as described here:

16032be virtio_net: add ethtool support for set and get of settings                                                                                                                                                           
Using 'ethtool -s' continues to over-write the linkspeed/duplex
settings with this patch.

The 1/3 patch is against net-next, while the 2-3/3 patch are the associated
qemu changes that would go in after as update-linux-headers.sh should
be run first. So the qemu patches are a demonstration of how I intend this
to work.

Thanks,

-Jason  

linux changes:

changes from v2:
* move speed/duplex read into virtnet_config_changed_work() so link up changes
  are detected

Jason Baron (1):
  virtio_net: propagate linkspeed/duplex settings from the hypervisor

 drivers/net/virtio_net.c        | 19 ++++++++++++++++++-
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

qemu changes:

changes from v2:
* if link up return configured speed/duplex, else return UNKNOWN speed and duplex

Jason Baron (2):
  qemu: virtio-net: use 64-bit values for feature flags
  qemu: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                         | 89 ++++++++++++++++++++---------
 include/hw/virtio/virtio-net.h              |  5 +-
 include/standard-headers/linux/virtio_net.h | 13 +++++
 3 files changed, 79 insertions(+), 28 deletions(-)


-- 
2.6.1
