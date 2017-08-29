Received: from eggs.gnu.org ([2001:4830:134:3::10]:43845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmot9-0007Op-91
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dmot5-0003KP-AF
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 18:21:39 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170829204934.9039-1-jsnow@redhat.com>
	<20170829204934.9039-4-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9b08ca85-7411-3c39-d416-5fd845b538de@amsat.org>
Date: Tue, 29 Aug 2017 19:20:47 -0300
MIME-Version: 1.0
In-Reply-To: <20170829204934.9039-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/9] IDE: add tracing for data ports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, qemu-devel@nongnu.org

On 08/29/2017 05:49 PM, John Snow wrote:
> To be used sparingly, but still interesting in the case of small
> firmwares designed to reproduce bugs in QEMU IDE.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/ide/core.c       | 12 +++++++++++-
>   hw/ide/trace-events |  5 +++++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index cb250e6..82a19b1 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -2259,6 +2259,8 @@ void ide_data_writew(void *opaque, uint32_t addr, uint32_t val)
>       IDEState *s = idebus_active_if(bus);
>       uint8_t *p;
>   
> +    trace_ide_data_writew(addr, val, bus, s);
> +
>       /* PIO data access allowed only when DRQ bit is set. The result of a write
>        * during PIO out is indeterminate, just ignore it. */
>       if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
> @@ -2304,6 +2306,8 @@ uint32_t ide_data_readw(void *opaque, uint32_t addr)
>           s->status &= ~DRQ_STAT;
>           s->end_transfer_func(s);
>       }
> +
> +    trace_ide_data_readw(addr, ret, bus, s);
>       return ret;
>   }
>   
> @@ -2313,6 +2317,8 @@ void ide_data_writel(void *opaque, uint32_t addr, uint32_t val)
>       IDEState *s = idebus_active_if(bus);
>       uint8_t *p;
>   
> +    trace_ide_data_writel(addr, val, bus, s);
> +
>       /* PIO data access allowed only when DRQ bit is set. The result of a write
>        * during PIO out is indeterminate, just ignore it. */
>       if (!(s->status & DRQ_STAT) || ide_is_pio_out(s)) {
> @@ -2343,7 +2349,8 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr)
>       /* PIO data access allowed only when DRQ bit is set. The result of a read
>        * during PIO in is indeterminate, return 0 and don't move forward. */
>       if (!(s->status & DRQ_STAT) || !ide_is_pio_out(s)) {
> -        return 0;
> +        ret = 0;
> +        goto out;
>       }
>   
>       p = s->data_ptr;
> @@ -2358,6 +2365,9 @@ uint32_t ide_data_readl(void *opaque, uint32_t addr)
>           s->status &= ~DRQ_STAT;
>           s->end_transfer_func(s);
>       }
> +
> +out:
> +    trace_ide_data_readl(addr, ret, bus, s);
>       return ret;
>   }
>   
> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
> index bff8f39..17bc6f1 100644
> --- a/hw/ide/trace-events
> +++ b/hw/ide/trace-events
> @@ -6,6 +6,11 @@ ide_ioport_read(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s
>   ide_ioport_write(uint32_t addr, const char *reg, uint32_t val, void *bus, void *s) "IDE PIO wr @ 0x%"PRIx32" (%s); val 0x%02"PRIx32"; bus %p IDEState %p"
>   ide_status_read(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO rd @ 0x%"PRIx32" (Alt Status); val 0x%02"PRIx32"; bus %p; IDEState %p"
>   ide_cmd_write(uint32_t addr, uint32_t val, void *bus)                              "IDE PIO wr @ 0x%"PRIx32" (Device Control); val 0x%02"PRIx32"; bus %p"
> +# Warning: verbose
> +ide_data_readw(uint32_t addr, uint32_t val, void *bus, void *s)                    "IDE PIO rd @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
> +ide_data_writew(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Word); val 0x%04"PRIx32"; bus %p; IDEState %p"
> +ide_data_readl(uint32_t addr, uint32_t val, void *bus, void *s)                    "IDE PIO rd @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus %p; IDEState %p"
> +ide_data_writel(uint32_t addr, uint32_t val, void *bus, void *s)                   "IDE PIO wr @ 0x%"PRIx32" (Data: Long); val 0x%08"PRIx32"; bus %p; IDEState %p"
>   # misc
>   ide_exec_cmd(void *bus, void *state, uint32_t cmd) "IDE exec cmd: bus %p; state %p; cmd 0x%02x"
>   ide_cancel_dma_sync_buffered(void *fn, void *req) "invoking cb %p of buffered request %p with -ECANCELED"
> 
