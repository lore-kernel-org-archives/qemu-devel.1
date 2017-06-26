Received: from eggs.gnu.org ([2001:4830:134:3::10]:35554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcfa-0000CN-2g
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dPcfZ-0002XC-E0
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:39:46 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:33162)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dPcfZ-0002Wu-7W
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:39:45 -0400
Received: by mail-wr0-x242.google.com with SMTP id x23so30510365wrb.0
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 15:39:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170623164557.11636-4-f4bug@amsat.org>
References: <20170623164557.11636-1-f4bug@amsat.org>
	<20170623164557.11636-4-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Jun 2017 15:39:13 -0700
Message-ID: <CAKmqyKM_eWW2jps6Xw2JsjjrCoX_aLZdjYwYGWRq6FbF+WZkCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Laszlo Ersek <lersek@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>

On Fri, Jun 23, 2017 at 9:45 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> then abort calling error_setg()

The commit message should be able to be read separately from the title.

Once you fix up the message:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair

>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/core/qdev.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 849952a8d4..05aaa67cb8 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -448,7 +448,11 @@ qemu_irq qdev_get_gpio_in_named(DeviceState *dev, co=
nst char *name, int n)
>  {
>      NamedGPIOList *gpio_list =3D qdev_get_named_gpio_list(dev, name);
>
> -    assert(n >=3D 0 && n < gpio_list->num_in);
> +    assert(n >=3D 0);
> +    if (n >=3D gpio_list->num_in) {
> +        error_setg(&error_abort, "Invalid gpio #%d (of %d) for %s",
> +                   n, gpio_list->num_in, name ? name : "device");
> +    }
>      return gpio_list->in[n];
>  }
>
> --
> 2.13.1
>
>
