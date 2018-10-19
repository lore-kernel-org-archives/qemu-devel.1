Received: from eggs.gnu.org ([2001:4830:134:3::10]:46011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVIb-0004PR-AC
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:58:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gDVIa-0000oG-0S
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:58:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:35007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gDVIZ-0008Ms-Mw
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 09:58:43 -0400
Received: by mail-oi1-x244.google.com with SMTP id 22-v6so26893672oiz.2
	for <qemu-devel@nongnu.org>; Fri, 19 Oct 2018 06:58:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1539954845-26716-5-git-send-email-thuth@redhat.com>
References: <1539954845-26716-1-git-send-email-thuth@redhat.com>
	<1539954845-26716-5-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Oct 2018 14:57:55 +0100
Message-ID: <CAFEAcA-ahq3Y4sgs=Vijq_fsDPgX4JuG0gGdMwE5oOLOrsvxjQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] configs: Add a CONFIG_UNIMP switch for
 the "unimplemented-device"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Richard Henderson <richard.henderson@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 19 October 2018 at 14:14, Thomas Huth <thuth@redhat.com> wrote:
> The "unimplemented-device" is currently only used for one arm board.

? It's used in all the MPS boards, several of the imx SoCs,
the nrf51 SoC used by the microbit, and by the stellaris boards.

> Let's add a CONFIG switch to make sure that we only compile it when
> it is really necessary.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 +
>  hw/misc/Makefile.objs           | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
> index 6f2ffc1..dc9730f 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -7,6 +7,7 @@ CONFIG_NAND=y
>  CONFIG_OR_IRQ=y
>  CONFIG_SPLIT_IRQ=y
>  CONFIG_REGISTER=y
> +CONFIG_UNIMP=y
>  CONFIG_ECC=y
>  CONFIG_SERIAL=y
>  CONFIG_SERIAL_ISA=y

This seems awkward to me. The 'unimplemented' device is supposed
to be an entirely generic thing usable in any board model.
If we only turn it on in the arm-softmmu.mak then it means
faffing around with the default-configs/ whenever it gets
used in a different architecture.

In particular, there's a pull request on the list that uses
it in a sparc board, so this patch will break compile on sparc
once that pullreq lands.

thanks
-- PMM
