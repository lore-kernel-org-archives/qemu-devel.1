Received: from eggs.gnu.org ([209.51.188.92]:40592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwMMb-0003rM-PB
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:32:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gwMMb-0007CB-17
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 02:32:17 -0500
Date: Wed, 20 Feb 2019 08:32:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190220073206.gkzviu3v5xpu65n7@sirius.home.kraxel.org>
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-4-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190220010232.18731-4-philmd@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 03/25] chardev/wctablet: Use unsigned
 type to hold unsigned value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad J Pandit <pjp@fedoraproject.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

On Wed, Feb 20, 2019 at 02:02:10AM +0100, Philippe Mathieu-Daud=E9 wrote:
> TabletChardev::query is an array of uint8_t.
> Use the same type to hold it (this also silent a -Wsign-conversion
> warning in the trace function).
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

> ---
>  chardev/trace-events | 2 +-
>  chardev/wctablet.c   | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/chardev/trace-events b/chardev/trace-events
> index d0e5f3bbc1..562bfe70e9 100644
> --- a/chardev/trace-events
> +++ b/chardev/trace-events
> @@ -5,7 +5,7 @@ wct_init(void) ""
>  wct_cmd_re(void) ""
>  wct_cmd_st(void) ""
>  wct_cmd_sp(void) ""
> -wct_cmd_ts(int input) "0x%02x"
> +wct_cmd_ts(uint8_t input) "0x%02x"
>  wct_cmd_other(const char *cmd) "%s"
>  wct_speed(int speed) "%d"
> =20
> diff --git a/chardev/wctablet.c b/chardev/wctablet.c
> index 35dbd29a33..cf7a08a363 100644
> --- a/chardev/wctablet.c
> +++ b/chardev/wctablet.c
> @@ -207,7 +207,8 @@ static int wctablet_chr_write(struct Chardev *chr,
>                                const uint8_t *buf, int len)
>  {
>      TabletChardev *tablet =3D WCTABLET_CHARDEV(chr);
> -    unsigned int i, clen;
> +    size_t i;
> +    unsigned int clen;
>      char *pos;
> =20
>      if (tablet->line_speed !=3D 9600) {
> @@ -269,7 +270,7 @@ static int wctablet_chr_write(struct Chardev *chr,
> =20
>      } else if (strncmp((char *)tablet->query, "TS", 2) =3D=3D 0 &&
>                 clen =3D=3D 3) {
> -        unsigned int input =3D tablet->query[2];
> +        uint8_t input =3D tablet->query[2];
>          uint8_t codes[7] =3D {
>              0xa3,
>              ((input & 0x80) =3D=3D 0) ? 0x7e : 0x7f,
> --=20
> 2.20.1
>=20
