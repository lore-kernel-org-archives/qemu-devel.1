Received: from eggs.gnu.org ([2001:4830:134:3::10]:39959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnHtT-0001Cz-3t
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dnHtO-00015D-MJ
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dnHtO-00014k-Fg
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 01:19:50 -0400
References: <20170831035306.29170-1-f4bug@amsat.org>
	<20170831035306.29170-2-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <be9ca245-f1af-e78a-aa12-c479e59b2985@redhat.com>
Date: Thu, 31 Aug 2017 07:19:41 +0200
MIME-Version: 1.0
In-Reply-To: <20170831035306.29170-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] serial: add serial_chr_nonnull() to
 use the null backend when none provided
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>

On 31.08.2017 05:53, Philippe Mathieu-Daud=C3=A9 wrote:
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/char/serial.h |  1 +
>  hw/char/serial.c         | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
>=20
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index c4daf11a14..96bccb39e1 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -93,6 +93,7 @@ SerialState *serial_mm_init(MemoryRegion *address_spa=
ce,
>                              hwaddr base, int it_shift,
>                              qemu_irq irq, int baudbase,
>                              Chardev *chr, enum device_endian end);
> +Chardev *serial_chr_nonnull(Chardev *chr);

Why do you need the prototype? Please make the function static if
possible (otherwise please add some rationale in the patch description).

>  /* serial-isa.c */
>  #define TYPE_ISA_SERIAL "isa-serial"
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index 9aec6c60d8..7a100db107 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -1025,6 +1025,19 @@ static const MemoryRegionOps serial_mm_ops[3] =3D=
 {
>      },
>  };
> =20
> +Chardev *serial_chr_nonnull(Chardev *chr)
> +{
> +    static int serial_id;
> +    char *label;
> +
> +    label =3D g_strdup_printf("discarding-serial%d", serial_id++);
> +    chr =3D qemu_chr_new(label, "null");

That looks wrong - you're ignoring the input parameter and always open
the "null" device? Shouldn't there be a "if (chr) return chr;" in front
of this?

> +    assert(chr);
> +    g_free(label);
> +
> +    return chr;
> +}

 Thomas

PS: I think you should also merge the two patches together, they are
small enough.
