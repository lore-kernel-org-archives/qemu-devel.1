Received: from eggs.gnu.org ([2001:4830:134:3::10]:48360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb6vg-000646-Ny
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cb6vf-00038e-Pn
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:39:36 -0500
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cb6vf-00038G-JP
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 09:39:35 -0500
Received: by mail-wr0-x229.google.com with SMTP id k90so40252004wrc.3
	for <qemu-devel@nongnu.org>; Tue, 07 Feb 2017 06:39:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485879782-6075-3-git-send-email-vijay.kilari@gmail.com>
References: <1485879782-6075-1-git-send-email-vijay.kilari@gmail.com>
	<1485879782-6075-3-git-send-email-vijay.kilari@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Feb 2017 14:39:13 +0000
Message-ID: <CAFEAcA_K2TcihHTTrrr7kZ3pGZ3BNptDb0mt5Rc0YinkGD1eHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v7 RESEND 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vijay Kilari <vijay.kilari@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Eric Auger <eric.auger@redhat.com>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 31 January 2017 at 16:22,  <vijay.kilari@gmail.com> wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>
> To Save and Restore ICC_SRE_EL1 register Add ICC_SRE_EL1 register
> to vmstate and GICv3CPUState struct.
>
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> ---
>  hw/intc/arm_gicv3_common.c         | 1 +
>  include/hw/intc/arm_gicv3_common.h | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 0f8c4b8..f3245d9 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -68,6 +68,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
>          VMSTATE_UINT32(gicr_igrpmodr0, GICv3CPUState),
>          VMSTATE_UINT32(gicr_nsacr, GICv3CPUState),
>          VMSTATE_UINT8_ARRAY(gicr_ipriorityr, GICv3CPUState, GIC_INTERNAL),
> +        VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
>          VMSTATE_UINT64_ARRAY(icc_ctlr_el1, GICv3CPUState, 2),
>          VMSTATE_UINT64(icc_pmr_el1, GICv3CPUState),
>          VMSTATE_UINT64_ARRAY(icc_bpr, GICv3CPUState, 3),
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index 341a311..183c7f8 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -166,6 +166,7 @@ struct GICv3CPUState {
>      uint8_t gicr_ipriorityr[GIC_INTERNAL];
>
>      /* CPU interface */
> +    uint64_t icc_sre_el1;
>      uint64_t icc_ctlr_el1[2];
>      uint64_t icc_pmr_el1;
>      uint64_t icc_bpr[3];

This breaks migration compatibility for TCG using GICv3; you
need to do something here with a VMState subsection so
the new register is only transferred if it's non-zero.

thanks
-- PMM
