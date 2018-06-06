Received: from eggs.gnu.org ([2001:4830:134:3::10]:45600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeL4-0000MQ-Gq
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQeL0-0002q0-IM
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 15:43:22 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180606190955.20845-1-jsnow@redhat.com>
	<20180606190955.20845-6-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <378c5b8c-ab60-0130-3213-5e3018c4606b@amsat.org>
Date: Wed, 6 Jun 2018 16:43:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180606190955.20845-6-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/7] ide: make ide_transfer_stop idempotent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 06/06/2018 04:09 PM, John Snow wrote:
> From: Paolo Bonzini <pbonzini@redhat.com>
> 
> There is code checking s->end_transfer_func and it was not taught about
> ide_transfer_cancel.  We can just use ide_transfer_stop because
> s->end_transfer_func is only ever called in the DRQ phase.
> 
> ide_transfer_cancel can then be removed, since it would just be
> calling ide_transfer_halt.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/ide/core.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/ide/core.c b/hw/ide/core.c
> index 54799ea6fb..9c4864ae54 100644
> --- a/hw/ide/core.c
> +++ b/hw/ide/core.c
> @@ -547,10 +547,9 @@ static void ide_cmd_done(IDEState *s)
>      }
>  }
>  
> -static void ide_transfer_halt(IDEState *s,
> -                              void(*end_transfer_func)(IDEState *))
> +static void ide_transfer_halt(IDEState *s)
>  {
> -    s->end_transfer_func = end_transfer_func;
> +    s->end_transfer_func = ide_transfer_stop;
>      s->data_ptr = s->io_buffer;
>      s->data_end = s->io_buffer;
>      s->status &= ~DRQ_STAT;
> @@ -558,15 +557,10 @@ static void ide_transfer_halt(IDEState *s,
>  
>  void ide_transfer_stop(IDEState *s)
>  {
> -    ide_transfer_halt(s, ide_transfer_stop);
> +    ide_transfer_halt(s);
>      ide_cmd_done(s);
>  }
>  
> -static void ide_transfer_cancel(IDEState *s)
> -{
> -    ide_transfer_halt(s, ide_transfer_cancel);
> -}
> -
>  int64_t ide_get_sector(IDEState *s)
>  {
>      int64_t sector_num;
> @@ -1361,7 +1355,7 @@ static bool cmd_nop(IDEState *s, uint8_t cmd)
>  static bool cmd_device_reset(IDEState *s, uint8_t cmd)
>  {
>      /* Halt PIO (in the DRQ phase), then DMA */
> -    ide_transfer_cancel(s);
> +    ide_transfer_halt(s);
>      ide_cancel_dma_sync(s);
>  
>      /* Reset any PIO commands, reset signature, etc */
> 
