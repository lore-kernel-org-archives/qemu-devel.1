Received: from eggs.gnu.org ([2001:4830:134:3::10]:47636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TE3-0004Jr-Um
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TDz-0001mw-QG
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:39 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:46332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TDz-0001l7-Jq
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:35 -0400
Received: by mail-wm0-x236.google.com with SMTP id m72so7843676wmc.1
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:03:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-6-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-6-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:03:13 +0100
Message-ID: <CAFEAcA-FQxm-EXRk_GGuazaNgoRon4E=EMfdEEH_Xwh-5v1S-g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/17] imx_fec: Use ENET_FTRL to determine
 truncation length
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Frame truncation length, TRUNC_FL, is determined by the contents of
> ENET_FTRL register, so convert the code to use it instead of a
> hardcoded constant.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 767402909d..989c11be5f 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1050,8 +1050,8 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>      size += 4;
>
>      /* Huge frames are truncted.  */
> -    if (size > ENET_MAX_FRAME_SIZE) {
> -        size = ENET_MAX_FRAME_SIZE;
> +    if (size > s->regs[ENET_FTRL]) {
> +        size = s->regs[ENET_FTRL];
>          flags |= ENET_BD_TR | ENET_BD_LG;
>      }

PS: since you're editing this bit of code anyway, can you fix
the typo in the comment in passing: should be "truncated".

thanks
-- PMM
