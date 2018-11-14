Received: from eggs.gnu.org ([2001:4830:134:3::10]:53537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMyRW-0005DL-Sa
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:55:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gMyRS-0006XE-Vr
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:55:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gMyRS-0006Wk-Lg
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 11:55:02 -0500
Date: Wed, 14 Nov 2018 16:54:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181114165456.GS19298@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181114164438.6412-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181114164438.6412-1-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
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
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Wed, Nov 14, 2018 at 10:44:38AM -0600, Michael Roth wrote:
> When building qemu-ga for w32 with VSS support, some parts of qemu-ga
> are not linked against glib, specifically the C++ bits used to
> create the VSS provider DLL. With 3ebee3b191e, we now define assert()
> as g_assert() for all mingw32 builds via osdep.h, which results in the
> following build breakage:
>=20
>   x86_64-w64-mingw32-g++ -o qga/vss-win32/qga-vss.dll qga/vss-win32/req=
uester.o qga/vss-win32/provider.o qga/vss-win32/install.o /home/mdroth/w/=
qemu4.git/qga/vss-win32/qga-vss.def  -shared -Wl,--add-stdcall-alias,--en=
able-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
>   qga/vss-win32/requester.o: In function `requester_freeze':
>   /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:284: undefined r=
eference to `g_assertion_message_expr'
>   qga/vss-win32/requester.o: In function `requester_thaw':
>   /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:508: undefined r=
eference to `g_assertion_message_expr'
>   /home/mdroth/w/qemu4.git/qga/vss-win32/requester.cpp:509: undefined r=
eference to `g_assertion_message_expr'
>   collect2: error: ld returned 1 exit status
>   make: *** [/home/mdroth/w/qemu4.git/qga/vss-win32/Makefile.objs:10: q=
ga/vss-win32/qga-vss.dll] Error 1
>   make: *** Waiting for unfinished jobs....
>=20
> Fix this by introducing a USE_NATIVE_MINGW32_ASSERT macro that can
> be defined prior to inclusion of osdep.h for build targets that
> don't link against glib.

Why doesn't it link to glib and can that be fixed ?

Glib is considered a mandatory dependancy on anything in QEMU that
uses osdep.h, since that header pulls in the glib.h header unconditionall=
y.

> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
> v2:
>  * define USE_NATIVE_MINGW32_ASSERT via build recipe and avoid moving
>    #include's before osdep.h (Philippe)
> ---
>  include/qemu/osdep.h        | 2 +-
>  qga/vss-win32/Makefile.objs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> index 3bf48bcdec..59364bfeb0 100644
> --- a/include/qemu/osdep.h
> +++ b/include/qemu/osdep.h
> @@ -129,7 +129,7 @@ extern int daemon(int, int);
>   * code that is unreachable when features are disabled.
>   * All supported versions of Glib's g_assert() satisfy this requiremen=
t.
>   */
> -#ifdef __MINGW32__
> +#if defined(__MINGW32__) && !defined(USE_NATIVE_MINGW32_ASSERT)

I don't think we should have these kind of hacks.

Either make vss-win32 link to glib, or stop it importing
osdep.h entirely if it really must be built completely
standalone from normal QEMU dependancies.

>  #undef assert
>  #define assert(x)  g_assert(x)
>  #endif
> diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
> index 23d08da225..5773bfd868 100644
> --- a/qga/vss-win32/Makefile.objs
> +++ b/qga/vss-win32/Makefile.objs
> @@ -3,7 +3,7 @@
>  qga-vss-dll-obj-y +=3D requester.o provider.o install.o
> =20
>  obj-qga-vss-dll-obj-y =3D $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
> -$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-prot=
otypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wol=
d-style-definition -Wredundant-decls -fstack-protector-all -fstack-protec=
tor-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-=
dtor
> +$(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-prot=
otypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wol=
d-style-definition -Wredundant-decls -fstack-protector-all -fstack-protec=
tor-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-=
dtor -DUSE_NATIVE_MINGW32_ASSERT
> =20
>  $(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enab=
le-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
>  $(obj)/qga-vss.dll: $(obj-qga-vss-dll-obj-y) $(SRC_PATH)/$(obj)/qga-vs=
s.def
> --=20
> 2.17.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
