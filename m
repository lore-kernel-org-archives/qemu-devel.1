Received: from eggs.gnu.org ([2001:4830:134:3::10]:35611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gLdSm-0000qn-HA
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 19:18:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1gLdSj-0008UY-As
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 19:18:52 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:33244)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <flukshun@gmail.com>) id 1gLdSf-0008TQ-VF
	for qemu-devel@nongnu.org; Sat, 10 Nov 2018 19:18:46 -0500
Received: by mail-ot1-x331.google.com with SMTP id q1so4989215otk.0
	for <qemu-devel@nongnu.org>; Sat, 10 Nov 2018 16:18:44 -0800 (PST)
Sender: fluxion <flukshun@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <dc234347-1e4f-2139-bd00-26f049a007f0@amsat.org>
References: <20181109160014.28646-1-mdroth@linux.vnet.ibm.com>
	<dc234347-1e4f-2139-bd00-26f049a007f0@amsat.org>
Message-ID: <154189551108.30771.11921228391873134084@sif>
Date: Sat, 10 Nov 2018 18:18:31 -0600
Subject: Re: [Qemu-devel] [PATCH] build: qga: add macro to force use of
 native mingw32 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>

Quoting Philippe Mathieu-Daud=C3=A9 (2018-11-10 13:34:25)
> Hi Michael,
> =

> On 11/9/18 5:00 PM, Michael Roth wrote:
> > When building qemu-ga for w32 with VSS support, some parts of qemu-ga
> > are not linked against glib, specifically the C++ bits used to
> > create the VSS provider DLL. With 3ebee3b191e, we now define assert()
> > as g_assert() for all mingw32 builds via osdep.h, which results in the
> > following build breakage:
> > =

> >   x86_64-w64-mingw32-g++ -o qga/vss-win32/qga-vss.dll qga/vss-win32/req=
uester.o qga/vss-win32/provider.o qga/vss-win32/install.o /home/mdroth/w/qe=
mu4.git/qga/vss-win32/qga-vss.def  -shared -Wl,--add-stdcall-alias,--enable=
-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
> >   qga/vss-win32/requester.o: In function `requester_freeze':
> >   /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:284: undefined r=
eference to `g_assertion_message_expr'
> >   qga/vss-win32/requester.o: In function `requester_thaw':
> >   /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:508: undefined r=
eference to `g_assertion_message_expr'
> >   /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:509: undefined r=
eference to `g_assertion_message_expr'
> >   collect2: error: ld returned 1 exit status
> >   make: *** [/home/mdroth/w/qemu4.git/qga/vss-win32/Makefile.objs:10: q=
ga/vss-win32/qga-vss.dll] Error 1
> >   make: *** Waiting for unfinished jobs....
> > =

> > Fix this by introducing a USE_NATIVE_MINGW32_ASSERT macro that can
> > be defined prior to inclusion of osdep.h in individual C/C++ files
> > that don't link against glib.
> > =

> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> >  include/qemu/osdep.h        | 2 +-
> >  qga/vss-win32/install.cpp   | 2 +-
> >  qga/vss-win32/provider.cpp  | 2 +-
> >  qga/vss-win32/requester.cpp | 2 +-
> >  qga/vss-win32/vss-common.h  | 2 ++
> >  5 files changed, 6 insertions(+), 4 deletions(-)
> > =

> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index 3bf48bcdec..59364bfeb0 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -129,7 +129,7 @@ extern int daemon(int, int);
> >   * code that is unreachable when features are disabled.
> >   * All supported versions of Glib's g_assert() satisfy this requiremen=
t.
> >   */
> > -#ifdef __MINGW32__
> > +#if defined(__MINGW32__) && !defined(USE_NATIVE_MINGW32_ASSERT)
> >  #undef assert
> >  #define assert(x)  g_assert(x)
> >  #endif
> =

> OK.
> =

> > diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
> > index 6713e58670..6ed2d5930c 100644
> > --- a/qga/vss-win32/install.cpp
> > +++ b/qga/vss-win32/install.cpp
> > @@ -10,9 +10,9 @@
> >   * See the COPYING file in the top-level directory.
> >   */
> >  =

> > +#include "vss-common.h"
> >  #include "qemu/osdep.h"
> =

> I don't like breaking the rule and not using "qemu/osdep.h" first.
> (See below for suggestion).

Yah, if it can be easily avoided that's probably the better route.

> =

> >  =

> > -#include "vss-common.h"
> >  #include <inc/win2003/vscoordint.h>
> >  #include "install.h"
> >  #include <wbemidl.h>
> > diff --git a/qga/vss-win32/provider.cpp b/qga/vss-win32/provider.cpp
> > index 72d8b0e19d..d298af91b2 100644
> > --- a/qga/vss-win32/provider.cpp
> > +++ b/qga/vss-win32/provider.cpp
> > @@ -10,8 +10,8 @@
> >   * See the COPYING file in the top-level directory.
> >   */
> >  =

> > -#include "qemu/osdep.h"
> >  #include "vss-common.h"
> > +#include "qemu/osdep.h"
> =

> Ditto.
> =

> >  #include <inc/win2003/vscoordint.h>
> >  #include <inc/win2003/vsprov.h>
> >  =

> > diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> > index 5378c55d23..d239bd9598 100644
> > --- a/qga/vss-win32/requester.cpp
> > +++ b/qga/vss-win32/requester.cpp
> > @@ -10,8 +10,8 @@
> >   * See the COPYING file in the top-level directory.
> >   */
> >  =

> > -#include "qemu/osdep.h"
> >  #include "vss-common.h"
> > +#include "qemu/osdep.h"
> =

> Ditto.
> =

> >  #include "requester.h"
> >  #include "install.h"
> >  #include <inc/win2003/vswriter.h>
> > diff --git a/qga/vss-win32/vss-common.h b/qga/vss-win32/vss-common.h
> > index 61c170b52e..275cbb59c5 100644
> > --- a/qga/vss-win32/vss-common.h
> > +++ b/qga/vss-win32/vss-common.h
> > @@ -13,6 +13,8 @@
> >  #ifndef VSS_COMMON_H
> >  #define VSS_COMMON_H
> >  =

> > +#define USE_NATIVE_MINGW32_ASSERT
> =

> I believe you can add this in the "VSS SDK" section of the ./configure
> script:
> =

> -- >8 --
> diff --git a/configure b/configure
> @@ -4588,7 +4588,7 @@ int main(void) { return VSS_CTX_BACKUP; }
>  EOF
>    if compile_prog "$vss_win32_include" "" ; then
>      guest_agent_with_vss=3D"yes"
> -    QEMU_CFLAGS=3D"$QEMU_CFLAGS $vss_win32_include"
> +    QEMU_CFLAGS=3D"$QEMU_CFLAGS -DUSE_NATIVE_MINGW32_ASSERT
> $vss_win32_include"
>      libs_qga=3D"-lole32 -loleaut32 -lshlwapi -lstdc++
> -Wl,--enable-stdcall-fixup $libs_qga"
>      qga_vss_provider=3D"qga/vss-win32/qga-vss.dll qga/vss-win32/qga-vss.=
tlb"
>    else
> ---
> =

> What do you think?

This may pass it on to the qemu build itself, but something similar for
just the VSS DLL target might do the trick. I'll give that a shot,
thanks.

> =

> Regards,
> =

> Phil.
> =

> > +
> >  #define __MIDL_user_allocate_free_DEFINED__
> >  #include <windows.h>
> >  #include <shlwapi.h>
> > =

>=20
