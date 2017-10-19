Received: from eggs.gnu.org ([2001:4830:134:3::10]:38809)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e594j-0000nc-I9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:33:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e594f-0004aI-Fa
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:33:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e594f-0004ZA-AS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 07:33:17 -0400
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f5ffd96f-8060-2c22-e6f9-49eab8cfe7c7@redhat.com>
Date: Thu, 19 Oct 2017 13:33:07 +0200
MIME-Version: 1.0
In-Reply-To: <1508390650-19115-3-git-send-email-changpeng.liu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org
Cc: stefanha@gmail.com, mst@redhat.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On 19/10/2017 07:24, Changpeng Liu wrote:
>    ;;
>    --enable-vhost-scsi) vhost_scsi=3D"yes"
>    ;;
> +  --disable-vhost-user-blk) vhost_user_blk=3D"no"
> +  ;;
> +  --enable-vhost-user-blk) vhost_user_blk=3D"yes"
> +  ;;
>    --disable-vhost-vsock) vhost_vsock=3D"no"
>    ;;
>    --enable-vhost-vsock) vhost_vsock=3D"yes"
> @@ -1511,6 +1517,7 @@ disabled with --disable-FEATURE, default is enabl=
ed if available:
>    cap-ng          libcap-ng support
>    attr            attr and xattr support
>    vhost-net       vhost-net acceleration support
> +  vhost-user-blk  VM virtio-blk acceleration in user space

Please use default-configs instead of a new configure switch.  See how
CONFIG_VHOST_USER_SCSI is used in default-configs/pci.mak and
default-configs/s390x-softmmu.mak.

>=20
> +static const int user_feature_bits[] =3D {
> +    VIRTIO_BLK_F_SIZE_MAX,
> +    VIRTIO_BLK_F_SEG_MAX,
> +    VIRTIO_BLK_F_GEOMETRY,
> +    VIRTIO_BLK_F_BLK_SIZE,
> +    VIRTIO_BLK_F_TOPOLOGY,
> +    VIRTIO_BLK_F_SCSI,

Please omit VIRTIO_BLK_F_SCSI, it's a legacy option that is not anymore
part of virtio 1.0.

> +    VIRTIO_BLK_F_MQ,
> +    VIRTIO_BLK_F_RO,
> +    VIRTIO_BLK_F_FLUSH,
> +    VIRTIO_BLK_F_BARRIER,

Same for VIRTIO_BLK_F_BARRIER.

> +    VIRTIO_BLK_F_WCE,

And VIRTIO_BLK_F_WCE is the same as VIRTIO_BLK_F_FLUSH, so it can be
removed too.  Please include VIRTIO_BLK_F_CONFIG_WCE instead, since you
are supporting it in vhost_user_blk_set_config.

> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_RING_F_INDIRECT_DESC,
> +    VIRTIO_RING_F_EVENT_IDX,
> +    VIRTIO_F_NOTIFY_ON_EMPTY,
> +    VHOST_INVALID_FEATURE_BIT
> +};

>=20
> +static const TypeInfo vhost_user_blk_info =3D {
> +    .name =3D TYPE_VHOST_USER_BLK,
> +    .parent =3D TYPE_VIRTIO_DEVICE,
> +    .instance_size =3D sizeof(VHostUserBlk),
> +    .instance_init =3D vhost_user_blk_instance_init,
> +    .class_init =3D vhost_user_blk_class_init,
> +};
> +

There is some code duplication, so maybe it's worth introducing a common
superclass like TYPE_VIRTIO_SCSI_COMMON.  I'll let others comment on
whether this is a requirement.

Paolo
