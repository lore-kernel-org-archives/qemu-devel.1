Received: from eggs.gnu.org ([2001:4830:134:3::10]:33467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1LtC-0007rp-BX
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 20:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1Lt9-0007Cu-8o
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 20:58:02 -0400
Received: from mga06.intel.com ([134.134.136.31]:49460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1f1Lt8-0007Cb-Sj
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 20:57:59 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Thu, 29 Mar 2018 00:57:13 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B6255AE@SHSMSX103.ccr.corp.intel.com>
References: <20180328192800.7138-1-maxime.coquelin@redhat.com>
	<20180328192800.7138-3-maxime.coquelin@redhat.com>
In-Reply-To: <20180328192800.7138-3-maxime.coquelin@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/2] vhost-user: back SET/GET_CONFIG
 requests with a protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>



> -----Original Message-----
> From: Maxime Coquelin [mailto:maxime.coquelin@redhat.com]
> Sent: Thursday, March 29, 2018 3:28 AM
> To: mst@redhat.com; Liu, Changpeng <changpeng.liu@intel.com>;
> marcandre.lureau@redhat.com; qemu-devel@nongnu.org
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Subject: [PATCH v2 2/2] vhost-user: back SET/GET_CONFIG requests with a
> protocol feature
>=20
> Without a dedicated protocol feature, QEMU cannot know whether
> the backend can handle VHOST_USER_SET_CONFIG and
> VHOST_USER_GET_CONFIG messages.
>=20
> This patch adds a protocol feature that is only advertised by
> QEMU if the device implements the config ops. Vhost user init
> fails if the device support the feature but the backend doesn't.
>=20
> The backend should only send VHOST_USER_SLAVE_CONFIG_CHANGE_MSG
> requests if the protocol feature has been negotiated.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Passed our own vhost-user-blk target with the patch, I can submit a fix to =
QEMU vhost-user-blk example
after this commit.

Tested-by: Changpeng Liu <changpeng.liu@intel.com>
> ---
>  docs/interop/vhost-user.txt | 21 ++++++++++++---------
>  hw/virtio/vhost-user.c      | 22 ++++++++++++++++++++++
>  2 files changed, 34 insertions(+), 9 deletions(-)
>=20
> diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> index c058c407df..534caab18a 100644
> --- a/docs/interop/vhost-user.txt
> +++ b/docs/interop/vhost-user.txt
> @@ -379,6 +379,7 @@ Protocol features
>  #define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
>  #define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION 7
>  #define VHOST_USER_PROTOCOL_F_PAGEFAULT      8
> +#define VHOST_USER_PROTOCOL_F_CONFIG         9
>=20
>  Master message types
>  --------------------
> @@ -664,7 +665,8 @@ Master message types
>        Master payload: virtio device config space
>        Slave payload: virtio device config space
>=20
> -      Submitted by the vhost-user master to fetch the contents of the vi=
rtio
> +      When VHOST_USER_PROTOCOL_F_CONFIG is negotiated, this message is
> +      submitted by the vhost-user master to fetch the contents of the vi=
rtio
>        device configuration space, vhost-user slave's payload size MUST m=
atch
>        master's request, vhost-user slave uses zero length of payload to
>        indicate an error to vhost-user master. The vhost-user master may
> @@ -677,7 +679,8 @@ Master message types
>        Master payload: virtio device config space
>        Slave payload: N/A
>=20
> -      Submitted by the vhost-user master when the Guest changes the virt=
io
> +      When VHOST_USER_PROTOCOL_F_CONFIG is negotiated, this message is
> +      submitted by the vhost-user master when the Guest changes the virt=
io
>        device configuration space and also can be used for live migration
>        on the destination host. The vhost-user slave must check the flags
>        field, and slaves MUST NOT accept SET_CONFIG for read-only
> @@ -766,13 +769,13 @@ Slave message types
>       Slave payload: N/A
>       Master payload: N/A
>=20
> -     Vhost-user slave sends such messages to notify that the virtio devi=
ce's
> -     configuration space has changed, for those host devices which can s=
upport
> -     such feature, host driver can send VHOST_USER_GET_CONFIG message to
> slave
> -     to get the latest content. If VHOST_USER_PROTOCOL_F_REPLY_ACK is
> -     negotiated, and slave set the VHOST_USER_NEED_REPLY flag, master mu=
st
> -     respond with zero when operation is successfully completed, or non-=
zero
> -     otherwise.
> +     When VHOST_USER_PROTOCOL_F_CONFIG is negotiated, vhost-user slave
> sends
> +     such messages to notify that the virtio device's configuration spac=
e has
> +     changed, for those host devices which can support such feature, hos=
t
> +     driver can send VHOST_USER_GET_CONFIG message to slave to get the l=
atest
> +     content. If VHOST_USER_PROTOCOL_F_REPLY_ACK is negotiated, and slav=
e
> set
> +     the VHOST_USER_NEED_REPLY flag, master must respond with zero when
> +     operation is successfully completed, or non-zero otherwise.
>=20
>  VHOST_USER_PROTOCOL_F_REPLY_ACK:
>  -------------------------------
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 44aea5c0a8..cc8a24aa31 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -46,6 +46,7 @@ enum VhostUserProtocolFeature {
>      VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
>      VHOST_USER_PROTOCOL_F_CRYPTO_SESSION =3D 7,
>      VHOST_USER_PROTOCOL_F_PAGEFAULT =3D 8,
> +    VHOST_USER_PROTOCOL_F_CONFIG =3D 9,
>      VHOST_USER_PROTOCOL_F_MAX
>  };
>=20
> @@ -1211,6 +1212,17 @@ static int vhost_user_init(struct vhost_dev *dev, =
void
> *opaque)
>=20
>          dev->protocol_features =3D
>              protocol_features & VHOST_USER_PROTOCOL_FEATURE_MASK;
> +
> +        if (!dev->config_ops || !dev->config_ops->vhost_dev_config_notif=
ier) {
> +            /* Dont acknowledge CONFIG feature if device doesn't support=
 it */
> +            dev->protocol_features &=3D ~(1ULL <<
> VHOST_USER_PROTOCOL_F_CONFIG);
> +        } else if (!(protocol_features &
> +                    (1ULL << VHOST_USER_PROTOCOL_F_CONFIG))) {
> +            error_report("Device expects VHOST_USER_PROTOCOL_F_CONFIG "
> +                    "but backend does not support it.");
> +            return -1;
> +        }
> +
>          err =3D vhost_user_set_protocol_features(dev, dev->protocol_feat=
ures);
>          if (err < 0) {
>              return err;
> @@ -1405,6 +1417,11 @@ static int vhost_user_get_config(struct vhost_dev
> *dev, uint8_t *config,
>          .hdr.size =3D VHOST_USER_CONFIG_HDR_SIZE + config_len,
>      };
>=20
> +    if (!virtio_has_feature(dev->protocol_features,
> +                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +        return -1;
> +    }
> +
>      if (config_len > VHOST_USER_MAX_CONFIG_SIZE) {
>          return -1;
>      }
> @@ -1448,6 +1465,11 @@ static int vhost_user_set_config(struct vhost_dev
> *dev, const uint8_t *data,
>          .hdr.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
>      };
>=20
> +    if (!virtio_has_feature(dev->protocol_features,
> +                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +        return -1;
> +    }
> +
>      if (reply_supported) {
>          msg.hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>      }
> --
> 2.14.3
