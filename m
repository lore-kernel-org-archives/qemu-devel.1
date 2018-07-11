Received: from eggs.gnu.org ([2001:4830:134:3::10]:54068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdCrx-00056N-NX
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:01:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdCrr-0007Ti-KK
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:01:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49766 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdCrr-0007Ta-FM
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 07:01:07 -0400
References: <20180710155037.16834-1-stefanha@redhat.com>
	<20180710155037.16834-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <28ae4c18-82cc-184b-5e67-1be2c9e16107@redhat.com>
Date: Wed, 11 Jul 2018 13:01:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180710155037.16834-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: l00284672 <lizhengui@huawei.com>, Fam Zheng <famz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On 10/07/2018 17:50, Stefan Hajnoczi wrote:
> The ->pre_plug() callback is invoked before the device is realized.  Th=
e
> ->plug() callback is invoked when the device is being realized but
> before it is reset.
>=20
> This patch adds a ->post_plug() callback which is invoked after the
> device has been reset.  This callback is needed by HotplugHandlers that
> need to wait until after ->reset().
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Thanks Stefan.  I looked a bit at the code last week, and it seemed to
me that pretty much all "plug" callbacks should be split into a
"pre_plug" (check) and a "post_plug" (commit).  So the patch is okay,
but please remove the Error** argument of post_plug, because all the
checks should have happened already (there is none in the case of
virtio-scsi).

Thanks,

Paolo

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
> @@ -47,6 +47,8 @@ typedef void (*hotplug_fn)(HotplugHandler *plug_handl=
er,
>   * @parent: Opaque parent interface.
>   * @pre_plug: pre plug callback called at start of device.realize(true=
)
>   * @plug: plug callback called at end of device.realize(true).
> + * @post_plug: post plug callback called after device.realize(true) an=
d device
> + *             reset
>   * @unplug_request: unplug request callback.
>   *                  Used as a means to initiate device unplug for devi=
ces that
>   *                  require asynchronous unplug handling.
> @@ -61,6 +63,7 @@ typedef struct HotplugHandlerClass {
>      /* <public> */
>      hotplug_fn pre_plug;
>      hotplug_fn plug;
> +    hotplug_fn post_plug;
>      hotplug_fn unplug_request;
>      hotplug_fn unplug;
>  } HotplugHandlerClass;
> @@ -83,6 +86,15 @@ void hotplug_handler_pre_plug(HotplugHandler *plug_h=
andler,
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
> @@ -35,6 +35,17 @@ void hotplug_handler_plug(HotplugHandler *plug_handl=
er,
>      }
>  }
> =20
> +void hotplug_handler_post_plug(HotplugHandler *plug_handler,
> +                               DeviceState *plugged_dev,
> +                               Error **errp)
> +{
> +    HotplugHandlerClass *hdc =3D HOTPLUG_HANDLER_GET_CLASS(plug_handle=
r);
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
> @@ -865,6 +865,13 @@ static void device_set_realized(Object *obj, bool =
value, Error **errp)
>          }
>          if (dev->hotplugged) {
>              device_reset(dev);
> +
> +            if (hotplug_ctrl) {
> +                hotplug_handler_post_plug(hotplug_ctrl, dev, &local_er=
r);
> +                if (local_err !=3D NULL) {
> +                    goto child_realize_fail;
> +                }
> +            }
>          }
>          dev->pending_deleted_event =3D false;
>      } else if (!value && dev->realized) {
>=20
