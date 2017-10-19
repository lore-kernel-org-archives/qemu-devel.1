Received: from eggs.gnu.org ([2001:4830:134:3::10]:36385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5Ca1-0004ZR-Fb
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1e5CZy-0003xr-88
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:17:53 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:45274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1e5CZx-0003wB-ST
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 11:17:50 -0400
Received: by mail-wm0-x243.google.com with SMTP id q124so16727396wmb.0
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 08:17:49 -0700 (PDT)
Date: Thu, 19 Oct 2017 17:17:45 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171019151745.GH6205@stefanha-x1.localdomain>
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 2/4] vhost-user-blk: introduce a new
 vhost-user-blk host device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On Thu, Oct 19, 2017 at 01:24:08PM +0800, Changpeng Liu wrote:
> This commit introduces a new vhost-user device for block, it uses a
> chardev to connect with the backend, same with Qemu virito-blk device,
> Guest OS still uses the virtio-blk frontend driver.
> 
> To use it, start Qemu with command line like this:
> 
> qemu-system-x86_64 \
>     -chardev socket,id=char0,path=/path/vhost.socket \
>     -device vhost-user-blk-pci,chardev=char0,num_queues=1, \
>             bootindex=2... \
> 
> Users can use different parameters for `num_queues` and `bootindex`.
> 
> Different with exist Qemu virtio-blk host device, it makes more easy
> for users to implement their own I/O processing logic, such as all
> user space I/O stack against hardware block device. It uses the new
> vhost messages(VHOST_USER_GET_CONFIG) to get block virtio config
> information from backend process.
> 
> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  configure                          |  11 ++
>  hw/block/Makefile.objs             |   3 +
>  hw/block/vhost-user-blk.c          | 360 +++++++++++++++++++++++++++++++++++++
>  hw/virtio/virtio-pci.c             |  55 ++++++
>  hw/virtio/virtio-pci.h             |  18 ++
>  include/hw/virtio/vhost-user-blk.h |  40 +++++
>  6 files changed, 487 insertions(+)
>  create mode 100644 hw/block/vhost-user-blk.c
>  create mode 100644 include/hw/virtio/vhost-user-blk.h
> 
> diff --git a/configure b/configure
> index 663e908..f2b348f 100755
> --- a/configure
> +++ b/configure
> @@ -318,6 +318,7 @@ tcg="yes"
>  
>  vhost_net="no"
>  vhost_scsi="no"
> +vhost_user_blk="no"
>  vhost_vsock="no"
>  vhost_user=""
>  kvm="no"
> @@ -782,6 +783,7 @@ Linux)
>    kvm="yes"
>    vhost_net="yes"
>    vhost_scsi="yes"
> +  vhost_user_blk="yes"
>    vhost_vsock="yes"
>    QEMU_INCLUDES="-I\$(SRC_PATH)/linux-headers -I$(pwd)/linux-headers $QEMU_INCLUDES"
>    supported_os="yes"
> @@ -1139,6 +1141,10 @@ for opt do
>    ;;
>    --enable-vhost-scsi) vhost_scsi="yes"
>    ;;
> +  --disable-vhost-user-blk) vhost_user_blk="no"
> +  ;;
> +  --enable-vhost-user-blk) vhost_user_blk="yes"
> +  ;;
>    --disable-vhost-vsock) vhost_vsock="no"
>    ;;
>    --enable-vhost-vsock) vhost_vsock="yes"
> @@ -1511,6 +1517,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    cap-ng          libcap-ng support
>    attr            attr and xattr support
>    vhost-net       vhost-net acceleration support
> +  vhost-user-blk  VM virtio-blk acceleration in user space
>    spice           spice
>    rbd             rados block device (rbd)
>    libiscsi        iscsi support
> @@ -5417,6 +5424,7 @@ echo "posix_madvise     $posix_madvise"
>  echo "libcap-ng support $cap_ng"
>  echo "vhost-net support $vhost_net"
>  echo "vhost-scsi support $vhost_scsi"
> +echo "vhost-user-blk support $vhost_user_blk"
>  echo "vhost-vsock support $vhost_vsock"
>  echo "vhost-user support $vhost_user"
>  echo "Trace backends    $trace_backends"
> @@ -5845,6 +5853,9 @@ fi
>  if test "$vhost_scsi" = "yes" ; then
>    echo "CONFIG_VHOST_SCSI=y" >> $config_host_mak
>  fi
> +if test "$vhost_user_blk" = "yes" -a "$vhost_user" = "yes"; then
> +  echo "CONFIG_VHOST_USER_BLK=y" >> $config_host_mak
> +fi
>  if test "$vhost_net" = "yes" -a "$vhost_user" = "yes"; then
>    echo "CONFIG_VHOST_NET_USED=y" >> $config_host_mak
>  fi
> diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
> index e0ed980..4c19a58 100644
> --- a/hw/block/Makefile.objs
> +++ b/hw/block/Makefile.objs
> @@ -13,3 +13,6 @@ obj-$(CONFIG_SH4) += tc58128.o
>  
>  obj-$(CONFIG_VIRTIO) += virtio-blk.o
>  obj-$(CONFIG_VIRTIO) += dataplane/
> +ifeq ($(CONFIG_VIRTIO),y)
> +obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk.o
> +endif
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> new file mode 100644
> index 0000000..8aa9fa9
> --- /dev/null
> +++ b/hw/block/vhost-user-blk.c
> @@ -0,0 +1,360 @@
> +/*
> + * vhost-user-blk host device
> + *
> + * Copyright IBM, Corp. 2011
> + * Copyright(C) 2017 Intel Corporation.
> + *
> + * Authors:
> + *  Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
> + *  Changpeng Liu <changpeng.liu@intel.com>

This gives the impression that IBM originally authored this code but
little copied code is actually in this file.  Feel free to put your own
copyright and authorship information at the top and then add a statement
like "Based on foo.c, Copyright IBM, Corp. 2011" instead.  That way it's
clear that this is new code that you wrote with reference to the
original file you used as a starting point.

> +static Property vhost_user_blk_properties[] = {
> +    DEFINE_PROP_CHR("chardev", VHostUserBlk, chardev),
> +    DEFINE_PROP_UINT16("num_queues", VHostUserBlk, num_queues, 1),
> +    DEFINE_PROP_UINT32("queue_size", VHostUserBlk, queue_size, 128),
> +    DEFINE_PROP_BIT64("f_size_max", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SIZE_MAX, true),
> +    DEFINE_PROP_BIT64("f_sizemax", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SIZE_MAX, true),
> +    DEFINE_PROP_BIT64("f_segmax", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SEG_MAX, true),
> +    DEFINE_PROP_BIT64("f_geometry", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_GEOMETRY, true),
> +    DEFINE_PROP_BIT64("f_readonly", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_RO, false),
> +    DEFINE_PROP_BIT64("f_blocksize", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_BLK_SIZE, true),
> +    DEFINE_PROP_BIT64("f_topology", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_TOPOLOGY, true),
> +    DEFINE_PROP_BIT64("f_multiqueue", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_MQ, true),
> +    DEFINE_PROP_BIT64("f_flush", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_FLUSH, true),
> +    DEFINE_PROP_BIT64("f_barrier", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_BARRIER, false),
> +    DEFINE_PROP_BIT64("f_scsi", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_SCSI, false),
> +    DEFINE_PROP_BIT64("f_wce", VHostUserBlk, host_features,
> +                      VIRTIO_BLK_F_WCE, false),

Please explain how feature negotation works.  The vhost-user slave
advertises support features in the return value from
VHOST_USER_GET_FEATURES.  How does this additional feature mask work and
why is it useful?
