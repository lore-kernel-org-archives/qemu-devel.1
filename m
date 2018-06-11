Received: from eggs.gnu.org ([2001:4830:134:3::10]:49889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSC6i-0005uq-GM
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:58:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSC6f-0005d2-FG
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:58:56 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:40177)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fSC6f-0005cs-AE
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 21:58:53 -0400
Received: by mail-qt0-x242.google.com with SMTP id q6-v6so18916686qtn.7
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 18:58:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180608123307.24773-1-alex.bennee@linaro.org>
	<20180608123307.24773-46-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <af5c8a17-c4b5-a54a-5523-304f46a8706b@amsat.org>
Date: Sun, 10 Jun 2018 22:58:45 -0300
MIME-Version: 1.0
In-Reply-To: <20180608123307.24773-46-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v6 45/49] tests/tcg: override runners for
 broken tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Yongbok Kim <yongbok.kim@mips.com>

On 06/08/2018 09:33 AM, Alex Bennée wrote:
> To get a clean run of check-tcg these tests are currently skipped:
> 
>   - hello-mips for mips
>   - linux-test for sparc
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v4
>   - document broken tests in commit
>   - temporarily demote fcvt while fixes percolate upstream
> v5
>   - reinstate fcvt
>   - remove test-mmap overrides (done with EXTRA_RUNS now)
> v6
>   - move to after the skip-test helper
> ---
>  tests/tcg/mips/Makefile.target    | 3 +++
>  tests/tcg/sparc64/Makefile.target | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/mips/Makefile.target b/tests/tcg/mips/Makefile.target
> index 71f0c2dd53..086625f533 100644
> --- a/tests/tcg/mips/Makefile.target
> +++ b/tests/tcg/mips/Makefile.target
> @@ -17,3 +17,6 @@ hello-mips: LDFLAGS+=-nostdlib
>  
>  # For MIPS32 and 64 we have a bunch of extra tests in sub-directories
>  # however they are intended for system tests.
> +
> +run-hello-mips: hello-mips
> +	$(call skip-test, $<, "BROKEN")
> diff --git a/tests/tcg/sparc64/Makefile.target b/tests/tcg/sparc64/Makefile.target
> index 408dace783..064c7a598b 100644
> --- a/tests/tcg/sparc64/Makefile.target
> +++ b/tests/tcg/sparc64/Makefile.target
> @@ -1,6 +1,11 @@
>  # -*- Mode: makefile -*-
>  #
> -# sparc specific tweaks
> +# sparc specific tweaks and masking out broken tests
> +
> +# different from the other hangs
> +# /home/alex/lsrc/qemu/qemu.git/tests/tcg/multiarch/linux-test.c:264: Value too large for defined data type (ret=-1, errno=92/Value too large for defined data type)

Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Dropping "/home/alex/lsrc/qemu/qemu.git/":
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> +run-linux-test: linux-test
> +	$(call skip-test, $<, "BROKEN")
>  
>  # On Sparc64 Linux support 8k pages
>  EXTRA_RUNS+=run-test-mmap-8192
> 
