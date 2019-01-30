Received: from eggs.gnu.org ([209.51.188.92]:57000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gofkE-0006Xq-VW
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gofkD-0002dI-Uo
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:36:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gofkD-0002dA-N4
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 21:36:53 -0500
References: <20190122083152.10705-1-xieyongji@baidu.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <30a4a533-042e-0f54-1449-ecd7ed26aa1b@redhat.com>
Date: Wed, 30 Jan 2019 10:29:10 +0800
MIME-Version: 1.0
In-Reply-To: <20190122083152.10705-1-xieyongji@baidu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 0/6] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: elohimes@gmail.com, mst@redhat.com, stefanha@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com, maxime.coquelin@redhat.com, yury-kotov@yandex-team.ru, wrfsh@yandex-team.ru
Cc: qemu-devel@nongnu.org, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>


On 2019/1/22 =E4=B8=8B=E5=8D=884:31, elohimes@gmail.com wrote:
> From: Xie Yongji <xieyongji@baidu.com>
>
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
>
> The patch 1 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> and VHOST_USER_SET_INFLIGHT_FD to support support transferring shared
> buffer between qemu and backend.
>
> The patch 2,3 are the corresponding libvhost-user patches of
> patch 1. Make libvhost-user support VHOST_USER_GET_INFLIGHT_FD
> and VHOST_USER_SET_INFLIGHT_FD.
>
> The patch 4 allows vhost-user-blk to use the two new messages
> to get/set inflight buffer from/to backend.
>
> The patch 5 supports vhost-user-blk to reconnect backend when
> connection closed.
>
> The patch 6 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
> to vhost-user-blk backend which is used to tell qemu that
> we support reconnecting now.
>
> This series is based on Daniel P. Berrang=C3=A9's patchset:
>
> https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg03344.html
>
> To use it, we could start qemu with:
>
> qemu-system-x86_64 \
>          -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,reconnect=
=3D1, \
>          -device vhost-user-blk-pci,chardev=3Dchar0 \
>
> and start vhost-user-blk backend with:
>
> vhost-user-blk -b /path/file -s /path/vhost.socket
>
> Then we can restart vhost-user-blk at any time during VM running.
>
> V4 to V5:
> - Drop patch that enables "nowait" option on client sockets
> - Support resubmitting inflight I/O in order
> - Make inflight I/O tracking more robust
> - Remove align field and add queue size field in VhostUserInflight
> - Document more details in vhost-user.txt


I'm still not convinced about this approach. If the maintainer decide to=20
merge, at least two things needs to be added besides the correctness of=20
the code:

- you need prove that this approach can work for packed ring

-=C2=A0 an unit-test to test the crash during logging in-flight descripto=
r.

Thanks


>
> V3 to V4:
> - Drop messages VHOST_USER_GET_SHM_SIZE and VHOST_USER_SET_SHM_FD
> - Introduce two new messages VHOST_USER_GET_INFLIGHT_FD
>    and VHOST_USER_SET_INFLIGHT_FD
> - Allocate inflight buffer in backend rather than in qemu
> - Document a recommended format for inflight buffer
>
> V2 to V3:
> - Using exisiting wait/nowait options to control connection on
>    client sockets instead of introducing "disconnected" option.
> - Support the case that vhost-user backend restart during initialzation
>    of vhost-user-blk device.
>
> V1 to V2:
> - Introduce "disconnected" option for chardev instead of reuse "wait"
>    option
> - Support the case that QEMU starts before vhost-user backend
> - Drop message VHOST_USER_SET_VRING_INFLIGHT
> - Introduce two new messages VHOST_USER_GET_SHM_SIZE
>    and VHOST_USER_SET_SHM_FD
>
> Xie Yongji (6):
>    vhost-user: Support transferring inflight buffer between qemu and
>      backend
>    libvhost-user: Introduce vu_queue_map_desc()
>    libvhost-user: Support tracking inflight I/O in shared memory
>    vhost-user-blk: Add support to get/set inflight buffer
>    vhost-user-blk: Add support to reconnect backend
>    contrib/vhost-user-blk: enable inflight I/O tracking
>
>   Makefile                                |   2 +-
>   contrib/libvhost-user/libvhost-user.c   | 402 ++++++++++++++++++++---=
-
>   contrib/libvhost-user/libvhost-user.h   |  40 +++
>   contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
>   docs/interop/vhost-user.txt             | 101 ++++++
>   hw/block/vhost-user-blk.c               | 227 ++++++++++---
>   hw/virtio/vhost-user.c                  | 110 +++++++
>   hw/virtio/vhost.c                       | 105 +++++++
>   include/hw/virtio/vhost-backend.h       |  10 +
>   include/hw/virtio/vhost-user-blk.h      |   5 +
>   include/hw/virtio/vhost.h               |  19 ++
>   11 files changed, 925 insertions(+), 99 deletions(-)
>
