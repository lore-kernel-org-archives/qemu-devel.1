Received: from eggs.gnu.org ([2001:4830:134:3::10]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdFBA-0000fn-8G
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fdFB9-00066D-6w
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:29:12 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fdFB8-00065k-Sm
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 09:29:11 -0400
Received: by mail-wr1-x442.google.com with SMTP id m1-v6so5472364wrg.5
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 06:29:10 -0700 (PDT)
Date: Wed, 11 Jul 2018 14:29:08 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180711132908.GK31228@stefanha-x1.localdomain>
References: <20180710155037.16834-1-stefanha@redhat.com>
	<20180710155037.16834-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <20180710155037.16834-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qdev: add HotplugHandler->post_plug()
 callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 10, 2018 at 04:50:36PM +0100, Stefan Hajnoczi wrote:
> The ->pre_plug() callback is invoked before the device is realized.  The
> ->plug() callback is invoked when the device is being realized but
> before it is reset.
>=20
> This patch adds a ->post_plug() callback which is invoked after the
> device has been reset.  This callback is needed by HotplugHandlers that
> need to wait until after ->reset().
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/hotplug.h | 12 ++++++++++++
>  hw/core/hotplug.c    | 11 +++++++++++
>  hw/core/qdev.c       |  7 +++++++
>  3 files changed, 30 insertions(+)
>=20
> diff --git a/include/hw/hotplug.h b/include/hw/hotplug.h
> index 1a0516a479..1e8b1053b6 100644
> --- a/include/hw/hotplug.h
> +++ b/include/hw/hotplug.h
> @@ -47,6 +47,8 @@ typedef void (*hotplug_fn)(HotplugHandler *plug_handler,
>   * @parent: Opaque parent interface.
>   * @pre_plug: pre plug callback called at start of device.realize(true)
>   * @plug: plug callback called at end of device.realize(true).
> + * @post_plug: post plug callback called after device.realize(true) and =
device
> + *             reset
>   * @unplug_request: unplug request callback.
>   *                  Used as a means to initiate device unplug for device=
s that
>   *                  require asynchronous unplug handling.
> @@ -61,6 +63,7 @@ typedef struct HotplugHandlerClass {
>      /* <public> */
>      hotplug_fn pre_plug;
>      hotplug_fn plug;
> +    hotplug_fn post_plug;
>      hotplug_fn unplug_request;
>      hotplug_fn unplug;
>  } HotplugHandlerClass;
> @@ -83,6 +86,15 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_han=
dler,
>                                DeviceState *plugged_dev,
>                                Error **errp);
> =20
> +/**
> + * hotplug_handler_post_plug:
> + *
> + * Call #HotplugHandlerClass.post_plug callback of @plug_handler.
> + */
> +void hotplug_handler_post_plug(HotplugHandler *plug_handler,
> +                               DeviceState *plugged_dev,
> +                               Error **errp);
> +
>  /**
>   * hotplug_handler_unplug_request:
>   *
> diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
> index 17ac986685..ab34c19461 100644
> --- a/hw/core/hotplug.c
> +++ b/hw/core/hotplug.c
> @@ -35,6 +35,17 @@ void hotplug_handler_plug(HotplugHandler *plug_handler,
>      }
>  }
> =20
> +void hotplug_handler_post_plug(HotplugHandler *plug_handler,
> +                               DeviceState *plugged_dev,
> +                               Error **errp)
> +{
> +    HotplugHandlerClass *hdc =3D HOTPLUG_HANDLER_GET_CLASS(plug_handler);
> +
> +    if (hdc->post_plug) {
> +        hdc->post_plug(plug_handler, plugged_dev, errp);
> +    }
> +}
> +
>  void hotplug_handler_unplug_request(HotplugHandler *plug_handler,
>                                      DeviceState *plugged_dev,
>                                      Error **errp)
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index cf0db4b6da..78c0e031ff 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -865,6 +865,13 @@ static void device_set_realized(Object *obj, bool va=
lue, Error **errp)
>          }
>          if (dev->hotplugged) {
>              device_reset(dev);
> +
> +            if (hotplug_ctrl) {

In the final patch I will move this out of if (dev->hotplugged) since
the other HotplugHandler callbacks are also invoked unconditionally.

> +                hotplug_handler_post_plug(hotplug_ctrl, dev, &local_err);
> +                if (local_err !=3D NULL) {
> +                    goto child_realize_fail;
> +                }
> +            }
>          }
>          dev->pending_deleted_event =3D false;
>      } else if (!value && dev->realized) {
> --=20
> 2.17.1
>=20
>=20

--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRgYkAAoJEJykq7OBq3PIcXIIAIEvN9/kMNlb3baCIO8DNAjm
eoq89220UHcwwrEE8n6RH0cF9jwgUktKxSSeijJ7IbnNq6A1q4ZT3b+aQAKlPKos
JY7sC0jLEL6H0ZKiorKm0nuuIMxW2D4kxc7TXsaRto6hIzodEpRtyxWIF5J9NDAl
+xPEuIYJ+2v4ezvt561qEBgVKLT0NxEm8Ppqj4bS7gXvFxSD0TjA0iAJCo25idNb
lKNjPvEXSsNk6lV5SxdXKLfh64MQEuxzvb+2LqsQpyaf+1TB40XFUAmJF734+dlz
BLHSffJrMNaTzCFP337tdz8NOvUxvkx1KXc3iu4lAUpzpUuACYpZlWQL+JPmDeY=
=tYmM
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
