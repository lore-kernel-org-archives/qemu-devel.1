Received: from eggs.gnu.org ([209.51.188.92]:56469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0wqT-0003PB-Qa
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:18:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0wqS-0000KD-Qf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:18:05 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h0wqS-0000J4-IB
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 18:18:04 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so795245wmi.1
	for <qemu-devel@nongnu.org>; Mon, 04 Mar 2019 15:18:04 -0800 (PST)
References: <20190304180920.21534-1-svens@stackframe.org>
	<20190304180920.21534-2-svens@stackframe.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2951e9ec-41c9-14cb-423c-4292c27965aa@redhat.com>
Date: Tue, 5 Mar 2019 00:18:01 +0100
MIME-Version: 1.0
In-Reply-To: <20190304180920.21534-2-svens@stackframe.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] lsi: use enum type for s->waiting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sven Schnelle <svens@stackframe.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 3/4/19 7:09 PM, Sven Schnelle wrote:
> This makes the code easier to read - no functional change.
> 
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
>  hw/scsi/lsi53c895a.c | 42 +++++++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 19 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 6d280f8b77..fb9c6db4b2 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -194,6 +194,13 @@ typedef struct lsi_request {
>      QTAILQ_ENTRY(lsi_request) next;
>  } lsi_request;
>  
> +enum {
> +    LSI_NOWAIT,

You forgot the comment for NOWAIT.

> +    LSI_WAIT_RESELECT, /* Wait Reselect instruction has been issued */
> +    LSI_DMA_SCRIPTS, /* processing DMA from lsi_execute_script */
> +    LSI_DMA_IN_PROGRESS, /* DMA operation is in progress */
> +};
> +
>  typedef struct {
>      /*< private >*/
>      PCIDevice parent_obj;
> @@ -212,10 +219,6 @@ typedef struct {
>      int msg_action;
>      int msg_len;
>      uint8_t msg[LSI_MAX_MSGIN_LEN];
> -    /* 0 if SCRIPTS are running or stopped.
> -     * 1 if a Wait Reselect instruction has been issued.
> -     * 2 if processing DMA from lsi_execute_script.
> -     * 3 if a DMA operation is in progress.  */
>      int waiting;

When a field is not used by migration, you can declare it as enum:

       enum {
           LSI_NOWAIT = 0, /* SCRIPTS are running or stopped */
           LSI_WAIT_RESELECT = 1, /* Wait Reselect instruction has been
issued */
           LSI_DMA_SCRIPTS = 2, /* processing DMA from lsi_execute_script */
           LSI_DMA_IN_PROGRESS = 3, /* DMA operation is in progress */
       } waiting;

This gives hints to the compiler about values to check.

>      SCSIBus bus;
>      int current_lun;
> @@ -322,7 +325,7 @@ static void lsi_soft_reset(LSIState *s)
>  
>      s->msg_action = 0;
>      s->msg_len = 0;
> -    s->waiting = 0;
> +    s->waiting = LSI_NOWAIT;
>      s->dsa = 0;
>      s->dnad = 0;
>      s->dbc = 0;
> @@ -564,10 +567,10 @@ static void lsi_bad_phase(LSIState *s, int out, int new_phase)
>  static void lsi_resume_script(LSIState *s)
>  {
>      if (s->waiting != 2) {
> -        s->waiting = 0;
> +        s->waiting = LSI_NOWAIT;
>          lsi_execute_script(s);
>      } else {
> -        s->waiting = 0;
> +        s->waiting = LSI_NOWAIT;
>      }
>  }
>  
> @@ -744,7 +747,7 @@ static int lsi_queue_req(LSIState *s, SCSIRequest *req, uint32_t len)
>         Since no interrupt stacking is implemented in the emulation, it
>         is also required that there are no pending interrupts waiting
>         for service from the device driver. */
> -    if (s->waiting == 1 ||
> +    if (s->waiting == LSI_WAIT_RESELECT ||
>          (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON) &&
>           !(s->istat0 & (LSI_ISTAT0_SIP | LSI_ISTAT0_DIP)))) {
>          /* Reselect device.  */
> @@ -789,7 +792,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
>      int out;
>  
>      assert(req->hba_private);
> -    if (s->waiting == 1 || req->hba_private != s->current ||
> +    if (s->waiting == LSI_WAIT_RESELECT || req->hba_private != s->current ||
>          (lsi_irq_on_rsl(s) && !(s->scntl1 & LSI_SCNTL1_CON))) {
>          if (lsi_queue_req(s, req, len)) {
>              return;
> @@ -803,7 +806,7 @@ static void lsi_transfer_data(SCSIRequest *req, uint32_t len)
>      s->current->dma_len = len;
>      s->command_complete = 1;
>      if (s->waiting) {
> -        if (s->waiting == 1 || s->dbc == 0) {
> +        if (s->waiting == LSI_WAIT_RESELECT || s->dbc == 0) {
>              lsi_resume_script(s);
>          } else {
>              lsi_do_dma(s, out);
> @@ -1093,7 +1096,7 @@ static void lsi_wait_reselect(LSIState *s)
>          lsi_reselect(s, p);
>      }
>      if (s->current == NULL) {
> -        s->waiting = 1;
> +        s->waiting = LSI_WAIT_RESELECT;
>      }
>  }
>  
> @@ -1202,16 +1205,16 @@ again:
>          s->dnad64 = addr_high;
>          switch (s->sstat1 & 0x7) {
>          case PHASE_DO:
> -            s->waiting = 2;
> +            s->waiting = LSI_DMA_SCRIPTS;
>              lsi_do_dma(s, 1);
>              if (s->waiting)
> -                s->waiting = 3;
> +                s->waiting = LSI_DMA_IN_PROGRESS;
>              break;
>          case PHASE_DI:
> -            s->waiting = 2;
> +            s->waiting = LSI_DMA_SCRIPTS;
>              lsi_do_dma(s, 0);
>              if (s->waiting)
> -                s->waiting = 3;
> +                s->waiting = LSI_DMA_IN_PROGRESS;
>              break;
>          case PHASE_CMD:
>              lsi_do_command(s);
> @@ -1278,6 +1281,7 @@ again:
>                  }
>                  s->sbcl |= LSI_SBCL_BSY;
>                  lsi_set_phase(s, PHASE_MO);
> +                s->waiting = LSI_NOWAIT;
>                  break;
>              case 1: /* Disconnect */
>                  trace_lsi_execute_script_io_disconnect();
> @@ -1542,7 +1546,7 @@ again:
>              }
>          }
>      }
> -    if (insn_processed > 10000 && !s->waiting) {
> +    if (insn_processed > 10000 && s->waiting == LSI_NOWAIT) {
>          /* Some windows drivers make the device spin waiting for a memory
>             location to change.  If we have been executed a lot of code then
>             assume this is the case and force an unexpected device disconnect.
> @@ -1554,7 +1558,7 @@ again:
>          }
>          lsi_script_scsi_interrupt(s, LSI_SIST0_UDC, 0);
>          lsi_disconnect(s);
> -    } else if (s->istat1 & LSI_ISTAT1_SRUN && !s->waiting) {
> +    } else if (s->istat1 & LSI_ISTAT1_SRUN && s->waiting == LSI_NOWAIT) {
>          if (s->dcntl & LSI_DCNTL_SSM) {
>              lsi_script_dma_interrupt(s, LSI_DSTAT_SSI);
>          } else {
> @@ -1885,9 +1889,9 @@ static void lsi_reg_writeb(LSIState *s, int offset, uint8_t val)
>              s->istat0 &= ~LSI_ISTAT0_INTF;
>              lsi_update_irq(s);
>          }
> -        if (s->waiting == 1 && val & LSI_ISTAT0_SIGP) {
> +        if (s->waiting == LSI_WAIT_RESELECT && val & LSI_ISTAT0_SIGP) {
>              trace_lsi_awoken();
> -            s->waiting = 0;
> +            s->waiting = LSI_NOWAIT;
>              s->dsp = s->dnad;
>              lsi_execute_script(s);
>          }
> 
