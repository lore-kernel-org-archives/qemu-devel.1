Received: from eggs.gnu.org ([2001:4830:134:3::10]:52095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDg-0001kB-0f
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuri.benditovich@daynix.com>) id 1cGiDc-0003yf-Re
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:51 -0500
Received: from mail-wj0-f178.google.com ([209.85.210.178]:36798)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
	id 1cGiDc-0003uf-JG
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 03:13:48 -0500
Received: by mail-wj0-f178.google.com with SMTP id tk12so93243265wjb.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 00:13:25 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 13 Dec 2016 10:12:04 +0200
Message-Id: <1481616728-148412-1-git-send-email-yuri.benditovich@daynix.com>
Subject: [Qemu-devel] [PATCH v3 0/4] virtio-net discards TX data after link
 down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>

https://bugzilla.redhat.com/show_bug.cgi?id=1295637
Upon set_link monitor command or upon netdev deletion
virtio-net sends link down indication to the guest
and stops vhost if one is used.
Guest driver can still submit data for TX until it
recognizes link loss. If these packets not returned by
the host, the Windows guest will never be able to finish
disable/removal/shutdown. In order to allow qemu to
discard these packets, virtio queue shall update
its internal structure upon vhost stop.

Changes from v2:
   introduced virtqueue_drop_all to drop all queued packets without mapping
   used virtqueue_drop_all instead of pop/push

Changes from v1:
   added drop for outstanding tx packets for tx=timer
   (mainly for case of vhost=off)
   fixed link down flow to drop outstanding packets and
   ensure tx queue notification enabled

Yuri Benditovich (4):
  net: Add virtio queue interface to update used index from vring state
  net: vhost stop updates virtio queue state
  virtio: Introduce virtqueue_drop_all procedure
  net: virtio-net discards TX data after link down

 hw/net/virtio-net.c        | 26 ++++++++++++++++++++++++++
 hw/virtio/vhost.c          |  1 +
 hw/virtio/virtio.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/virtio/virtio.h |  2 ++
 4 files changed, 72 insertions(+)

-- 
1.9.1
