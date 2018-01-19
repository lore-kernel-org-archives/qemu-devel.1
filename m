Received: from eggs.gnu.org ([2001:4830:134:3::10]:46811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecazg-0003Zf-FA
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ecazf-0005xk-LK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:02:24 -0500
Received: from mail-lf0-x244.google.com ([2a00:1450:4010:c07::244]:37031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ecazf-0005xF-EP
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 13:02:23 -0500
Received: by mail-lf0-x244.google.com with SMTP id f3so3096271lfe.4
	for <qemu-devel@nongnu.org>; Fri, 19 Jan 2018 10:02:23 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180118183108.16009-7-f4bug@amsat.org>
References: <20180118182510.15630-1-f4bug@amsat.org>
	<20180118183108.16009-1-f4bug@amsat.org>
	<20180118183108.16009-7-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 19 Jan 2018 10:01:51 -0800
Message-ID: <CAKmqyKOhrdCquMjoA-mP=3mvA7esyALv25_8YfHJK-aZqfdE6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 07/17] sdhci: add
 init_readonly_registers() to initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Kevin O'Connor <kevin@koconnor.net>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, Jan 18, 2018 at 10:30 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

> ---
>  hw/sd/sdhci.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index 8c9c0fbc2a..caf5e5a1b4 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -1174,12 +1174,19 @@ static inline unsigned int sdhci_get_fifolen(SDHC=
IState *s)
>      }
>  }
>
> +static void sdhci_init_readonly_registers(SDHCIState *s, Error **errp)
> +{
> +    if (s->capareg =3D=3D UINT64_MAX) {
> +        s->capareg =3D SDHC_CAPAB_REG_DEFAULT;
> +    }
> +}
> +
>  /* --- qdev common --- */
>
>  #define DEFINE_SDHCI_COMMON_PROPERTIES(_state) \
> -    /* Capabilities registers provide information on supported features
> -     * of this specific host controller implementation */ \
> -    DEFINE_PROP_UINT64("capareg", _state, capareg, SDHC_CAPAB_REG_DEFAUL=
T), \
> +    /* deprecated: Capabilities registers provide information on support=
ed
> +     * features of this specific host controller implementation */ \
> +    DEFINE_PROP_UINT64("capareg", _state, capareg, UINT64_MAX), \
>      DEFINE_PROP_UINT64("maxcurr", _state, maxcurr, 0)
>
>  static void sdhci_initfn(SDHCIState *s)
> @@ -1204,6 +1211,13 @@ static void sdhci_uninitfn(SDHCIState *s)
>
>  static void sdhci_common_realize(SDHCIState *s, Error **errp)
>  {
> +    Error *local_err =3D NULL;
> +
> +    sdhci_init_readonly_registers(s, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
>      s->buf_maxsz =3D sdhci_get_fifolen(s);
>      s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>
> --
> 2.15.1
>
>
