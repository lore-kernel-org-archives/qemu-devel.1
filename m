Received: from eggs.gnu.org ([2001:4830:134:3::10]:42233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fqKU1-0001kZ-8w
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1fqKTv-0001gk-IA
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:46:45 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:43131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1fqKTu-0001fO-6c
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:46:39 -0400
Received: by mail-io0-f194.google.com with SMTP id y10-v6so4233091ioa.10
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:46:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
References: <1534433563-30865-1-git-send-email-yury-kotov@yandex-team.ru>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 16 Aug 2018 17:46:36 +0200
Message-ID: <CAMxuvazEvrsXJ+oXYO_-4BD3P9qK9ZOai6PEH2_in-yxRY0apQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yury Kotov <yury-kotov@yandex-team.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>

Hi

On Thu, Aug 16, 2018 at 5:32 PM, Yury Kotov <yury-kotov@yandex-team.ru> wrote:
> We are using QEMU (2.12.0) with SPDK (18.04.1) over vhost-user to emulate block
> devices. One of our cases it to restart SPDK without restarting VM (in case
> of some updates or smth like it). We tried to use the 'reconnect' option for
> the '-chardev' device:
>   -object memory-backend-file,id=mem0,size=1G,mem-path=/dev/hugepages,share=on \
>   -numa node,memdev=mem0 \
>   -chardev socket,id=spdk_vhost_blk1,path=/var/tmp/vhost.1,reconnect=10 \
>   -device vhost-user-blk-pci,chardev=spdk_vhost_blk1,num-queues=4
>
> After this, vhost-user-blk initialization fails with an error below:
>   qemu-system-x86_64: -device ...: Failed to set msg fds.
>   qemu-system-x86_64: -device ...: vhost-user-blk: vhost initialization failed:
>                                    Operation not permitted
>
> We got the same error with the latest QEMU (c542a9f9794ec8e0bc3f).

Why not setup qemu socket chardev in server mode? This is the only
vhost-user reconnect setup that is supported atm (see
vhost-user-test.c). You avoid having a reconnect loop that way.

>
> We made some investigations and found out that there are several issues:
>
> 1. Reconnect option postpones the first connection till machine init done event.
>    But we need this connection during vhost blk device initialization which
>    happens before the machine init done handling.
>
> 2. If the connection is forced, then the reconnection will be successful
>    after SPDK restart. The problem is that virtual queue will not start.
>    The reason for it is that virtual queue initialization commands
>    should be resent:
>    * VHOST_USER_SET_FEATURES
>    * VHOST_USER_SET_MEM_TABLE
>    * VHOST_USER_SET_VRING_NUM
>    * VHOST_USER_SET_VRING_BASE
>    * VHOST_USER_SET_VRING_ADDR
>    * VHOST_USER_SET_VRING_KICK
>    * VHOST_USER_SET_VRING_CALL
>
> The patch set resolves both of these issues.
>
> Test case:
>
> 1. Start fio process (inside VM):
>      fio --name test --ioengine=libaio --iodepth=64 --bs=4096 \
>          --rw=randrw --direct=1 --sync=1 --verify=md5 \
>          --size=64M --filename=/dev/vda --loops=100
>
> 2. Restart SPDK many times.
>    We are expecting that during SPDK restart fio will pause and fio should
>    continue to work after restart completion.
>
> 3. fio process completed successfully without any error.
>
> Yury Kotov (3):
>   chardev: prevent extra connection attempt in tcp_chr_machine_done_hook
>   vhost: refactor vhost_dev_start and vhost_virtqueue_start
>   vhost-user: add reconnect support for vhost-user
>
>  chardev/char-socket.c     |   5 +-
>  hw/virtio/vhost-user.c    |  65 ++++++++++++--
>  hw/virtio/vhost.c         | 223 +++++++++++++++++++++++++++++++---------------
>  include/hw/virtio/vhost.h |   2 +
>  4 files changed, 215 insertions(+), 80 deletions(-)
>
> --
> 2.7.4
>
