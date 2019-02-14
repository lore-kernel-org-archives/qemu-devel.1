Received: from eggs.gnu.org ([209.51.188.92]:46058)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1guEMJ-000276-70
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:35:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1guEGS-00051E-RO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:29:10 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:50469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1guEGR-0004gB-1U
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:29:07 -0500
Received: by mail-it1-x144.google.com with SMTP id z7so13838528iti.0
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 02:29:00 -0800 (PST)
MIME-Version: 1.0
References: <20190214040652.4811-1-richard.henderson@linaro.org>
In-Reply-To: <20190214040652.4811-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 14 Feb 2019 11:28:48 +0100
Message-ID: <CABoDooP6WtwRnSjRhQjD=0Z_K1+wvZGufzc40hnGjmwGuo9NkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/4] target/arm: Reduce overhead of
 cpu_get_tb_cpu_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi Richard,

On Thu, Feb 14, 2019 at 5:07 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We've talked about this before, caching state to reduce the
> amount of computation that happens looking up each TB.
>
> I know that Peter has been concerned that we would not be able to
> reliably maintain all of the places that need to be updates to
> keep this up-to-date.
>
> Well, modulo dirty tricks within linux-user, it appears as if
> exception delivery and return, plus after every TB-ending write
> to a system register is sufficient.
>
> There seems to be a noticable improvement, although wall-time
> is harder to come by -- all of my system-level measurements
> include user input, and my user-level measurements seem to be
> too small to matter.

FWIW this patch series made a run of linux-user AArch64 176.gcc 166.i
go from 29.5s down to 24.5s (on an E5-2650 v2).  Though that'd need
more benchmarks, that looks quite good to me.

Thanks,

Laurent

>
> r~
>
>
> Richard Henderson (4):
>   target/arm: Split out recompute_hflags et al
>   target/arm: Rebuild hflags at el changes and MSR writes
>   target/arm: Assert hflags is correct in cpu_get_tb_cpu_state
>   target/arm: Rely on hflags correct in cpu_get_tb_cpu_state
>
>  target/arm/cpu.h           |  22 ++-
>  target/arm/helper.h        |   3 +
>  target/arm/internals.h     |   4 +
>  linux-user/syscall.c       |   1 +
>  target/arm/cpu.c           |   1 +
>  target/arm/helper-a64.c    |   3 +
>  target/arm/helper.c        | 267 ++++++++++++++++++++++---------------
>  target/arm/machine.c       |   1 +
>  target/arm/op_helper.c     |   1 +
>  target/arm/translate-a64.c |   6 +-
>  target/arm/translate.c     |  14 +-
>  11 files changed, 204 insertions(+), 119 deletions(-)
>
> --
> 2.17.1
>
>
