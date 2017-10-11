Received: from eggs.gnu.org ([2001:4830:134:3::10]:54811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e278c-00041a-OO
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e278Y-0005xP-QJ
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:52:50 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:56996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e278Y-0005x5-If
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 22:52:46 -0400
Received: by mail-pf0-x234.google.com with SMTP id b85so371953pfj.13
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 19:52:46 -0700 (PDT)
References: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
	<1507556919-24992-9-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3bab968b-3476-55c2-ba7d-ffd2b902e532@linaro.org>
Date: Tue, 10 Oct 2017 19:52:42 -0700
MIME-Version: 1.0
In-Reply-To: <1507556919-24992-9-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] target/arm: Support some Thumb insns
 being always unconditional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

On 10/09/2017 06:48 AM, Peter Maydell wrote:
> -    if (dc->condexec_mask) {
> +    if (dc->condexec_mask && !thumb_insn_is_unconditional(dc, insn)) {
>          uint32_t cond = dc->condexec_cond;
>  
>          if (cond != 0x0e) {     /* Skip conditional when condition is AL. */

Don't you still need to advance the condexec_mask?

For HLT it doesn't matter, clearly.
I'm not sure what happens to an IT block for debug breakpoints.

But SG behaves as NOP when in non-secure memory.
That would seem to require that

	itft	eq
	add	r1, r0, r0
	sg
	add	r2, r0, r0
	add	r3, r0, r0

should modify both r1 and r2 for T and r3 should be unconditional.  If you
don't advance condexec_mask, it would seem that r2 gets F and r3 gets T.


r~
