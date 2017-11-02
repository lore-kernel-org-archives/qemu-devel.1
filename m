Received: from eggs.gnu.org ([2001:4830:134:3::10]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eAMLE-00064k-1f
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eAML9-0005XR-5C
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:43:56 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:49523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eAML8-0005XC-TG
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 16:43:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id b189so1338161wmd.4
	for <qemu-devel@nongnu.org>; Thu, 02 Nov 2017 13:43:50 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <050fc3d3-7b01-13b9-d8b2-65ae7d089a40@twiddle.net>
Date: Thu, 2 Nov 2017 21:43:45 +0100
MIME-Version: 1.0
In-Reply-To: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] cpu-exec: Exit exclusive region on
 longjmp from step_atomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>

On 11/02/2017 05:35 PM, Peter Maydell wrote:
> Commit ac03ee5331612e44be narrowed the scope of the exclusive
> region so it only covers when we're executing the TB, not when
> we're generating it. However it missed that there is more than
> one execution path out of cpu_tb_exec -- if the atomic insn
> causes an exception then the code will longjmp out, skipping
> the code to end the exclusive region. This causes QEMU to hang
> the next time the CPU calls start_exclusive(), waiting for
> itself to exit the region.
> 
> Move the "end the region" code out to the end of the
> function so that it is run for both normal exit and also
> for exit-via-longjmp. We have to use a volatile bool flag
> to decide whether we need to end the region, because we
> can longjump out of the codegen as well as the execution.
> 
> (For some reason this only reproduces for me with a clang
> optimized build, not a gcc debug build.)
> 
> Fixes: ac03ee5331612e44beb393df2b578c951d27dc0d
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2: use a flag so we get the "longjump out of the
> codegen" case right.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

I've got one other tcg patch queued for 2.11.
I could take this via tcg-next if you like.


r~
