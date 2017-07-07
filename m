Received: from eggs.gnu.org ([2001:4830:134:3::10]:54540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dTVsg-0001Wl-NO
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dTVsc-0006GH-Mt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:22 -0400
Received: from us-smtp-delivery-101.mimecast.com ([216.205.24.101]:50745)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dTVsc-0006Fe-Bh
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 12:13:18 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Fri, 7 Jul 2017 16:13:09 +0000
Message-ID: <6EE75907-957A-40F7-B8D3-A06AEABCB2D2@nutanix.com>
References: <1497462278-15961-1-git-send-email-felipe@nutanix.com>
In-Reply-To: <1497462278-15961-1-git-send-email-felipe@nutanix.com>
Content-Language: en-US
Content-ID: <E57B3EC40A8D5543976EAE1569D8CB7C@namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: support cross-endianess
 negatiation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Marc-Andre Lureau <marcandre.lureau@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Mike Cui <cui@nutanix.com>

ping. :)

F.

> On 14 Jun 2017, at 18:44, Felipe Franciosi <felipe@nutanix.com> wrote:
>=20
> Currently, vhost-user does not implement any means for notifying the
> backend about guest endianess. This commit introduces a new message
> called VHOST_USER_SET_VRING_ENDIAN which is analogous to the ioctl()
> called VHOST_SET_VRING_ENDIAN used for kernel vhost backends. Such
> message is necessary for backends supporting legacy (pre-1.0) virtio
> devices running in big-endian guests.
>=20
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
> Signed-off-by: Mike Cui <cui@nutanix.com>
> ---
> v1->v2:
> * Elaborated message usage on the documentation.
> * Fixed Id typo (22->23) on the documentation.
>=20
> docs/specs/vhost-user.txt | 16 ++++++++++++++++
> hw/virtio/vhost-user.c    | 23 +++++++++++++++++++++--
> 2 files changed, 37 insertions(+), 2 deletions(-)
>=20
> diff --git a/docs/specs/vhost-user.txt b/docs/specs/vhost-user.txt
> index 481ab56..954771d 100644
> --- a/docs/specs/vhost-user.txt
> +++ b/docs/specs/vhost-user.txt
> @@ -326,6 +326,7 @@ Protocol features
> #define VHOST_USER_PROTOCOL_F_REPLY_ACK      3
> #define VHOST_USER_PROTOCOL_F_MTU            4
> #define VHOST_USER_PROTOCOL_F_SLAVE_REQ      5
> +#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN   6
>=20
> Master message types
> --------------------
> @@ -580,6 +581,21 @@ Master message types
>       This request should be send only when VIRTIO_F_IOMMU_PLATFORM featu=
re
>       has been successfully negotiated.
>=20
> + * VHOST_USER_SET_VRING_ENDIAN
> +
> +      Id: 23
> +      Equivalent ioctl: VHOST_SET_VRING_ENDIAN
> +      Master payload: vring state description
> +
> +      Set the endianess of a VQ for legacy devices. Little-endian is ind=
icated
> +      with state.num set to 0 and big-endian is indicated with state.num=
 set
> +      to 1. Other values are invalid.
> +      This request should be sent only when VHOST_USER_PROTOCOL_F_CROSS_=
ENDIAN
> +      has been negotiated.
> +      Backends that negotiated this feature should handle both endianess=
es
> +      and expect this message once (per VQ) during device configuration
> +      (ie. before the master starts the VQ).
> +
> Slave message types
> -------------------
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index 958ee09..006af1c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -33,6 +33,7 @@ enum VhostUserProtocolFeature {
>     VHOST_USER_PROTOCOL_F_REPLY_ACK =3D 3,
>     VHOST_USER_PROTOCOL_F_NET_MTU =3D 4,
>     VHOST_USER_PROTOCOL_F_SLAVE_REQ =3D 5,
> +    VHOST_USER_PROTOCOL_F_CROSS_ENDIAN =3D 6,
>=20
>     VHOST_USER_PROTOCOL_F_MAX
> };
> @@ -63,6 +64,7 @@ typedef enum VhostUserRequest {
>     VHOST_USER_NET_SET_MTU =3D 20,
>     VHOST_USER_SET_SLAVE_REQ_FD =3D 21,
>     VHOST_USER_IOTLB_MSG =3D 22,
> +    VHOST_USER_SET_VRING_ENDIAN =3D 23,
>     VHOST_USER_MAX
> } VhostUserRequest;
>=20
> @@ -367,8 +369,25 @@ static int vhost_user_set_vring_addr(struct vhost_de=
v *dev,
> static int vhost_user_set_vring_endian(struct vhost_dev *dev,
>                                        struct vhost_vring_state *ring)
> {
> -    error_report("vhost-user trying to send unhandled ioctl");
> -    return -1;
> +    bool cross_endian =3D virtio_has_feature(dev->protocol_features,
> +                                           VHOST_USER_PROTOCOL_F_CROSS_E=
NDIAN);
> +    VhostUserMsg msg =3D {
> +        .request =3D VHOST_USER_SET_VRING_ENDIAN,
> +        .flags =3D VHOST_USER_VERSION,
> +        .payload.state =3D *ring,
> +        .size =3D sizeof(msg.payload.state),
> +    };
> +
> +    if (!cross_endian) {
> +        error_report("vhost-user trying to send unhandled ioctl");
> +        return -1;
> +    }
> +
> +    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
> +        return -1;
> +    }
> +
> +    return 0;
> }
>=20
> static int vhost_set_vring(struct vhost_dev *dev,
> --=20
> 1.9.5
>=20
