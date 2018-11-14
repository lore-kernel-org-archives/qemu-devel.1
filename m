Received: from eggs.gnu.org ([2001:4830:134:3::10]:56480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gN1pz-0006Fr-Es
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1gN1pw-0006C8-2d
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:32:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1gN1pv-0006A1-Pw
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 15:32:32 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAEKSxr9019297
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 15:32:27 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nrt4c1u4v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 15:32:27 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Nov 2018 20:32:26 -0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <20181114165456.GS19298@redhat.com>
References: <20181114164438.6412-1-mdroth@linux.vnet.ibm.com>
	<20181114165456.GS19298@redhat.com>
Date: Wed, 14 Nov 2018 14:32:11 -0600
Message-Id: <154222753143.7171.16371357104308077883@sif>
Subject: Re: [Qemu-devel] [PATCH for-3.1 v2] build: qga: add macro to force
 use of native mingw32 assert()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Quoting Daniel P. Berrang=C3=A9 (2018-11-14 10:54:56)
> On Wed, Nov 14, 2018 at 10:44:38AM -0600, Michael Roth wrote:
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
> > be defined prior to inclusion of osdep.h for build targets that
> > don't link against glib.
> =

> Why doesn't it link to glib and can that be fixed ?

Not sure, the original commit (b39297ae) takes some steps specifically to
avoid a glib dependency, but I'm not sure what the underlying reasons were.
One downside is that it would require a static mingw glib dependency even
for non-static qemu/qemu-ga builds, but that's not too hard to deal with if
we add the appropriate configure checks/errors for it (especially
compared to satisfying the VSS SDK dependency...)

> =

> Glib is considered a mandatory dependancy on anything in QEMU that
> uses osdep.h, since that header pulls in the glib.h header unconditionall=
y.

Of the 3 source files in qga/vss-win32/:

install.cpp uses it for:

  #include <stdio.h>
  #include "config-host.h"
  #include "qemu-version.h"

requester.cpp uses it for:

  #include <stdio.h>
  #include <assert.h>
  #include "qemu/compiler.h" //for GCC_FMT_ATTR

and provider.cpp doesn't need it.

It's not much, but if linking with static glib isn't too bad that seems
like the simplest option, and might allow for some cleanups later (like
removing the struct Error stubs re-implementations in requester.h).

Thanks for the suggestions.

> =

> > Cc: Richard Henderson <richard.henderson@linaro.org>
> > Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> > ---
> > v2:
> >  * define USE_NATIVE_MINGW32_ASSERT via build recipe and avoid moving
> >    #include's before osdep.h (Philippe)
> > ---
> >  include/qemu/osdep.h        | 2 +-
> >  qga/vss-win32/Makefile.objs | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
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
> =

> I don't think we should have these kind of hacks.
> =

> Either make vss-win32 link to glib, or stop it importing
> osdep.h entirely if it really must be built completely
> standalone from normal QEMU dependancies.
> =

> >  #undef assert
> >  #define assert(x)  g_assert(x)
> >  #endif
> > diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
> > index 23d08da225..5773bfd868 100644
> > --- a/qga/vss-win32/Makefile.objs
> > +++ b/qga/vss-win32/Makefile.objs
> > @@ -3,7 +3,7 @@
> >  qga-vss-dll-obj-y +=3D requester.o provider.o install.o
> >  =

> >  obj-qga-vss-dll-obj-y =3D $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
> > -$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-prot=
otypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-=
style-definition -Wredundant-decls -fstack-protector-all -fstack-protector-=
strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor
> > +$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-prot=
otypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wold-=
style-definition -Wredundant-decls -fstack-protector-all -fstack-protector-=
strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-dtor -=
DUSE_NATIVE_MINGW32_ASSERT
> >  =

> >  $(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enab=
le-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
> >  $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vs=
s.def
> > -- =

> > 2.17.1
> > =

> > =

> =

> Regards,
> Daniel
> -- =

> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>=20
