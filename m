Received: from eggs.gnu.org ([2001:4830:134:3::10]:60852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1Log-0005mU-Az
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 20:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changpeng.liu@intel.com>) id 1f1Lod-0005Q3-8F
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 20:53:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:23685)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <changpeng.liu@intel.com>)
	id 1f1Lod-0005PI-00
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 20:53:19 -0400
From: "Liu, Changpeng" <changpeng.liu@intel.com>
Date: Thu, 29 Mar 2018 00:53:11 +0000
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B6255A0@SHSMSX103.ccr.corp.intel.com>
References: <20180328192800.7138-1-maxime.coquelin@redhat.com>
	<20180328192800.7138-2-maxime.coquelin@redhat.com>
In-Reply-To: <20180328192800.7138-2-maxime.coquelin@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 1/2] vhost-user-blk: set config ops
 before vhost-user init
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
> Subject: [PATCH v2 1/2] vhost-user-blk: set config ops before vhost-user =
init
>=20
> As soon as vhost-user init is done, the backend may send
> VHOST_USER_SLAVE_CONFIG_CHANGE_MSG, so let's set the
> notification callback before it.
>=20
> Also, it will be used to know whether the device supports
> the config feature to advertize it or not.
>=20
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
>  hw/block/vhost-user-blk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> index f840f07dfe..262baca432 100644
> --- a/hw/block/vhost-user-blk.c
> +++ b/hw/block/vhost-user-blk.c
> @@ -259,6 +259,8 @@ static void vhost_user_blk_device_realize(DeviceState
> *dev, Error **errp)
>      s->dev.vq_index =3D 0;
>      s->dev.backend_features =3D 0;
>=20
> +    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
Please also remove the line "assert(hdev->vhost_ops);" in function vhost_de=
v_set_config_notifier at vhost.c file.
> +
>      ret =3D vhost_dev_init(&s->dev, &s->chardev, VHOST_BACKEND_TYPE_USER=
, 0);
>      if (ret < 0) {
>          error_setg(errp, "vhost-user-blk: vhost initialization failed: %=
s",
> @@ -277,8 +279,6 @@ static void vhost_user_blk_device_realize(DeviceState
> *dev, Error **errp)
>          s->blkcfg.num_queues =3D s->num_queues;
>      }
>=20
> -    vhost_dev_set_config_notifier(&s->dev, &blk_ops);
> -
>      return;
>=20
>  vhost_err:
> --
> 2.14.3
