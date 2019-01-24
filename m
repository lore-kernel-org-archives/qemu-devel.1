Received: from eggs.gnu.org ([209.51.188.92]:40337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfkw-0004XY-0j
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:13:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmfkv-0006vp-BO
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:13:22 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmfkp-0006Uh-SQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:13:17 -0500
Received: by mail-ot1-x341.google.com with SMTP id g16so1320875otg.11
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 06:12:53 -0800 (PST)
MIME-Version: 1.0
References: <20190121184314.14311-1-peter.maydell@linaro.org>
In-Reply-To: <20190121184314.14311-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 14:12:41 +0000
Message-ID: <CAFEAcA9sL7BakhTBPj-TC2iQyZQVhHNvZFxz4Xx8f094tU3tJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] xlnx-zynqmp: Don't create rpu-cluster if
 there are no RPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Cc: "patches@linaro.org" <patches@linaro.org>, Luc Michel <luc.michel@greensocs.com>, Alistair Francis <alistair@alistair23.me>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Mon, 21 Jan 2019 at 18:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> If we aren't going to create any RPUs, then don't create the
> rpu-cluster unit. This allows us to add an assertion to the
> cluster object that it contains at least one CPU, which helps
> to avoid bugs in creating clusters and putting CPUs in them.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is a preparatory patch that is necessary for the series
> "[PATCH v3 0/4] tcg: support heterogenous CPU clusters"
> (20190121152218.9592-1-peter.maydell@linaro.org)
> in order to avoid the xlnx-zcu102 board asserting if started with
> fewer than 5 CPUs.
>
>  hw/arm/xlnx-zynqmp.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 370b0e44a38..16cba433cb7 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -178,6 +178,11 @@ static void xlnx_zynqmp_create_rpu(XlnxZynqMPState *s, const char *boot_cpu,
>      int i;
>      int num_rpus = MIN(smp_cpus - XLNX_ZYNQMP_NUM_APU_CPUS, XLNX_ZYNQMP_NUM_RPU_CPUS);
>
> +    if (num_rpus == 0) {
> +        /* Don't create rpu-cluster object if there's nothing to put in it */
> +        return;
> +    }

Applied to target-arm.next with a fixup to test for "<= 0".

thanks
-- PMM
