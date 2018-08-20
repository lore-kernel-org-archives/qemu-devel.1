Received: from eggs.gnu.org ([2001:4830:134:3::10]:49735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1frgkT-0000Ow-Rg
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:45:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1frgkP-000554-Qb
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:45:21 -0400
Received: from mail-by2nam01on0105.outbound.protection.outlook.com
	([104.47.34.105]:40242
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1frgkP-00052E-EB
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 05:45:17 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Mon, 20 Aug 2018 09:45:11 +0000
Message-ID: <BN7PR08MB4868E801C917548C44678D88C6320@BN7PR08MB4868.namprd08.prod.outlook.com>
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534182832-554-82-git-send-email-aleksandar.markovic@rt-rk.com>,
	<c9eb581f-3f03-c28e-4095-3064e556f7c0@members.leeds.ac.uk>
In-Reply-To: <c9eb581f-3f03-c28e-4095-3064e556f7c0@members.leeds.ac.uk>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v8 81/87] linux-user: Add support for
 statx() syscall for all platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>, Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Paul Burton <pburton@wavecomp.com>, Stefan Markovic <smarkovic@wavecomp.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "richard.henderson@linaro.org" <richard.henderson@linaro.org>, "laurent@vivier.eu" <laurent@vivier.eu>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>

> From: Timothy Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> Sent: Monday, August 20, 2018 9:48 AM
>=20
> Subject: Re: [PATCH v8 81/87] linux-user: Add support for statx() syscall=
 for all platforms
>=20
> On 13/08/18 18:53, Aleksandar Markovic wrote:
> > From: Aleksandar Rikalo <arikalo@wavecomp.com>
> >
> > Implement support for translation of system call statx(). The
> > implementation includes invoking other (more mature) syscalls
> > (from the same 'stat' family) on the host side. This way,
> > problems of availability of statx() on the host side are
> > avoided.
> >
> > Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> > Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
> > ---
> >   linux-user/syscall.c      | 121 +++++++++++++++++++++++++++++++++++++=
++++++++-
> >   linux-user/syscall_defs.h |  38 +++++++++++++++
> >   2 files changed, 158 insertions(+), 1 deletion(-)
> >
>=20
>=20
> > +            if ((p =3D=3D NULL) || (*((char *)p) =3D=3D 0)) {
> > +                /* By file descriptor */
> > +                ret =3D get_errno(fstat(dirfd, &st));
> > +                unlock_user(p, arg2, 0);
> > +            } else if (*((char *)p) =3D=3D '/') {
> > +                /* Absolute pathname */
> > +                ret =3D get_errno(stat(path(p), &st));
> > +                unlock_user(p, arg2, 0);
> > +            } else {
> > +                if (dirfd =3D=3D AT_FDCWD) {
> > +                    /* Pathname relative to the current working direct=
ory */
> > +                    ret =3D get_errno(stat(path(p), &st));
> > +                    unlock_user(p, arg2, 0);
> > +                } else {
> > +                    /*
> > +                     * Pathname relative to the directory referred to =
by the
> > +                     * file descriptor dirfd
> > +                     */
> > +                    ret =3D get_errno(fstatat(dirfd, path(p), &st, fla=
gs));
> > +                    unlock_user(p, arg2, 0);
> > +                }
> > +            }
>=20
> This doesn't correctly handle the flags argument, it is ignored unless a
> relative path and directory file descriptor is provided.

Hi, Timothy.

Agreed. The patch generally needs certain improvements wrt handling origina=
l statx() arguments. I would certianly add handling the mask argument.

> As such an implementation of lstat that uses statx will be broken.
>=20
> Since fstatat exists since 2.6.16 this can be reduced to a call to fstata=
t.

I am not sure what you meant here. I think QEMU lstat() implementation does=
 not use statx(). This implementation of statx() uses hosts's statx(), and,=
 as a fallback, host's fstat(), stat(), and fstatat().

I would like to add that I think this patch should be submitted separately,=
 out of this series.

Yours,
Aleksandar
