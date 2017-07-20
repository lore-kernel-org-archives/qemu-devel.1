Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYDTj-0004e7-FJ
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dYDTi-0000e2-JN
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:35:03 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:33461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dYDTi-0000ca-D1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:35:02 -0400
Received: by mail-wm0-x236.google.com with SMTP id v139so1889939wmv.0
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:35:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
References: <1500029117-6387-1-git-send-email-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 16:34:40 +0100
Message-ID: <CAFEAcA_WAvAei161UpsFSmjzW_TrmRhmcU4WQmDw=msajaQg0w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Handle $RANDOM not being supported
 by the shell
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kamil Rytarowski <n54@gmx.com>, "patches@linaro.org" <patches@linaro.org>

On 14 July 2017 at 11:45, Peter Maydell <peter.maydell@linaro.org> wrote:
> In various places in our test makefiles and scripts we use the
> shell $RANDOM to create a random number. This is a bash
> specific extension, and doesn't work on other shells.
> With dash the shell doesn't complain, it just effectively
> always evaluates $RANDOM to 0:
>   echo $((RANDOM + 32768))     => 32768
>
> However, on NetBSD the shell will complain:
>   "-sh: arith: syntax error: "RANDOM + 32768"
>
> which means that "make check" fails.
>
> Switch to using "${RANDOM:-0}" instead of $RANDOM,
> which will portably either give us a random number or zero.
> This means that on non-bash shells we don't get such
> good test coverage via the MALLOC_PERTURB_ setting, but
> we were already in that situation for non-bash shells.
>
> Our only other uses of $RANDOM (in tests/qemu-iotests/check
> and tests/qemu-iotests/162) are in shell scripts which use
> a #!/bin/bash line so they are always run under bash.
>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  tests/Makefile.include | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Applied, thanks.

-- PMM
