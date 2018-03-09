Received: from eggs.gnu.org ([2001:4830:134:3::10]:39936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1euL75-0004Rl-Im
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1euL73-0001ka-Bm
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:43:23 -0500
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-7-git-send-email-eric.auger@redhat.com>
	<CAFEAcA_KBtbNiRUV5=nFVj=y8Sv7moNJSs-WVEYv6mdtzDaQ3w@mail.gmail.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <292a247d-0575-a6d0-f42e-cf042fd42062@redhat.com>
Date: Fri, 9 Mar 2018 17:43:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_KBtbNiRUV5=nFVj=y8Sv7moNJSs-WVEYv6mdtzDaQ3w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 06/14] hw/arm/smmuv3: Queue helpers
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

On 08/03/18 19:28, Peter Maydell wrote:
> On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
>> We introduce helpers to read/write into the command and event
>> circular queues.
>>
>> smmuv3_write_eventq and smmuv3_cmq_consume will become static
>> in subsequent patches.
>>
>> Invalidation commands are not yet dealt with. We do not cache
>> data that need to be invalidated. This will change with vhost
>> integration.
>>
>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>
>> ---
>>
>> v8 -> v9:
>> - fix CMD_SSID & CMD_ADDR + some renamings
>> - do cons increment after the execution of the command
>> - add Q_INCONSISTENT()
>>
>> v7 -> v8
>> - use address_space_rw
>> - helpers inspired from spec
>> ---
>>  hw/arm/smmuv3-internal.h | 150 +++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/smmuv3.c          | 162 +++++++++++++++++++++++++++++++++++++++++++++++
>>  hw/arm/trace-events      |   4 ++
>>  3 files changed, 316 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
>> index 40b39a1..c0771ce 100644
>> --- a/hw/arm/smmuv3-internal.h
>> +++ b/hw/arm/smmuv3-internal.h
>> @@ -162,4 +162,154 @@ static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
>>  void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
>>  void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
>>
>> +/* Queue Handling */
>> +
>> +#define LOG2SIZE(q)        extract64((q)->base, 0, 5)
>> +#define BASE(q)            ((q)->base & SMMU_BASE_ADDR_MASK)
renamed Q_LOG2SIZE and Q_BASE respectively
> 
> These are both very generic names for things in header files.
> 
> Looking at the required behaviour of the *_BASE registers,
> if the LOG2SIZE field is written to a value larger than the maximum,
> it is supposed to read back as the value written but must behave
> as if it was set to the maximum. That suggests to me that your
> SMMUQueue struct should have a "log2size" field which is set when
> the guest writes to *_BASE (which is where you can cap it to the
> max value).
done
> 
>> +#define WRAP_MASK(q)       (1 << LOG2SIZE(q))
>> +#define INDEX_MASK(q)      ((1 << LOG2SIZE(q)) - 1)
>> +#define WRAP_INDEX_MASK(q) ((1 << (LOG2SIZE(q) + 1)) - 1)
> 
> WRAP_INDEX_MASK is unused (but see below for a possible use)
kept and adopted your suggestions below
> 
>> +
>> +#define Q_CONS_ENTRY(q)  (BASE(q) + \
>> +                          (q)->entry_size * ((q)->cons & INDEX_MASK(q)))
>> +#define Q_PROD_ENTRY(q)  (BASE(q) + \
>> +                          (q)->entry_size * ((q)->prod & INDEX_MASK(q)))
>> +
>> +#define Q_CONS(q) ((q)->cons & INDEX_MASK(q))
>> +#define Q_PROD(q) ((q)->prod & INDEX_MASK(q))
> 
> If you put these a bit earlier you can use them in the definitions
> of Q_CONS_ENTRY and Q_PROD_ENTRY.
done
> 
>> +
>> +#define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> LOG2SIZE(q))
>> +#define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> LOG2SIZE(q))
>> +
>> +#define Q_FULL(q) \
>> +    (((((q)->cons) & INDEX_MASK(q)) == \
>> +      (((q)->prod) & INDEX_MASK(q))) && \
>> +     ((((q)->cons) & WRAP_MASK(q)) != \
>> +      (((q)->prod) & WRAP_MASK(q))))
> 
> You could write this as
>    ((cons ^ prod) & WRAP_INDEX_MASK) == WRAP_MASK
done
> 
>> +
>> +#define Q_EMPTY(q) \
>> +    (((((q)->cons) & INDEX_MASK(q)) == \
>> +      (((q)->prod) & INDEX_MASK(q))) && \
>> +     ((((q)->cons) & WRAP_MASK(q)) == \
>> +      (((q)->prod) & WRAP_MASK(q))))
> 
> and this as
>    (cons & WRAP_INDEX_MASK) == (prod & WRAP_INDEX_MASK)
done
> 
> (or as ((cons ^ prod) & WRAP_INDEX_MASK) == 0, but that's unnecessarily
> obscure I think.)
> 
> 
> This is all a bit macro-heavy. Do these really all need to be macros
> rather than functions?
> 
>> +
>> +#define Q_INCONSISTENT(q) \
>> +((((((q)->prod) & INDEX_MASK(q)) > (((q)->cons) & INDEX_MASK(q))) && \
>> +((((q)->prod) & WRAP_MASK(q)) != (((q)->cons) & WRAP_MASK(q)))) || \
>> +(((((q)->prod) & INDEX_MASK(q)) < (((q)->cons) & INDEX_MASK(q))) && \
>> +((((q)->prod) & WRAP_MASK(q)) == (((q)->cons) & WRAP_MASK(q))))) \
>> +
> 
> This never seems to be used. (Also it has a stray trailing '\',
> and isn't indented very clearly.
removed
> 
>> +#define SMMUV3_CMDQ_ENABLED(s) \
>> +     (FIELD_EX32(s->cr[0], CR0, CMDQEN))
>> +
>> +#define SMMUV3_EVENTQ_ENABLED(s) \
>> +     (FIELD_EX32(s->cr[0], CR0, EVENTQEN))

Those were moved to static inline functions
>> +
>> +static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
>> +{
>> +    s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
>> +}
>> +
>> +void smmuv3_write_eventq(SMMUv3State *s, Evt *evt);
>> +
>> +/* Commands */
>> +
>> +enum {
>> +    SMMU_CMD_PREFETCH_CONFIG = 0x01,
>> +    SMMU_CMD_PREFETCH_ADDR,
>> +    SMMU_CMD_CFGI_STE,
>> +    SMMU_CMD_CFGI_STE_RANGE,
>> +    SMMU_CMD_CFGI_CD,
>> +    SMMU_CMD_CFGI_CD_ALL,
>> +    SMMU_CMD_CFGI_ALL,
>> +    SMMU_CMD_TLBI_NH_ALL     = 0x10,
>> +    SMMU_CMD_TLBI_NH_ASID,
>> +    SMMU_CMD_TLBI_NH_VA,
>> +    SMMU_CMD_TLBI_NH_VAA,
>> +    SMMU_CMD_TLBI_EL3_ALL    = 0x18,
>> +    SMMU_CMD_TLBI_EL3_VA     = 0x1a,
>> +    SMMU_CMD_TLBI_EL2_ALL    = 0x20,
>> +    SMMU_CMD_TLBI_EL2_ASID,
>> +    SMMU_CMD_TLBI_EL2_VA,
>> +    SMMU_CMD_TLBI_EL2_VAA,  /* 0x23 */
>> +    SMMU_CMD_TLBI_S12_VMALL  = 0x28,
>> +    SMMU_CMD_TLBI_S2_IPA     = 0x2a,
>> +    SMMU_CMD_TLBI_NSNH_ALL   = 0x30,
>> +    SMMU_CMD_ATC_INV         = 0x40,
>> +    SMMU_CMD_PRI_RESP,
>> +    SMMU_CMD_RESUME          = 0x44,
>> +    SMMU_CMD_STALL_TERM,
>> +    SMMU_CMD_SYNC,          /* 0x46 */
>> +};
>> +
>> +static const char *cmd_stringify[] = {
>> +    [SMMU_CMD_PREFETCH_CONFIG] = "SMMU_CMD_PREFETCH_CONFIG",
>> +    [SMMU_CMD_PREFETCH_ADDR]   = "SMMU_CMD_PREFETCH_ADDR",
>> +    [SMMU_CMD_CFGI_STE]        = "SMMU_CMD_CFGI_STE",
>> +    [SMMU_CMD_CFGI_STE_RANGE]  = "SMMU_CMD_CFGI_STE_RANGE",
>> +    [SMMU_CMD_CFGI_CD]         = "SMMU_CMD_CFGI_CD",
>> +    [SMMU_CMD_CFGI_CD_ALL]     = "SMMU_CMD_CFGI_CD_ALL",
>> +    [SMMU_CMD_CFGI_ALL]        = "SMMU_CMD_CFGI_ALL",
>> +    [SMMU_CMD_TLBI_NH_ALL]     = "SMMU_CMD_TLBI_NH_ALL",
>> +    [SMMU_CMD_TLBI_NH_ASID]    = "SMMU_CMD_TLBI_NH_ASID",
>> +    [SMMU_CMD_TLBI_NH_VA]      = "SMMU_CMD_TLBI_NH_VA",
>> +    [SMMU_CMD_TLBI_NH_VAA]     = "SMMU_CMD_TLBI_NH_VAA",
>> +    [SMMU_CMD_TLBI_EL3_ALL]    = "SMMU_CMD_TLBI_EL3_ALL",
>> +    [SMMU_CMD_TLBI_EL3_VA]     = "SMMU_CMD_TLBI_EL3_VA",
>> +    [SMMU_CMD_TLBI_EL2_ALL]    = "SMMU_CMD_TLBI_EL2_ALL",
>> +    [SMMU_CMD_TLBI_EL2_ASID]   = "SMMU_CMD_TLBI_EL2_ASID",
>> +    [SMMU_CMD_TLBI_EL2_VA]     = "SMMU_CMD_TLBI_EL2_VA",
>> +    [SMMU_CMD_TLBI_EL2_VAA]    = "SMMU_CMD_TLBI_EL2_VAA",
>> +    [SMMU_CMD_TLBI_S12_VMALL]  = "SMMU_CMD_TLBI_S12_VMALL",
>> +    [SMMU_CMD_TLBI_S2_IPA]     = "SMMU_CMD_TLBI_S2_IPA",
>> +    [SMMU_CMD_TLBI_NSNH_ALL]   = "SMMU_CMD_TLBI_NSNH_ALL",
>> +    [SMMU_CMD_ATC_INV]         = "SMMU_CMD_ATC_INV",
>> +    [SMMU_CMD_PRI_RESP]        = "SMMU_CMD_PRI_RESP",
>> +    [SMMU_CMD_RESUME]          = "SMMU_CMD_RESUME",
>> +    [SMMU_CMD_STALL_TERM]      = "SMMU_CMD_STALL_TERM",
>> +    [SMMU_CMD_SYNC]            = "SMMU_CMD_SYNC",
>> +};
>> +
>> +#define SMMU_CMD_STRING(type) (                                      \
>> +(type < ARRAY_SIZE(cmd_stringify)) ? cmd_stringify[type] : "UNKNOWN" \
>> +)
> 
> If this was a function you'd know what the type of 'type' is
> and so whether it needed to have a >= 0 check on it. Also it
> will hand you a NULL pointer for a value that's inside the
> array size but not initialized, like 0x24.
OK
> 
>> +
>> +/* CMDQ fields */
>> +
>> +typedef enum {
>> +    SMMU_CERROR_NONE = 0,
>> +    SMMU_CERROR_ILL,
>> +    SMMU_CERROR_ABT,
>> +    SMMU_CERROR_ATC_INV_SYNC,
>> +} SMMUCmdError;
>> +
>> +enum { /* Command completion notification */
>> +    CMD_SYNC_SIG_NONE,
>> +    CMD_SYNC_SIG_IRQ,
>> +    CMD_SYNC_SIG_SEV,
>> +};
>> +
>> +#define CMD_TYPE(x)         extract32((x)->word[0], 0 , 8)
>> +#define CMD_SSEC(x)         extract32((x)->word[0], 10, 1)
>> +#define CMD_SSV(x)          extract32((x)->word[0], 11, 1)
>> +#define CMD_RESUME_AC(x)    extract32((x)->word[0], 12, 1)
>> +#define CMD_RESUME_AB(x)    extract32((x)->word[0], 13, 1)
>> +#define CMD_SYNC_CS(x)      extract32((x)->word[0], 12, 2)
>> +#define CMD_SSID(x)         extract32((x)->word[0], 12, 20)
>> +#define CMD_SID(x)          ((x)->word[1])
>> +#define CMD_VMID(x)         extract32((x)->word[1], 0 , 16)
>> +#define CMD_ASID(x)         extract32((x)->word[1], 16, 16)
>> +#define CMD_RESUME_STAG(x)  extract32((x)->word[2], 0 , 16)
>> +#define CMD_RESP(x)         extract32((x)->word[2], 11, 2)
>> +#define CMD_LEAF(x)         extract32((x)->word[2], 0 , 1)
>> +#define CMD_STE_RANGE(x)    extract32((x)->word[2], 0 , 5)
>> +#define CMD_ADDR(x) ({                                        \
>> +            uint64_t high = (uint64_t)(x)->word[3];           \
>> +            uint64_t low = extract32((x)->word[2], 12, 20);    \
>> +            uint64_t addr = high << 32 | (low << 12);         \
>> +            addr;                                             \
>> +        })
>> +
>> +int smmuv3_cmdq_consume(SMMUv3State *s);
>> +
>>  #endif
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 8779d3f..0b57215 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -94,6 +94,72 @@ void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t new_gerrorn)
>>      trace_smmuv3_write_gerrorn(acked, s->gerrorn);
>>  }
>>
>> +static uint32_t queue_index_inc(uint32_t val,
>> +                                uint32_t qidx_mask, uint32_t qwrap_mask)
>> +{
>> +    uint32_t i = (val + 1) & qidx_mask;
>> +
>> +    if (i <= (val & qidx_mask)) {
>> +        i = ((val & qwrap_mask) ^ qwrap_mask) | i;
>> +    } else {
>> +        i = (val & qwrap_mask) | i;
>> +    }
>> +    return i;
> 
> This is unnecessarily complicated -- an index increment is just
>    val = (val + 1) & INDEX_WRAP_MASK;
> which will automatically flip the wrap bit as required.
> 
OK
>> +}
>> +
>> +static inline void queue_prod_incr(SMMUQueue *q)
>> +{
>> +    q->prod = queue_index_inc(q->prod, INDEX_MASK(q), WRAP_MASK(q));
> 
> Doesn't this trash the ERR code in bits [30:24], or are you
> keeping that somewhere else for efficiency?
in case there is an error we don't increment. But switching to deposit32
as it looks saner.
> 
>> +}
>> +
>> +static inline void queue_cons_incr(SMMUQueue *q)
>> +{
>> +    q->cons = queue_index_inc(q->cons, INDEX_MASK(q), WRAP_MASK(q));
>> +}
>> +
>> +static inline MemTxResult queue_read(SMMUQueue *q, void *data)
>> +{
>> +    dma_addr_t addr = Q_CONS_ENTRY(q);
>> +
>> +    return dma_memory_read(&address_space_memory, addr,
>> +                           (uint8_t *)data, q->entry_size);
> 
> Does the compiler complain if you don't provide this cast?
no
> 
>> +}
>> +
>> +static void queue_write(SMMUQueue *q, void *data)
>> +{
>> +    dma_addr_t addr = Q_PROD_ENTRY(q);
>> +    MemTxResult ret;
>> +
>> +    ret = dma_memory_write(&address_space_memory, addr,
>> +                           (uint8_t *)data, q->entry_size);
>> +    if (ret != MEMTX_OK) {
>> +        return;
> 
> Shouldn't we record or return this error to the caller,
> like queue_read() does, rather than throwing it away?
> I think that for the event queue (which is the only user
> here ) this should cause an EVENTQ_ABT_ERR.
done
> 
>> +    }
>> +
>> +    queue_prod_incr(q);
>> +}
>> +
>> +void smmuv3_write_eventq(SMMUv3State *s, Evt *evt)
>> +{
>> +    SMMUQueue *q = &s->eventq;
>> +    bool q_empty = Q_EMPTY(q);
>> +    bool q_full = Q_FULL(q);
> 
> You only use these once each, and they're not very complicated
> expressions, so you might as well just have the uses be
> "if (Q_FULL(q)) { ..." &c.
done
> 
>> +
>> +    if (!SMMUV3_EVENTQ_ENABLED(s)) {
>> +        return;
>> +    }
>> +
>> +    if (q_full) {
>> +        return;
>> +    }
>> +
>> +    queue_write(q, evt);
>> +
>> +    if (q_empty) {
>> +        smmuv3_trigger_irq(s, SMMU_IRQ_EVTQ, 0);
>> +    }
>> +}
>> +
>>  static void smmuv3_init_regs(SMMUv3State *s)
>>  {
>>      /**
>> @@ -133,6 +199,102 @@ static void smmuv3_init_regs(SMMUv3State *s)
>>      s->sid_split = 0;
>>  }
>>
>> +int smmuv3_cmdq_consume(SMMUv3State *s)
>> +{
>> +    SMMUCmdError cmd_error = SMMU_CERROR_NONE;
>> +    SMMUQueue *q = &s->cmdq;
>> +    uint32_t type = 0;
>> +
>> +    if (!SMMUV3_CMDQ_ENABLED(s)) {
>> +        return 0;
>> +    }
>> +    /*
>> +     * some commands depend on register values, as above. In case those
> 
> Where is "as above" referring to ?
I meant CMDQ enabled (CR0).
> 
>> +     * register values change while handling the command, spec says it
>> +     * is UNPREDICTABLE whether the command is interpreted under the new
>> +     * or old value.
>> +     */
>> +
>> +    while (!Q_EMPTY(q)) {
>> +        uint32_t pending = s->gerror ^ s->gerrorn;
>> +        Cmd cmd;
>> +
>> +        trace_smmuv3_cmdq_consume(Q_PROD(q), Q_CONS(q),
>> +                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>> +
>> +        if (FIELD_EX32(pending, GERROR, CMDQ_ERR)) {
>> +            break;
>> +        }
>> +
>> +        if (queue_read(q, &cmd) != MEMTX_OK) {
>> +            cmd_error = SMMU_CERROR_ABT;
>> +            break;
>> +        }
>> +
>> +        type = CMD_TYPE(&cmd);
>> +
>> +        trace_smmuv3_cmdq_opcode(SMMU_CMD_STRING(type));
>> +
>> +        switch (type) {
>> +        case SMMU_CMD_SYNC:
>> +            if (CMD_SYNC_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
>> +                smmuv3_trigger_irq(s, SMMU_IRQ_CMD_SYNC, 0);
>> +            }
>> +            break;
>> +        case SMMU_CMD_PREFETCH_CONFIG:
>> +        case SMMU_CMD_PREFETCH_ADDR:
>> +        case SMMU_CMD_CFGI_STE:
>> +        case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
>> +        case SMMU_CMD_CFGI_CD:
>> +        case SMMU_CMD_CFGI_CD_ALL:
>> +        case SMMU_CMD_TLBI_NH_ALL:
>> +        case SMMU_CMD_TLBI_NH_ASID:
>> +        case SMMU_CMD_TLBI_NH_VA:
>> +        case SMMU_CMD_TLBI_NH_VAA:
>> +        case SMMU_CMD_TLBI_EL3_ALL:
>> +        case SMMU_CMD_TLBI_EL3_VA:
>> +        case SMMU_CMD_TLBI_EL2_ALL:
>> +        case SMMU_CMD_TLBI_EL2_ASID:
>> +        case SMMU_CMD_TLBI_EL2_VA:
>> +        case SMMU_CMD_TLBI_EL2_VAA:
>> +        case SMMU_CMD_TLBI_S12_VMALL:
>> +        case SMMU_CMD_TLBI_S2_IPA:
>> +        case SMMU_CMD_TLBI_NSNH_ALL:
>> +        case SMMU_CMD_ATC_INV:
>> +        case SMMU_CMD_PRI_RESP:
>> +        case SMMU_CMD_RESUME:
>> +        case SMMU_CMD_STALL_TERM:
>> +            trace_smmuv3_unhandled_cmd(type);
>> +            break;
>> +        default:
>> +            cmd_error = SMMU_CERROR_ILL;
>> +            error_report("Illegal command type: %d", CMD_TYPE(&cmd));
> 
> This isn't what error_report() is for. You can log it as a GUEST_ERROR.
OK
> 
>> +            break;
>> +        }
>> +        if (cmd_error) {
>> +            break;
>> +        }
>> +        /*
>> +         * We only increment the cons index after the completion of
>> +         * the command. We do that because the SYNC returns immediatly
> 
> "immediately"
> 
>> +         * and do not check the completion of previous commands
> 
> "does not"
> 
>> +         */
>> +        queue_cons_incr(q);
>> +    }
>> +
>> +    if (cmd_error) {
>> +        error_report("Error on %s command execution: %d",
>> +                     SMMU_CMD_STRING(type), cmd_error);
> 
> Again, not error_report(). Probably a good location for a trace_ point.
OK
> 
>> +        smmu_write_cmdq_err(s, cmd_error);
>> +        smmuv3_trigger_irq(s, SMMU_IRQ_GERROR, R_GERROR_CMDQ_ERR_MASK);
>> +    }
>> +
>> +    trace_smmuv3_cmdq_consume_out(Q_PROD(q), Q_CONS(q),
>> +                                  Q_PROD_WRAP(q), Q_CONS_WRAP(q));
>> +
>> +    return 0;
>> +}
>> +
>>  static void smmu_write_mmio(void *opaque, hwaddr addr,
>>                              uint64_t val, unsigned size)
>>  {
>> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
>> index 2ddae40..1c5105d 100644
>> --- a/hw/arm/trace-events
>> +++ b/hw/arm/trace-events
>> @@ -18,3 +18,7 @@ smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PRIx64" va
>>  smmuv3_trigger_irq(int irq) "irq=%d"
>>  smmuv3_write_gerror(uint32_t toggled, uint32_t gerror) "toggled=0x%x, new gerror=0x%x"
>>  smmuv3_write_gerrorn(uint32_t acked, uint32_t gerrorn) "acked=0x%x, new gerrorn=0x%x"
>> +smmuv3_unhandled_cmd(uint32_t type) "Unhandled command type=%d"
>> +smmuv3_cmdq_consume(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod=%d cons=%d prod.wrap=%d cons.wrap=%d"
>> +smmuv3_cmdq_opcode(const char *opcode) "<--- %s"
>> +smmuv3_cmdq_consume_out(uint32_t prod, uint32_t cons, uint8_t prod_wrap, uint8_t cons_wrap) "prod:%d, cons:%d, prod_wrap:%d, cons_wrap:%d "
>> --
>> 2.5.5
>>
> 
> thanks
> -- PMM
> 
