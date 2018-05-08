Received: from eggs.gnu.org ([2001:4830:134:3::10]:33221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG4PD-00023X-2X
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fG4P9-0004SR-SP
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:19:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51414 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fG4P9-0004S6-N4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:19:51 -0400
Date: Tue, 8 May 2018 16:19:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180508151940.GC5967@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504160026.14017-4-berrange@redhat.com>
	<752b52d8-2990-13d7-753c-36aafc5f0041@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <752b52d8-2990-13d7-753c-36aafc5f0041@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] glib: enforce the minimum required
 version and warn about old APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On Tue, May 08, 2018 at 05:17:40PM +0200, Paolo Bonzini wrote:
> On 04/05/2018 18:00, Daniel P. Berrang=C3=A9 wrote:
> > There are two useful macros that can be defined before including
> > glib.h that are related to the min required glib version
> >=20
> >  - GLIB_VERSION_MIN_REQUIRED
> >=20
> >    When this is defined, if code uses an API that was deprecated
> >    in this version, or older, a compiler warning will be emitted.
> >    This alerts maintainers to update their code to whatever new
> >    replacement API is now recommended best practice.
> >=20
> >  - GLIB_VERSION_MAX_ALLOWED
> >=20
> >    When this is defined, if code uses an API that was introduced
> >    in a version that is newer than the declared version, a compiler
> >    warning will be emitted. This alerts maintainers if new code
> >    accidentally uses functionality that won't be available on some
> >    supported platforms.
> >=20
> > The GLIB_VERSION_MAX_ALLOWED constant makes it a bit harder to opt
> > in to using specific new APIs with a GLIB_CHECK_VERSION conditional.
> > To workaround this Pragmas can be used to temporarily turn off the
> > -Wdeprecated-declarations compiler warning, while a static inline
> > compat function is implemented. Nothing needs that at this time,
> > so just illustrate it in a comment for benefit of future changes.
>=20
> Unfortunately there is one need, and it's a bug in glib itself:
>=20
> In file included from /usr/lib64/glib-2.0/include/glibconfig.h:9:0,
>                  from /usr/include/glib-2.0/glib/gtypes.h:32,
>                  from /usr/include/glib-2.0/glib/galloca.h:32,
>                  from /usr/include/glib-2.0/glib.h:30,
>                  from /home/pbonzini/work/upstream/qemu/include/glib-co=
mpat.h:29,
>                  from /home/pbonzini/work/upstream/qemu/include/qemu/os=
dep.h:107,
>                  from /home/pbonzini/work/upstream/qemu/disas/arm-a64.c=
c:21:
> /usr/include/glib-2.0/glib/glib-autocleanups.h: In function =E2=80=98vo=
id glib_autoptr_cleanup_GOptionGroup(GOptionGroup**)=E2=80=99:
> /usr/include/glib-2.0/glib/glib-autocleanups.h:63:45: error: =E2=80=98v=
oid g_option_group_unref(GOptionGroup*)=E2=80=99 is deprecated (declared =
at /usr/include/glib-2.0/glib/goption.h:372): Not available before 2.44 [=
-Werror=3Ddeprecated-declarations]
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(GOptionGroup, g_option_group_unref)
>                                              ^
> /usr/include/glib-2.0/glib/gmacros.h:444:88: note: in definition of mac=
ro =E2=80=98G_DEFINE_AUTOPTR_CLEANUP_FUNC=E2=80=99
>    static inline void _GLIB_AUTOPTR_FUNC_NAME(TypeName) (TypeName **_pt=
r) { if (*_ptr) (func) (*_ptr); }         \
>                                                                        =
                 ^
> /usr/include/glib-2.0/glib/gmacros.h:444:100: error: =E2=80=98void g_op=
tion_group_unref(GOptionGroup*)=E2=80=99 is deprecated (declared at /usr/=
include/glib-2.0/glib/goption.h:372): Not available before 2.44 [-Werror=3D=
deprecated-declarations]
>    static inline void _GLIB_AUTOPTR_FUNC_NAME(TypeName) (TypeName **_pt=
r) { if (*_ptr) (func) (*_ptr); }         \
>                                                                        =
                             ^
> /usr/include/glib-2.0/glib/glib-autocleanups.h:63:1: note: in expansion=
 of macro =E2=80=98G_DEFINE_AUTOPTR_CLEANUP_FUNC=E2=80=99
>  G_DEFINE_AUTOPTR_CLEANUP_FUNC(GOptionGroup, g_option_group_unref)
>=20
> (This is RHEL7 glib2-2.50.3-3.el7.x86_64).
>=20
> Luckily you suggested the solution yourself---this seems to work:
>=20
> diff --git a/include/glib-compat.h b/include/glib-compat.h
> index d066f6d..ef07489 100644
> --- a/include/glib-compat.h
> +++ b/include/glib-compat.h
> @@ -26,6 +26,8 @@
>   */
>  #define GLIB_VERSION_MAX_ALLOWED GLIB_VERSION_2_42
> =20
> +_Pragma("GCC diagnostic push")
> +_Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
>  #include <glib.h>
> =20
>  /*
> @@ -42,8 +44,6 @@
>   * signature that does what we need, but with a "_qemu"
>   * suffix eg
>   *
> - * _Pragma("GCC diagnostic push")
> - * _Pragma("GCC diagnostic ignored \"-Wdeprecated-declarations\"")
>   * static inline void g_foo_qemu(const char *wibble)
>   * {
>   *     #if GLIB_CHECK_VERSION(X, Y, 0)
> @@ -52,12 +52,10 @@
>   *        g_something_equivalent_in_older_glib(wibble);
>   *     #endif
>   * }
> - * _Pragma("GCC diagnostic pop")
>   *
> - * The Pragma calls turn off -Wdeprecated-declarations,
> - * ensuring this wrapper function impl doesn't trigger the
> - * compiler warning about using too new glib APIs. Finally
> - * we can do
> + * The _Pragma at the top of this file turns off -Wdeprecated-declarat=
ions,
> + * ensuring this wrapper function impl doesn't trigger the compiler wa=
rning
> + * about using too new glib APIs. Finally we can do
>   *
>   *   #define g_foo(a) g_foo_qemu(a)
>   *
> @@ -94,4 +92,6 @@ gint g_poll_fixed(GPollFD *fds, guint nfds, gint time=
out);
>      } while (0)
>  #endif
> =20
> +_Pragma("GCC diagnostic pop")
> +
>  #endif
>=20
> I'll give it a shot on clang too.

Ok, that change looks fine with me assuming it passes your build tests.
In fact that is what I had done in an earlier version.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
