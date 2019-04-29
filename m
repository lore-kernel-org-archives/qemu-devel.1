Received: from eggs.gnu.org ([209.51.188.92]:52190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5qe-0002UC-1k
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL5qa-0000Ez-P4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:57:31 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:35502)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL5qa-0000C7-6u
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 08:57:28 -0400
Received: by mail-ot1-x333.google.com with SMTP id g24so3880201otq.2
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 05:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-2-richard.henderson@linaro.org>
In-Reply-To: <20190315032629.21234-2-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 13:57:13 +0100
Message-ID: <CAFEAcA_zP=KXXtiRn3AbpT6Dcjcjh3RNS1k+AB3TYZYBLOpiSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 01/23] crypto: Merge crypto-obj-y into
 libqemuutil.a
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, 15 Mar 2019 at 03:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We will shortly need this in the user-only binaries, so drop the split
> into system and tools binaries.  This also means that crypto-aes-obj-y
> can be merged back into crypto-obj-y.
>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  Makefile             | 12 +++++-------
>  Makefile.objs        |  8 ++------
>  Makefile.target      |  4 ----
>  configure            |  9 +++------
>  crypto/Makefile.objs |  5 +----
>  5 files changed, 11 insertions(+), 27 deletions(-)

This patch breaks a --static configure for me:

e104462:bionic:qemu$ (cd build/all-linux-static/ && '../../configure'
'--cc=3Dccache gcc' '--enable-debug' '--static' '--disable-system'
'--disable-tools')

ERROR: sizeof(size_t) doesn't match GLIB_SIZEOF_SIZE_T.
       You probably need to set PKG_CONFIG_LIBDIR
       to point to the right pkg-config files for your
       build target

The error message is bogus, but the problem is that we
tried to build one of the test programs like this:

ccache gcc -pthread -I/usr/include/glib-2.0
-I/usr/lib/x86_64-linux-gnu/glib-2.0/include -m64 -mcx16 -D_GNU_SOURCE
-D_FILE_OFFSET_BITS=3D64 -D_LARGEFILE_SOURCE -Wstrict-prototypes
-Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes
-fno-strict-aliasing -fno-common -fwrapv -std=3Dgnu99
-Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-value
-Wno-missing-include-dirs -Wempty-body -Wnested-externs
-Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers
-Wold-style-declaration -Wold-style-definition -Wtype-limits
-fstack-protector-strong -I/usr/include/p11-kit-1
-I/usr/include/libpng16 -g -o config-temp/qemu-conf.exe
config-temp/qemu-conf.c -m64 -static -g -lgthread-2.0 -pthread
-lglib-2.0 -pthread -lpcre -pthread -lnettle -lgnutls -lgmp
/usr/lib/x86_64-linux-gnu/libunistring.so -lidn2 -lhogweed -lgmp
-lnettle -ltasn1 -lp11-kit -lz
gcc: error: /usr/lib/x86_64-linux-gnu/libunistring.so: No such file or dire=
ctory

which is almost certainly because we're now including
a bunch of extra libraries in the link for the static
linux-user binaries which don't work statically linked.
(In particular one of them looks to have a bogus
pkg-config which puts a .so file in the link line for
a static link...)

thanks
-- PMM
