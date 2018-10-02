Received: from eggs.gnu.org ([2001:4830:134:3::10]:54739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HOi-0004KC-Fd
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7HOh-0007HL-Ae
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:55:20 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7HOg-0007Fk-UR
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:55:19 -0400
Received: by mail-oi1-x243.google.com with SMTP id 22-v6so29172oiz.2
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:55:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180926112048.17778-2-alex.bennee@linaro.org>
References: <20180926112048.17778-1-alex.bennee@linaro.org>
	<20180926112048.17778-2-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 10:54:57 +0100
Message-ID: <CAFEAcA9CDX02Mmt-i+2Ct=at_iS8pjcbSN+ZPhj+BYUC1xXrUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 1/4] target/arm64: properly handle DBGVR
 RESS bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Omair Javaid <omair.javaid@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On 26 September 2018 at 12:20, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
> This only fails with some (broken) versions of gdb but we should
> treat the top bits of DBGBVR as RESS. As the hardware may have IMPDEF
> approaches to writes to this register we apply the sign extension when
> checking breakpoints.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  target/arm/kvm64.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> index e0b8246283..80ad07ed0c 100644
> --- a/target/arm/kvm64.c
> +++ b/target/arm/kvm64.c
> @@ -356,13 +356,23 @@ bool kvm_arm_hw_debug_active(CPUState *cs)
>      return ((cur_hw_wps > 0) || (cur_hw_bps > 0));
>  }
>
> +/*
> + * We shouldn't rely on gdb correctly setting the top bits of DBGBVR
> + * and the HW lists the top bits a RESS - sign-extending the top bit
> + * of the VA address. As it is IMPDEF if the write is either a sign
> + * extension or kept as is we might fix it up before we compare with
> + * the correctly reported and sign extended address.
> + */
> +
>  static bool find_hw_breakpoint(CPUState *cpu, target_ulong pc)
>  {
>      int i;
>
>      for (i =3D 0; i < cur_hw_bps; i++) {
>          HWBreakpoint *bp =3D get_hw_bp(i);
> -        if (bp->bvr =3D=3D pc) {
> +        target_ulong bvr =3D bp->bvr;
> +        bvr |=3D extract64(bvr, 52, 1) ? MAKE_64BIT_MASK(53, 11) : 0;
> +        if (bvr =3D=3D pc) {
>              return true;
>          }
>      }

Shouldn't we be sanitizing the addresses we get from gdb
before we put them into the hardware watchpoint registers,
rather than doing the sign extension when we read the registers?

thanks
-- PMM
