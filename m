Received: from eggs.gnu.org ([2001:4830:134:3::10]:48764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f6NQE-0001R5-4v
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1f6NQA-0006kv-4P
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:36:54 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1f6NQ9-0006ig-V7
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 17:36:50 -0400
Date: Wed, 11 Apr 2018 17:36:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180411213648.GA27136@flamenco>
References: <1522883475-27858-1-git-send-email-cota@braap.org>
	<1522883475-27858-2-git-send-email-cota@braap.org>
	<874lki5yj2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874lki5yj2.fsf@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v3 01/15] tests: add fp-test,
 a floating point test suite
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On Wed, Apr 11, 2018 at 02:20:49 +0100, Alex Bennée wrote:
> Emilio G. Cota <cota@braap.org> writes:
> So with the attached patch and my proposed cross build we can now get:
> 
> 02:15:54 [alex@zen:~/l/q/qemu.git] softfloat-fixes-for-2.12-v1 ± find . -iname "fp-test" | xargs file
> ./ppc64-linux-user/tests/fp-test:      ELF 64-bit LSB executable, 64-bit PowerPC or cisco 7500, version 1 (GNU/Linux), statically linked, for GNU/Linux 3.2.0, not stripped
(snip)
> But it did mean having to hack about a little, mainly to get rid of
> glib.

That will let us build fp-test using a cross-compiler. My initial
thinking was that since we'd end up testing on a real host
(with "-t host" mode), cross-compiling wouldn't be necessary since we
could just compile natively on said host.

But since we seem to be moving towards supporting cross-compilers,
it takes little effort to cross-compile fp-test as well. The main
hurdle is to remove the glib dependence as you pointed out. I just
wrote a few patches to do this:

$ git log --oneline -5 --reverse
48e802b osdep: disable glib-compat.h include with QEMU_NO_GLIB
d3c78c7 softfloat: do not include glib headers
744a9c4 tests/tcg/Makefile: define _GNU_SOURCE
661c0e2 tests/fp: fixup
e057d45 tests/tcg/Makefile: fp-test build fixup

The main difference with your attached patch is that we remove ifdef's
from fp-test.c while keeping the osdep.h include.

You can fetch the patches from
  https://github.com/cota/qemu/tree/softfloat-fixes-for-2.12-v1

[BTW the name of the branch is just to keep your original branch name;
I'm in now way intending for this to be part of 2.12 :>]

Thanks,

		Emilio
