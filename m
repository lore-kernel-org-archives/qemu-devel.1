Received: from eggs.gnu.org ([2001:4830:134:3::10]:60286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flG0K-0006Cy-QO
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1flG0J-0002ci-SE
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 11:59:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180802144430.13870-1-peter.maydell@linaro.org>
	<20180802144430.13870-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <509a2c72-2e88-6961-6029-f373c78fe9b8@amsat.org>
Date: Thu, 2 Aug 2018 12:58:51 -0300
MIME-Version: 1.0
In-Reply-To: <20180802144430.13870-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/3] hw/ppc/ppc_boards: Don't use old_mmio
 for ref405ep_fpga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, patches@linaro.org

Hi Peter,

On 08/02/2018 11:44 AM, Peter Maydell wrote:
> Switch the ref405ep_fpga device away from using the old_mmio
> MemoryRegion accessors.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ppc/ppc405_boards.c | 60 +++++++-----------------------------------
>  1 file changed, 10 insertions(+), 50 deletions(-)
> 
> diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> index 70111075b33..f5a9c24b6ce 100644
> --- a/hw/ppc/ppc405_boards.c
> +++ b/hw/ppc/ppc405_boards.c
> @@ -66,7 +66,7 @@ struct ref405ep_fpga_t {
>      uint8_t reg1;
>  };
>  
> -static uint32_t ref405ep_fpga_readb (void *opaque, hwaddr addr)
> +static uint64_t ref405ep_fpga_readb(void *opaque, hwaddr addr, unsigned size)
>  {
>      ref405ep_fpga_t *fpga;
>      uint32_t ret;
> @@ -87,8 +87,8 @@ static uint32_t ref405ep_fpga_readb (void *opaque, hwaddr addr)
>      return ret;
>  }
>  
> -static void ref405ep_fpga_writeb (void *opaque,
> -                                  hwaddr addr, uint32_t value)
> +static void ref405ep_fpga_writeb(void *opaque, hwaddr addr, uint64_t value,
> +                                 unsigned size)
>  {
>      ref405ep_fpga_t *fpga;
>  
> @@ -105,54 +105,14 @@ static void ref405ep_fpga_writeb (void *opaque,
>      }
>  }
>  
> -static uint32_t ref405ep_fpga_readw (void *opaque, hwaddr addr)
> -{
> -    uint32_t ret;
> -
> -    ret = ref405ep_fpga_readb(opaque, addr) << 8;
> -    ret |= ref405ep_fpga_readb(opaque, addr + 1);
> -
> -    return ret;
> -}
> -
> -static void ref405ep_fpga_writew (void *opaque,
> -                                  hwaddr addr, uint32_t value)
> -{
> -    ref405ep_fpga_writeb(opaque, addr, (value >> 8) & 0xFF);
> -    ref405ep_fpga_writeb(opaque, addr + 1, value & 0xFF);
> -}
> -
> -static uint32_t ref405ep_fpga_readl (void *opaque, hwaddr addr)
> -{
> -    uint32_t ret;
> -
> -    ret = ref405ep_fpga_readb(opaque, addr) << 24;
> -    ret |= ref405ep_fpga_readb(opaque, addr + 1) << 16;
> -    ret |= ref405ep_fpga_readb(opaque, addr + 2) << 8;
> -    ret |= ref405ep_fpga_readb(opaque, addr + 3);
> -
> -    return ret;
> -}
> -
> -static void ref405ep_fpga_writel (void *opaque,
> -                                  hwaddr addr, uint32_t value)
> -{
> -    ref405ep_fpga_writeb(opaque, addr, (value >> 24) & 0xFF);
> -    ref405ep_fpga_writeb(opaque, addr + 1, (value >> 16) & 0xFF);
> -    ref405ep_fpga_writeb(opaque, addr + 2, (value >> 8) & 0xFF);
> -    ref405ep_fpga_writeb(opaque, addr + 3, value & 0xFF);
> -}
> -
>  static const MemoryRegionOps ref405ep_fpga_ops = {
> -    .old_mmio = {
> -        .read = {
> -            ref405ep_fpga_readb, ref405ep_fpga_readw, ref405ep_fpga_readl,
> -        },
> -        .write = {
> -            ref405ep_fpga_writeb, ref405ep_fpga_writew, ref405ep_fpga_writel,
> -        },
> -    },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .read = ref405ep_fpga_readb,
> +    .write = ref405ep_fpga_writeb,
> +    .impl.min_access_size = 1,
> +    .impl.max_access_size = 1,
> +    .valid.min_access_size = 1,
> +    .valid.max_access_size = 4,
> +    .endianness = DEVICE_BIG_ENDIAN,

Hopefully this is a good case to show the bug I'm having with
access_with_adjusted_size().

I agree with your change, so:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

However IMO little endian guest access is likely to fail.

The bug I'm having looks like, we have BE data is 'aabbccdd', I expect
16-bit access @2 return 'ccdd' but returns 'bbaa' (IIRC).

I used those cripple tests:
https://github.com/philmd/qemu/commit/671ce501a5301849a91384e6ba6f2f3affabcd0d#diff-da1e7a2e0582a05aa232a4baf37f4572

I'll try go get some free time to resurrect/rebase this branch.

Regards,

Phil.

>  };
>  
>  static void ref405ep_fpga_reset (void *opaque)
> 
