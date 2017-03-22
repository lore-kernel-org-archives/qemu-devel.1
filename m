Received: from eggs.gnu.org ([2001:4830:134:3::10]:57711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqh0M-00075A-Av
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1cqh0J-0006LA-4s
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:12:50 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:33758)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1cqh0I-0006L6-Vd
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:12:47 -0400
Received: by mail-vk0-x243.google.com with SMTP id j64so15396413vkg.0
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 07:12:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qDLcpTJG9yrYptJHP_p598fakaW7ufzcbih5Wo2ySog@mail.gmail.com>
References: <20170322130952.8997-1-sameeh@daynix.com>
	<CAFEAcA-qDLcpTJG9yrYptJHP_p598fakaW7ufzcbih5Wo2ySog@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 22 Mar 2017 16:12:46 +0200
Message-ID: <CAKPgXcGowUDwW1Q+dPsHOrqkrWQORxxBaNuysJbddhG8Z=a=rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH qemu-ga] qga: Make qemu-ga compile
 statically for Windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Yan Vugenfirer <yan@daynix.com>, Stefan Hajnoczi <stefanha@gmail.com>

On Wed, Mar 22, 2017 at 3:21 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 22 March 2017 at 13:09, Sameeh Jubran <sameeh@daynix.com> wrote:
> > Attempting to compile qemu-ga statically as follows for Windows causes
> > the following error:
> >
> > Compilation:
> >     ./configure --disable-docs --target-list=x86_64-softmmu \
> >     --cross-prefix=x86_64-w64-mingw32- --static \
> >     --enable-guest-agent-msi --with-vss-sdk=/path/to/VSSSDK72
> >
> >     make -j8 qemu-ga
> >
> > Error:
> >     path/to/qemu/stubs/error-printf.c:7: undefined reference to
> `__imp_g_test_config_vars'
> >     collect2: error: ld returned 1 exit status
> >     Makefile:444: recipe for target 'qemu-ga.exe' failed
> >     make: *** [qemu-ga.exe] Error 1
> >
> > This is caused by a bug in the pkg-config file for glib as it doesn't
> define
> > GLIB_STATIC_COMPILATION for pkg-config --static.
> >
> > Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> > Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
> > @@ -4138,7 +4138,7 @@ int main(void) { return VSS_CTX_BACKUP; }
> >  EOF
> >    if compile_prog "$vss_win32_include" "" ; then
> >      guest_agent_with_vss="yes"
> > -    QEMU_CFLAGS="$QEMU_CFLAGS $vss_win32_include"
> > +    QEMU_CFLAGS="-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS
> $vss_win32_include"
> >      libs_qga="-lole32 -loleaut32 -lshlwapi -lstdc++
> -Wl,--enable-stdcall-fixup $libs_qga"
> >      qga_vss_provider="qga/vss-win32/qga-vss.dll
> qga/vss-win32/qga-vss.tlb"
> >    else
>
> If we need this for static glib compilation we should
> be adding it where we do the "test for glib and
> add glib related flags to the CFLAGS", not in the
> part of configure where we decide that we're
> compiling the guest agent.
>
> Also, please can we have a comment that clearly states
> why we need this and that we're working around a
> packaging bug in glib for Windows, please?
>
sure, no problem.

>
> thanks
> -- PMM
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
