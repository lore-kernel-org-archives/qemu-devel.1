Received: from eggs.gnu.org ([2001:4830:134:3::10]:42658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfThz-0006oa-IE
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfThy-0000bP-2h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:19:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36648)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfThx-0000ZM-Pc
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:19:46 -0400
References: <150229440762.12920.17394043752149329973.stgit@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1732154b-1ed6-41e5-7dd2-c9062898ee4b@redhat.com>
Date: Wed, 9 Aug 2017 11:19:42 -0500
MIME-Version: 1.0
In-Reply-To: <150229440762.12920.17394043752149329973.stgit@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="E7qvMekkmUXR3vjqmRSqBhwn4n2D8od6n"
Subject: Re: [Qemu-devel] [for-2.10 PATCH v3] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E7qvMekkmUXR3vjqmRSqBhwn4n2D8od6n
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1732154b-1ed6-41e5-7dd2-c9062898ee4b@redhat.com>
Subject: Re: [for-2.10 PATCH v3] 9pfs: local: fix fchmodat_nofollow()
 limitations
References: <150229440762.12920.17394043752149329973.stgit@bahia.lan>
In-Reply-To: <150229440762.12920.17394043752149329973.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 11:00 AM, Greg Kurz wrote:
> This function has to ensure it doesn't follow a symlink that could be u=
sed
> to escape the virtfs directory. This could be easily achieved if fchmod=
at()
> on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, bu=
t
> it doesn't. There was a tentative to implement a new fchmodat2() syscal=
l
> with the correct semantics:
>=20
> https://patchwork.kernel.org/patch/9596301/
>=20
> but it didn't gain much momentum. Also it was suggested to look at a O_=
PATH

s/a O_PATH/an O_PATH/

> based solution in the first place.
>=20
> The current implementation covers most use-cases, but it notably fails =
if:
> - the target path has access rights equal to 0000 (openat() returns EPE=
RM),
>   =3D> once you've done chmod(0000) on a file, you can never chmod() ag=
ain
> - the target path is UNIX domain socket (openat() returns ENXIO)
>   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs
>=20
> The solution is to use O_PATH: openat() now succeeds in both cases, and=
 we
> can ensure the path isn't a symlink with fstat(). The associated entry =
in
> "/proc/self/fd" can hence be safely passed to the regular chmod() sysca=
ll.

My late-breaking question from v2 remains: fstat() on O_PATH only works
in kernel 3.6 and newer; are we worried about kernels in the window of
2.6.39 (when O_PATH was introduced) and 3.5?  Or at this point, are we
reasonably sure that platforms are either too old for O_PATH at all
(Hello RHEL 6, with 2.6.32), or else new enough that we aren't going to
have spurious failures due to fstat() not doing what we want?

I don't actually know the failure mode of fstat() on kernel 3.5, so if
someone cares about that working (presumably because they are on a
platform with such a kernel), please speak up. (Or even run my test
program included on the v1 thread, to show us what happens)

> +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
> +#ifndef O_PATH

Please make this '#if O_PATH' or even '#if O_PATH_9P_UTIL'; as it might
be feasible for someone to

#ifndef O_PATH
#define O_PATH 0
#endif

where the macro is defined but the feature is not present, messing up
our code if we only check for a definition.

> +#else
> +    /* Now we handle racing symlinks. */
> +    ret =3D fstat(fd, &stbuf);
> +    if (ret) {
> +        goto out;

This may leave errno at an unusual value for fchmodat(), if we are on
kernel 3.5.  But until someone speaks up that it matters, I'm okay
saving any cleanup work in that area for a followup patch.

> +    }
> +    if (S_ISLNK(stbuf.st_mode)) {
> +        errno =3D ELOOP;
> +        ret =3D -1;
> +        goto out;
> +    }
> +
> +    {
> +        char *proc_path =3D g_strdup_printf("/proc/self/fd/%d", fd);
> +        ret =3D chmod(proc_path, mode);
> +        g_free(proc_path);
> +    }
> +#endif
> +out:

Swap these two lines - your only use of 'goto out' are under the O_PATH
branch, and therefore you get a compilation failure about unused label
on older glibc.

With the #if condition fixed and the scope of the #endif fixed,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--E7qvMekkmUXR3vjqmRSqBhwn4n2D8od6n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLNh4ACgkQp6FrSiUn
Q2og7Af9Ezl3NEHPe6x7qpDrM6qLKk4HngWcrvVAI1X5QSL3XrIW94pWHQO/MOD9
P7n6QfWZjVWBo568bf15WeEeEwZy2+AMVWRttxyrXNru1O58YS1ViAkZ1wsgx+GZ
UvsGlKNsl1UFw5gSbbtgFhXsDM/zC5aCvJFSyefWY2Z3E/1v6CATS81PXRIdmLh5
9rz0nyONRzyMa2I30JJRwzhXrNmlzyOv6LY3mEFKiYR0qG33n9joFOBJWf1bE8pB
54AFTe5s/d1Fz2kfxDjc5+7aohBpnufwce9dTBaXQWVdb95wF/VzeZ5/cjlj1Lmi
ulqfuhCHWqyA9oWTXbFJUzTfIMXauA==
=3akq
-----END PGP SIGNATURE-----

--E7qvMekkmUXR3vjqmRSqBhwn4n2D8od6n--
