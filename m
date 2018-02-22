Received: from eggs.gnu.org ([2001:4830:134:3::10]:42070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoswR-0000uE-Nx
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:37:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoswQ-0005nh-Mt
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:37:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50286 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoswQ-0005n4-Gf
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 10:37:50 -0500
Date: Thu, 22 Feb 2018 16:37:40 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180222153740.3zkvjen77uwjqhd2@sirius.home.kraxel.org>
References: <20180219111458.25983-1-kraxel@redhat.com>
	<20180219111458.25983-5-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180219111458.25983-5-kraxel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 4/7] qdev: add hotpluggable to
 DeviceState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

On Mon, Feb 19, 2018 at 12:14:55PM +0100, Gerd Hoffmann wrote:
> vfio display support wants disable hotplug for certain devices, because
> qemu doesn't support hotplugging display devices and qemu consoles.
>=20
> Add a hotpluggable bool to DeviceState, initialize it from
> DeviceClass->hotpluggable, update device_get_hotpluggable accordingly.
>=20
> Devices can flip the new variable from true to false if needed.

Alex wants an ack for this one.  Who maintains it these days?

MAINTAINERS doesn't list qdev.  For QOM which is closest probably
Andreas F=E4rber is listed.  Havn't seen him on the list for a while
though.

Ok, lets try some usual suspects...
Markus? Eric? Paolo? Peter?  Any comments on this one?

thanks,
  Gerd

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/hw/qdev-core.h | 1 +
>  hw/core/qdev.c         | 5 +++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index fc9d617a76..37d86f26e5 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -154,6 +154,7 @@ struct DeviceState {
>      const char *id;
>      char *canonical_path;
>      bool realized;
> +    bool hotpluggable;
>      bool pending_deleted_event;
>      QemuOpts *opts;
>      int hotplugged;
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 7ed1f431f0..89e03c7b47 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -946,8 +946,8 @@ static bool device_get_hotpluggable(Object *obj, Er=
ror **errp)
>      DeviceClass *dc =3D DEVICE_GET_CLASS(obj);
>      DeviceState *dev =3D DEVICE(obj);
> =20
> -    return dc->hotpluggable && (dev->parent_bus =3D=3D NULL ||
> -                                qbus_is_hotpluggable(dev->parent_bus))=
;
> +    return dc->hotpluggable && dev->hotpluggable &&
> +        (dev->parent_bus =3D=3D NULL || qbus_is_hotpluggable(dev->pare=
nt_bus));
>  }
> =20
>  static bool device_get_hotplugged(Object *obj, Error **err)
> @@ -988,6 +988,7 @@ static void device_initfn(Object *obj)
>          class =3D object_class_get_parent(class);
>      } while (class !=3D object_class_by_name(TYPE_DEVICE));
> =20
> +    dev->hotpluggable =3D DEVICE_CLASS(class)->hotpluggable;
>      object_property_add_link(OBJECT(dev), "parent_bus", TYPE_BUS,
>                               (Object **)&dev->parent_bus, NULL, 0,
>                               &error_abort);
> --=20
> 2.9.3
>=20
