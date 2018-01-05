Received: from eggs.gnu.org ([2001:4830:134:3::10]:42328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eXajr-00050i-63
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:45:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jbaron@akamai.com>) id 1eXajm-0005cO-PC
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:45:23 -0500
Received: from mx0a-00190b01.pphosted.com ([2620:100:9001:583::1]:60672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jbaron@akamai.com>) id 1eXajl-0005a1-OU
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 17:45:18 -0500
From: Jason Baron <jbaron@akamai.com>
Date: Fri,  5 Jan 2018 17:44:52 -0500
Message-Id: <cover.1515190238.git.jbaron@akamai.com>
Subject: [Qemu-devel] [PATCH v4 0/3] virtio_net: allow hypervisor to
 indicate linkspeed and duplex setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com
Cc: davem@davemloft.net, jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

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

changes from v3:
* break the speed/duplex read into a function and also call from virtnet_probe
  when status bit is not negotiated
* only do speed/duplex read in virtnet_config_changed_work() on LINK_UP

changes from v2:
* move speed/duplex read into virtnet_config_changed_work() so link up changes
  are detected

Jason Baron (1):
  virtio_net: propagate linkspeed/duplex settings from the hypervisor

 drivers/net/virtio_net.c        | 23 ++++++++++++++++++++++-
 include/uapi/linux/virtio_net.h | 13 +++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)


qemu changes:

Jason Baron (2):
  qemu: virtio-net: use 64-bit values for feature flags
  qemu: add linkspeed and duplex settings to virtio-net

 hw/net/virtio-net.c                         | 87 ++++++++++++++++++++---------
 include/hw/virtio/virtio-net.h              |  5 +-
 include/standard-headers/linux/virtio_net.h | 13 +++++
 3 files changed, 77 insertions(+), 28 deletions(-)

-- 
2.6.1
