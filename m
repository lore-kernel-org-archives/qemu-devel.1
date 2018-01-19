Received: from eggs.gnu.org ([2001:4830:134:3::10]:34329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecbFU-0004ZC-TJ
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:18:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ecbFR-0006VC-0P
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:18:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ecbFQ-0006Up-Q3
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:18:40 -0500
Date: Fri, 19 Jan 2018 16:18:27 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180119181827.GM15832@localhost.localdomain>
References: <20180116131555.14242-1-f4bug@amsat.org>
	<20180116131555.14242-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180116131555.14242-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/11] hw/i2c: convert I2CSlaveClass::init
 -> realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

On Tue, Jan 16, 2018 at 10:15:47AM -0300, Philippe Mathieu-Daud=E9 wrote:
[...]
> -static int i2c_slave_qdev_init(DeviceState *dev)
> +static void i2c_slave_realize(DeviceState *dev, Error **errp)
>  {
>      I2CSlave *s =3D I2C_SLAVE(dev);
>      I2CSlaveClass *sc =3D I2C_SLAVE_GET_CLASS(s);
> =20
> -    if (sc->init) {
> -        return sc->init(s);
> +    if (sc->realize) {
> +        return sc->realize(s, errp);
>      }

Do you think i2c_slave_realize() will perform additional actions
in the future?  If not, why not let subclasses set
DeviceClass::realize directly?

> -
> -    return 0;
>  }
> =20
>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t a=
ddr)
> @@ -301,7 +299,7 @@ DeviceState *i2c_create_slave(I2CBus *bus, const ch=
ar *name, uint8_t addr)
>  static void i2c_slave_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *k =3D DEVICE_CLASS(klass);
> -    k->init =3D i2c_slave_qdev_init;
> +    k->realize =3D i2c_slave_realize;
>      set_bit(DEVICE_CATEGORY_MISC, k->categories);
>      k->bus_type =3D TYPE_I2C_BUS;
>      k->props =3D i2c_props;
[...]

--=20
Eduardo
