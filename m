Received: from eggs.gnu.org ([2001:4830:134:3::10]:48014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bbv-0005Dg-Fz
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:13:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bbu-0005ed-JN
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:12:59 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:50189)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bbu-0005e3-DX
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:12:58 -0400
Received: by mail-wm0-x231.google.com with SMTP id u138so24381387wmu.5
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:12:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504286483-23327-8-git-send-email-eric.auger@redhat.com>
References: <1504286483-23327-1-git-send-email-eric.auger@redhat.com>
	<1504286483-23327-8-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:12:36 +0100
Message-ID: <CAFEAcA-QNCreM0JQZYgHpE5kwXoidrY=gxzSfSgMJsEZ_5D=Jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 07/20] hw/arm/smmuv3: Queue helpers
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
> We introduce helpers to read/write into the circular queues.
> smmuv3_read_cmdq and smmuv3_write_evtq will become static
> later on.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

See comments on a previous patch where I suggest a better
way to implement the queue increment/wrapping handling.

> +typedef enum {
> +    CMD_Q_EMPTY,
> +    CMD_Q_FULL,
> +    CMD_Q_PARTIALLY_FILLED,
> +} SMMUQStatus;
> +
> +#define Q_ENTRY(q, idx)  (q->base + q->ent_size * idx)
> +#define Q_WRAP(q, pc)    ((pc) >> (q)->shift)
> +#define Q_IDX(q, pc)     ((pc) & ((1 << (q)->shift) - 1))
> +
> +static inline SMMUQStatus __smmu_queue_status(SMMUV3State *s, SMMUQueue *q)

No __ prefixes, please.

> +{
> +    uint32_t prod = Q_IDX(q, q->prod);
> +    uint32_t cons = Q_IDX(q, q->cons);
> +
> +    if ((prod == cons) && (q->wrap.prod != q->wrap.cons)) {
> +        return CMD_Q_FULL;
> +    } else if ((prod == cons) && (q->wrap.prod == q->wrap.cons)) {
> +        return CMD_Q_EMPTY;
> +    }
> +    return CMD_Q_PARTIALLY_FILLED;
> +}
> +#define smmu_is_q_full(s, q) (__smmu_queue_status(s, q) == CMD_Q_FULL)
> +#define smmu_is_q_empty(s, q) (__smmu_queue_status(s, q) == CMD_Q_EMPTY)
> +
> +static inline int __smmu_q_enabled(SMMUV3State *s, uint32_t q)
> +{
> +    return smmu_read32_reg(s, SMMU_REG_CR0) & q;
> +}
> +#define smmu_cmd_q_enabled(s) __smmu_q_enabled(s, SMMU_CR0_CMDQ_ENABLE)
> +#define smmu_evt_q_enabled(s) __smmu_q_enabled(s, SMMU_CR0_EVTQ_ENABLE)

This code seems to be rather macro-happy.

thanks
-- PMM
