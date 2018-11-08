Received: from eggs.gnu.org ([2001:4830:134:3::10]:34466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKleR-0004xL-Oe
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gKleP-0000jx-M5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 09:51:19 -0500
Date: Thu, 8 Nov 2018 15:50:58 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181108145058.GD6006@linux.fritz.box>
References: <20181105205641.17862-1-v.mayatskih@gmail.com>
	<20181105205641.17862-2-v.mayatskih@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105205641.17862-2-v.mayatskih@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 1/1 V2] Add vhost-pci-blk driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Mayatskikh <v.mayatskih@gmail.com>
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org

Am 05.11.2018 um 21:56 hat Vitaly Mayatskikh geschrieben:
> This driver uses the kernel-mode acceleration for virtio-blk and
> allows to get a near bare metal disk performance inside a VM.
> 
> Signed-off-by: Vitaly Mayatskikh <v.mayatskih@gmail.com>
> ---
>  configure                     |  10 +
>  default-configs/virtio.mak    |   1 +
>  hw/block/Makefile.objs        |   1 +
>  hw/block/vhost-blk.c          | 429 ++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c        |  60 +++++
>  hw/virtio/virtio-pci.h        |  19 ++
>  include/hw/virtio/vhost-blk.h |  43 ++++
>  7 files changed, 563 insertions(+)
>  create mode 100644 hw/block/vhost-blk.c
>  create mode 100644 include/hw/virtio/vhost-blk.h
> 
> diff --git a/configure b/configure
> index 46ae1e8c76..787bc780da 100755
> --- a/configure
> +++ b/configure
> @@ -371,6 +371,7 @@ vhost_crypto="no"
>  vhost_scsi="no"
>  vhost_vsock="no"
>  vhost_user=""
> +vhost_blk=""
>  kvm="no"
>  hax="no"
>  hvf="no"
> @@ -869,6 +870,7 @@ Linux)
>    vhost_crypto="yes"
>    vhost_scsi="yes"
>    vhost_vsock="yes"
> +  vhost_blk="yes"
>    QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
>    supported_os="yes"
>    libudev="yes"
> @@ -1263,6 +1265,10 @@ for opt do
>    ;;
>    --enable-vhost-vsock) vhost_vsock="yes"
>    ;;
> +  --disable-vhost-blk) vhost_blk="no"
> +  ;;
> +  --enable-vhost-blk) vhost_blk="yes"
> +  ;;
>    --disable-opengl) opengl="no"
>    ;;
>    --enable-opengl) opengl="yes"
> @@ -6000,6 +6006,7 @@ echo "vhost-crypto support $vhost_crypto"
>  echo "vhost-scsi support $vhost_scsi"
>  echo "vhost-vsock support $vhost_vsock"
>  echo "vhost-user support $vhost_user"
> +echo "vhost-blk support $vhost_blk"
>  echo "Trace backends    $trace_backends"
>  if have_backend "simple"; then
>  echo "Trace output file $trace_file-<pid>"
> @@ -6461,6 +6468,9 @@ fi
>  if test "$vhost_user" = "yes" ; then
>    echo "CONFIG_VHOST_USER=y" >> $config_host_mak
>  fi
> +if test "$vhost_blk" = "yes" ; then
> +  echo "CONFIG_VHOST_BLK=y" >> $config_host_mak
> +fi
>  if test "$blobs" = "yes" ; then
>    echo "INSTALL_BLOBS=yes" >> $config_host_mak
>  fi
> diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
> index 1304849018..765c0a2a04 100644
> --- a/default-configs/virtio.mak
> +++ b/default-configs/virtio.mak
> @@ -1,5 +1,6 @@
>  CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
>  CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
> +CONFIG_VHOST_BLK=$(CONFIG_LINUX)
>  CONFIG_VIRTIO=y
>  CONFIG_VIRTIO_9P=y
>  CONFIG_VIRTIO_BALLOON=y
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index 53ce5751ae..857ce823fc 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -14,3 +14,4 @@ obj-$(CONFIG_SH4) += tc58128.o
>  obj-$(CONFIG_VIRTIO_BLK) += virtio-blk.o
>  obj-$(CONFIG_VIRTIO_BLK) += dataplane/
>  obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
> +obj-$(CONFIG_VHOST_BLK) += vhost-blk.o
> diff --git a/hw/block/vhost-blk.c b/hw/block/vhost-blk.c
> new file mode 100644
> index 0000000000..4ca8040ee7
> --- /dev/null
> +++ b/hw/block/vhost-blk.c
> @@ -0,0 +1,429 @@
> +/*
> + * vhost-blk host device
> + *
> + * Copyright(C) 2018 IBM Corporation
> + *
> + * Authors:
> + *  Vitaly Mayatskikh <v.mayatskih@gmail.com>
> + *
> + * Largely based on the "vhost-user-blk.c" implemented by:
> + * Changpeng Liu <changpeng.liu@intel.com>

You mean contrib/vhost-user-blk/vhost-user-blk.c in the QEMU tree? That
one has the following license:

 * This work is licensed under the terms of the GNU GPL, version 2 only.
 * See the COPYING file in the top-level directory.

You have this on the other hand:

> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.

I think you need to get rid of any vhost-user-blk.c parts before you can
make it LGPL2+.

Kevin
