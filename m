Received: from eggs.gnu.org ([2001:4830:134:3::10]:43108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO1KD-0007AA-7S
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:35:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dO1KC-0003bA-BB
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:35:05 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35005)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dO1KC-0003ap-4Z
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:35:04 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k67so21525912wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 05:35:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170622111845.5296-1-alex.bennee@linaro.org>
References: <20170622111845.5296-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Jun 2017 13:34:42 +0100
Message-ID: <CAFEAcA_cUBfzUyCs60e3O9TpqyvXTmkU9Uh25EL1Vy23Lw0fXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] target/arm/helper: document potential CNTV
 register bear trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andre Przywara <andre.przywara@arm.com>, Christoffer Dall <cdall@linaro.org>

On 22 June 2017 at 12:18, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> The ARM KVM encodings have been inadvertently switched for
> CNTV_CVAL_EL0/CNTVCT_EL0 in the register API since its introduction.
> Fortunately this doesn't currently mater as the reset values for both
> are the same. However if this ever changes things will break in
> interesting ways.

Augh.

> Migration is currently unaffected as we just use
> cpu->cpreg_vmstate_indexes/cpreg_vmstate_values verbatim. However this
> would break if we ever supported migration between KVM and TCG models.
>
> For now we just warn future generations who may touch this code.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Christoffer Dall <cdall@linaro.org>
> ---
>  target/arm/helper.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 2594faa9b8..e7a0e39583 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -211,6 +211,11 @@ static bool raw_accessors_invalid(const ARMCPRegInfo=
 *ri)
>      return true;
>  }
>
> +/*
> + * FIXME: the KVM API has switched encodings for
> + * CNTV_CVAL_EL0/CNTVCT_EL0 which need to be fixed if we want to
> + * change the reset values or support KVM<->TCG migration.
> + */

I don't really like just peppering the code with FIXMEs like this.
How much work would it be to determine what the actual required fix
is (whether kernel side or QEMU side) and implement it?

thanks
-- PMM
