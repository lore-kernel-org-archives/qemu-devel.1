Received: from eggs.gnu.org ([2001:4830:134:3::10]:46186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP6WG-00018F-Cn
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:47:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cP6WF-0005rg-GE
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:47:44 -0500
Received: from mail-ua0-x22e.google.com ([2607:f8b0:400c:c08::22e]:35513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cP6WF-0005rY-CA
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 06:47:43 -0500
Received: by mail-ua0-x22e.google.com with SMTP id y9so45328365uae.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jan 2017 03:47:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161227231156.22745-1-Sergio.G.DelReal@gmail.com>
References: <20161227231156.22745-1-Sergio.G.DelReal@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Jan 2017 11:47:22 +0000
Message-ID: <CAFEAcA_JSkB5FiJTn_amM90vYdPVi=puaVVbfNScAf3p7nL9Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/dma: Fix dead code in pl080.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Sergio_Andr=C3=A9s_G=C3=B3mez_Del_Real?= <sergio.g.delreal@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 December 2016 at 23:11, Sergio Andr=C3=A9s G=C3=B3mez Del Real
<sergio.g.delreal@gmail.com> wrote:
> The patch fixes dead code in pl080_read() and pl080_write() as reported
> in bug #1637974. According to ARM's official Technical Reference Manual,
> offsets handled by the switch statement are 0x100, 0x104, 0x108, 0x10C
> and 0x110, so the solution suggested by the guy who reported the bug is
> right.
>
> Signed-off-by: Sergio Andr=C3=A9s G=C3=B3mez Del Real <Sergio.G.DelReal@g=
mail.com>
> ---
>  hw/dma/pl080.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index 7724c93..3b0c20b 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -255,7 +255,7 @@ static uint64_t pl080_read(void *opaque, hwaddr offse=
t,
>          i =3D (offset & 0xe0) >> 5;
>          if (i >=3D s->nchannels)
>              goto bad_offset;
> -        switch (offset >> 2) {
> +        switch ((offset - 0x100) >> 2) {
>          case 0: /* SrcAddr */
>              return s->chan[i].src;
>          case 1: /* DestAddr */
> @@ -316,7 +316,7 @@ static void pl080_write(void *opaque, hwaddr offset,
>          i =3D (offset & 0xe0) >> 5;
>          if (i >=3D s->nchannels)
>              goto bad_offset;
> -        switch (offset >> 2) {
> +        switch ((offset - 0x100) >> 2) {
>          case 0: /* SrcAddr */
>              s->chan[i].src =3D value;
>              break;
> --
> 2.10.2

Looking at the TRM, I don't think this fix is correct. The switches
are intended to handle all of the DMACC* DMA channel registers:

0x100 DMACC0SrcAddr
0x104 DMACC0DestAddr
0x108 DMACC0LLI
0x10C DMACC0Control
0x110 DMACC0Configuration
0x120 DMACC1SrcAddr
0x124 DMACC1DestAddr
etc
up to
0x1F0 DMACC7Configuration

and what the switch is trying to do is figure out which of
SrcAddr/DestAddr/LLI/Control/Configuration we're looking at
(it then uses the correctly calculated 'i' index to pick the
right index into the s->chan[] array for DMACC0 vs DMACC1 etc).

So the correct thing to switch on here is
(offset & 0x1f) >> 2.

thanks
-- PMM
