Received: from eggs.gnu.org ([2001:4830:134:3::10]:53699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fEd3h-000805-Mp
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1fEd3g-0006vd-PS
	for qemu-devel@nongnu.org; Fri, 04 May 2018 11:55:45 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180504153431.5169-1-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <780abdaa-a20f-d82d-fc3c-5df111887cd9@twiddle.net>
Date: Fri, 4 May 2018 08:55:36 -0700
MIME-Version: 1.0
In-Reply-To: <20180504153431.5169-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: Fix dup_vec in non-AVX2 codepath
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, qemu-stable@nongnu.org

On 05/04/2018 08:34 AM, Peter Maydell wrote:
> The VPUNPCKLD* instructions are all "non-destructive source",
> indicated by "NDS" in the encoding string in the x86 ISA manual.
> This means that they take two source operands, one of which is
> encoded in the VEX.vvvv field. We were incorrectly treating them
> as if they were destructive-source and passing 0 as the 'v'
> argument of tcg_out_vex_modrm(). This meant we were always
> using %xmm0 as one of the source operands, causing incorrect
> results if the register allocator happened to want to use
> something else. For instance the input AArch64 insn:
>  DUP v26.16b, w21
> which becomes TCG IR ops:
>  dup_vec v128,e8,tmp2,x21
>  st_vec v128,e8,tmp2,env,$0xa40
> was assembled to:
> 0x607c568c:  c4 c1 7a 7e 86 e8 00 00  vmovq    0xe8(%r14), %xmm0
> 0x607c5694:  00
> 0x607c5695:  c5 f9 60 c8              vpunpcklbw %xmm0, %xmm0, %xmm1
> 0x607c5699:  c5 f9 61 c9              vpunpcklwd %xmm1, %xmm0, %xmm1
> 0x607c569d:  c5 f9 70 c9 00           vpshufd  $0, %xmm1, %xmm1
> 0x607c56a2:  c4 c1 7a 7f 8e 40 0a 00  vmovdqu  %xmm1, 0xa40(%r14)
> 0x607c56aa:  00
> 
> when the vpunpcklwd insn should be "%xmm1, %xmm1, %xmm1".
> This resulted in our incorrectly setting the output vector to
> q26=0000320000003200:0000320000003200
> when given an input of x21 == 0000000002803200
> rather than the expected all-zeroes.

Oops.  Apparently I don't do enough testing on older machines.

> Pass the correct source register number to tcg_out_vex_modrm()
> for these insns.
> 
> Fixes: 770c2fc7bb70804a
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tcg/i386/tcg-target.inc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied to tcg-next, thanks.


r~
