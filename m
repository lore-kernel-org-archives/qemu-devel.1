Received: from eggs.gnu.org ([2001:4830:134:3::10]:37609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAWaV-0004St-Td
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eAWaS-0002cE-OV
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:40:23 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:46694)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eAWaS-0002bm-G3
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 03:40:20 -0400
Received: by mail-wr0-x241.google.com with SMTP id l1so1705486wrc.3
	for <qemu-devel@nongnu.org>; Fri, 03 Nov 2017 00:40:20 -0700 (PDT)
References: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1509640536-32160-1-git-send-email-peter.maydell@linaro.org>
Date: Fri, 03 Nov 2017 07:40:17 +0000
Message-ID: <87vairhkta.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>


Peter Maydell <peter.maydell@linaro.org> writes:

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

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--
Alex Benn=C3=A9e
