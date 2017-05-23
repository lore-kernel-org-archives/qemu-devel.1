Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDAgL-0002gY-29
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:21:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDAgF-0002zo-QM
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:21:04 -0400
Received: from [59.151.112.132] (port=60354 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dDAgF-0002xH-AS
	for qemu-devel@nongnu.org; Tue, 23 May 2017 10:20:59 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 23 May 2017 22:20:32 +0800
Message-ID: <1495549241-23380-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V5 0/9] Add COLO-proxy virtio-net support
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

V5:
 - patch1: No change.
 - patch2: Keep the long line in qemu-option.hx.
           Squash patch2 into old patch3.
           Add more comments.
           Fix the return value.
 - patch3: Add more comments in commit log.
 - patch4: Add Suggested-by tag.
           Fix commit log.
           Move vnet_hdr to SocketReadState.
 - patch5: No change.
 - patch6: Squash old patch6 into this patch. 
 - patch7: No change.
 - patch8: Remove the offset_all.
 - patch9: Squash old patch11 and the patch12.


V4:
 - Add vnet_hdr option for filter-mirror, filter-redirector,
   filter-rewriter,colo-compare.
 - Use new design to impliment virtio-net support for colo-proxy.
 - Fix codestyle.
 - Remove unused option for filter-rewriter.
 - Add filter-rewriter virtio-net support.
 - Address other comments.


Zhang Chen (9):
  net: Add vnet_hdr_len related arguments in NetClientState
  net/filter-mirror.c: Make filter mirror support vnet support.
  net/filter-mirror.c: Add new option to enable vnet support for
    filter-redirector
  net/net.c: Add vnet_hdr support in SocketReadState
  net/colo.c: Make vnet_hdr_len as packet property
  net/colo-compare.c: Make colo-compare support vnet_hdr_len
  net/colo.c: Add vnet packet parse feature in colo-proxy
  net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
  net/filter-rewriter.c: Make filter-rewriter support vnet_hdr_len

 include/net/net.h     |   8 +++-
 net/colo-compare.c    |  92 +++++++++++++++++++++++++++++++++++++------
 net/colo.c            |   9 +++--
 net/colo.h            |   4 +-
 net/filter-mirror.c   | 107 +++++++++++++++++++++++++++++++++++++++++++++++---
 net/filter-rewriter.c |  55 +++++++++++++++++++++++++-
 net/net.c             |  35 +++++++++++++++--
 qemu-options.hx       |  19 +++++----
 8 files changed, 291 insertions(+), 38 deletions(-)

-- 
2.7.4
