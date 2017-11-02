Received: from eggs.gnu.org ([2001:4830:134:3::10]:53891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eAJ5k-0006wU-PJ
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:15:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eAJ5g-0002d9-1A
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:15:44 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35375)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eAJ5f-0002cm-RA
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:15:39 -0400
Date: Thu, 2 Nov 2017 13:15:38 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20171102171538.GA9433@flamenco>
References: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard Henderson <rth@twiddle.net>

On Thu, Nov 02, 2017 at 16:35:36 +0000, Peter Maydell wrote:
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

Reviewed-by: Emilio G. Cota <cota@braap.org>

Good catch, thanks for the fix!

		E.
