Received: from eggs.gnu.org ([209.51.188.92]:54818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guEsx-00051f-To
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guEpo-0001do-VK
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:05:44 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1guEpk-0001WK-CX
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:05:38 -0500
Received: by mail-wr1-x443.google.com with SMTP id c8so5987048wrs.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:05:28 -0800 (PST)
References: <20190214040652.4811-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190214040652.4811-1-richard.henderson@linaro.org>
Date: Thu, 14 Feb 2019 11:05:26 +0000
Message-ID: <877ee2iqa1.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, cota@braap.org


Richard Henderson <richard.henderson@linaro.org> writes:

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

I'll run some of my benchmarks on it but I'm almost certain it will help
as it is one of the highest hits on "perf top" when running a loaded
guest.

>
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


--
Alex Benn=C3=A9e
