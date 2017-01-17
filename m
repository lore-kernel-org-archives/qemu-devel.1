Received: from eggs.gnu.org ([2001:4830:134:3::10]:60604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU6G-00026I-Cq
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:47:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTU67-0001Jn-2m
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:47:00 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:35435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTU66-0001JL-Po
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 08:46:50 -0500
Received: by mail-ua0-x231.google.com with SMTP id y9so103293339uae.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 05:46:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484204658-28058-4-git-send-email-wei@redhat.com>
References: <1484204658-28058-1-git-send-email-wei@redhat.com>
	<1484204658-28058-4-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 13:46:29 +0000
Message-ID: <CAFEAcA-_uGard1X9=NucVT87qRtX3dsipSWgwQDSfeADPvs79g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V1 3/4] target-arm: Add support for PMU
 register PMINTENSET_EL1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 January 2017 at 07:04, Wei Huang <wei@redhat.com> wrote:
> This patch adds access support for PMINTENSET_EL1.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/helper.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 9044a33..22c66e3 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1261,9 +1261,17 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>        .writefn = pmuserenr_write, .raw_writefn = raw_write },
>      { .name = "PMINTENSET", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 1,
>        .access = PL1_RW, .accessfn = access_tpm,
> +      .type = ARM_CP_ALIAS,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
>        .resetvalue = 0,
>        .writefn = pmintenset_write, .raw_writefn = raw_write },
> +    { .name = "PMINTENSET_EL1", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 0, .crn = 9, .crm = 14, .opc2 = 1,
> +      .access = PL1_RW, .accessfn = access_tpm,
> +      .type = ARM_CP_IO,
> +      .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> +      .writefn = pmintenset_write, .raw_writefn = raw_write,
> +      .resetvalue = 0x0 },
>      { .name = "PMINTENCLR", .cp = 15, .crn = 9, .crm = 14, .opc1 = 0, .opc2 = 2,
>        .access = PL1_RW, .accessfn = access_tpm, .type = ARM_CP_ALIAS,
>        .fieldoffset = offsetof(CPUARMState, cp15.c9_pminten),
> --

c9_pminten needs to become 64 bits.

We should add PMINTENCLR_EL1 too -- it's a bit weird to provide the
SET function but not its parter CLR operation.

thanks
-- PMM
