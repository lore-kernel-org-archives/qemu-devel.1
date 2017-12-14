Received: from eggs.gnu.org ([2001:4830:134:3::10]:53715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXg1-0001Du-SX
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1ePXg1-000469-2L
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:52:09 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:34770)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1ePXg0-00042t-QP
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 12:52:08 -0500
Received: by mail-wr0-x241.google.com with SMTP id y21so5884761wrc.1
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 09:52:08 -0800 (PST)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20171213195852.30439-14-f4bug@amsat.org>
References: <20171213195852.30439-1-f4bug@amsat.org>
	<20171213195852.30439-14-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Thu, 14 Dec 2017 09:51:37 -0800
Message-ID: <CAKmqyKNPY47rHEzOU0HScfN60UixdRtwYk_UGTbsdmbO3PCS8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/14] sdhci: add sdhci_init_capareg() to
 initialize the CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Prasad J Pandit <pjp@fedoraproject.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Andrey Yurovsky <yurovsky@gmail.com>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Dec 13, 2017 at 11:58 AM, Philippe Mathieu-Daud=C3=A9
<f4bug@amsat.org> wrote:
> following patches modifying CAPAB will be easier to review.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/sd/sdhci.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index dadc4787b2..78bb8e8e89 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -100,6 +100,13 @@
>
>  #define MASKED_WRITE(reg, mask, val)  (reg =3D (reg & (mask)) | (val))
>
> +static void sdhci_init_capareg(SDHCIState *s, Error **errp)
> +{
> +    if (s->capareg =3D=3D UINT32_MAX) {
> +        s->capareg =3D SDHC_CAPAB_REG_DEFAULT;
> +    }
> +}
> +
>  static uint8_t sdhci_slotint(SDHCIState *s)
>  {
>      return (s->norintsts & s->norintsigen) || (s->errintsts & s->errints=
igen) ||
> @@ -1158,6 +1165,8 @@ static void sdhci_initfn(SDHCIState *s)
>
>  static void sdhci_realizefn(SDHCIState *s, Error **errp)
>  {
> +    sdhci_init_capareg(s, errp);
> +
>      s->buf_maxsz =3D sdhci_get_fifolen(s);
>      s->fifo_buffer =3D g_malloc0(s->buf_maxsz);
>
> @@ -1244,8 +1253,7 @@ const VMStateDescription sdhci_vmstate =3D {
>  /* Capabilities registers provide information on supported features of t=
his
>   * specific host controller implementation */
>  static Property sdhci_properties[] =3D {
> -    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg,
> -            SDHC_CAPAB_REG_DEFAULT),
> +    DEFINE_PROP_UINT32("capareg", SDHCIState, capareg, UINT32_MAX),

This looks like a step in the wrong direction.

If this is required to do something smarter latter it should probably
be in that series.

Alistair

>      DEFINE_PROP_UINT32("maxcurr", SDHCIState, maxcurr, 0),
>      DEFINE_PROP_BOOL("pending-insert-quirk", SDHCIState, pending_insert_=
quirk,
>                       false),
> --
> 2.15.1
>
>
