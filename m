Received: from eggs.gnu.org ([2001:4830:134:3::10]:49939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPdzP-000168-4z
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dPdzO-0008JW-9u
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44124)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dPdzO-0008JI-3o
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 20:04:18 -0400
From: "Eduardo Habkost" <ehabkost@redhat.com>
Date: Fri, 23 Jun 2017 16:25:00 -0300
Message-ID: <20170623192500.GC3038@localhost.localdomain>
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623164557.11636-4-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170623164557.11636-4-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/core: report an error if invalid
 gpio is used
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Fri, Jun 23, 2017 at 01:45:57PM -0300, Philippe Mathieu-Daud=E9 wrote:
> then abort calling error_setg()

I don't understand the reasons for this.  This commit message says
"what" and "how", but not "why".

>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  hw/core/qdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 849952a8d4..05aaa67cb8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -448,7 +448,11 @@ qemu_irq qdev_get_gpio_in_named(DeviceState *dev, =
const char *name, int n)
>  {
>      NamedGPIOList *gpio_list =3D qdev_get_named_gpio_list(dev, name);
> =20
> -    assert(n >=3D 0 && n < gpio_list->num_in);
> +    assert(n >=3D 0);
> +    if (n >=3D gpio_list->num_in) {
> +        error_setg(&error_abort, "Invalid gpio #%d (of %d) for %s",
> +                   n, gpio_list->num_in, name ? name : "device");

Why exactly assert() is ok for (n < 0), but not for
(n >=3D gpio_list->num_io)?

If you have reasons to believe (n >=3D gpio_list->num_in) can be triggere=
d
by user input, then abort() isn't an appropriate way to handle it.

> +    }
>      return gpio_list->in[n];
>  }
> =20
> --=20
> 2.13.1
>=20

--=20
Eduardo
