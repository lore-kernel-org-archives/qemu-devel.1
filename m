Received: from eggs.gnu.org ([2001:4830:134:3::10]:46614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiHFE-0005u1-Ad
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiHFB-0001iU-CK
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:42:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33900 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fiHFB-0001gJ-4t
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:42:09 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 91D2E412D7CC
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 10:42:07 +0000 (UTC)
Date: Wed, 25 Jul 2018 12:42:05 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180725104205.GB23742@vader>
References: <20180720154425.31285-1-marcandre.lureau@redhat.com>
	<20180720154425.31285-2-marcandre.lureau@redhat.com>
	<20180720160039.GO16700@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="v9Ux+11Zm5mwPlX6"
Content-Disposition: inline
In-Reply-To: <20180720160039.GO16700@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] seccomp: use SIGSYS signal instead of
 killing the thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pmoore@redhat.com


--v9Ux+11Zm5mwPlX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20/07/2018 - 17:00:39, Daniel P. Berrange wrote:
> On Fri, Jul 20, 2018 at 05:44:24PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> > The seccomp action SCMP_ACT_KILL results in immediate termination of
> > the thread that made the bad system call. However, qemu being
> > multi-threaded, it keeps running. There is no easy way for parent
> > process / management layer (libvirt) to know about that situation.
> >=20
> > Instead, the default SIGSYS handler when invoked with SCMP_ACT_TRAP
> > will terminate the program and core dump.
> >=20
> > This may not be the most secure solution, but probably better than
> > just killing the offending thread. SCMP_ACT_KILL_PROCESS has been
> > added in Linux 4.14 to improve the situation, which I propose to use
> > by default if available in the next patch.
>=20
> Note that seccomp doesn't promise to protect against all  types
> of vulnerability in a program. It merely aims to stop the program
> executing designated system calls.
>=20
> Using SCMP_ACT_TRAP still prevents syscal execution to exactly the
> same extent that SCMP_ACT_KILL does, so its security level is the
> same.
>=20
> What differs is that the userspace app has option to ignore the
> syscall and carry on instead of being killed. A malicous attacker
> would thus have option to try to influence other parts of QEMU
> todo bad stuff, but if they already have control over the userspace
> process to this extent, they can likely do such bad stuff even
> before executing the syscalls
>=20
> So I don't think there's any significant difference in security
> protection here.  Mostly the difference is just about what the
> crash will look like. A full process crash (from the default
> signal handler) looks better than a thread crash for the reasons
> you've explained.

I guess that's the whole point of having the process killed instead of the=
=20
thread. Seccomp is not a big security feature alone by itself, but rather
combined with others techniques.

Marc, from what we've already discussed I think these patches are good enou=
gh
for now. Thanks a lot for the contribution.

>=20
> >=20
> > Related to:
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456
> >=20
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  qemu-seccomp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> > index 9cd8eb9499..b117a92559 100644
> > --- a/qemu-seccomp.c
> > +++ b/qemu-seccomp.c
> > @@ -125,7 +125,7 @@ static int seccomp_start(uint32_t seccomp_opts)
> >              continue;
> >          }
> > =20
> > -        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_KILL, blacklist[i]=
=2Enum,
> > +        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_TRAP, blacklist[i]=
=2Enum,
> >                                      blacklist[i].narg, blacklist[i].ar=
g_cmp);
> >          if (rc < 0) {
> >              goto seccomp_return;
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20

Acked-by: Eduardo Otubo <otubo@redhat.com>

--v9Ux+11Zm5mwPlX6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWFP9AAoJEN8y58Dw//miNgAIALE2srv0LDesCJxQx7st2GQj
j0sRJFr57JPns+2mmkxm6dvpogq2N211i4a9iWIsY3uEks8Zyw/zSoNUPfZOUOlR
kxsZqIARFNYp0zWmnBMueHhpwO1s8d6PL7d9WKgFAo5YRMW/mSyMscWNkK8i8aze
xhmqHGmFIdKyuvIloctaXdhc8BzXPl4R71cSlzXx4uR0EBukAlIhgTsr8rDhCAYw
8QZRYjtzue1bKICkNeWXdPAfHeVvEPZKVYir5rvg1eIx2sYUjNzsZQIkG+bM741E
8S04mgQTTPeYnxpks8ndYKO1EWJL7aWqJfF18geEmlbMC/r5GgTAslhFr4pUW+8=
=p8NA
-----END PGP SIGNATURE-----

--v9Ux+11Zm5mwPlX6--
