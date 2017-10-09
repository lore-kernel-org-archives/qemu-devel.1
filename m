Received: from eggs.gnu.org ([2001:4830:134:3::10]:52799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bwg-0006F4-QO
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bwf-0007kW-M8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:34:26 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:49921)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bwf-0007kK-BY
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:34:25 -0400
Received: by mail-wm0-x236.google.com with SMTP id b189so24444856wmd.4
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:34:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-10-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-10-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:34:03 +0100
Message-ID: <CAFEAcA81EjsJ_ZVjvCY-jAjzq_=CK1AVdwGTd_c_XPpC53+E9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 09/20] hw/arm/smmuv3: Event queue
 recording helper
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
> Let's introduce a helper function aiming at recording an
> event in the event queue.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> At the moment, for some events we do not fill all the fields.
> Typically filling the FetchAddr field resulting of an abort
> on page table walk would require to return more information
> from this latter in case of error.
>
> However with enabled use cases I have not seen any event
> recorded yet.
> ---
>  hw/arm/smmuv3-internal.h | 45 ++++++++++++++++++++++++--
>  hw/arm/smmuv3.c          | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 126 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index a5d60b4..e3e9828 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -259,8 +259,6 @@ static inline void smmu_write_cmdq_err(SMMUV3State *s, uint32_t err_type)
>                          regval | err_type << SMMU_CMD_CONS_ERR_SHIFT);
>  }
>
> -void smmuv3_write_evtq(SMMUV3State *s, Evt *evt);
> -
>  /*****************************
>   * Commands
>   *****************************/
> @@ -361,4 +359,47 @@ enum { /* Command completion notification */
>              addr;                                       \
>          })
>
> +/*****************************
> + * EVTQ fields
> + *****************************/
> +
> +#define EVT_Q_OVERFLOW        (1 << 31)
> +
> +#define EVT_SET_TYPE(x, t)    deposit32((x)->word[0], 0, 8, t)
> +#define EVT_SET_SID(x, s)     ((x)->word[1] =  s)
> +#define EVT_SET_INPUT_ADDR(x, addr) ({                    \
> +            (x)->word[5] = (uint32_t)(addr >> 32);        \
> +            (x)->word[4] = (uint32_t)(addr & 0xffffffff); \
> +        })
> +#define EVT_SET_RNW(x, rnw)     deposit32((x)->word[3], 3, 1, rnw)
> +
> +/*****************************
> + * Events
> + *****************************/
> +
> +typedef enum evt_err {
> +    SMMU_EVT_OK,
> +    SMMU_EVT_F_UUT,
> +    SMMU_EVT_C_BAD_SID,
> +    SMMU_EVT_F_STE_FETCH,
> +    SMMU_EVT_C_BAD_STE,
> +    SMMU_EVT_F_BAD_ATS_REQ,
> +    SMMU_EVT_F_STREAM_DISABLED,
> +    SMMU_EVT_F_TRANS_FORBIDDEN,
> +    SMMU_EVT_C_BAD_SSID,
> +    SMMU_EVT_F_CD_FETCH,
> +    SMMU_EVT_C_BAD_CD,
> +    SMMU_EVT_F_WALK_EXT_ABRT,
> +    SMMU_EVT_F_TRANS        = 0x10,
> +    SMMU_EVT_F_ADDR_SZ,
> +    SMMU_EVT_F_ACCESS,
> +    SMMU_EVT_F_PERM,
> +    SMMU_EVT_F_TLB_CONFLICT = 0x20,
> +    SMMU_EVT_F_CFG_CONFLICT = 0x21,
> +    SMMU_EVT_E_PAGE_REQ     = 0x24,
> +} SMMUEvtErr;
> +
> +void smmuv3_record_event(SMMUV3State *s, hwaddr iova,
> +                         uint32_t sid, bool is_write, SMMUEvtErr type);
> +
>  #endif
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index f35fadc..7470576 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -132,7 +132,7 @@ static MemTxResult smmuv3_read_cmdq(SMMUV3State *s, Cmd *cmd)
>      return ret;
>  }
>
> -void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
> +static void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
>  {
>      SMMUQueue *q = &s->evtq;
>      bool was_empty = smmu_is_q_empty(s, q);
> @@ -157,6 +157,88 @@ void smmuv3_write_evtq(SMMUV3State *s, Evt *evt)
>      }
>  }
>
> +/*
> + * smmuv3_record_event - Record an event
> + */
> +void smmuv3_record_event(SMMUV3State *s, hwaddr iova,

(Are you sure you want a hwaddr and not a uint64_t ?)

> +                         uint32_t sid, IOMMUAccessFlags perm,
> +                         SMMUEvtErr type)
> +{
> +    Evt evt;
> +    bool rnw = perm & IOMMU_RO;

This doesn't feel like a great way to structure this, because
every event has different fields and so you'll end up with
a huge number of parameters to this function, half of which
are unused for any given callsite.

I think a better approach is to have one utility function
per event type (the syn_aa64_* functions in target/arm/internals.h
for filling out syndrome register values are an example of this).

Or you could have a struct-and-union setup

typedef struct {
    uint8_t event_type;
    union {
        struct {
            hwaddr iova;
            bool rnw;
            // etc
        } f_uut;
        struct {
            // etc
        } c_bad_streamid;
        // etc
    } u;
} EventInfo;

and have callers fill that in for this function to then
marshal into the record structure. That might be a bit
heavyweight here compared to just having a function per
event -- depends a bit on whether your callsites are
going to find it helpful to construct an EventInfo in
one place and then hand it around/return it from a function
before recording it in the queue, or if you always have
all the info you need for the event right at the point
where you want to record it.

thanks
-- PMM
