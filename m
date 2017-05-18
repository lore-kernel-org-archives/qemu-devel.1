Received: from eggs.gnu.org ([2001:4830:134:3::10]:39595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBIHy-00011E-Dh
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:04:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dBIHx-0003zo-7K
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dBIHw-0003zP-V9
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:04:09 -0400
Date: Thu, 18 May 2017 11:04:04 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170518100403.GB2079@work-vm>
References: <1495021572-20852-1-git-send-email-sameeh@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495021572-20852-1-git-send-email-sameeh@daynix.com>
Subject: Re: [Qemu-devel] [PATCH] e1000e: Fix a bug where guest hangs upon
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>

* Sameeh Jubran (sameeh@daynix.com) wrote:
> The bug was caused by the "receive overrun" (bit #6 of the ICR register) interrupt
> which would be triggered post migration in a heavy traffic environment. Even though the
> "receive overrun" bit (#6) is masked out by the IMS register (refer to the log below)
> the driver still receives an interrupt as the "receive overrun" bit (#6) causes the
> "Other" - bit #24 of the ICR register - bit to be set as documented below. The driver
> handles the interrupt and clears the "Other" bit (#24) but doesn't clear the
> "receive overrun" bit (#6) which leads to an infinite loop. Apparently the Windows
> driver expects that the "receive overrun" bit and other ones - documented below - to be
> cleared when the "Other" bit (#24) is cleared.
> 
> So to sum that up:
> 1. Bit #6 of the ICR register is set by heavy traffic
> 2. As a results of setting bit #6, bit #24 is set
> 3. The driver receives an interrupt for bit 24 (it doesn't receieve an interrupt for bit #6 as it is masked out by IMS)
> 4. The driver handles and clears the interrupt of bit #24
> 5. Bit #6 is still set.
> 6. 2 happens all over again
> 
> The Interrupt Cause Read - ICR register:
> 
> The ICR has the "Other" bit - bit #24 - that is set when one or more of the following
> ICR register's bits are set:
> 
> LSC - bit #2, RXO - bit #6, MDAC - bit #9, SRPD - bit #16, ACK - bit #17, MNG - bit #18
> 
> Log sample of the storm:
> 
> 27563@1494850819.411877:e1000e_irq_pending_interrupts ICR PENDING: 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
> 27563@1494850819.411900:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x815000c2, IMS: 0xa00004)
> 27563@1494850819.411915:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x815000c2, IMS: 0xa00004)
> 27563@1494850819.412380:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x815000c2, IMS: 0xa00004)
> 27563@1494850819.412395:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x815000c2, IMS: 0xa00004)
> 27563@1494850819.412436:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x815000c2, IMS: 0xa00004)
> 27563@1494850819.412441:e1000e_irq_pending_interrupts ICR PENDING: 0x0 (ICR: 0x815000c2, IMS: 0xa00004)
> 27563@1494850819.412998:e1000e_irq_pending_interrupts ICR PENDING: 0x1000000 (ICR: 0x815000c2, IMS: 0x1a00004)
> 
> This commit solves:
> https://bugzilla.redhat.com/show_bug.cgi?id=1447935
> https://bugzilla.redhat.com/show_bug.cgi?id=1449490
> 
> Signed-off-by: Sameeh Jubran <sjubran@redhat.com>

Thanks, I tested this with our downstream and it does
fix the reproducer for 1447935 for me, so:


Tested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Dave

> ---
>  hw/net/e1000e_core.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
> index 28c5be1..8174b53 100644
> --- a/hw/net/e1000e_core.c
> +++ b/hw/net/e1000e_core.c
> @@ -2454,14 +2454,17 @@ e1000e_set_ics(E1000ECore *core, int index, uint32_t val)
>  static void
>  e1000e_set_icr(E1000ECore *core, int index, uint32_t val)
>  {
> +    uint32_t icr = 0;
>      if ((core->mac[ICR] & E1000_ICR_ASSERTED) &&
>          (core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>          trace_e1000e_irq_icr_process_iame();
>          e1000e_clear_ims_bits(core, core->mac[IAM]);
>      }
>  
> -    trace_e1000e_irq_icr_write(val, core->mac[ICR], core->mac[ICR] & ~val);
> -    core->mac[ICR] &= ~val;
> +    icr = core->mac[ICR] & ~val;
> +    icr = (val & E1000_ICR_OTHER) ? (icr & ~E1000_ICR_OTHER_CAUSES) : icr;
> +    trace_e1000e_irq_icr_write(val, core->mac[ICR], icr);
> +    core->mac[ICR] = icr;
>      e1000e_update_interrupt_state(core);
>  }
>  
> -- 
> 2.8.1.185.gdc0db2c
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
