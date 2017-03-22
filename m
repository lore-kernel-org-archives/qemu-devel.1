Received: from eggs.gnu.org ([2001:4830:134:3::10]:42960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqgKj-0005EJ-TD
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cqgKi-0000Bn-RY
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:29:49 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cqgKi-0000BW-IX
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 09:29:48 -0400
Received: by mail-wm0-x243.google.com with SMTP id z133so9753274wmb.2
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 06:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20170322130952.8997-1-sameeh@daynix.com>
In-Reply-To: <20170322130952.8997-1-sameeh@daynix.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 22 Mar 2017 13:29:35 +0000
Message-ID: <CAJ+F1CJGLHMJGsYu-WBV1cWcs0J1U5_=aPw1vSnaDcPQfbBXrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Sameeh Jubran <sameeh@daynix.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: Yan Vugenfirer <yan@daynix.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

Hi

On Wed, Mar 22, 2017 at 5:11 PM Sameeh Jubran <sameeh@daynix.com> wrote:

> Attempting to compile qemu-ga statically as follows for Windows causes
> the following error:
>
> Compilation:
>     ./configure --disable-docs --target-list=3Dx86_64-softmmu \
>     --cross-prefix=3Dx86_64-w64-mingw32- --static \
>     --enable-guest-agent-msi --with-vss-sdk=3D/path/to/VSSSDK72
>
>     make -j8 qemu-ga
>
> Error:
>     path/to/qemu/stubs/error-printf.c:7: undefined reference to
> `__imp_g_test_config_vars'
>     collect2: error: ld returned 1 exit status
>     Makefile:444: recipe for target 'qemu-ga.exe' failed
>     make: *** [qemu-ga.exe] Error 1
>

weird, I don't get this error on fedora 25 (but I have no vss-sdk, is that
related?).


>
> This is caused by a bug in the pkg-config file for glib as it doesn't
> define
> GLIB_STATIC_COMPILATION for pkg-config --static.
>

If that's a bug in glib, it would be nice to have a link to a bug report.


>
> Signed-off-by: Stefan Hajnoczi <stefanha@gmail.com>
> Signed-off-by: Sameeh Jubran <sameeh@daynix.com>
>
---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index b9a30cf..6f7b460 100755
> --- a/configure
> +++ b/configure
> @@ -4138,7 +4138,7 @@ int main(void) { return VSS_CTX_BACKUP; }
>  EOF
>    if compile_prog "$vss_win32_include" "" ; then
>      guest_agent_with_vss=3D"yes"
> -    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vss_win32_include"
> +    QEMU_CFLAGS=3D"-DGLIB_STATIC_COMPILATION $QEMU_CFLAGS
> $vss_win32_include"
>      libs_qga=3D"-lole32 -loleaut32 -lshlwapi -lstdc++
> -Wl,--enable-stdcall-fixup $libs_qga"
>      qga_vss_provider=3D"qga/vss-win32/qga-vss.dll qga/vss-win32/qga-vss.=
tlb"
>    else
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
