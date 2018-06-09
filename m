Received: from eggs.gnu.org ([2001:4830:134:3::10]:59752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fRiYJ-0004rJ-P6
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 14:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1fRiYI-00050k-PT
	for qemu-devel@nongnu.org; Sat, 09 Jun 2018 14:25:27 -0400
References: <20180608200558.386-1-laurent@vivier.eu>
	<20180608200558.386-12-laurent@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <66dab148-ed2f-dbf8-3b6f-02938f9c5ae7@tuxfamily.org>
Date: Sat, 9 Jun 2018 20:25:18 +0200
MIME-Version: 1.0
In-Reply-To: <20180608200558.386-12-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 11/13] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Jason Wang <jasowang@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Aurelien Jarno <aurelien@aurel32.net>

On 08.06.2018 22:05, Laurent Vivier wrote:
> This is needed by Quadra 800, this card can run on little-endian
> or big-endian bus.
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  hw/net/dp8393x.c | 101 ++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 70 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
> index ef5f1eb94f..5061474e6b 100644
> --- a/hw/net/dp8393x.c
> +++ b/hw/net/dp8393x.c
> @@ -150,6 +150,7 @@ typedef struct dp8393xState {
>  
>      /* Hardware */
>      uint8_t it_shift;
> +    bool big_endian;
>      qemu_irq irq;
>  #ifdef DEBUG_SONIC
>      int irq_level;
> @@ -174,6 +175,12 @@ typedef struct dp8393xState {
>      AddressSpace as;
>  } dp8393xState;
>  
> +#ifdef HOST_WORDS_BIGENDIAN
> +static const bool host_big_endian = true;
> +#else
> +static const bool host_big_endian = false;
> +#endif
> +
>  /* Accessor functions for values which are formed by
>   * concatenating two 16 bit device registers. By putting these
>   * in their own functions with a uint32_t return type we avoid the
> @@ -220,6 +227,36 @@ static uint32_t dp8393x_wt(dp8393xState *s)
>      return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
>  }
>  
> +static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
> +                            int offset)
> +{
> +    uint16_t val;
> +
> +    if (s->big_endian) {
> +        val = base[offset * width + width - 1];
> +    } else {
> +        val = base[offset * width];
> +    }
> +    if (s->big_endian != host_big_endian) {
> +        val = bswap16(val);
> +    }
> +    return val;
> +}

Could you maybe write that like this instead:

{
    uint16_t val;

    if (s->big_endian) {
        val = base[offset * width + width - 1];
        val = be16_to_cpu(val);
    } else {
        val = base[offset * width];
        val = le16_to_cpu(val);
    }
    return val;
}

?
... then you don't need that ugly host_big_endian variable anymore.

 Thomas
