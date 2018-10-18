Received: from eggs.gnu.org ([2001:4830:134:3::10]:57091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDFTk-0002P2-7z
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gDFTg-0006xh-Vr
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:05:12 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gDFTg-0006uZ-H5
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 17:05:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id q1-v6so2288786wrs.4
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 14:05:08 -0700 (PDT)
References: <1538426899-17560-1-git-send-email-george.kennedy@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0910e008-d6ca-bc03-a66e-addbca592248@redhat.com>
Date: Thu, 18 Oct 2018 23:05:05 +0200
MIME-Version: 1.0
In-Reply-To: <1538426899-17560-1-git-send-email-george.kennedy@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] lsi: Reselection needed to remove pending
 commands from queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: George Kennedy <george.kennedy@oracle.com>, qemu-devel@nongnu.org

On 01/10/2018 22:48, George Kennedy wrote:
> Under heavy IO (e.g. fio) the queue is not checked frequently enough for
> pending commands. As a result some pending commands are timed out by the
> linux sym53c8xx driver, which sends SCSI Abort messages for the timed out
> commands. The SCSI Abort messages result in linux errors, which show up
> in /var/log/messages.
> 
> e.g.
> sd 0:0:3:0: [sdd] tag#33 ABORT operation started
> scsi target0:0:3: control msgout:
> 80 20 47 d
> sd 0:0:3:0: ABORT operation complete.
> scsi target0:0:4: message d sent on bad reselection
> 
> Add a deadline along with the command when it is added to the queue.
> When the current command completes, check the queue for pending commands
> that have exceeded the deadline and if so, simulate a Wait Reselect
> to handle the pending commands on the queue.
> 
> When a Wait Reselect is needed, intercept and save the current DMA Scripts
> Ptr (DSP) contents and load it instead with the pointer to the Reselection
> Scripts.  When Reselection has completed, restore the original DSP contents.
> 
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>

I don't understand the timeout.  Why can't the SCRIPTS part of the patch
just complete the WAIT RESELECT command in lsi_reselect?  This would
also avoid the SCRIPTS_LOAD_AND_STORE hack.

Likewise, storing the resel_dsp should be done in lsi_wait_reselect.
The way you are checking SCRIPTS_WAIT_RESELECT is specific to the Linux
firmware that has an offset of 0 in the Wait Reselect command.
s->resel_dsp should be set to s->dnad, which is already initialized
correctly where lsi_wait_reselect is called.

Thanks,


> ---
>  hw/scsi/lsi53c895a.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> index 996b406..1e38ceb 100644
> --- a/hw/scsi/lsi53c895a.c
> +++ b/hw/scsi/lsi53c895a.c
> @@ -198,6 +198,7 @@ typedef struct lsi_request {
>      uint32_t dma_len;
>      uint8_t *dma_buf;
>      uint32_t pending;
> +    uint64_t deadline;
>      int out;
>      QTAILQ_ENTRY(lsi_request) next;
>  } lsi_request;
> @@ -232,6 +233,9 @@ typedef struct {
>      int command_complete;
>      QTAILQ_HEAD(, lsi_request) queue;
>      lsi_request *current;
> +    int want_resel;     /* need resel to handle queued completed cmds */
> +    uint32_t resel_dsp; /* DMA Scripts Ptr (DSP) of reselection scsi scripts */
> +    uint32_t next_dsp;  /* if want_resel, will be loaded with above */
>  
>      uint32_t dsa;
>      uint32_t temp;
> @@ -310,6 +314,44 @@ static inline int lsi_irq_on_rsl(LSIState *s)
>  {
>      return (s->sien0 & LSI_SIST0_RSL) && (s->scid & LSI_SCID_RRE);
>  }
> +#ifdef DEBUG_LSI
> +static void showq(LSIState *s)
> +{
> +    lsi_request *p;
> +    int count = 0;
> +
> +    QTAILQ_FOREACH(p, &s->queue, next) {
> +        DPRINTF("%d: tag=%x, pending=%x, deadline=%lx\n",
> +            count++, p->tag, p->pending, p->deadline);
> +    }
> +}
> +
> +static int get_pending_count(LSIState *s)
> +{
> +    lsi_request *p;
> +    int count = 0;
> +
> +    QTAILQ_FOREACH(p, &s->queue, next) {
> +        if (p->pending) {
> +            count++;
> +        }
> +    }
> +    return count;
> +}
> +#endif
> +static int pending_past_deadline(LSIState *s)
> +{
> +    lsi_request *p;
> +
> +    QTAILQ_FOREACH(p, &s->queue, next) {
> +        if (p->pending) {
> +            if (qemu_clock_get_ns(QEMU_CLOCK_REALTIME) > p->deadline) {
> +                return 1;
> +            }
> +        }
> +    }
> +    return 0;
> +}
>  
>  static void lsi_soft_reset(LSIState *s)
>  {
> @@ -634,15 +676,22 @@ static void lsi_do_dma(LSIState *s, int out)
>      }
>  }
>  
> +/* Max time a completed command can be on the queue before Reselection needed */
> +#define LSI_DEADLINE    1000
>  
>  /* Add a command to the queue.  */
>  static void lsi_queue_command(LSIState *s)
>  {
>      lsi_request *p = s->current;
> +    uint64_t timeout_ms = LSI_DEADLINE;
>  
>      DPRINTF("Queueing tag=0x%x\n", p->tag);
>      assert(s->current != NULL);
>      assert(s->current->dma_len == 0);
> +
> +    p->deadline = qemu_clock_get_ns(QEMU_CLOCK_REALTIME) +
> +        timeout_ms * 1000000ULL;
> +
>      QTAILQ_INSERT_TAIL(&s->queue, s->current, next);
>      s->current = NULL;
>  
> @@ -668,6 +717,8 @@ static void lsi_reselect(LSIState *s, lsi_request *p)
>  
>      assert(s->current == NULL);
>      QTAILQ_REMOVE(&s->queue, p, next);
> +    DPRINTF("lsi_reselect: p->tag=%x, p->pending=%x, p->deadline=%lx\n",
> +        p->tag, p->pending, p->deadline);
>      s->current = p;
>  
>      id = (p->tag >> 8) & 0xf;
> @@ -775,6 +826,10 @@ static void lsi_command_complete(SCSIRequest *req, uint32_t status, size_t resid
>          lsi_request_free(s, s->current);
>          scsi_req_unref(req);
>      }
> +    if (pending_past_deadline(s)) {
> +        DPRINTF("lsi_command_complete: want_resel = 1\n");
> +        s->want_resel = 1;
> +    }
>      lsi_resume_script(s);
>  }
>  
> @@ -987,7 +1042,7 @@ static void lsi_do_msgout(LSIState *s)
>              s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
>              break;
>          case 0x22: /* ORDERED queue */
> -            BADF("ORDERED queue not implemented\n");
> +            DPRINTF("ORDERED queue not implemented\n");
>              s->select_tag |= lsi_get_msgbyte(s) | LSI_TAG_VALID;
>              break;
>          case 0x0d:
> @@ -1075,8 +1130,17 @@ static void lsi_memcpy(LSIState *s, uint32_t dest, uint32_t src, int count)
>  static void lsi_wait_reselect(LSIState *s)
>  {
>      lsi_request *p;
> +#ifdef DEBUG_LSI
> +    int pending_count = get_pending_count(s);
>  
> -    DPRINTF("Wait Reselect\n");
> +    if (pending_count) {
> +        DPRINTF("Wait Reselect, s->current=%p, pending_count=%d\n",
> +            s->current, pending_count);
> +        showq(s);
> +    }
> +#endif
> +    if (s->current)
> +        return;
>  
>      QTAILQ_FOREACH(p, &s->queue, next) {
>          if (p->pending) {
> @@ -1089,6 +1153,9 @@ static void lsi_wait_reselect(LSIState *s)
>      }
>  }
>  
> +#define SCRIPTS_LOAD_AND_STORE  0xe2340004
> +#define SCRIPTS_WAIT_RESELECT   0x50000000
> +
>  static void lsi_execute_script(LSIState *s)
>  {
>      PCIDevice *pci_dev = PCI_DEVICE(s);
> @@ -1096,10 +1163,16 @@ static void lsi_execute_script(LSIState *s)
>      uint32_t addr, addr_high;
>      int opcode;
>      int insn_processed = 0;
> +    uint32_t save_dsp = 0;
>  
>      s->istat1 |= LSI_ISTAT1_SRUN;
>  again:
>      insn_processed++;
> +    if (s->next_dsp) {
> +        save_dsp = s->dsp;
> +        s->dsp = s->next_dsp;
> +        DPRINTF("lsi_execute_script: setting up for wait_reselection...\n");
> +    }
>      insn = read_dword(s, s->dsp);
>      if (!insn) {
>          /* If we receive an empty opcode increment the DSP by 4 bytes
> @@ -1107,9 +1180,18 @@ again:
>          s->dsp += 4;
>          goto again;
>      }
> +    if (s->want_resel && s->resel_dsp && (insn == SCRIPTS_LOAD_AND_STORE)) {
> +        /* Reselection follows Load and Store */
> +        DPRINTF("lsi_execute_script: detects want_resel...\n");
> +        s->next_dsp = s->resel_dsp;
> +        s->want_resel = 0;
> +    }
>      addr = read_dword(s, s->dsp + 4);
>      addr_high = 0;
> -    DPRINTF("SCRIPTS dsp=%08x opcode %08x arg %08x\n", s->dsp, insn, addr);
> +    if ((insn == SCRIPTS_WAIT_RESELECT) && !s->resel_dsp) {
> +        s->resel_dsp = s->dsp;    /* save resel dsp for later use */
> +        DPRINTF("lsi_execute_script: s->resel_dsp=%x\n", s->resel_dsp);
> +    }
>      s->dsps = addr;
>      s->dcmd = insn >> 24;
>      s->dsp += 8;
> @@ -1273,7 +1355,13 @@ again:
>                  s->scntl1 &= ~LSI_SCNTL1_CON;
>                  break;
>              case 2: /* Wait Reselect */
> +                DPRINTF("Wait Reselect\n");
>                  if (!lsi_irq_on_rsl(s)) {
> +                    if (save_dsp) {
> +                        DPRINTF("Restore original s->dsp=%x\n", save_dsp);
> +                        s->dsp = save_dsp;
> +                        save_dsp = s->next_dsp = 0;
> +                    }
>                      lsi_wait_reselect(s);
>                  }
>                  break;
> 
