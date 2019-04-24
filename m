Received: from eggs.gnu.org ([209.51.188.92]:60247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hJGQs-0006dJ-0w
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:51:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1hJGQq-000639-2S
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:51:21 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:39268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hJGQp-00061F-Tm
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 07:51:19 -0400
Received: by mail-qk1-x743.google.com with SMTP id f125so5765595qke.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 04:51:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190320112646.3712-1-xieyongji@baidu.com>
In-Reply-To: <20190320112646.3712-1-xieyongji@baidu.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 24 Apr 2019 19:51:04 +0800
Message-ID: <CAONzpcbxZGcacO5+OSv7r1FxBEAQe+Bso7cFRN3puFeLwtiKgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v8 0/7] vhost-user-blk: Add support for
 backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, kwolf@redhat.com, mreitz@redhat.com, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, changpeng.liu@intel.com
Cc: qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

Ping...

On Wed, 20 Mar 2019 at 19:27, <elohimes@gmail.com> wrote:
>
> From: Xie Yongji <xieyongji@baidu.com>
>
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
>
> The patch 1,2,3 introduce started flag to VirtioDevice to
> fix possible guest hung after migration for virtio 1.0
> transitional devices.
>
> The patch 4,5,6 support vhost-user-blk to reconnect backend
> when connection closed.
>
> The patch 7 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
> to vhost-user-blk backend which is used to tell qemu that
> we support reconnecting now.
>
> To use it, we could start qemu with:
>
> qemu-system-x86_64 \
>         -chardev socket,id=char0,path=/path/vhost.socket,reconnect=1, \
>         -device vhost-user-blk-pci,chardev=char0 \
>
> and start vhost-user-blk backend with:
>
> vhost-user-blk -b /path/file -s /path/vhost.socket
>
> Then we can restart vhost-user-blk at any time during VM running.
>
> v8:
> - Remove merged vhost-user part
> - Introduce started flag to VirtioDevice to fix some bugs
> - Rework reconnect logic in vhost_user_blk_device_realize()
>
> v7:
> - Introduce a 64-bit counter to struct DescStateSplit/DescStatePacked
>   to preserve the order of fetching available descriptors
> - Add support to resubmit inflight I/O in order in libvhost-user.c
> - Rename process_head to last_batch_head in struct DescStateSplit
>
> v6:
> - Document the layout in inflight buffer for packed virtqueue
> - Rework the layout in inflight buffer for split virtqueue
> - Remove version field in VhostUserInflight
> - Add a patch to remove some redundant check in
>   contrib/libvhost-user.c
> - Document more details in vhost-user.txt
>
> v5:
> - Drop patch that enables "nowait" option on client sockets
> - Support resubmitting inflight I/O in order
> - Make inflight I/O tracking more robust
> - Remove align field and add queue size field in VhostUserInflight
> - Document more details in vhost-user.txt
>
> v4:
> - Drop messages VHOST_USER_GET_SHM_SIZE and VHOST_USER_SET_SHM_FD
> - Introduce two new messages VHOST_USER_GET_INFLIGHT_FD
>   and VHOST_USER_SET_INFLIGHT_FD
> - Allocate inflight buffer in backend rather than in qemu
> - Document a recommended format for inflight buffer
>
> v3:
> - Using exisiting wait/nowait options to control connection on
>   client sockets instead of introducing "disconnected" option.
> - Support the case that vhost-user backend restart during initialzation
>   of vhost-user-blk device.
>
> v2:
> - Introduce "disconnected" option for chardev instead of reuse "wait"
>   option
> - Support the case that QEMU starts before vhost-user backend
> - Drop message VHOST_USER_SET_VRING_INFLIGHT
> - Introduce two new messages VHOST_USER_GET_SHM_SIZE
>   and VHOST_USER_SET_SHM_FD
>
> Xie Yongji (7):
>   virtio: Introduce started flag to VirtioDevice
>   virtio: Use started flag in virtio_vmstate_change()
>   vhost-user-blk: Use started flag in vhost_user_blk_set_status()
>   vhost-user-blk: Only start vhost-user backend with the first kick
>   vhost-user-blk: Add return value for vhost_user_blk_start()
>   vhost-user-blk: Add support to reconnect backend
>   contrib/vhost-user-blk: enable inflight I/O tracking
>
>  contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
>  hw/block/vhost-user-blk.c               | 175 +++++++++++++++++++-----
>  hw/virtio/virtio.c                      |  54 +++++++-
>  include/hw/virtio/vhost-user-blk.h      |   3 +
>  include/hw/virtio/virtio.h              |   2 +
>  5 files changed, 202 insertions(+), 35 deletions(-)
>
> --
> 2.17.1
>
