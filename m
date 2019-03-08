Received: from eggs.gnu.org ([209.51.188.92]:47657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2CKh-0007Tz-8F
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2CKg-0004B5-EV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 05:02:27 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-6-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <08a34be1-9c4c-cd05-84f5-a83a461d63ae@redhat.com>
Date: Fri, 8 Mar 2019 11:02:00 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 05/18] hw/nvram/fw_cfg: Use the ldst API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
> The load/store API eases code review.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/nvram/fw_cfg.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
> index 684c2cf00a..8eb76a382c 100644
> --- a/hw/nvram/fw_cfg.c
> +++ b/hw/nvram/fw_cfg.c
> @@ -141,7 +141,7 @@ static char *read_splashfile(char *filename, gsize =
*file_sizep,
>      }
> =20
>      /* check magic ID */
> -    filehead =3D ((content[0] & 0xff) + (content[1] << 8)) & 0xffff;
> +    filehead =3D lduw_le_p(content);
>      if (filehead =3D=3D 0xd8ff) {
>          file_type =3D JPG_FILE;
>      } else if (filehead =3D=3D 0x4d42) {
> @@ -152,7 +152,7 @@ static char *read_splashfile(char *filename, gsize =
*file_sizep,
> =20
>      /* check BMP bpp */
>      if (file_type =3D=3D BMP_FILE) {
> -        bmp_bpp =3D (content[28] + (content[29] << 8)) & 0xffff;
> +        bmp_bpp =3D lduw_le_p(&content[28]);
>          if (bmp_bpp !=3D 24) {
>              goto error;
>          }
>=20

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
