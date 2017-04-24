Received: from eggs.gnu.org ([2001:4830:134:3::10]:49136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2UzJ-0006mS-Ev
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 23:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1d2UzE-0000e4-JB
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 23:48:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1d2UzE-0000dz-9E
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 23:48:28 -0400
References: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2010f24d-1ad0-4bab-bcd5-5e98fe21578a@redhat.com>
Date: Mon, 24 Apr 2017 11:48:21 +0800
MIME-Version: 1.0
In-Reply-To: <1492670346-18004-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V2 0/6] Add COLO-proxy virtio-net support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, qemu devel <qemu-devel@nongnu.org>
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>



On 2017=E5=B9=B404=E6=9C=8820=E6=97=A5 14:39, Zhang Chen wrote:
> If user use -device virtio-net-pci, virtio-net driver will add a header
> to raw net packet that colo-proxy can't handle it. COLO-proxy just
> focus on the packet payload, so we skip the virtio-net header to compar=
e
> the sent packet that primary guest's to secondary guest's.
>
> Zhang Chen (6):
>    net/filter-mirror.c: Add filter-mirror and filter-redirector vnet
>      support.
>    net/net.c: Add vnet header length to SocketReadState
>    net/colo-compare.c: Make colo-compare support vnet_hdr_len
>    net/socket.c: Add vnet packet support in net_socket_receive()
>    net/colo.c: Add vnet packet parse feature in colo-proxy
>    net/colo-compare.c: Add vnet packet's tcp/udp/icmp compare
>
>   include/net/net.h     |  4 +++-
>   net/colo-compare.c    | 48 +++++++++++++++++++++++++++++++++++++++---=
------
>   net/colo.c            |  9 +++++----
>   net/colo.h            |  4 +++-
>   net/filter-mirror.c   | 25 ++++++++++++++++++++-----
>   net/filter-rewriter.c |  2 +-
>   net/net.c             | 24 ++++++++++++++++++++++--
>   net/socket.c          |  6 ++++++
>   8 files changed, 99 insertions(+), 23 deletions(-)
>

A quick glance at the series and find two issues:

- We can't assume virtio-net is the only user for vnet header, you need=20
query e.g NetClientState for a correct vnet header len.
- This series breaks qtest:

**
ERROR:tests/e1000e-test.c:296:e1000e_send_verify: assertion failed=20
(buffer =3D=3D "TEST"): ("" =3D=3D "TEST")
GTester: last random seed: R02S39dd06f7f52013798111df2e4eb602c5
**
ERROR:tests/e1000e-test.c:365:e1000e_receive_verify: assertion failed=20
(le32_to_cpu(descr.wb.upper.status_error) & esta_dd =3D=3D esta_dd):=20
(0x00000000 =3D=3D 0x00000001)
GTester: last random seed: R02S8c8200b8ec86358cb7addb5c6fe1303c
**
ERROR:tests/e1000e-test.c:296:e1000e_send_verify: assertion failed=20
(buffer =3D=3D "TEST"): ("" =3D=3D "TEST")
GTester: last random seed: R02S9be86025aa7ded4902bdf644c3964a6e
**
ERROR:tests/libqos/virtio.c:94:qvirtio_wait_queue_isr: assertion failed:=20
(g_get_monotonic_time() - start_time <=3D timeout_us)
GTester: last random seed: R02S30cac33d7a98fa56806ca59b35910ea5
**
ERROR:tests/libqos/virtio.c:94:qvirtio_wait_queue_isr: assertion failed:=20
(g_get_monotonic_time() - start_time <=3D timeout_us)
GTester: last random seed: R02S258359836760a723622abf56cf2e61e7
^C/home/devel/git/qemu/tests/Makefile.include:815: recipe for target=20
'check-qtest-x86_64' failed
make: *** [check-qtest-x86_64] Interrupt

Please fix them.

Thanks
