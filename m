Received: from eggs.gnu.org ([2001:4830:134:3::10]:53233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eX3N9-0003DE-Rc
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:07:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eX3N7-0004Tp-2r
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:07:43 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40157)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eX3N6-0004Su-Py
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 06:07:40 -0500
Received: by mail-wr0-x242.google.com with SMTP id p17so1130778wre.7
	for <qemu-devel@nongnu.org>; Thu, 04 Jan 2018 03:07:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515030814-4621-1-git-send-email-changpeng.liu@intel.com>
References: <1515030814-4621-1-git-send-email-changpeng.liu@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 4 Jan 2018 12:07:39 +0100
Message-ID: <CAJ+F1CLgVdZ62TwuTame-=oASSUR0fhgssLPuC5yZhtD9UiNiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10 0/4] Introduce a new vhost-user-blk
 host device to QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: QEMU <qemu-devel@nongnu.org>, james.r.harris@intel.com, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Felipe Franciosi <felipe@nutanix.com>

Hi

On Thu, Jan 4, 2018 at 2:53 AM, Changpeng Liu <changpeng.liu@intel.com> wro=
te:
> Although virtio scsi specification was designed as a replacement for virt=
io_blk,
> there are still many users using virtio_blk. QEMU 2.9 introduced a new de=
vice
> vhost user scsi which can process I/O in user space for virtio_scsi, this=
 commit
> introduces a new vhost user block host device, which can support virtio_b=
lk in
> Guest OS, and I/O processing in another I/O target.
>
> Due to the limitation for virtio_blk specification, virtio_blk device can=
not get
> block information such as capacity, block size etc via the specification,=
 several
> new vhost user messages were added to deliver virtio config space
> information between Qemu and I/O target, VHOST_USER_GET_CONFIG/VHOST_USER=
_SET_CONFIG
> messages used for get/set config space from/to I/O target, VHOST_USER_SLA=
VE_CONFIG_CHANGE_MSG
> slave message was added for the event notifier in case the change of virt=
io config space. Also,
> those messages can be used for vhost device live migration as well.
>
> CHANGES:
> v10: fix the code style error.
> v8-v9: Several small optimization and code cleanup according to the comme=
nts.
> v7-v8: Instead using an event file descriptor for event notifier in case =
of virtio
> configuration space changed, while here used a new vhost-user slave messa=
ge to deliver
> such event. Several small optimizations to address the comments from v7.
> v6-v7: change the parameter of set configuration function let it only con=
tain valid data buffer.
> v5-v6: add header flags for vhost-user master so that the slave can know =
the purpose for
> set config, also vhost-user get/set messages' payload doesn't contain inv=
alid data buffers.
> v4-v5: add header offset and size for virtio config space.
> v3-v4: refactoring the vhost user block example patch based on new libvho=
st-user library.
> v2-v3: add new vhost user message to get/set virtio config space.
>
> Changpeng Liu (4):
>   vhost-user: add new vhost user messages to support virtio config space
>   vhost-user-blk: introduce a new vhost-user-blk host device
>   contrib/libvhost-user: enable virtio config space messages
>   contrib/vhost-user-blk: introduce a vhost-user-blk sample application

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Michael, do you take it?
thanks

>
>  .gitignore                              |   1 +
>  Makefile                                |   3 +
>  Makefile.objs                           |   1 +
>  contrib/libvhost-user/libvhost-user.c   |  42 +++
>  contrib/libvhost-user/libvhost-user.h   |  33 ++
>  contrib/vhost-user-blk/Makefile.objs    |   1 +
>  contrib/vhost-user-blk/vhost-user-blk.c | 545 ++++++++++++++++++++++++++=
++++++
>  default-configs/pci.mak                 |   1 +
>  docs/interop/vhost-user.txt             |  55 ++++
>  hw/block/Makefile.objs                  |   3 +
>  hw/block/vhost-user-blk.c               | 359 +++++++++++++++++++++
>  hw/virtio/vhost-user.c                  | 118 +++++++
>  hw/virtio/vhost.c                       |  32 ++
>  hw/virtio/virtio-pci.c                  |  55 ++++
>  hw/virtio/virtio-pci.h                  |  18 ++
>  include/hw/virtio/vhost-backend.h       |  12 +
>  include/hw/virtio/vhost-user-blk.h      |  41 +++
>  include/hw/virtio/vhost.h               |  15 +
>  18 files changed, 1335 insertions(+)
>  create mode 100644 contrib/vhost-user-blk/Makefile.objs
>  create mode 100644 contrib/vhost-user-blk/vhost-user-blk.c
>  create mode 100644 hw/block/vhost-user-blk.c
>  create mode 100644 include/hw/virtio/vhost-user-blk.h
>
> --
> 1.9.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
