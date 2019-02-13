Received: from eggs.gnu.org ([209.51.188.92]:57302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtqaa-0003Dc-Lo
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:12:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gtqaS-0004l3-Bx
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 04:12:18 -0500
Date: Wed, 13 Feb 2019 09:12:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190213091206.GB13960@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190212212917.26977-1-mdroth@linux.vnet.ibm.com>
	<20190212212917.26977-2-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190212212917.26977-2-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] qga-win: include glib when building
 VSS DLL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Tue, Feb 12, 2019 at 03:29:16PM -0600, Michael Roth wrote:
> Commit 3ebee3b191e defined assert() as g_assert(), but when we build
> the VSS DLL component of QGA (to handle fsfreeze) we do not include
> glib, which results in breakage when building with VSS support enabled.
>=20
> Fix this by including glib. Since the VSS DLL is built statically,
> this introduces an additional dependency on static glib and supporting
> libs for the mingw environment (possibly why we didn't include glib
> originally), but VSS support already has very specific prerequisites
> so it shouldn't affect too many build environments.
>=20
> Since the VSS DLL code does use qemu/osdep.h, this should also help
> avoid future breakages and possibly allow for some clean ups in current
> VSS code.
>=20
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  qga/vss-win32/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/qga/vss-win32/Makefile.objs b/qga/vss-win32/Makefile.objs
> index 23d08da225..dad9d1b0ba 100644
> --- a/qga/vss-win32/Makefile.objs
> +++ b/qga/vss-win32/Makefile.objs
> @@ -5,7 +5,7 @@ qga-vss-dll-obj-y +=3D requester.o provider.o install.o
>  obj-qga-vss-dll-obj-y =3D $(addprefix $(obj)/, $(qga-vss-dll-obj-y))
>  $(obj-qga-vss-dll-obj-y): QEMU_CXXFLAGS =3D $(filter-out -Wstrict-prot=
otypes -Wmissing-prototypes -Wnested-externs -Wold-style-declaration -Wol=
d-style-definition -Wredundant-decls -fstack-protector-all -fstack-protec=
tor-strong, $(QEMU_CFLAGS)) -Wno-unknown-pragmas -Wno-delete-non-virtual-=
dtor
> =20
> -$(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enab=
le-stdcall-fixup -lole32 -loleaut32 -lshlwapi -luuid -static
> +$(obj)/qga-vss.dll: LDFLAGS =3D -shared -Wl,--add-stdcall-alias,--enab=
le-stdcall-fixup -lglib-2.0 -lole32 -loleaut32 -lshlwapi -luuid -lintl -l=
ws2_32 -static

Adding -lglib-2.0 makes sense, but your commit message doesn't explain
why -lintl or -lws2_32 are being added & they don't really make sense
to me.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
