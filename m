Received: from eggs.gnu.org ([2001:4830:134:3::10]:40409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfQZI-000505-Dm
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:58:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfQZF-0004Dh-26
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:58:36 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:44212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfQZE-0004Ct-SW
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 08:58:33 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C32FF8BECC
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 14:58:29 +0200 (CEST)
Date: Wed, 9 Aug 2017 14:58:21 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809145821.4f58b939@bahia.lan>
In-Reply-To: <13af5639-c245-f186-6684-479665c700eb@redhat.com>
References: <150221331695.15915.4904484630739512874.stgit@bahia.lan>
	<9e56de2e-2c20-6e28-efd0-1f78b21a7be5@amsat.org>
	<9f3c0af6-1ff8-adca-9f69-2be8dd7d250f@redhat.com>
	<db1e220e-f3bf-352d-57ac-6ad3b427e944@amsat.org>
	<c26818de-c402-2db2-25f7-0e568ab41ddf@redhat.com>
	<13af5639-c245-f186-6684-479665c700eb@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/9zrlNAMkcIQQlX1cJXuVi73";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.10 PATCH] 9pfs: local: fix
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
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, Stefan Hajnoczi <stefanha@redhat.com>, zhiyong.wu@ucloud.cn, qemu-devel@nongnu.org

--Sig_/9zrlNAMkcIQQlX1cJXuVi73
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Aug 2017 15:28:35 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/08/2017 03:24 PM, Eric Blake wrote:
> > On 08/08/2017 03:10 PM, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> Technically, POSIX says (and 'man 2 open' agrees, modulo the fact that
> >>> Linux still lacks O_SEARCH) that you MUST provide one of the 5 access
> >>> modes (they are O_RDONLY, O_RDWR, O_WRONLY, O_EXEC, and O_SEARCH;
> >>> although POSIX allows O_EXEC and O_SEARCH to be the same bit pattern),
> >>> and then bitwise-or any additional flags.  So the usage here is corre=
ct.
> >>> =20
> >  =20
> >> Oh ok. I didn't think of that, just checked Linux manpage:
> >>
> >>    O_PATH (since Linux 2.6.39)
> >>
> >>           When O_PATH is specified in flags, flag bits other than
> >>           O_CLOEXEC, O_DIRECTORY, and O_NOFOLLOW are ignored. =20
> >=20
> > There are access modes (5 in POSIX), and then flag bits (O_NONBLOCK
> > being one of the flag bits, and therefore ignored when O_PATH is true).
> > Presumably, the author was being careful by mentioning "flag bits" (and
> > thereby implicitly meaning that O_RDONLY is NOT ignored when using
> > O_PATH).  But I'm not _quite_ sure whether O_PATH should be considered a
> > sixth access mode, or a flag bit, and the Linux man page doesn't help on
> > that front ;)  Hmm - if you treat O_PATH as an access mode rather than a
> > flag bit, then O_RDONLY | O_PATH no longer makes sense at all (you can't
> > mix two modes at once).  Maybe we should file a bug report against the
> > man page to get clarification. =20
>=20
> Quoting my version of 'man 2 open'
>=20
>        The  argument  flags  must  include  one of the following access
> modes:
>        O_RDONLY, O_WRONLY, or O_RDWR.  These request opening  the  file
> read-
>        only, write-only, or read/write, respectively.
>=20
>        In addition, zero or more file creation flags and file status
> flags can
>        be bitwise-or'd in flags.   The  file  creation  flags  are
> O_CLOEXEC,
>        O_CREAT,  O_DIRECTORY,  O_EXCL,  O_NOCTTY,  O_NOFOLLOW,
> O_TMPFILE, and
>        O_TRUNC.  The file status flags are all of the remaining  flags
> listed
>        below.   The  distinction between these two groups of flags is
> that the
>        file status flags can be retrieved and (in some  cases)
> modified;  see
>        fcntl(2) for details.
>=20
> and fcntl() lets you see whether an fd was opened with O_PATH, which
> makes it a file status flag.  Well, except that fcntl() also lets you
> see which mode an fd was opened with (such as O_WRONLY).  Hmm - still fuz=
zy.
>=20

I agree the documentation is unclear, but in linux/fs/open.c we have:

static inline int build_open_flags(int flags, umode_t mode, struct open_fla=
gs *op)
{
        int lookup_flags =3D 0;
        int acc_mode =3D ACC_MODE(flags);
[...]
        } else if (flags & O_PATH) {
                /*
                 * If we have O_PATH in the open flag. Then we
                 * cannot have anything other than the below set of flags
                 */
                flags &=3D O_DIRECTORY | O_NOFOLLOW | O_PATH;
                acc_mode =3D 0;
        }

This seems to indicate that the access mode is simply ignored.

So I guess it is ok to drop O_RDONLY, even if it isn't clearly documented
in the manpage... I don't have a strong opinion anyway.

--Sig_/9zrlNAMkcIQQlX1cJXuVi73
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLBu0ACgkQAvw66wEB28KoJgCgnQ/E4DkknWnXn/OzieXtZu7z
KZsAn1j1pBwatKN9lC9HVGz2ayyZDDQ2
=kB8k
-----END PGP SIGNATURE-----

--Sig_/9zrlNAMkcIQQlX1cJXuVi73--
