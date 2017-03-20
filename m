Received: from eggs.gnu.org ([2001:4830:134:3::10]:33010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpwBN-0001Ca-GI
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:13:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpwBH-0000Zw-W2
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:13:05 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpwBH-0000Z9-Q4
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 08:12:59 -0400
Received: by mail-wr0-x22f.google.com with SMTP id u108so90838134wrb.3
	for <qemu-devel@nongnu.org>; Mon, 20 Mar 2017 05:12:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
References: <CAKPgXcFwSHgb+sLimF=+En_fHM1rYnV1+jX3Tg_hP07EmzyiJg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Mar 2017 12:12:38 +0000
Message-ID: <CAFEAcA96jEBYDNC=cBmDAaFfdQnDtmLyP32uFxhv1CQ0k55mRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] qemu-ga static compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, QEMU Developers <qemu-devel@nongnu.org>

On 14 March 2017 at 16:51, Sameeh Jubran <sameeh@daynix.com> wrote:
> Hi all,
>
> I am trying to compile qemu-ga for Windows statically using the following
> commands:
>
> ./configure --disable-docs --target-list=x86_64-softmmu
> --cross-prefix=x86_64-w64-mingw32- --static --enable-guest-agent-msi
> --with-vss-sdk=/path/to/VSSSDK72
>
> make -j8 qemu-ga
>
>
> And I keep getting this error:
>
> /home/sameeh/Builds/q/stubs/error-printf.c:7: undefined reference to
> `__imp_g_test_config_vars'
> collect2: error: ld returned 1 exit status
> Makefile:444: recipe for target 'qemu-ga.exe' failed
> make: *** [qemu-ga.exe] Error 1

My guess is that maybe some dependent library's pkg-config
configuration for static builds is broken. We run into this
from time to time, because most libraries don't get used in
static builds very often and so getting the config wrong
(forgetting to explicitly say that your library depends on
some other library) is a bug that tends to not get found quickly.
(For dynamic builds dependent libraries are implicitly pulled in.)

You could try to see if you can find which library actually defines
the missing symbol and whether supplying that -lwhatever on the
command line causes the build to complete.

Giving us the linker command line for the qemu-ga.exe would also
be useful info (if you pass make V=1 it will print command lines).

thanks
-- PMM
