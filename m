Received: from eggs.gnu.org ([2001:4830:134:3::10]:51081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwgHY-0004wU-Fd
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:16:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fwgHT-0002pp-MR
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:16:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43654 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1fwgHT-0002pf-GC
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 00:16:03 -0400
References: <20180830142708.14311-1-sameeh@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <521030a0-a6cd-2fc7-5264-62b493a010dd@redhat.com>
Date: Mon, 3 Sep 2018 12:15:58 +0800
MIME-Version: 1.0
In-Reply-To: <20180830142708.14311-1-sameeh@daynix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/6] Virtio-net: Support RSS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org
Cc: Yan Vugenfirer <yan@daynix.com>



On 2018=E5=B9=B408=E6=9C=8830=E6=97=A5 22:27, Sameeh Jubran wrote:
> From: Sameeh Jubran <sjubran@redhat.com>
>
> This series implements the Steering Mode feature which was introduced o=
n the
> virtio-dev list a while ago, which can be found here:
> * https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html
>
> The first three patches add some infrastructure support that is used in
> the following three patches.
>
> The ebpf filter doesn't fully work yet as I'm having an issue with the
> verifier which needs to be fixed.

What issues did you meet? You can attach a trace buffer and get verbose=20
debug information from that. Btw, dpdk use cls bpf and we use socket filt=
er.

>
> The patches still need some love as not all of the cases have been hand=
led
> yet most of the functionality has been implemented.

One question is how indirection table is implemented, I thought it=20
should be a map but looks not. Please see comment on patch 6.

Thanks

>
> Please share your thoughts and comments so I'll move forward with
> sending v1 along with a fully functioning ebpf code.
>
> Sameeh Jubran (6):
>    Add bpf support to qemu
>    tap: Add support for bpf ioctls
>    vhost-net: Expose vhost_net_get_fd
>    virtio-net: implement steering mode feature
>    virtio-net: steering mode: Implement rss support
>    virtio-net: rss: Add bpf filter
>
>   MAINTAINERS                                 |    5 +
>   configure                                   |   44 +
>   hw/net/rss_bpf_insns.h                      | 3992 ++++++++++++++++++=
+++++++++
>   hw/net/rss_tap_bpf.h                        |   37 +
>   hw/net/rss_tap_bpf_program.c                |  172 ++
>   hw/net/vhost_net.c                          |    2 +-
>   hw/net/virtio-net.c                         |  250 +-
>   include/hw/virtio/virtio-net.h              |    5 +
>   include/net/net.h                           |    3 +-
>   include/standard-headers/linux/virtio_net.h |   55 +
>   net/tap-bsd.c                               |    5 +
>   net/tap-linux.c                             |   29 +-
>   net/tap-linux.h                             |    3 +-
>   net/tap-solaris.c                           |    5 +
>   net/tap-stub.c                              |    5 +
>   net/tap.c                                   |    8 +
>   net/tap_int.h                               |    1 +
>   qapi/net.json                               |   11 +
>   scripts/update-linux-headers.sh             |    8 +-
>   19 files changed, 4627 insertions(+), 13 deletions(-)
>   create mode 100644 hw/net/rss_bpf_insns.h
>   create mode 100644 hw/net/rss_tap_bpf.h
>   create mode 100644 hw/net/rss_tap_bpf_program.c
>
