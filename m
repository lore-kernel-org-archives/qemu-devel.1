Received: from eggs.gnu.org ([2001:4830:134:3::10]:58487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSQR3-0000ni-A0
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gSQR1-00074Z-3d
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:49:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gSQR0-000746-TW
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 12:49:07 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A12B2308219A
	for <qemu-devel@nongnu.org>; Thu, 29 Nov 2018 17:49:05 +0000 (UTC)
Date: Thu, 29 Nov 2018 15:49:00 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181129174900.GP18284@habkost.net>
References: <20181127092801.21777-1-marcandre.lureau@redhat.com>
	<20181127092801.21777-26-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181127092801.21777-26-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v4 25/28] machine: add compat-props
 interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, imammedo@redhat.com

On Tue, Nov 27, 2018 at 01:27:58PM +0400, Marc-Andr=E9 Lureau wrote:
> Let's make compatiblity properties an interface, so that objects other
> than QDev can benefit from having machine compatiblity properties.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
[...]
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 3b31b2c025..b0ee05f837 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -970,28 +970,8 @@ static void device_initfn(Object *obj)
>      QLIST_INIT(&dev->gpios);
>  }
> =20
> -static const GPtrArray *ac_compat_props;
> -static const GPtrArray *mc_compat_props;
> -
> -void accel_register_compat_props(const GPtrArray *props)
> -{
> -    ac_compat_props =3D props;
> -}
> -
> -void machine_register_compat_props(const GPtrArray *props)
> -{
> -    mc_compat_props =3D props;
> -}
> -
>  static void device_post_init(Object *obj)
>  {
> -    if (ac_compat_props) {
> -        object_apply_global_props(obj, ac_compat_props, &error_abort);
> -    }
> -    if (mc_compat_props) {
> -        object_apply_global_props(obj, mc_compat_props, &error_abort);
> -    }
> -
>      qdev_prop_set_globals(DEVICE(obj));
>  }
> =20
> @@ -1124,6 +1104,10 @@ static const TypeInfo device_type_info =3D {
>      .class_init =3D device_class_init,
>      .abstract =3D true,
>      .class_size =3D sizeof(DeviceClass),
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_COMPAT_PROPS },
> +        { }
> +    }

At first I thought TYPE_COMPAT_PROPS was a practical way to
implement this feature, but now I'm worried: the ordering between
compat_props_post_init() qdev_prop_set_globals() is very
important (user-provided globals must always be set after compat
props), and here the ordering is implicit and easy to break
accidentally.

What if instead of a QOM interface we just provide a simple
object_apply_compat_props() function?  e.g.:

qdev.c:

  static void device_post_init(Object *obj)
  {
      object_apply_compat_props(obj);
      apply_user_provided_globals(obj);
  }

object_interface.c:

  void user_creatable_complete(Object *obj, Error **errp)
  {
      object_apply_compat_props(obj);
      ...
      ucc->complete(...)
  }

Most people don't understand QOM interfaces and their
initialization ordering rules.  Everybody understands C function
calls.

> [...]

--=20
Eduardo
