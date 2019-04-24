Received: from eggs.gnu.org ([209.51.188.92]:33946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJILu-0008ST-NI
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:54:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1hJII9-0003aj-Hr
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:50:31 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1hJII9-0003ZE-2n
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 09:50:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id a9so7687872wrp.6
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 06:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190424092028-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190424092028-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 24 Apr 2019 15:50:15 +0200
Message-ID: <CAJ+F1CLPjEwwrXwEYTGE-zsmK4cAn0Dg=dv8h6CnXt537mofCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/11] vhost-user for input & GPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

Hi

On Wed, Apr 24, 2019 at 3:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 23, 2019 at 03:19:53PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > vhost-user allows to drive a virtio device in a seperate
> > process. After vhost-user-net, we have seen
> > vhost-user-{scsi,blk,crypto} added more recently.
> >
> > This series, initially proposed ~3 years ago, time flies
> > (https://lists.gnu.org/archive/html/qemu-devel/2016-06/msg01905.html)
> > contributes with vhost-user-input and vhost-user-gpu.
>
>
> Pls note asan errors reported by patchew.

Those are pre-existing, and I thought we had patches on the list for
them, but I can't find them.

A quick fix could be:

diff --git a/contrib/libvhost-user/libvhost-user.c
b/contrib/libvhost-user/libvhost-user.c
index c9823a1354..944d5c9c4f 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -543,7 +543,7 @@ static bool
 vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;
     dev->nregions =3D memory->nregions;

     DPRINT("Nregions: %d\n", memory->nregions);
@@ -685,7 +685,7 @@ static bool
 vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
     int i;
-    VhostUserMemory *memory =3D &vmsg->payload.memory;
+    VhostUserMemory m =3D vmsg->payload.memory, *memory =3D &m;

     for (i =3D 0; i < dev->nregions; i++) {
         VuDevRegion *r =3D &dev->regions[i];
@@ -814,7 +814,7 @@ vu_set_vring_num_exec(VuDev *dev, VhostUserMsg *vmsg)
 static bool
 vu_set_vring_addr_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    struct vhost_vring_addr *vra =3D &vmsg->payload.addr;
+    struct vhost_vring_addr addr =3D vmsg->payload.addr, *vra =3D &addr;
     unsigned int index =3D vra->index;
     VuVirtq *vq =3D &dev->vq[index];


>
>
> > You may start a vhost-user-gpu with virgl rendering in a separate
> > process like this:
> >
> > $ ./vhost-user-gpu --virgl -s vgpu.sock &
> > $ qemu...
> >   -chardev socket,id=3Dchr,path=3Dvgpu.sock
> >   -device vhost-user-vga,chardev=3Dchr
> >
> > v6:
> >  - do not install vhost-user-input
> >  - install vhost-user-gpu and json file following the spec
> >  - fix the build when drm-intel-devel missing
> >  - rebase (& resend without already applied patches)
> >
> > v5:
> >  - remove user-creatable version of vhost-user-backend
> >  - remove optinal management of sub-process in vhost-user-backend
> >  - removed daemonize/pid code
> >  - drop introduction of new input & gpu messages for PCI config space
> >    handling, instead use VHOST_USER_PROTOCOL_F_CONFIG
> >  - plain mem & udmabuf fallback for 2d rendering
> >  - rebased, kconfig-ify, rst-ify
> >
> > Marc-Andr=C3=A9 Lureau (11):
> >   Add vhost-user-backend
> >   Add vhost-user-input-pci
> >   libvhost-user: add PROTOCOL_F_CONFIG if {set,get}_config
> >   contrib: add vhost-user-input
> >   vhost-user: add vhost_user_gpu_set_socket()
> >   virtio: add virtio-gpu bswap helpers header
> >   util: compile drm.o on Linux
> >   contrib: add vhost-user-gpu
> >   virtio-gpu: split virtio-gpu, introduce virtio-gpu-base
> >   virtio-gpu: split virtio-gpu-pci & virtio-vga
> >   hw/display: add vhost-user-vga & gpu-pci
> >
> >  contrib/libvhost-user/libvhost-user.h      |    1 +
> >  contrib/vhost-user-gpu/drm.h               |   72 ++
> >  contrib/vhost-user-gpu/virgl.h             |   25 +
> >  contrib/vhost-user-gpu/vugpu.h             |  170 +++
> >  hw/display/virtio-vga.h                    |   32 +
> >  include/hw/virtio/vhost-backend.h          |    2 +
> >  include/hw/virtio/virtio-gpu-bswap.h       |   61 +
> >  include/hw/virtio/virtio-gpu-pci.h         |   40 +
> >  include/hw/virtio/virtio-gpu.h             |   92 +-
> >  include/hw/virtio/virtio-input.h           |   14 +
> >  include/sysemu/vhost-user-backend.h        |   57 +
> >  backends/vhost-user.c                      |  209 ++++
> >  contrib/libvhost-user/libvhost-user.c      |    5 +
> >  contrib/vhost-user-gpu/drm.c               |  341 ++++++
> >  contrib/vhost-user-gpu/main.c              | 1236 ++++++++++++++++++++
> >  contrib/vhost-user-gpu/virgl.c             |  579 +++++++++
> >  contrib/vhost-user-input/main.c            |  427 +++++++
> >  hw/display/vhost-user-gpu-pci.c            |   51 +
> >  hw/display/vhost-user-gpu.c                |  572 +++++++++
> >  hw/display/vhost-user-vga.c                |   52 +
> >  hw/display/virtio-gpu-3d.c                 |   49 +-
> >  hw/display/virtio-gpu-base.c               |  268 +++++
> >  hw/display/virtio-gpu-pci.c                |   55 +-
> >  hw/display/virtio-gpu.c                    |  415 ++-----
> >  hw/display/virtio-vga.c                    |  138 +--
> >  hw/input/vhost-user-input.c                |  129 ++
> >  hw/virtio/vhost-user-input-pci.c           |   53 +
> >  hw/virtio/vhost-user.c                     |   11 +
> >  vl.c                                       |    1 +
> >  MAINTAINERS                                |   14 +-
> >  Makefile                                   |   27 +-
> >  Makefile.objs                              |    2 +
> >  backends/Makefile.objs                     |    2 +
> >  configure                                  |   29 +
> >  contrib/vhost-user-gpu/50-qemu-gpu.json.in |    5 +
> >  contrib/vhost-user-gpu/Makefile.objs       |   10 +
> >  contrib/vhost-user-input/Makefile.objs     |    1 +
> >  docs/interop/index.rst                     |    2 +-
> >  docs/interop/vhost-user-gpu.rst            |  238 ++++
> >  docs/interop/vhost-user.txt                |    9 +
> >  hw/display/Kconfig                         |   10 +
> >  hw/display/Makefile.objs                   |    5 +-
> >  hw/input/Kconfig                           |    5 +
> >  hw/input/Makefile.objs                     |    1 +
> >  hw/virtio/Makefile.objs                    |    1 +
> >  rules.mak                                  |    9 +-
> >  util/Makefile.objs                         |    2 +-
> >  47 files changed, 5070 insertions(+), 459 deletions(-)
> >  create mode 100644 contrib/vhost-user-gpu/drm.h
> >  create mode 100644 contrib/vhost-user-gpu/virgl.h
> >  create mode 100644 contrib/vhost-user-gpu/vugpu.h
> >  create mode 100644 hw/display/virtio-vga.h
> >  create mode 100644 include/hw/virtio/virtio-gpu-bswap.h
> >  create mode 100644 include/hw/virtio/virtio-gpu-pci.h
> >  create mode 100644 include/sysemu/vhost-user-backend.h
> >  create mode 100644 backends/vhost-user.c
> >  create mode 100644 contrib/vhost-user-gpu/drm.c
> >  create mode 100644 contrib/vhost-user-gpu/main.c
> >  create mode 100644 contrib/vhost-user-gpu/virgl.c
> >  create mode 100644 contrib/vhost-user-input/main.c
> >  create mode 100644 hw/display/vhost-user-gpu-pci.c
> >  create mode 100644 hw/display/vhost-user-gpu.c
> >  create mode 100644 hw/display/vhost-user-vga.c
> >  create mode 100644 hw/display/virtio-gpu-base.c
> >  create mode 100644 hw/input/vhost-user-input.c
> >  create mode 100644 hw/virtio/vhost-user-input-pci.c
> >  create mode 100644 contrib/vhost-user-gpu/50-qemu-gpu.json.in
> >  create mode 100644 contrib/vhost-user-gpu/Makefile.objs
> >  create mode 100644 contrib/vhost-user-input/Makefile.objs
> >  create mode 100644 docs/interop/vhost-user-gpu.rst
> >
> > --
> > 2.21.0.313.ge35b8cb8e2
>


--=20
Marc-Andr=C3=A9 Lureau
