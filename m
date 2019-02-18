Received: from eggs.gnu.org ([209.51.188.92]:52710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqdw-0006d3-TK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:40:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqdu-0004wx-VD
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:40:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqdt-0004v8-HT
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:40:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id i12so20014595wrw.0
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:39:57 -0800 (PST)
References: <20190218175529.11237-1-svens@stackframe.org>
	<20190218175529.11237-2-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <861e47de-978b-b48c-d144-e50040d45bf4@redhat.com>
Date: Mon, 18 Feb 2019 22:39:54 +0100
MIME-Version: 1.0
In-Reply-To: <20190218175529.11237-2-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] lsi: use ldn_le_p()/stn_le_p()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>, deller@gmx.de

Hi Sven,

On 2/18/19 6:55 PM, Sven Schnelle wrote:
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/scsi/lsi53c895a.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index c493e3c4c7..93c4434bfb 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -2078,29 +2078,14 @@ static void lsi_ram_write(void *opaque, hwaddr addr,
>                            uint64_t val, unsigned size)
>  {
>      LSIState *s = opaque;
> -    uint32_t newval;
> -    uint32_t mask;
> -    int shift;
> -
> -    newval = s->script_ram[addr >> 2];
> -    shift = (addr & 3) * 8;
> -    mask = ((uint64_t)1 << (size * 8)) - 1;
> -    newval &= ~(mask << shift);
> -    newval |= val << shift;
> -    s->script_ram[addr >> 2] = newval;
> +    stn_le_p(((void*)s->script_ram) + addr, size, val);

If you want to do pointer arithmetic, it is safer to cast to a uintptr_t.
But since you update all the places that use script_ram[], it seems
pointless to keep it as an array of uint32_t. We can simply convert it
to an array of char.

Your patch looks sane otherwise,

Thanks,

Phil.

>  }
>  
>  static uint64_t lsi_ram_read(void *opaque, hwaddr addr,
>                               unsigned size)
>  {
>      LSIState *s = opaque;
> -    uint32_t val;
> -    uint32_t mask;
> -
> -    val = s->script_ram[addr >> 2];
> -    mask = ((uint64_t)1 << (size * 8)) - 1;
> -    val >>= (addr & 3) * 8;
> -    return val & mask;
> +    return ldn_le_p(((void *)s->script_ram) + addr, size);
>  }
>  
>  static const MemoryRegionOps lsi_ram_ops = {
> 
