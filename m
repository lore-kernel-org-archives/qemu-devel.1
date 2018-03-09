Received: from eggs.gnu.org ([2001:4830:134:3::10]:39711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1euL6t-0004Fj-5x
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1euL6r-0001c0-NC
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:11 -0500
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-8-git-send-email-eric.auger@redhat.com>
	<CAFEAcA9d30THtJPihHAm1dRRLr8a2kg2UqMmxJv-p1Zvjj2PgA@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <26abf1b6-5748-1aa7-7fc2-cdfd18bad7f0@redhat.com>
Date: Fri, 9 Mar 2018 17:42:57 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9d30THtJPihHAm1dRRLr8a2kg2UqMmxJv-p1Zvjj2PgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 07/14] hw/arm/smmuv3: Implement MMIO
 write operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

Hi Peter,

On 08/03/18 19:37, Peter Maydell wrote:
> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>> Now we have relevant helpers for queue and irq
>> management, let's implement MMIO write operations.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v7 -> v8:
>> - precise in the commit message invalidation commands
>>   are not yet treated.
>> - use new queue helpers
>> - do not decode unhandled commands at this stage
>> ---
>>  hw/arm/smmuv3-internal.h |  24 +++++++---
>>  hw/arm/smmuv3.c          | 111 +++++++++++++++++++++++++++++++++++++++++++++--
>>  hw/arm/trace-events      |   6 +++
>>  3 files changed, 132 insertions(+), 9 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index c0771ce..5af97ae 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -152,6 +152,25 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
>>      return extract64(r, offset << 3, 32);
>>  }
>>
>> +static inline void smmu_write64(uint64_t *r, unsigned offset,
>> +                                unsigned size, uint64_t value)
>> +{
>> +    if (size == 8 && !offset) {
>> +        *r  = value;
>> +    }
>> +
>> +    /* 32 bit access */
>> +
>> +    if (offset && offset != 4)  {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "SMMUv3 MMIO write: bad offset/size %u/%u\n",
>> +                      offset, size);
>> +        return ;
>> +    }
>> +
>> +    *r = deposit64(*r, offset << 3, 32, value);
> 
> Similar remarks apply to this helper as to smmu_read64 in the earlier patch.
removed
> 
>> +}
>> +
>>  /* Interrupts */
>>
>>  #define smmuv3_eventq_irq_enabled(s)                   \
>> @@ -159,9 +178,6 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
>>  #define smmuv3_gerror_irq_enabled(s)                  \
>>      (FIELD_EX32(s->irq_ctrl, IRQ_CTRL, GERROR_IRQEN))
>>
>> -void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
>> -void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
>> -
>>  /* Queue Handling */
>>
>>  #define LOG2SIZE(q)        extract64((q)->base, 0, 5)
>> @@ -310,6 +326,4 @@ enum { /* Command completion notification */
>>              addr;                                             \
>>          })
>>
>> -int smmuv3_cmdq_consume(SMMUv3State *s);
>> -
>>  #endif
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 0b57215..fcfdbb0 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -37,7 +37,8 @@
>>   * @irq: irq type
>>   * @gerror_mask: mask of gerrors to toggle (relevant if @irq is GERROR)
>>   */
>> -void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
>> +static void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq,
>> +                               uint32_t gerror_mask)
>>  {
>>
>>      bool pulse = false;
>> @@ -75,7 +76,7 @@ void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask)
>>      }
>>  }
>>
>> -void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>> +static void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>>  {
>>      uint32_t pending = s->gerror ^ s->gerrorn;
>>      uint32_t toggled = s->gerrorn ^ new_gerrorn;
>> @@ -199,7 +200,7 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>      s->sid_split = 0;
>>  }
>>
>> -int smmuv3_cmdq_consume(SMMUv3State *s)
>> +static int smmuv3_cmdq_consume(SMMUv3State *s)
>>  {
>>      SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>>      SMMUQueue *q = &s->cmdq;
>> @@ -298,7 +299,109 @@ int smmuv3_cmdq_consume(SMMUv3State *s)
>>  static void smmu_write_mmio(void *opaque, hwaddr addr,
>>                              uint64_t val, unsigned size)
>>  {
>> -    /* not yet implemented */
>> +    SMMUState *sys = opaque;
>> +    SMMUv3State *s = ARM_SMMUV3(sys);
>> +
>> +    /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases */
>> +    addr &= ~0x10000;
>> +
>> +    if (size != 4 && size != 8) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "SMMUv3 MMIO write: bad size %u\n", size);
>> +    }
> 
> As with read, this can never happen so you don't need to check for it.
> 
> As with read, probably better to explicitly whitelist the 64-bit
> accessible offsets, and LOG_GUEST_ERROR and write-ignore the others.
done
> 
>> +
>> +    trace_smmuv3_write_mmio(addr, val, size);
>> +
>> +    switch (addr) {
>> +    case A_CR0:
>> +        s->cr[0] = val;
>> +        s->cr0ack = val;
> 
> Spec says "reserved fields in SMMU_CR0 are not reflected in SMMU_CR0ACK",
> so you probably need to mask those out.
OK
> 
>> +        /* in case the command queue has been enabled */
>> +        smmuv3_cmdq_consume(s);
>> +        return;
>> +    case A_CR1:
>> +        s->cr[1] = val;
>> +        return;
>> +    case A_CR2:
>> +        s->cr[2] = val;
>> +        return;
>> +    case A_IRQ_CTRL:
>> +        s->irq_ctrl = val;
>> +        return;
>> +    case A_GERRORN:
>> +        smmuv3_write_gerrorn(s, val);
>> +        /*
>> +         * By acknowledging the CMDQ_ERR, SW may notify cmds can
>> +         * be processed again
>> +         */
>> +        smmuv3_cmdq_consume(s);
>> +        return;
>> +    case A_GERROR_IRQ_CFG0: /* 64b */
>> +        smmu_write64(&s->gerror_irq_cfg0, 0, size, val);
>> +        return;
>> +    case A_GERROR_IRQ_CFG0 + 4:
>> +        smmu_write64(&s->gerror_irq_cfg0, 4, size, val);
>> +        return;
>> +    case A_GERROR_IRQ_CFG1:
>> +        s->gerror_irq_cfg1 = val;
>> +        return;
>> +    case A_GERROR_IRQ_CFG2:
>> +        s->gerror_irq_cfg2 = val;
>> +        return;
>> +    case A_STRTAB_BASE: /* 64b */
>> +        smmu_write64(&s->strtab_base, 0, size, val);
>> +        return;
>> +    case A_STRTAB_BASE + 4:
>> +        smmu_write64(&s->strtab_base, 4, size, val);
>> +        return;
>> +    case A_STRTAB_BASE_CFG:
>> +        s->strtab_base_cfg = val;
>> +        if (FIELD_EX32(val, STRTAB_BASE_CFG, FMT) == 1) {
>> +            s->sid_split = FIELD_EX32(val, STRTAB_BASE_CFG, SPLIT);
>> +            s->features |= SMMU_FEATURE_2LVL_STE;
>> +        }
>> +        return;
>> +    case A_CMDQ_BASE: /* 64b */
>> +        smmu_write64(&s->cmdq.base, 0, size, val);
>> +        return;
>> +    case A_CMDQ_BASE + 4: /* 64b */
>> +        smmu_write64(&s->cmdq.base, 4, size, val);
>> +        return;
>> +    case A_CMDQ_PROD:
>> +        s->cmdq.prod = val;
>> +        smmuv3_cmdq_consume(s);
>> +        return;
>> +    case A_CMDQ_CONS:
>> +        s->cmdq.cons = val;
>> +        return;
>> +    case A_EVENTQ_BASE: /* 64b */
>> +        smmu_write64(&s->eventq.base, 0, size, val);
>> +        return;
>> +    case A_EVENTQ_BASE + 4:
>> +        smmu_write64(&s->eventq.base, 4, size, val);
>> +        return;
>> +    case A_EVENTQ_PROD:
>> +        s->eventq.prod = val;
>> +        return;
>> +    case A_EVENTQ_CONS:
>> +        s->eventq.cons = val;
>> +        return;
>> +    case A_EVENTQ_IRQ_CFG0: /* 64b */
>> +        s->eventq.prod = val;
>> +        smmu_write64(&s->eventq_irq_cfg0, 0, size, val);
>> +        return;
>> +    case A_EVENTQ_IRQ_CFG0 + 4:
>> +        smmu_write64(&s->eventq_irq_cfg0, 4, size, val);
>> +        return;
>> +    case A_EVENTQ_IRQ_CFG1:
>> +        s->eventq_irq_cfg1 = val;
>> +        return;
>> +    case A_EVENTQ_IRQ_CFG2:
>> +        s->eventq_irq_cfg2 = val;
>> +        return;
>> +    default:
>> +        error_report("%s unhandled access at 0x%"PRIx64, __func__, addr);
> 
> Tracepoint or LOG_GUEST_ERROR, not error_report(), please.
OK

Thanks

Eric
> 
>> +    }
>>  }
>>
>>  static uint64_t smmu_read_mmio(void *opaque, hwaddr addr, unsigned size)
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index 1c5105d..ed5dce0 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -22,3 +22,9 @@ smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
>>  smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>>  smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>>  smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>> +smmuv3_update(bool is_empty, uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "q empty:%d prod:%d cons:%d p.wrap:%d p.cons:%d"
>> +smmuv3_update_check_cmd(int error) "cmdq not enabled or error :0x%x"
>> +smmuv3_write_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" val:0x%"PRIx64" size: 0x%x"
>> +smmuv3_write_mmio_idr(hwaddr addr, uint64_t val) "write to RO/Unimpl reg 0x%lx val64:0x%lx"
>> +smmuv3_write_mmio_evtq_cons_bef_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "Before clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
>> +smmuv3_write_mmio_evtq_cons_after_clear(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "after clearing interrupt prod:0x%x cons:0x%x prod.w:%d cons.w:%d"
> 
> 
> thanks
> -- PMM
> 
