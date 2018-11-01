Received: from eggs.gnu.org ([2001:4830:134:3::10]:36519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGcY-0007T2-Pm
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGcY-0006Gs-3y
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:19:02 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:39626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIGcX-0006GR-MC
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:19:02 -0400
Received: by mail-ot1-x341.google.com with SMTP id g27so5549892oth.6
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:19:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <84c5dc6a-6507-1b72-9808-ef4a58ff26d4@redhat.com>
References: <154098485103.7774.2165977871054805313@015909e0f939>
	<84c5dc6a-6507-1b72-9808-ef4a58ff26d4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 17:18:40 +0000
Message-ID: <CAFEAcA_ByKuDeei4TtqRzWQT-W9CFtFRywrSCbp3TQXuTk9pCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/2] hw/arm/exynos4: Add DMA support for
 SMDKC210 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 31 October 2018 at 16:00, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The following patch fixes this crash, but I'm not sure this is the correc=
t
> fix:
>
> -- >8 --
> --- a/hw/intc/exynos4210_gic.c
> +++ b/hw/intc/exynos4210_gic.c
> @@ -213,6 +213,8 @@ void exynos4210_init_board_irqs(Exynos4210Irq *s)
>  {
>      uint32_t grp, bit, irq_id, n;
>
> +    memset(s->board_irqs, 0, sizeof(s->board_irqs));
> +
>      for (n =3D 0; n < EXYNOS4210_MAX_EXT_COMBINER_IN_IRQ; n++) {
>          irq_id =3D 0;
>          if (n =3D=3D EXYNOS4210_COMBINER_GET_IRQ_NUM(1, 4) ||

Generally devices should be able to assume that their state
structures are zero-initialized. In this case this memory
comes from
    Exynos4210State *s =3D g_new(Exynos4210State, 1);
in exynos4210_init().

So the quick fix for 3.1 would be to make that use g_new0().

Longer term, the code in hw/arm/exynos4210.c is implementing
an SoC, but it is not doing it in what is (now) the standard
way of having the SoC be a device object which contains all
the relevant SoC device objects. Making it work like that
would mean that the memory for the state struct would naturally
be zeroed out because it would be allocated by the functions
for "create me a QOM object or device".

thanks
-- PMM
