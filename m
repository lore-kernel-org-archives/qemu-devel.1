Received: from eggs.gnu.org ([2001:4830:134:3::10]:48505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87C6-0002mM-L7
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f87C5-0007nE-7y
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:41:30 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f87C5-0007mk-0M
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:41:29 -0400
Received: by mail-oi0-x244.google.com with SMTP id 126-v6so15139547oig.0
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 09:41:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1523518688-26674-7-git-send-email-eric.auger@redhat.com>
References: <1523518688-26674-1-git-send-email-eric.auger@redhat.com>
	<1523518688-26674-7-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 17:41:07 +0100
Message-ID: <CAFEAcA913D3L_33GO_FZTxip0EZr6XBDvgaTYWGg_Vjmq3PrJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v11 06/17] hw/arm/smmuv3: Queue helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: Eric Auger <eric.auger.pro@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <cdall@kernel.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On 12 April 2018 at 08:37, Eric Auger <eric.auger@redhat.com> wrote:
> We introduce helpers to read/write into the command and event
> circular queues.
>
> smmuv3_write_eventq and smmuv3_cmq_consume will become static
> in subsequent patches.
>
> Invalidation commands are not yet dealt with. We do not cache
> data that need to be invalidated. This will change with vhost
> integration.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
>
> ---
> v9 -> v10:
> - simplified macros
> - s/BASE/Q_BASE
> - use log2size field
> - static inline functions replacing some macros
> - simplified queue_prod_incr/queue_cons_incr and use deposit32
> - trace for cmdq_consume failure
>
> v8 -> v9:
> - fix CMD_SSID & CMD_ADDR + some renamings
> - do cons increment after the execution of the command
> - add Q_INCONSISTENT()
>
> v7 -> v8
> - use address_space_rw
> - helpers inspired from spec
> ---
>  hw/arm/smmuv3-internal.h | 154 +++++++++++++++++++++++++++++++++++++++++++++++
>  hw/arm/smmuv3.c          | 136 +++++++++++++++++++++++++++++++++++++++++
>  hw/arm/trace-events      |   5 ++
>  3 files changed, 295 insertions(+)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index 32f81d4..968fa25 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -156,4 +156,158 @@ static inline bool smmuv3_gerror_irq_enabled(SMMUv3State *s)
>  void smmuv3_trigger_irq(SMMUv3State *s, SMMUIrq irq, uint32_t gerror_mask);
>  void smmuv3_write_gerrorn(SMMUv3State *s, uint32_t gerrorn);
>
> +/* Queue Handling */
> +
> +#define Q_BASE(q)          ((q)->base & SMMU_BASE_ADDR_MASK)
> +#define WRAP_MASK(q)       (1 << (q)->log2size)
> +#define INDEX_MASK(q)      (((1 << (q)->log2size)) - 1)
> +#define WRAP_INDEX_MASK(q) ((1 << ((q)->log2size + 1)) - 1)
> +
> +#define Q_CONS(q) ((q)->cons & INDEX_MASK(q))
> +#define Q_PROD(q) ((q)->prod & INDEX_MASK(q))
> +
> +#define Q_CONS_ENTRY(q)  (Q_BASE(q) + (q)->entry_size * Q_CONS(q))
> +#define Q_PROD_ENTRY(q)  (Q_BASE(q) + (q)->entry_size * Q_PROD(q))
> +
> +#define Q_CONS_WRAP(q) (((q)->cons & WRAP_MASK(q)) >> (q)->log2size)
> +#define Q_PROD_WRAP(q) (((q)->prod & WRAP_MASK(q)) >> (q)->log2size)
> +
> +static inline bool smmuv3_q_full(SMMUQueue *q)
> +{
> +    return ((q->cons ^ q->prod) & WRAP_INDEX_MASK(q)) == WRAP_MASK(q);
> +}
> +
> +static inline bool smmuv3_q_empty(SMMUQueue *q)
> +{
> +    return (q->cons & WRAP_INDEX_MASK(q)) == (q->prod & WRAP_INDEX_MASK(q));
> +}
> +
> +static inline void queue_prod_incr(SMMUQueue *q)
> +{
> +    q->prod = (q->prod + 1) & WRAP_INDEX_MASK(q);
> +}
> +
> +static inline void queue_cons_incr(SMMUQueue *q)
> +{
> +    q->cons = deposit32(q->cons, 0, q->log2size + 1, q->cons + 1);
> +}

I was expecting these two functions to be implemented in
the same way. Worth a comment
    /* We have to use deposit for the CONS registers to preserve
     * the ERR field in the high bits.
     */

or if you prefer, instead a comment in queue_prod_incr saying
   /* We don't need to use deposit here because there are no
    * fields above WRAP in a PROD register
    */

(you don't need both comments).

> +
> +static inline bool smmuv3_cmdq_enabled(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->cr[0], CR0, CMDQEN);
> +}
> +
> +static inline bool smmuv3_eventq_enabled(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->cr[0], CR0, EVENTQEN);
> +}
> +
> +static inline void smmu_write_cmdq_err(SMMUv3State *s, uint32_t err_type)
> +{
> +    s->cmdq.cons = FIELD_DP32(s->cmdq.cons, CMDQ_CONS, ERR, err_type);
> +}
> +
> +void smmuv3_write_eventq(SMMUv3State *s, Evt *evt);
> +
> +/* Commands */
> +
> +typedef enum SMMUCommandType {
> +    SMMU_CMD_PREFETCH_CONFIG = 0x01,
> +    SMMU_CMD_PREFETCH_ADDR,
> +    SMMU_CMD_CFGI_STE,
> +    SMMU_CMD_CFGI_STE_RANGE,
> +    SMMU_CMD_CFGI_CD,
> +    SMMU_CMD_CFGI_CD_ALL,
> +    SMMU_CMD_CFGI_ALL,
> +    SMMU_CMD_TLBI_NH_ALL     = 0x10,
> +    SMMU_CMD_TLBI_NH_ASID,
> +    SMMU_CMD_TLBI_NH_VA,
> +    SMMU_CMD_TLBI_NH_VAA,
> +    SMMU_CMD_TLBI_EL3_ALL    = 0x18,
> +    SMMU_CMD_TLBI_EL3_VA     = 0x1a,
> +    SMMU_CMD_TLBI_EL2_ALL    = 0x20,
> +    SMMU_CMD_TLBI_EL2_ASID,
> +    SMMU_CMD_TLBI_EL2_VA,
> +    SMMU_CMD_TLBI_EL2_VAA,  /* 0x23 */
> +    SMMU_CMD_TLBI_S12_VMALL  = 0x28,
> +    SMMU_CMD_TLBI_S2_IPA     = 0x2a,
> +    SMMU_CMD_TLBI_NSNH_ALL   = 0x30,
> +    SMMU_CMD_ATC_INV         = 0x40,
> +    SMMU_CMD_PRI_RESP,
> +    SMMU_CMD_RESUME          = 0x44,
> +    SMMU_CMD_STALL_TERM,
> +    SMMU_CMD_SYNC,          /* 0x46 */

I don't think the comments are very useful here (and they're
not consistent -- you don't bother to mark 0x13 or 0x07).

> +} SMMUCommandType;
> +
> +static const char *cmd_stringify[] = {
> +    [SMMU_CMD_PREFETCH_CONFIG] = "SMMU_CMD_PREFETCH_CONFIG",
> +    [SMMU_CMD_PREFETCH_ADDR]   = "SMMU_CMD_PREFETCH_ADDR",
> +    [SMMU_CMD_CFGI_STE]        = "SMMU_CMD_CFGI_STE",
> +    [SMMU_CMD_CFGI_STE_RANGE]  = "SMMU_CMD_CFGI_STE_RANGE",
> +    [SMMU_CMD_CFGI_CD]         = "SMMU_CMD_CFGI_CD",
> +    [SMMU_CMD_CFGI_CD_ALL]     = "SMMU_CMD_CFGI_CD_ALL",
> +    [SMMU_CMD_CFGI_ALL]        = "SMMU_CMD_CFGI_ALL",
> +    [SMMU_CMD_TLBI_NH_ALL]     = "SMMU_CMD_TLBI_NH_ALL",
> +    [SMMU_CMD_TLBI_NH_ASID]    = "SMMU_CMD_TLBI_NH_ASID",
> +    [SMMU_CMD_TLBI_NH_VA]      = "SMMU_CMD_TLBI_NH_VA",
> +    [SMMU_CMD_TLBI_NH_VAA]     = "SMMU_CMD_TLBI_NH_VAA",
> +    [SMMU_CMD_TLBI_EL3_ALL]    = "SMMU_CMD_TLBI_EL3_ALL",
> +    [SMMU_CMD_TLBI_EL3_VA]     = "SMMU_CMD_TLBI_EL3_VA",
> +    [SMMU_CMD_TLBI_EL2_ALL]    = "SMMU_CMD_TLBI_EL2_ALL",
> +    [SMMU_CMD_TLBI_EL2_ASID]   = "SMMU_CMD_TLBI_EL2_ASID",
> +    [SMMU_CMD_TLBI_EL2_VA]     = "SMMU_CMD_TLBI_EL2_VA",
> +    [SMMU_CMD_TLBI_EL2_VAA]    = "SMMU_CMD_TLBI_EL2_VAA",
> +    [SMMU_CMD_TLBI_S12_VMALL]  = "SMMU_CMD_TLBI_S12_VMALL",
> +    [SMMU_CMD_TLBI_S2_IPA]     = "SMMU_CMD_TLBI_S2_IPA",
> +    [SMMU_CMD_TLBI_NSNH_ALL]   = "SMMU_CMD_TLBI_NSNH_ALL",
> +    [SMMU_CMD_ATC_INV]         = "SMMU_CMD_ATC_INV",
> +    [SMMU_CMD_PRI_RESP]        = "SMMU_CMD_PRI_RESP",
> +    [SMMU_CMD_RESUME]          = "SMMU_CMD_RESUME",
> +    [SMMU_CMD_STALL_TERM]      = "SMMU_CMD_STALL_TERM",
> +    [SMMU_CMD_SYNC]            = "SMMU_CMD_SYNC",
> +};
> +
> +static inline const char *smmu_cmd_string(SMMUCommandType type)
> +{
> +    return cmd_stringify[type] ? cmd_stringify[type] : "UNKNOWN";
> +}

It looks like you use this function on unsanitized type field
values direct from the guest structure, so you need to handle
the possibility that the 'type' argument is larger than
ARRAY_SIZE(cmd_stringify). (And also the possibility that it's
negative, if you want to be robust about it; that's a little
trickier since an enum might be signed or unsigned and if
unsigned the compiler may warn about comparisons that are
always false. I forget the best approach here.)

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
