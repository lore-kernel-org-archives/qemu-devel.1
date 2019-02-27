Received: from eggs.gnu.org ([209.51.188.92]:58828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gywjY-0006pL-VW
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gywjU-0002tV-EX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:46:40 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38796)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gywjM-0002oQ-EE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:46:28 -0500
Received: by mail-wr1-x441.google.com with SMTP id g12so5289091wrm.5
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 02:46:27 -0800 (PST)
MIME-Version: 1.0
References: <20190227103017.29515-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190227103017.29515-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 27 Feb 2019 11:46:13 +0100
Message-ID: <CAJ+F1CKPnDwBOesuQTKC8nhf+7qKBtFr95gk0cJj-SbtzcAoOQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 00/12] vhost-user-backend &
 vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Hi,

On Wed, Feb 27, 2019 at 11:38 AM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> This series is based on previously discussed "[PATCH v4 00/29]
> vhost-user for input & GPU" and "vhost-user: define conventions for
> vhost-user backends" work. The GPU part is left off for now.
>
> This series introduces a "vhost-user-backend": an helper object to be
> used by vhost-user devices to ease with backend initialization and
> handling. As a simple showcase, a "vhost-user-input-pci" device is
> introduced, which can be used with the "contrib: add vhost-user-input"
> example. vhost-user-input isn't meant to be installed, discovered or
> used by libvirt: no installation is done (no vhost-user JSON file is
> provided either).
>
> thanks
>
> v4:
> - drop "RFC: add explicit can_migrate to vhost_user_backend_dev_init()"
> - remove useless "cmd" struct field leftover

I suggest to apply this series through the virtio & vhost-user tree,
which Michael maintains.

The upcoming vhost-user-gpu series should more naturally fall under
Gerd responsability.

>
> v3:
> - add previously sent patch "libvhost-user: fix clang enum-conversion
>   warning" to fix clang build
> - "define conventions for vhost-user backends" updates after Eric review
> - Drop user-creatable from vhost-user-backend
> - Make vhost-user-input-pci take a chardev=3D (instead of vhost-user=3D)
>
> v2:
> - rebased (VhostUserInputPCI got most of the changes, due to split)
> - added "RFC: add explicit can_migrate to
>   vhost_user_backend_dev_init()" to attempt to address Michael
>   concerns about migration.
>
> Marc-Andr=C3=A9 Lureau (12):
>   libvhost-user: fix clang enum-conversion warning
>   vhost-user: define conventions for vhost-user backends
>   vhost-user: simplify vhost_user_init/vhost_user_cleanup
>   libvhost-user: exit by default on VHOST_USER_NONE
>   vhost-user: wrap some read/write with retry handling
>   Add vhost-user-backend
>   vhost-user: split vhost_user_read()
>   vhost-user: add vhost_user_input_get_config()
>   libvhost-user-glib: export vug_source_new()
>   libvhost-user: add vu_queue_unpop()
>   Add vhost-user-input-pci
>   contrib: add vhost-user-input
>
>  contrib/libvhost-user/libvhost-user-glib.h |   3 +
>  contrib/libvhost-user/libvhost-user.h      |  17 +-
>  include/hw/virtio/vhost-backend.h          |   4 +
>  include/hw/virtio/vhost-user-blk.h         |   2 +-
>  include/hw/virtio/vhost-user-scsi.h        |   2 +-
>  include/hw/virtio/vhost-user.h             |   2 +-
>  include/hw/virtio/virtio-input.h           |  14 +
>  include/sysemu/vhost-user-backend.h        |  58 +++
>  backends/cryptodev-vhost-user.c            |  18 +-
>  backends/vhost-user.c                      | 213 +++++++++++
>  contrib/libvhost-user/libvhost-user-glib.c |  11 +-
>  contrib/libvhost-user/libvhost-user.c      |  19 +-
>  contrib/vhost-user-input/main.c            | 398 +++++++++++++++++++++
>  hw/block/vhost-user-blk.c                  |  22 +-
>  hw/input/vhost-user-input.c                |  99 +++++
>  hw/scsi/vhost-user-scsi.c                  |  20 +-
>  hw/virtio/vhost-stub.c                     |   4 +-
>  hw/virtio/vhost-user-input-pci.c           |  53 +++
>  hw/virtio/vhost-user.c                     | 118 +++++-
>  net/vhost-user.c                           |  13 +-
>  MAINTAINERS                                |   5 +
>  Makefile                                   |   3 +
>  Makefile.objs                              |   1 +
>  backends/Makefile.objs                     |   3 +-
>  configure                                  |   3 +
>  contrib/vhost-user-input/Makefile.objs     |   1 +
>  default-configs/virtio.mak                 |   1 +
>  docs/interop/vhost-user.json               | 232 ++++++++++++
>  docs/interop/vhost-user.txt                | 109 +++++-
>  hw/input/Makefile.objs                     |   1 +
>  hw/virtio/Makefile.objs                    |   1 +
>  31 files changed, 1363 insertions(+), 87 deletions(-)
>  create mode 100644 include/sysemu/vhost-user-backend.h
>  create mode 100644 backends/vhost-user.c
>  create mode 100644 contrib/vhost-user-input/main.c
>  create mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input-pci.c
>  create mode 100644 contrib/vhost-user-input/Makefile.objs
>  create mode 100644 docs/interop/vhost-user.json
>
> --
> 2.21.0
>
>


--=20
Marc-Andr=C3=A9 Lureau
