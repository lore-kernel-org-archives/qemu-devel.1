Received: from eggs.gnu.org ([2001:4830:134:3::10]:38018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cex-0000Qv-EZ
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1cew-0005lX-Ki
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:20:11 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:54067)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1cew-0005jF-Fa
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:20:10 -0400
Received: by mail-wm0-x22f.google.com with SMTP id q132so25826944wmd.2
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 11:20:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1492623684-25799-2-git-send-email-alindsay@codeaurora.org>
References: <1492623684-25799-1-git-send-email-alindsay@codeaurora.org>
	<1492623684-25799-2-git-send-email-alindsay@codeaurora.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 19:19:48 +0100
Message-ID: <CAFEAcA-18f=10NENHVpqmhobf2camcqxVaq8KzquCSkJGknoZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 01/13] target/arm: A53: Initialize PMCEID[0]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, mspradli@codeaurora.org

On 19 April 2017 at 18:41, Aaron Lindsay <alindsay@codeaurora.org> wrote:
> A53 advertises ARM_FEATURE_PMU, but wasn't initializing pmceid[01]
>
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.c   | 2 +-
>  target/arm/cpu64.c | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 04b062c..921b028 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -1342,7 +1342,7 @@ static void cortex_a15_initfn(Object *obj)
>      cpu->id_pfr0 = 0x00001131;
>      cpu->id_pfr1 = 0x00011011;
>      cpu->id_dfr0 = 0x02010555;
> -    cpu->pmceid0 = 0x0000000;
> +    cpu->pmceid0 = 0x00000000;
>      cpu->pmceid1 = 0x00000000;
>      cpu->id_afr0 = 0x00000000;
>      cpu->id_mmfr0 = 0x10201105;

This is A15 code, which the commit message doesn't say anything about.
Fixing this code style nit should probably be a separate patch.

> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 670c07a..7b1642e 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -198,6 +198,8 @@ static void aarch64_a53_initfn(Object *obj)
>      cpu->id_isar5 = 0x00011121;
>      cpu->id_aa64pfr0 = 0x00002222;
>      cpu->id_aa64dfr0 = 0x10305106;
> +    cpu->pmceid0 = 0x00000000;
> +    cpu->pmceid1 = 0x00000000;
>      cpu->id_aa64isar0 = 0x00011120;
>      cpu->id_aa64mmfr0 = 0x00001122; /* 40 bit physical addr */
>      cpu->dbgdidr = 0x3516d000;

Does this actually make a difference? The field values should be 0
anyway if the CPU-specific initfn doesn't set them to anything.

thanks
-- PMM
