Received: from eggs.gnu.org ([2001:4830:134:3::10]:48129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dyygi-0007OX-HF
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dyygh-0005ur-CY
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:15:04 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:53958)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dyygh-0005l5-5d
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 07:15:03 -0400
Received: by mail-wm0-x22b.google.com with SMTP id q132so9854923wmd.2
	for <qemu-devel@nongnu.org>; Mon, 02 Oct 2017 04:15:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1506933058-28313-2-git-send-email-a.perevalov@samsung.com>
References: <CGME20171002083119eucas1p1a73232b22e354c9b27dbc4c0b9b78907@eucas1p1.samsung.com>
	<1506933058-28313-1-git-send-email-a.perevalov@samsung.com>
	<1506933058-28313-2-git-send-email-a.perevalov@samsung.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Oct 2017 12:14:39 +0100
Message-ID: <CAFEAcA8oo4cenAVsmcS5cmC3Uuh5e+bocM4hbHtvcpFB1ZJKGQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] Makefile: don't use LINKPROG for
 tests/migration/stress
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, heetae82.ahn@samsung.com, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>, i.maximets@samsung.com
List-ID: <qemu-devel.nongnu.org>

On 2 October 2017 at 09:30, Alexey Perevalov <a.perevalov@samsung.com> wrote:
> This patch just replaces  LINKPROG for CC.
> LINKPROG invokes both CXX and CC.
> So in case of static linking of C source, static libstdc++
> is required by build, but it could be missing in system.
> And static libstdc++ may not be needed for whole QEMU.
>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index abc6707..bf94516 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -803,7 +803,7 @@ tests/numa-test$(EXESUF): tests/numa-test.o
>  tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
>
>  tests/migration/stress$(EXESUF): tests/migration/stress.o
> -       $(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
> +       $(call quiet-command, $(CC) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
>
>  INITRD_WORK_DIR=tests/migration/initrd

Why does this executable need to define its own link rule anyway?
Ideally it should just use the standard rules.mak LINK function
like everything else. If it does need to do something weird
it should have a comment saying why it's weird...

thanks
-- PMM
