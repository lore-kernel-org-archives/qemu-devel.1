Received: from eggs.gnu.org ([2001:4830:134:3::10]:47123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecb0T-00049y-45
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:03:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecb0O-0006db-8s
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:03:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecb0O-0006cS-2g
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:03:08 -0500
Date: Fri, 19 Jan 2018 16:03:02 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119180302.GK15832@localhost.localdomain>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180116131555.14242-7-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/11] sysbus: add realize() and unrealize()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 16, 2018 at 10:15:50AM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> +static void sysbus_realize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sd =3D SYS_BUS_DEVICE(dev);
> +    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_GET_CLASS(sd);
> +
> +    if (sbc->realize) {
> +        sbc->realize(sd, errp);
> +    }
> +}
> +
> +static void sysbus_unrealize(DeviceState *dev, Error **errp)
> +{
> +    SysBusDevice *sd =3D SYS_BUS_DEVICE(dev);
> +    SysBusDeviceClass *sbc =3D SYS_BUS_DEVICE_GET_CLASS(sd);
> +
> +    if (sbc->unrealize) {
> +        sbc->unrealize(sd, errp);
> +    }
> +}

Why not just let the subclasses set DeviceClass::realize and
DeviceClass::unrealize directly?

> +
>  DeviceState *sysbus_create_varargs(const char *name,
>                                     hwaddr addr, ...)
>  {
> @@ -325,6 +346,8 @@ static void sysbus_device_class_init(ObjectClass *k=
lass, void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
>      k->init =3D sysbus_device_init;
> +    k->realize =3D sysbus_realize;
> +    k->unrealize =3D sysbus_unrealize;
>      k->bus_type =3D TYPE_SYSTEM_BUS;
>      /*
>       * device_add plugs devices into a suitable bus.  For "real" buses=
,
> --=20
> 2.15.1
>=20
>=20

--=20
Eduardo
