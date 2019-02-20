Received: from eggs.gnu.org ([209.51.188.92]:43332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwOwb-0005gR-T9
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:17:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gwOwb-0001V3-1G
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:17:37 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39785)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gwOwZ-0001RS-1r
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:17:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id x6so1628991qki.6
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:17:31 -0800 (PST)
MIME-Version: 1.0
References: <20190220010232.18731-1-philmd@redhat.com>
	<20190220010232.18731-4-philmd@redhat.com>
In-Reply-To: <20190220010232.18731-4-philmd@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 20 Feb 2019 11:17:19 +0100
Message-ID: <CAMxuvawsWu1m83qwp=U8m0X9Ar4m9CNiEVetfimhXoHzzkNHJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Prasad J Pandit <pjp@fedoraproject.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Anthony Perard <anthony.perard@citrix.com>, qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Zhang Chen <zhangckid@gmail.com>, xen-devel@lists.xenproject.org, Cornelia Huck <cohuck@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Amit Shah <amit@kernel.org>, Li Zhijian <lizhijian@cn.fujitsu.com>, Corey Minyard <minyard@acm.org>, "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul.durrant@citrix.com>, Halil Pasic <pasic@linux.ibm.com>, Stefano Stabellini <sstabellini@kernel.org>, qemu-s390x@nongnu.org, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Hi

On Wed, Feb 20, 2019 at 2:03 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> TabletChardev::query is an array of uint8_t.
> Use the same type to hold it (this also silent a -Wsign-conversion
> warning in the trace function).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  chardev/trace-events | 2 +-
>  chardev/wctablet.c   | 5 +++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
>
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
>
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
>
>      if (tablet->line_speed !=3D 9600) {
> @@ -269,7 +270,7 @@ static int wctablet_chr_write(struct Chardev *chr,
>
>      } else if (strncmp((char *)tablet->query, "TS", 2) =3D=3D 0 &&
>                 clen =3D=3D 3) {
> -        unsigned int input =3D tablet->query[2];
> +        uint8_t input =3D tablet->query[2];
>          uint8_t codes[7] =3D {
>              0xa3,
>              ((input & 0x80) =3D=3D 0) ? 0x7e : 0x7f,
> --
> 2.20.1
>
