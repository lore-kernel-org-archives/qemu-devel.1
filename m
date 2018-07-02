Received: from eggs.gnu.org ([2001:4830:134:3::10]:37266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwMP-0007Xk-EH
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fZwMO-0000LH-PW
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:47:09 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:39690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fZwMO-0000LB-KR
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 06:47:08 -0400
Received: by mail-oi0-x241.google.com with SMTP id d189-v6so6762912oib.6
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 03:47:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180630000242.29594-1-richard.henderson@linaro.org>
References: <20180630000242.29594-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Jul 2018 11:46:47 +0100
Message-ID: <CAFEAcA-go_e5=NP1ZMbkCz9MomPwUe8F=YU7JQM59ZR+p+JC9Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix qemu-system-aarch64 crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 30 June 2018 at 01:02, Richard Henderson
<richard.henderson@linaro.org> wrote:
> The sequence of events was
>   (1) Kernel executed a disabled sve insn,
>   (2) Undefined Instruction trap went to EL3,
>   (3) Lookup of the exception handler saw el3 and returned asidx 1,
>   (4) Which hadn't been set up.
>
> So there's definitely a bug with SVE exception routing.
> That said...
>
> With just the first patch, the kernel goes into a silly exception loop
> which is understandable.  With just the second patch, qemu gets SIGABRT
> instead of SIGSEGV, which is definitely easier to debug.
>
> I think I'm in favor of both patches, but you might say we shouldn't
> have to have the first one and just apply the second.

I think my vote is for just the second -- a CPU without the
security extensions should never be emitting transactions
with attrs.secure true, so that's a bug we want to track down.
Suitably placed assert()s do a better job of that than sweeping
the problem under the carpet by squashing the attributes
in arm_asidx_from_attrs().

thanks
-- PMM
