Received: from eggs.gnu.org ([2001:4830:134:3::10]:47466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TDW-0003v8-Vk
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0TDS-0001GL-TK
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:07 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:53213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0TDS-0001Eb-MF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 10:03:02 -0400
Received: by mail-wr0-x231.google.com with SMTP id k62so13099080wrc.9
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 07:03:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-8-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-8-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 15:02:41 +0100
Message-ID: <CAFEAcA_+HDjZWHbNhedzL7he=-1WPMRePh917-9BZJK0AYqPdg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 07/17] imx_fec: Emulate SHIFT16 in
 ENETx_RACC
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
> Needed to support latest Linux kernel driver which relies on that
> functionality.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c         | 23 +++++++++++++++++++++++
>  include/hw/net/imx_fec.h |  2 ++
>  2 files changed, 25 insertions(+)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 8a77136d38..bd62d7a75f 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1037,6 +1037,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>      uint32_t buf_addr;
>      unsigned int buf_len;
>      size_t size = len;
> +    bool shift16 = s->regs[ENET_RACC] & ENET_RACC_SHIFT16;
>
>      FEC_PRINTF("len %d\n", (int)size);
>
> @@ -1049,6 +1050,10 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>      /* 4 bytes for the CRC.  */
>      size += 4;
>
> +    if (shift16) {
> +        size += 2;
> +    }
> +
>      /* Huge frames are truncted.  */
>      if (size > s->regs[ENET_FTRL]) {
>          size = s->regs[ENET_FTRL];
> @@ -1085,6 +1090,24 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>              buf_len += size - 4;
>          }
>          buf_addr = bd.data;
> +
> +        if (shift16) {
> +            /*
> +             * If SHIFT16 bit of ENETx_RACC register is set we need to
> +             * align the payload to 4-byte boundary.
> +             */
> +            const uint8_t zeros[2] = { 0 };
> +
> +            dma_memory_write(&address_space_memory, buf_addr,
> +                             zeros, sizeof(zeros));
> +
> +            buf_addr += sizeof(zeros);
> +            buf_len  -= sizeof(zeros);
> +
> +            shift16 = false; /* We only do this once per Ethernet
> +                              * frame */
> +        }
> +

Can you avoid having an end-of-source-line comment that wraps
to multiple lines, please? (put it on a line of its own, or
edit down to fit.) Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
