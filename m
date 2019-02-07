Received: from eggs.gnu.org ([209.51.188.92]:43904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grmyV-0004e3-RA
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1grmyS-0003aJ-8o
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:30 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1grmyO-0003R2-Aj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 11:56:24 -0500
Received: by mail-qt1-f194.google.com with SMTP id r9so647637qtt.3
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 08:56:18 -0800 (PST)
MIME-Version: 1.0
References: <20190207165352.5439-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190207165352.5439-1-marcandre.lureau@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 7 Feb 2019 17:56:07 +0100
Message-ID: <CAMxuvaxMgLht906s+gruq9U_8gKKdtdhKS_LhsgHZt5z5ujfcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v2 00/12] vhost-user-backend &
 vhost-user-input
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Feb 7, 2019 at 5:53 PM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> This series is based on previously discussed "[PATCH v4 00/29]
> vhost-user for input & GPU" and "vhost-user: define conventions for
> vhost-user backends" work. The GPU part is left off for now.
>
> This series introduces a "vhost-user-backend": a convenience object
> for vhost-user devices, for common command line and initilization
> handling. As a simple showcase, a "vhost-user-input-pci" device is
> introduced, which can be used with the "contrib: add vhost-user-input"
> example. vhost-user-input isn't meant to be installed, discovered or
> used by libvirt: no installation is done (no vhost-user JSON file is
> provided either).
>
> thanks
>
> v2:
> - rebased (VhostUserInputPCI got most of the changes, due to split)
> - added "RFC: add explicit can_migrate to
>   vhost_user_backend_dev_init()" to attempt to address Michael
>   concerns about migration.

Oops git-publish :) resent with --subject-prefix=3DPATCH.

>
> Marc-Andr=C3=A9 Lureau (12):
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
>   RFC: add explicit can_migrate to vhost_user_backend_dev_init()
>
>  contrib/libvhost-user/libvhost-user-glib.h |   3 +
>  contrib/libvhost-user/libvhost-user.h      |  15 +
>  include/hw/virtio/vhost-backend.h          |   4 +
>  include/hw/virtio/vhost-user-blk.h         |   2 +-
>  include/hw/virtio/vhost-user-scsi.h        |   2 +-
>  include/hw/virtio/vhost-user.h             |   2 +-
>  include/hw/virtio/virtio-input.h           |  14 +
>  include/sysemu/vhost-user-backend.h        |  60 ++++
>  backends/cryptodev-vhost-user.c            |  18 +-
>  backends/vhost-user.c                      | 249 +++++++++++++
>  contrib/libvhost-user/libvhost-user-glib.c |  11 +-
>  contrib/libvhost-user/libvhost-user.c      |  19 +-
>  contrib/vhost-user-input/main.c            | 398 +++++++++++++++++++++
>  hw/block/vhost-user-blk.c                  |  22 +-
>  hw/input/vhost-user-input.c                | 110 ++++++
>  hw/scsi/vhost-user-scsi.c                  |  20 +-
>  hw/virtio/vhost-stub.c                     |   4 +-
>  hw/virtio/vhost-user-input-pci.c           |  53 +++
>  hw/virtio/vhost-user.c                     | 118 +++++-
>  net/vhost-user.c                           |  13 +-
>  vl.c                                       |   3 +-
>  MAINTAINERS                                |   5 +
>  Makefile                                   |   3 +
>  Makefile.objs                              |   1 +
>  backends/Makefile.objs                     |   3 +-
>  configure                                  |   3 +
>  contrib/vhost-user-input/Makefile.objs     |   1 +
>  default-configs/virtio.mak                 |   1 +
>  docs/interop/vhost-user.json               | 219 ++++++++++++
>  docs/interop/vhost-user.txt                | 109 +++++-
>  hw/input/Makefile.objs                     |   1 +
>  hw/virtio/Makefile.objs                    |   1 +
>  qemu-options.hx                            |  20 ++
>  33 files changed, 1420 insertions(+), 87 deletions(-)
>  create mode 100644 include/sysemu/vhost-user-backend.h
>  create mode 100644 backends/vhost-user.c
>  create mode 100644 contrib/vhost-user-input/main.c
>  create mode 100644 hw/input/vhost-user-input.c
>  create mode 100644 hw/virtio/vhost-user-input-pci.c
>  create mode 100644 contrib/vhost-user-input/Makefile.objs
>  create mode 100644 docs/interop/vhost-user.json
>
> --
> 2.20.1.519.g8feddda32c
>
