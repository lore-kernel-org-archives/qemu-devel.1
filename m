Received: from eggs.gnu.org ([2001:4830:134:3::10]:49032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrkd-0000YG-0c
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:58:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dVrkZ-0002Bw-UY
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:58:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dVrkZ-0002BY-Lf
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 23:58:43 -0400
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63e7bb8f-73b9-231e-fe49-c7805711622f@redhat.com>
Date: Fri, 14 Jul 2017 11:58:38 +0800
MIME-Version: 1.0
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V7 00/12] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B407=E6=9C=8804=E6=97=A5 14:53, Zhang Chen wrote:
> If user use -device virtio-net-pci, virtio-net driver will add a header
> to raw net packet that colo-proxy can't handle it. COLO-proxy just
> focus on the packet payload, so we skip the virtio-net header to compar=
e
> the sent packet that primary guest's to secondary guest's.
>
> V7:
>   - p1: No change.
>   - p2: Fix typo.
>         Move old patch 04/10 to 02/10.
>         Introduce a parameter for net_socket_rs_init().
>   - p3: Address comments split from origin 02/10.
>         Rebase code.
>   - p4: Remove some comments.
>         Fix typo.
>         Remove direction related codes, just get vnet_hdr_len
>         from nf->netdev->vnet_hdr_len.
>   - p5: Remove some comments.
>         Fix typo.
>   - p6: Origin 05/10.
>   - p7: Address comments split from origin 06/10.
>   - p8: Origin 06/10.
>   - p9: Fix typo. origin 07/10.
>   - p10: Origin 08/10.
>   - p11: Remove some comments.
>          Remove direction related codes, just get vnet_hdr_len
>          from nf->netdev->vnet_hdr_len.
>   - p12: Origin 10/10.
>
> V6:
>   - p1: Remove the using_vnet_hdr, I will send a independent
>         patchset about it.
>   - p2: Change option input way from vnet_hdr=3Don/off to vnet_hdr_supp=
ort.
>         Use nf->direction to decide check nf->netdev->vnet_hdr_len or n=
f->netdev->peer->vnet_hdr_len.
>   - p3: Change option input way from vnet_hdr=3Don/off to vnet_hdr_supp=
ort.
>   - p4: No change.
>   - p5: No change.
>   - p6: Change option input way from vnet_hdr=3Don/off to vnet_hdr_supp=
ort.
>         Fix commit log.
>   - p7: No change.
>   - p8: No change.
>   - p9: Change option input way from vnet_hdr=3Don/off to vnet_hdr_supp=
ort.
>         Use nf->direction to decide check nf->netdev->vnet_hdr_len or n=
f->netdev->peer->vnet_hdr_len.
>   - p10: New patch to add new example for the case needs vnet hdr.
>
> V5:
>   - patch1: No change.
>   - patch2: Keep the long line in qemu-option.hx.
>             Squash patch2 into old patch3.
>             Add more comments.
>             Fix the return value.
>   - patch3: Add more comments in commit log.
>   - patch4: Add Suggested-by tag.
>             Fix commit log.
>             Move vnet_hdr to SocketReadState.
>   - patch5: No change.
>   - patch6: Squash old patch6 into this patch.
>   - patch7: No change.
>   - patch8: Remove the offset_all.
>   - patch9: Squash old patch11 and the patch12.
>
>
> V4:
>   - Add vnet_hdr option for filter-mirror, filter-redirector,
>     filter-rewriter,colo-compare.
>   - Use new design to impliment virtio-net support for colo-proxy.
>   - Fix codestyle.
>   - Remove unused option for filter-rewriter.
>   - Add filter-rewriter virtio-net support.
>   - Address other comments.
>
>
> Zhang Chen (12):
>    net: Add vnet_hdr_len arguments in NetClientState
>    net/net.c: Add vnet_hdr support in SocketReadState
>    net/filter-mirror.c: Introduce parameter for filter_send()
>    net/filter-mirror.c: Make filter mirror support vnet support.
>    net/filter-mirror.c: Add new option to enable vnet support for
>      filter-redirector
>    net/colo.c: Make vnet_hdr_len as packet property
>    net/colo-compare.c: Introduce parameter for compare_chr_send()
>    net/colo-compare.c: Make colo-compare support vnet_hdr_len
>    net/colo.c: Add vnet packet parse feature in colo-proxy
>    net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
>    net/filter-rewriter.c: Make filter-rewriter support vnet_hdr_len
>    docs/colo-proxy.txt: Update colo-proxy usage of net driver with
>      vnet_header
>
>   docs/colo-proxy.txt   | 26 ++++++++++++++++
>   include/net/net.h     | 10 ++++--
>   net/colo-compare.c    | 84 ++++++++++++++++++++++++++++++++++++++++++=
---------
>   net/colo.c            |  9 +++---
>   net/colo.h            |  4 ++-
>   net/filter-mirror.c   | 75 +++++++++++++++++++++++++++++++++++++++++-=
---
>   net/filter-rewriter.c | 37 ++++++++++++++++++++++-
>   net/net.c             | 37 ++++++++++++++++++++---
>   net/socket.c          |  8 ++---
>   qemu-options.hx       | 19 ++++++------
>   10 files changed, 262 insertions(+), 47 deletions(-)
>

Applied, thanks.
