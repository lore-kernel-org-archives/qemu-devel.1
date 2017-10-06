Received: from eggs.gnu.org ([2001:4830:134:3::10]:42552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SzV-0000vt-HF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e0SzU-00058p-LN
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:48:37 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:53389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e0SzU-00057n-FD
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 09:48:36 -0400
Received: by mail-wr0-x22d.google.com with SMTP id y44so5380191wry.10
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 06:48:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918195100.17593-3-andrew.smirnov@gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-3-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Oct 2017 14:48:14 +0100
Message-ID: <CAFEAcA9M9ZpcAHB4eZ2zh9jA6YSWpLoEPiAznnL2-SSdJoW+Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 02/17] imx_fec: Do not calculate FEC
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
> Save some computation time and avoid calculating CRC's frame
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  hw/net/imx_fec.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
> index 88b4b049d7..75822344fc 100644
> --- a/hw/net/imx_fec.c
> +++ b/hw/net/imx_fec.c
> @@ -1032,9 +1032,7 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>      IMXENETBufDesc bd;
>      uint32_t flags = 0;
>      uint32_t addr;
> -    uint32_t crc;
>      uint32_t buf_addr;
> -    uint8_t *crc_ptr;
>      unsigned int buf_len;
>      size_t size = len;
>
> @@ -1048,8 +1046,6 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>
>      /* 4 bytes for the CRC.  */
>      size += 4;
> -    crc = cpu_to_be32(crc32(~0, buf, size));
> -    crc_ptr = (uint8_t *) &crc;
>
>      /* Huge frames are truncted.  */
>      if (size > ENET_MAX_FRAME_SIZE) {
> @@ -1090,9 +1086,10 @@ static ssize_t imx_enet_receive(NetClientState *nc, const uint8_t *buf,
>          dma_memory_write(&address_space_memory, buf_addr, buf, buf_len);
>          buf += buf_len;
>          if (size < 4) {
> +            const uint8_t zeros[4] = { 0 };
> +
>              dma_memory_write(&address_space_memory, buf_addr + buf_len,
> -                             crc_ptr, 4 - size);
> -            crc_ptr += 4 - size;
> +                             zeros, 4 - size);
>          }
>          bd.flags &= ~ENET_BD_E;
>          if (size == 0) {

This looks a bit odd. Doesn't the hardware calculate the CRC here?

thanks
-- PMM
