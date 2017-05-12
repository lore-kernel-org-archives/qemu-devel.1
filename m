Received: from eggs.gnu.org ([2001:4830:134:3::10]:55985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdC-0000HH-5k
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zd9-0003ct-1S
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:34 -0400
Received: from [59.151.112.132] (port=14198 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zd8-0003YR-L1
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:30 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:16 +0800
Message-ID: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 00/12] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If user use -device virtio-net-pci, virtio-net driver will add a header
to raw net packet that colo-proxy can't handle it. COLO-proxy just
focus on the packet payload, so we skip the virtio-net header to compare
the sent packet that primary guest's to secondary guest's.

V4:
 - Add vnet_hdr option for filter-mirror, filter-redirector,
   filter-rewriter,colo-compare.
 - Use new design to impliment virtio-net support for colo-proxy.
 - Fix codestyle.
 - Remove unused option for filter-rewriter.
 - Add filter-rewriter virtio-net support.
 - Address other comments.


Zhang Chen (12):
  net: Add vnet_hdr_len related arguments in NetClientState
  net/filter-mirror.c: Add new option to enable vnet support for
    filter-mirror
  net/filter-mirror.c: Make filter_mirror_send support vnet support.
  net/filter-mirror.c: Add new option to enable vnet support for
    filter-redirector
  net/net.c: Add vnet_hdr support in SocketReadState
  net/colo-compare.c: Add new option to enable vnet support for
    colo-compare
  net/colo.c: Make vnet_hdr_len as packet property
  net/colo-compare.c: Make colo-compare support vnet_hdr_len
  net/colo.c: Add vnet packet parse feature in colo-proxy
  net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
  net/filter-rewriter.c: Add new option to enable vnet support for
    filter-rewriter
  net/filter-rewriter.c: Make filter-rewriter support vnet_hdr_len

 include/net/net.h     |  11 +++++-
 net/colo-compare.c    |  99 ++++++++++++++++++++++++++++++++++++++---------
 net/colo.c            |   9 +++--
 net/colo.h            |   4 +-
 net/filter-mirror.c   | 104 +++++++++++++++++++++++++++++++++++++++++++++++---
 net/filter-rewriter.c |  55 +++++++++++++++++++++++++-
 net/net.c             |  38 ++++++++++++++++--
 net/socket.c          |   2 +-
 qemu-options.hx       |  17 +++++----
 9 files changed, 296 insertions(+), 43 deletions(-)

-- 
2.7.4
