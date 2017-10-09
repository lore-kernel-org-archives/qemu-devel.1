Received: from eggs.gnu.org ([2001:4830:134:3::10]:49122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bgy-0006vF-Jf
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bgx-00006v-5M
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:18:12 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:55992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bgw-00006M-Rp
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:18:11 -0400
Received: by mail-wm0-x235.google.com with SMTP id u138so25513707wmu.4
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:18:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-9-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-9-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:17:48 +0100
Message-ID: <CAFEAcA9_WHXEuqp0JPU8SVE6ULJHa3Kdq-38nj2Krf3KA90MQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 08/20] hw/arm/smmuv3: Implement MMIO
 write operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Radha.Chintakuntla@cavium.com, Sunil.Goutham@cavium.com, Radha Mohan <mohun106@gmail.com>, Trey Cain <tcain@qti.qualcomm.com>, Bharat Bhushan <bharat.bhushan@nxp.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Will Deacon <will.deacon@arm.com>, jean-philippe.brucker@arm.com, robin.murphy@arm.com, Peter Xu <peterx@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, wtownsen@redhat.com

On 1 September 2017 at 18:21, Eric Auger <eric.auger@redhat.com> wrote:
> Now we have relevant helpers for queue and irq
> management, let's implement MMIO write operations
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>  hw/arm/smmuv3-internal.h | 103 +++++++++++++++++++++++-
>  hw/arm/smmuv3.c          | 204 ++++++++++++++++++++++++++++++++++++++++++++++-
>  hw/arm/trace-events      |  15 ++++
>  3 files changed, 317 insertions(+), 5 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index d88f141..a5d60b4 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -215,8 +215,6 @@ static inline int smmu_enabled(SMMUV3State *s)
>
>  #define SMMU_CMDQ_ERR(s) (SMMU_PENDING_GERRORS(s) & SMMU_GERROR_CMDQ)
>
> -void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn);
> -
>  /***************************
>   * Queue Handling
>   ***************************/
> @@ -261,7 +259,106 @@ static inline void smmu_write_cmdq_err(SMMUV3State *s, uint32_t err_type)
>                          regval | err_type << SMMU_CMD_CONS_ERR_SHIFT);
>  }
>
> -MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd);
>  void smmuv3_write_evtq(SMMUV3State *s, Evt *evt);
>
> +/*****************************
> + * Commands
> + *****************************/
> +
> +enum {
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
> +};
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
> +/*****************************
> + * CMDQ fields
> + *****************************/
> +
> +typedef enum {
> +    SMMU_CERROR_NONE = 0,
> +    SMMU_CERROR_ILL,
> +    SMMU_CERROR_ABT,
> +    SMMU_CERROR_ATC_INV_SYNC,
> +} SMMUCmdError;
> +
> +enum { /* Command completion notification */
> +    CMD_SYNC_SIG_NONE,
> +    CMD_SYNC_SIG_IRQ,
> +    CMD_SYNC_SIG_SEV,
> +};
> +
> +#define CMD_TYPE(x)  extract32((x)->word[0], 0, 8)
> +#define CMD_SEC(x)   extract32((x)->word[0], 9, 1)
> +#define CMD_SEV(x)   extract32((x)->word[0], 10, 1)
> +#define CMD_AC(x)    extract32((x)->word[0], 12, 1)
> +#define CMD_AB(x)    extract32((x)->word[0], 13, 1)
> +#define CMD_CS(x)    extract32((x)->word[0], 12, 2)
> +#define CMD_SSID(x)  extract32((x)->word[0], 16, 16)
> +#define CMD_SID(x)   ((x)->word[1])
> +#define CMD_VMID(x)  extract32((x)->word[1], 0, 16)
> +#define CMD_ASID(x)  extract32((x)->word[1], 16, 16)
> +#define CMD_STAG(x)  extract32((x)->word[2], 0, 16)
> +#define CMD_RESP(x)  extract32((x)->word[2], 11, 2)
> +#define CMD_GRPID(x) extract32((x)->word[3], 0, 8)
> +#define CMD_SIZE(x)  extract32((x)->word[3], 0, 16)
> +#define CMD_LEAF(x)  extract32((x)->word[3], 0, 1)
> +#define CMD_SPAN(x)  extract32((x)->word[3], 0, 5)
> +#define CMD_ADDR(x) ({                                  \
> +            uint64_t addr = (uint64_t)(x)->word[3];     \
> +            addr <<= 32;                                \
> +            addr |=  extract32((x)->word[3], 12, 20);   \
> +            addr;                                       \
> +        })

This definitely seems to be reimplementing some of the registerfields.h
functionality.

> +
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 2f96463..f35fadc 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -72,7 +72,7 @@ static void smmuv3_irq_trigger(SMMUV3State *s, SMMUIrq irq, uint32_t gerror_val)
>      }
>  }
>
> -void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn)
> +static void smmuv3_write_gerrorn(SMMUV3State *s, uint32_t gerrorn)
>  {
>      uint32_t pending_gerrors = SMMU_PENDING_GERRORS(s);
>      uint32_t sanitized;
> @@ -116,7 +116,7 @@ static void smmu_q_write(SMMUQueue *q, void *data)
>      }
>  }
>
> -MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd)
> +static MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd)
>  {
>      SMMUQueue *q = &s->cmdq;
>      MemTxResult ret = smmu_q_read(q, cmd);
> @@ -224,6 +224,147 @@ static inline void smmu_update_base_reg(SMMUV3State *s, uint64_t *base,
>      *base = val & ~(SMMU_BASE_RA | 0x3fULL);
>  }
>
> +static int smmuv3_cmdq_consume(SMMUV3State *s)
> +{
> +    SMMUCmdError cmd_error = SMMU_CERROR_NONE;
> +
> +    trace_smmuv3_cmdq_consume(SMMU_CMDQ_ERR(s), smmu_cmd_q_enabled(s),
> +                              s->cmdq.prod, s->cmdq.cons,
> +                              s->cmdq.wrap.prod, s->cmdq.wrap.cons);
> +
> +    if (!smmu_cmd_q_enabled(s)) {
> +        return 0;
> +    }
> +
> +    while (!SMMU_CMDQ_ERR(s) && !smmu_is_q_empty(s, &s->cmdq)) {
> +        uint32_t type;
> +        Cmd cmd;
> +
> +        if (smmuv3_read_cmdq(s, &cmd) != MEMTX_OK) {
> +            cmd_error = SMMU_CERROR_ABT;
> +            break;
> +        }
> +
> +        type = CMD_TYPE(&cmd);
> +
> +        trace_smmuv3_cmdq_opcode(cmd_stringify[type]);
> +
> +        switch (CMD_TYPE(&cmd)) {
> +        case SMMU_CMD_SYNC:
> +            if (CMD_CS(&cmd) & CMD_SYNC_SIG_IRQ) {
> +                smmuv3_irq_trigger(s, SMMU_IRQ_CMD_SYNC, 0);
> +            }
> +            break;
> +        case SMMU_CMD_PREFETCH_CONFIG:
> +        case SMMU_CMD_PREFETCH_ADDR:
> +            break;
> +        case SMMU_CMD_CFGI_STE:
> +        {
> +             uint32_t streamid = cmd.word[1];
> +
> +             trace_smmuv3_cmdq_cfgi_ste(streamid);
> +            break;
> +        }
> +        case SMMU_CMD_CFGI_STE_RANGE: /* same as SMMU_CMD_CFGI_ALL */
> +        {
> +            uint32_t start = cmd.word[1], range, end;
> +
> +            range = extract32(cmd.word[2], 0, 5);
> +            end = start + (1 << (range + 1)) - 1;
> +            trace_smmuv3_cmdq_cfgi_ste_range(start, end);
> +            break;
> +        }
> +        case SMMU_CMD_CFGI_CD:
> +        case SMMU_CMD_CFGI_CD_ALL:
> +            trace_smmuv3_unhandled_cmd(type);

Do we cache anything that actually needs to be invalidated?

> +            break;
> +        case SMMU_CMD_TLBI_NH_ALL:
> +        case SMMU_CMD_TLBI_NH_ASID:
> +            trace_smmuv3_unhandled_cmd(type);

Ditto.

> +            break;
> +        case SMMU_CMD_TLBI_NH_VA:
> +        {
> +            int asid = extract32(cmd.word[1], 16, 16);
> +            int vmid = extract32(cmd.word[1], 0, 16);
> +            uint64_t low = extract32(cmd.word[2], 12, 20);
> +            uint64_t high = cmd.word[3];
> +            uint64_t addr = high << 32 | (low << 12);
> +
> +            trace_smmuv3_cmdq_tlbi_nh_va(asid, vmid, addr);
> +            break;
> +        }
> +        case SMMU_CMD_TLBI_NH_VAA:
> +        case SMMU_CMD_TLBI_EL3_ALL:
> +        case SMMU_CMD_TLBI_EL3_VA:
> +        case SMMU_CMD_TLBI_EL2_ALL:
> +        case SMMU_CMD_TLBI_EL2_ASID:
> +        case SMMU_CMD_TLBI_EL2_VA:
> +        case SMMU_CMD_TLBI_EL2_VAA:
> +        case SMMU_CMD_TLBI_S12_VMALL:
> +        case SMMU_CMD_TLBI_S2_IPA:
> +        case SMMU_CMD_TLBI_NSNH_ALL:
> +            trace_smmuv3_unhandled_cmd(type);
> +            break;
> +        case SMMU_CMD_ATC_INV:
> +        case SMMU_CMD_PRI_RESP:
> +        case SMMU_CMD_RESUME:
> +        case SMMU_CMD_STALL_TERM:
> +            trace_smmuv3_unhandled_cmd(type);
> +            break;

You could merge these two sets of cases (or maybe the TLBI are
trivial nops?)

> +        default:
> +            cmd_error = SMMU_CERROR_ILL;
> +            error_report("Illegal command type: %d", CMD_TYPE(&cmd));
> +            break;
> +        }
> +    }
> +
> +    if (cmd_error) {
> +        error_report("GERROR_CMDQ: CONS.ERR=%d", cmd_error);
> +        smmu_write_cmdq_err(s, cmd_error);
> +        smmuv3_irq_trigger(s, SMMU_IRQ_GERROR, SMMU_GERROR_CMDQ);
> +    }
> +
> +    trace_smmuv3_cmdq_consume_out(s->cmdq.wrap.prod, s->cmdq.prod,
> +                                  s->cmdq.wrap.cons, s->cmdq.cons);
> +
> +    return 0;


>  {
> +    SMMUState *sys = opaque;
> +    SMMUV3State *s = SMMU_V3_DEV(sys);
> +
> +    smmu_write_mmio_fixup(s, &addr);
> +
> +    trace_smmuv3_write_mmio(addr, val, size);
> +
> +    switch (addr) {
> +    case 0xFDC ... 0xFFC:
> +    case SMMU_REG_IDR0 ... SMMU_REG_IDR5:
> +        trace_smmuv3_write_mmio_idr(addr, val);
> +        return;
> +    case SMMU_REG_GERRORN:
> +        smmuv3_write_gerrorn(s, val);
> +        /*
> +         * By acknowledging the CMDQ_ERR, SW may notify cmds can
> +         * be processed again
> +         */
> +        smmuv3_cmdq_consume(s);
> +        return;
> +    case SMMU_REG_CR0:
> +        smmu_write32_reg(s, SMMU_REG_CR0, val);
> +        /* immediatly reflect the changes in CR0_ACK */
> +        smmu_write32_reg(s, SMMU_REG_CR0_ACK, val);

"immediately"

thanks
-- PMM
