Received: from eggs.gnu.org ([209.51.188.92]:50996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlnT-00083v-1U
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:45:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1hLlnP-0000on-Vd
	for qemu-devel@nongnu.org; Wed, 01 May 2019 05:45:03 -0400
Date: Wed, 1 May 2019 10:44:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190501094452.GQ29808@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1556666645.git.alistair.francis@wdc.com>
	<14aab381eaa678eca875d0b8bd456feb22a21bd8.1556666645.git.alistair.francis@wdc.com>
	<503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <503a1f5f-7dad-1e4e-e1b1-aaeeeac9739f@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/5] linux-user/uname: Fix GCC 9 build
 warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair23@gmail.com" <alistair23@gmail.com>, "kraxel@redhat.com" <kraxel@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On Wed, May 01, 2019 at 11:40:13AM +0200, Laurent Vivier wrote:
> On 01/05/2019 01:28, Alistair Francis wrote:
> > Fix this warning when building with GCC9 on Fedora 30:
> > In function =E2=80=98strncpy=E2=80=99,
> >     inlined from =E2=80=98sys_uname=E2=80=99 at /home/alistair/qemu/l=
inux-user/uname.c:94:3:
> > /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builti=
n_strncpy=E2=80=99 output may be truncated copying 64 bytes from a string=
 of length 64 [-Werror=3Dstringop-truncation]
> >   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos=
 (__dest));
> >       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~
> >=20
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  linux-user/uname.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/linux-user/uname.c b/linux-user/uname.c
> > index 313b79dbad..2fc6096a5b 100644
> > --- a/linux-user/uname.c
> > +++ b/linux-user/uname.c
> > @@ -73,7 +73,7 @@ const char *cpu_to_uname_machine(void *cpu_env)
> >  #define COPY_UTSNAME_FIELD(dest, src) \
> >    do { \
> >        /* __NEW_UTS_LEN doesn't include terminating null */ \
> > -      (void) strncpy((dest), (src), __NEW_UTS_LEN); \
> > +      (void) memcpy((dest), (src), MIN(strlen(src), __NEW_UTS_LEN));=
 \
>=20
> You should use MIN(strlen(src) + 1, __NEW_UTS_LEN) to copy the NUL
> character if it is present and fit in __NEW_UTS_LEN.

IMHO we shouldn't use strlen at all. I proposed fixing it using sizeof()
instead here:

  https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02154.html

>=20
> >        (dest)[__NEW_UTS_LEN] =3D '\0'; \
> >    } while (0)

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
