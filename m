Received: from eggs.gnu.org ([2001:4830:134:3::10]:43283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhiyong.yang@intel.com>) id 1dDS0c-0004wu-9V
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:51:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhiyong.yang@intel.com>) id 1dDS0Y-0003t6-A4
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:51:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:34358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhiyong.yang@intel.com>)
	id 1dDS0X-0003sr-WD
	for qemu-devel@nongnu.org; Wed, 24 May 2017 04:51:06 -0400
From: "Yang, Zhiyong" <zhiyong.yang@intel.com>
Date: Wed, 24 May 2017 08:50:58 +0000
Message-ID: <E182254E98A5DA4EB1E657AC7CB9BD2A3EBBB851@BGSMSX101.gar.corp.intel.com>
References: <20170524083446.32261-1-maxime.coquelin@redhat.com>
In-Reply-To: <20170524083446.32261-1-maxime.coquelin@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] vhost-user: pass message as a pointer to
 process_message_reply()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jfreiman@redhat.com" <jfreiman@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

Hi, Maxime:

> -----Original Message-----
> From: Maxime Coquelin [mailto:maxime.coquelin@redhat.com]
> Sent: Wednesday, May 24, 2017 4:35 PM
> To: Yang, Zhiyong <zhiyong.yang@intel.com>; mst@redhat.com; qemu-
> devel@nongnu.org; jfreiman@redhat.com; marcandre.lureau@redhat.com
> Cc: Maxime Coquelin <maxime.coquelin@redhat.com>
> Subject: [PATCH] vhost-user: pass message as a pointer to
> process_message_reply()
>=20
> process_message_reply() was recently updated to get full message content
> instead of only its request field.
>=20
> There is no need to copy all the struct content into the stack, so just p=
ass its
> pointer.
>=20
> Cc: Zhiyong Yang <zhiyong.yang@intel.com>
> Fixes: 60cd11024f41 ("hw/virtio: fix vhost user fails to startup when MQ"=
)
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Good modification. Thanks.

Reviewed-by:  Zhiyong Yang <zhiyong.yang@intel.com>

> ---
>  hw/virtio/vhost-user.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c index
> b87a176..baf2487 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -162,11 +162,11 @@ fail:
>  }
>=20
>  static int process_message_reply(struct vhost_dev *dev,
> -                                 VhostUserMsg msg)
> +                                 VhostUserMsg *msg)
>  {
>      VhostUserMsg msg_reply;
>=20
> -    if ((msg.flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
> +    if ((msg->flags & VHOST_USER_NEED_REPLY_MASK) =3D=3D 0) {
>          return 0;
>      }
>=20
> @@ -174,10 +174,10 @@ static int process_message_reply(struct vhost_dev
> *dev,
>          return -1;
>      }
>=20
> -    if (msg_reply.request !=3D msg.request) {
> +    if (msg_reply.request !=3D msg->request) {
>          error_report("Received unexpected msg type."
>                       "Expected %d received %d",
> -                     msg.request, msg_reply.request);
> +                     msg->request, msg_reply.request);
>          return -1;
>      }
>=20
> @@ -324,7 +324,7 @@ static int vhost_user_set_mem_table(struct vhost_dev
> *dev,
>      }
>=20
>      if (reply_supported) {
> -        return process_message_reply(dev, msg);
> +        return process_message_reply(dev, &msg);
>      }
>=20
>      return 0;
> @@ -716,7 +716,7 @@ static int vhost_user_net_set_mtu(struct vhost_dev
> *dev, uint16_t mtu)
>=20
>      /* If reply_ack supported, slave has to ack specified MTU is valid *=
/
>      if (reply_supported) {
> -        return process_message_reply(dev, msg);
> +        return process_message_reply(dev, &msg);
>      }
>=20
>      return 0;
> --
> 2.9.4
