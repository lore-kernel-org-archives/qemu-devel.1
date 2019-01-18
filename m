Received: from eggs.gnu.org ([209.51.188.92]:47736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkRE7-0008AU-FG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:18:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gkRE6-00030U-DQ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:18:15 -0500
Date: Fri, 18 Jan 2019 10:18:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190118101806.GF20660@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190118101114.11759-1-rjones@redhat.com>
	<20190118101114.11759-2-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190118101114.11759-2-rjones@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com

On Fri, Jan 18, 2019 at 10:11:14AM +0000, Richard W.M. Jones wrote:
> On FreeBSD 11.2:
>=20
>   $ nbdkit memory size=3D1M --run './qemu-io -f raw -c "aio_write 0 512=
" $nbd'
>   Parsing error: non-numeric argument, or extraneous/unrecognized suffi=
x -- aio_write
>=20
> After main option parsing, we reinitialize optind so we can parse each
> command.  However reinitializing optind to 0 does not work on FreeBSD.
> What happens when you do this is optind remains 0 after the option
> parsing loop, and the result is we try to parse argv[optind] =3D=3D
> argv[0] =3D=3D "aio_write" as if it was the first parameter.
>=20
> The FreeBSD manual page says:
>=20
>   In order to use getopt() to evaluate multiple sets of arguments, or t=
o
>   evaluate a single set of arguments multiple times, the variable optre=
set
>   must be set to 1 before the second and each additional set of calls t=
o
>   getopt(), and the variable optind must be reinitialized.
>=20
> (From the rest of the man page it is clear that optind must be
> reinitialized to 1).
>=20
> The glibc man page says:
>=20
>   A program that scans multiple argument vectors,  or  rescans  the  sa=
me
>   vector  more than once, and wants to make use of GNU extensions such =
as
>   '+' and '-' at  the  start  of  optstring,  or  changes  the  value  =
of
>   POSIXLY_CORRECT  between scans, must reinitialize getopt() by resetti=
ng
>   optind to 0, rather than the traditional value of 1.  (Resetting  to =
 0
>   forces  the  invocation  of  an  internal  initialization  routine th=
at
>   rechecks POSIXLY_CORRECT and checks for GNU extensions in optstring.)
>=20
> This commit introduces an OS-portability function called
> qemu_reset_optind which provides a way of resetting optind that works
> on FreeBSD and platforms that use optreset, while keeping it the same
> as now on other platforms.
>=20
> Note that the qemu codebase sets optind in many other places, but in
> those other places it's setting a local variable and not using getopt.
> This change is only needed in places where we are using getopt and the
> associated global variable optind.
>=20
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  configure            | 14 ++++++++++++++
>  include/qemu/osdep.h | 16 ++++++++++++++++
>  qemu-img.c           |  2 +-
>  qemu-io-cmds.c       |  2 +-
>  4 files changed, 32 insertions(+), 2 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>



Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
