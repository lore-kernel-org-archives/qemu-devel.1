Received: from eggs.gnu.org ([209.51.188.92]:55657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Lo5-0000q1-JY
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:21:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h3Ld0-00007x-L4
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:10:11 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35841)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h3Ld0-000066-Cm
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:10:06 -0400
Received: by mail-ot1-x343.google.com with SMTP id v62so4024411otb.3
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <1552292963-19430-1-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1552292963-19430-1-git-send-email-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Mar 2019 14:09:54 +0000
Message-ID: <CAFEAcA_awCQTXDMLUVuEtQNAZSU4eJp=6EA1c9QQrDygFfeHyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [RESEND PATCH] target/arm: change arch timer
 registers access permission
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: gengdongjiu <gengdongjiu@huawei.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On Mon, 11 Mar 2019 at 08:29, gengdongjiu <gengdongjiu@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> Some generic arch timer registers are Config-RW in the EL0,
> which means the EL0 exception level can have write permission
> if it is appropriately configured.
>
> When VM access registers, it firstly checks whether they have RW
> permission, then check whether it is appropriately configured.
> If they are defined to Ready only in EL0, even though they have been

"read only" ?

> appropriately configured, they still do not have write permission.
> So need to add the write permission according to ARMV8 spec when
> define it.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Yes, this seems to be a bug which has been present since
I added the generic timer support in commit 55d284af8e31b in 2013.

I'm not sure why the bug is there -- my best guess is that I
incorrectly copied the permission flags from the CNTFRQ register
(which really is RO from PL0 but RW from PL1 and above) to
these other registers which should be fully RW from PL0.

> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2607d39..3db94c6 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2665,7 +2665,7 @@ static const ARMCPRegInfo generic_timer_cp_reginfo[] = {
>      /* per-timer control */
>      { .name = "CNTP_CTL", .cp = 15, .crn = 14, .crm = 2, .opc1 = 0, .opc2 = 1,
>        .secure = ARM_CP_SECSTATE_NS,
> -      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_R,
> +      .type = ARM_CP_IO | ARM_CP_ALIAS, .access = PL1_RW | PL0_RW,

The PLx_{R,W,RW} constants all imply access is also possible from
the higher PLs, so this can just be written ".access = PL0_RW".

thanks
-- PMM
