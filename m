Received: from eggs.gnu.org ([2001:4830:134:3::10]:34251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvOAP-0006fw-HF
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1fvNum-0003ZO-2W
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:20 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:53111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1fvNul-0003To-Ni
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 10:27:15 -0400
Received: by mail-wm0-x244.google.com with SMTP id y139-v6so2197602wmc.2
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 07:27:15 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 30 Aug 2018 17:27:02 +0300
Message-Id: <20180830142708.14311-1-sameeh@daynix.com>
Subject: [Qemu-devel] [RFC 0/6] Virtio-net: Support RSS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Yan Vugenfirer <yan@daynix.com>

From: Sameeh Jubran <sjubran@redhat.com>

This series implements the Steering Mode feature which was introduced on the
virtio-dev list a while ago, which can be found here:
* https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html

The first three patches add some infrastructure support that is used in
the following three patches.

The ebpf filter doesn't fully work yet as I'm having an issue with the
verifier which needs to be fixed.

The patches still need some love as not all of the cases have been handled
yet most of the functionality has been implemented.

Please share your thoughts and comments so I'll move forward with
sending v1 along with a fully functioning ebpf code.

Sameeh Jubran (6):
  Add bpf support to qemu
  tap: Add support for bpf ioctls
  vhost-net: Expose vhost_net_get_fd
  virtio-net: implement steering mode feature
  virtio-net: steering mode: Implement rss support
  virtio-net: rss: Add bpf filter

 MAINTAINERS                                 |    5 +
 configure                                   |   44 +
 hw/net/rss_bpf_insns.h                      | 3992 +++++++++++++++++++++++++++
 hw/net/rss_tap_bpf.h                        |   37 +
 hw/net/rss_tap_bpf_program.c                |  172 ++
 hw/net/vhost_net.c                          |    2 +-
 hw/net/virtio-net.c                         |  250 +-
 include/hw/virtio/virtio-net.h              |    5 +
 include/net/net.h                           |    3 +-
 include/standard-headers/linux/virtio_net.h |   55 +
 net/tap-bsd.c                               |    5 +
 net/tap-linux.c                             |   29 +-
 net/tap-linux.h                             |    3 +-
 net/tap-solaris.c                           |    5 +
 net/tap-stub.c                              |    5 +
 net/tap.c                                   |    8 +
 net/tap_int.h                               |    1 +
 qapi/net.json                               |   11 +
 scripts/update-linux-headers.sh             |    8 +-
 19 files changed, 4627 insertions(+), 13 deletions(-)
 create mode 100644 hw/net/rss_bpf_insns.h
 create mode 100644 hw/net/rss_tap_bpf.h
 create mode 100644 hw/net/rss_tap_bpf_program.c

-- 
2.13.6
