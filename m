Received: from eggs.gnu.org ([2001:4830:134:3::10]:37014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enrSO-0003Sq-In
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:50:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1enrSN-0002By-8X
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:50:36 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:37764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1enrSN-0002Bu-28
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 14:50:35 -0500
Received: by mail-oi0-x233.google.com with SMTP id f186so908550oig.4
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 11:50:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180219171037.24539-1-laurent@vivier.eu>
References: <20180219171037.24539-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Feb 2018 19:50:13 +0000
Message-ID: <CAFEAcA-W+xQMov2=WHPYwh_EVFiaW+8D+0VWB2T6kJ6Bo_xLFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 19 February 2018 at 17:10, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit f0fa81767555fe2c4b5f8c9e0725a80eac1d7f56:
>
>   cuda.h: Fix multiple typedef (2018-02-16 18:38:21 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-2.12-pull-request
>
> for you to fetch changes up to f352a021329f73d0219018cdfb39369687e8cadd:
>
>   linux-user: MIPS set cpu to r6 CPU if binary is R6 (2018-02-18 18:52:32 +0100)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------

Hi. This breaks one of my linux-user smoke tests:

/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/sparc32plus-linux-user/qemu-sparc32plus
-L ./gnemul/qemu-sparc sparc/ls -l dummyfile
unable to find CPU model 'Fujitsu MB86904'

This is because the include path for linux-user picks the
guest-architecture subdirectory for the TARGET_ABI_DIR,
which for sparc32plus is "sparc", but the set of CPUs compiled
in depends on the TARGET_ARCH, which is "sparc64", and
sparc64 doesn't include that 32-bit Fujitsu CPU.
The linux-user/sparc/target_elf.h needs to have code to handle
both the pure-32-bit and 32-bit-ABI-on-64-bit-CPU cases,
the same way that linux-user/ppc/target_elf.h does.

thanks
-- PMM
