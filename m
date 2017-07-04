Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0003ha-0g
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhc-00071b-2U
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:57 -0400
Received: from [59.151.112.132] (port=28283 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhb-0006vy-38
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:51 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:44 +0800
Message-ID: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 00/12] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

If user use -device virtio-net-pci, virtio-net driver will add a header
to raw net packet that colo-proxy can't handle it. COLO-proxy just
focus on the packet payload, so we skip the virtio-net header to compare
the sent packet that primary guest's to secondary guest's.

V7:
 - p1: No change.
 - p2: Fix typo.
       Move old patch 04/10 to 02/10.
       Introduce a parameter for net_socket_rs_init().
 - p3: Address comments split from origin 02/10.
       Rebase code.
 - p4: Remove some comments.
       Fix typo.
       Remove direction related codes, just get vnet_hdr_len
       from nf->netdev->vnet_hdr_len.
 - p5: Remove some comments.
       Fix typo.
 - p6: Origin 05/10.
 - p7: Address comments split from origin 06/10.
 - p8: Origin 06/10.
 - p9: Fix typo. origin 07/10.
 - p10: Origin 08/10.
 - p11: Remove some comments.
        Remove direction related codes, just get vnet_hdr_len
        from nf->netdev->vnet_hdr_len.
 - p12: Origin 10/10.

V6:
 - p1: Remove the using_vnet_hdr, I will send a independent
       patchset about it.
 - p2: Change option input way from vnet_hdr=on/off to vnet_hdr_support.
       Use nf->direction to decide check nf->netdev->vnet_hdr_len or nf->netdev->peer->vnet_hdr_len.
 - p3: Change option input way from vnet_hdr=on/off to vnet_hdr_support.
 - p4: No change.
 - p5: No change.
 - p6: Change option input way from vnet_hdr=on/off to vnet_hdr_support.
       Fix commit log.
 - p7: No change.
 - p8: No change.
 - p9: Change option input way from vnet_hdr=on/off to vnet_hdr_support.
       Use nf->direction to decide check nf->netdev->vnet_hdr_len or nf->netdev->peer->vnet_hdr_len.
 - p10: New patch to add new example for the case needs vnet hdr.

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


Zhang Chen (12):
  net: Add vnet_hdr_len arguments in NetClientState
  net/net.c: Add vnet_hdr support in SocketReadState
  net/filter-mirror.c: Introduce parameter for filter_send()
  net/filter-mirror.c: Make filter mirror support vnet support.
  net/filter-mirror.c: Add new option to enable vnet support for
    filter-redirector
  net/colo.c: Make vnet_hdr_len as packet property
  net/colo-compare.c: Introduce parameter for compare_chr_send()
  net/colo-compare.c: Make colo-compare support vnet_hdr_len
  net/colo.c: Add vnet packet parse feature in colo-proxy
  net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
  net/filter-rewriter.c: Make filter-rewriter support vnet_hdr_len
  docs/colo-proxy.txt: Update colo-proxy usage of net driver with
    vnet_header

 docs/colo-proxy.txt   | 26 ++++++++++++++++
 include/net/net.h     | 10 ++++--
 net/colo-compare.c    | 84 ++++++++++++++++++++++++++++++++++++++++++---------
 net/colo.c            |  9 +++---
 net/colo.h            |  4 ++-
 net/filter-mirror.c   | 75 +++++++++++++++++++++++++++++++++++++++++----
 net/filter-rewriter.c | 37 ++++++++++++++++++++++-
 net/net.c             | 37 ++++++++++++++++++++---
 net/socket.c          |  8 ++---
 qemu-options.hx       | 19 ++++++------
 10 files changed, 262 insertions(+), 47 deletions(-)

-- 
2.7.4
