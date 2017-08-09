Received: from eggs.gnu.org ([2001:4830:134:3::10]:46831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfTtG-0002T1-KN
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:31:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfTtD-0006qQ-Fa
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:31:26 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:54510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfTtD-0006q1-92
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:31:23 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B111089247
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 18:31:21 +0200 (CEST)
Date: Wed, 9 Aug 2017 18:31:14 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809183114.0795c35c@bahia.lan>
In-Reply-To: <1732154b-1ed6-41e5-7dd2-c9062898ee4b@redhat.com>
References: <150229440762.12920.17394043752149329973.stgit@bahia.lan>
	<1732154b-1ed6-41e5-7dd2-c9062898ee4b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/SrRrZU+3veupFfa12r8VZ01";
	protocol="application/pgp-signature"
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
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

--Sig_/SrRrZU+3veupFfa12r8VZ01
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 11:19:42 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/09/2017 11:00 AM, Greg Kurz wrote:
> > This function has to ensure it doesn't follow a symlink that could be u=
sed
> > to escape the virtfs directory. This could be easily achieved if fchmod=
at()
> > on linux honored the AT_SYMLINK_NOFOLLOW flag as described in POSIX, but
> > it doesn't. There was a tentative to implement a new fchmodat2() syscall
> > with the correct semantics:
> >=20
> > https://patchwork.kernel.org/patch/9596301/
> >=20
> > but it didn't gain much momentum. Also it was suggested to look at a O_=
PATH =20
>=20
> s/a O_PATH/an O_PATH/
>=20

Fixed.

> > based solution in the first place.
> >=20
> > The current implementation covers most use-cases, but it notably fails =
if:
> > - the target path has access rights equal to 0000 (openat() returns EPE=
RM), =20
> >   =3D> once you've done chmod(0000) on a file, you can never chmod() ag=
ain =20
> > - the target path is UNIX domain socket (openat() returns ENXIO) =20
> >   =3D> bind() of UNIX domain sockets fails if the file is on 9pfs =20
> >=20
> > The solution is to use O_PATH: openat() now succeeds in both cases, and=
 we
> > can ensure the path isn't a symlink with fstat(). The associated entry =
in
> > "/proc/self/fd" can hence be safely passed to the regular chmod() sysca=
ll. =20
>=20
> My late-breaking question from v2 remains: fstat() on O_PATH only works

Yeah I saw your mail just after sending the v3 :)

> in kernel 3.6 and newer; are we worried about kernels in the window of
> 2.6.39 (when O_PATH was introduced) and 3.5?  Or at this point, are we
> reasonably sure that platforms are either too old for O_PATH at all
> (Hello RHEL 6, with 2.6.32), or else new enough that we aren't going to
> have spurious failures due to fstat() not doing what we want?
>=20
> I don't actually know the failure mode of fstat() on kernel 3.5, so if
> someone cares about that working (presumably because they are on a
> platform with such a kernel), please speak up. (Or even run my test
> program included on the v1 thread, to show us what happens)
>=20

That seems reasonable to me.

> > +    fd =3D openat_file(dirfd, name, O_RDONLY | O_PATH_9P_UTIL, 0);
> > +#ifndef O_PATH =20
>=20
> Please make this '#if O_PATH' or even '#if O_PATH_9P_UTIL'; as it might
> be feasible for someone to
>=20
> #ifndef O_PATH
> #define O_PATH 0
> #endif
>=20
> where the macro is defined but the feature is not present, messing up
> our code if we only check for a definition.
>=20

Ok, I'll do that.

> > +#else
> > +    /* Now we handle racing symlinks. */
> > +    ret =3D fstat(fd, &stbuf);
> > +    if (ret) {
> > +        goto out; =20
>=20
> This may leave errno at an unusual value for fchmodat(), if we are on
> kernel 3.5.  But until someone speaks up that it matters, I'm okay
> saving any cleanup work in that area for a followup patch.
>=20

Agreed.

> > +    }
> > +    if (S_ISLNK(stbuf.st_mode)) {
> > +        errno =3D ELOOP;
> > +        ret =3D -1;
> > +        goto out;
> > +    }
> > +
> > +    {
> > +        char *proc_path =3D g_strdup_printf("/proc/self/fd/%d", fd);
> > +        ret =3D chmod(proc_path, mode);
> > +        g_free(proc_path);
> > +    }
> > +#endif
> > +out: =20
>=20
> Swap these two lines - your only use of 'goto out' are under the O_PATH
> branch, and therefore you get a compilation failure about unused label
> on older glibc.
>=20

Oops.

> With the #if condition fixed and the scope of the #endif fixed,
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks !

--Sig_/SrRrZU+3veupFfa12r8VZ01
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLONIACgkQAvw66wEB28IfPwCfZJGAxRChfWjmJzIbjBbo5Z1c
Kd4AnjqXcczoRaJL3KuX2zUKAfJd4Ei1
=BtGt
-----END PGP SIGNATURE-----

--Sig_/SrRrZU+3veupFfa12r8VZ01--
