Received: from eggs.gnu.org ([2001:4830:134:3::10]:50182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZduj-0002xW-JL
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:28:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cZdui-0005Lg-R9
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:28:33 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cZdui-0005L7-KK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 08:28:32 -0500
Received: by mail-wm0-x234.google.com with SMTP id c85so28971923wmi.1
	for <qemu-devel@nongnu.org>; Fri, 03 Feb 2017 05:28:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1485875745-27741-4-git-send-email-wei@redhat.com>
References: <1485875745-27741-1-git-send-email-wei@redhat.com>
	<1485875745-27741-4-git-send-email-wei@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Feb 2017 13:28:11 +0000
Message-ID: <CAFEAcA-UpfQExDL3uk5SGh4KOwuFXrpkV6sBhbBqKAJHs+wnVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH V2 3/5] target-arm: Add support for PMU
 register PMXEVCNTR_EL0
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

On 31 January 2017 at 15:15, Wei Huang <wei@redhat.com> wrote:
> To make PMU register support complete, this patch adds support for
> PMXEVCNTR_EL0.
>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  target/arm/helper.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index c8620d9..6b8460a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1255,6 +1255,10 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
>      { .name = "PMXEVCNTR", .cp = 15, .crn = 9, .crm = 13, .opc1 = 0, .opc2 = 2,
>        .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
>        .accessfn = pmreg_access },
> +    { .name = "PMXEVCNTR_EL0", .state = ARM_CP_STATE_AA64,
> +      .opc0 = 3, .opc1 = 3, .crn = 9, .crm = 13, .opc2 = 2,
> +      .access = PL0_RW, .type = ARM_CP_CONST, .resetvalue = 0,
> +      .accessfn = pmreg_access },

We don't need to do this, because we're already spec-compliant.
Since we only support the cycle counter, accesses to PMXEVCNTR
are always CONSTRAINED UNPREDICTABLE and "accesses UNDEF" is
a permitted choice, which is what we do at the moment.
('Accesses are RAZ/WI' are also a permitted choice.)

Is there a reason you've opted for the RAZ/WI here?

thanks
-- PMM
