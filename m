Received: from eggs.gnu.org ([2001:4830:134:3::10]:50554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG8Qu-0000wr-Pa
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dG8Qq-00049Q-Se
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:33:24 -0400
Received: from 19.mo5.mail-out.ovh.net ([46.105.35.78]:43810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dG8Qq-00048U-M2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 14:33:20 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DCC52FE1E7
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 20:33:18 +0200 (CEST)
Date: Wed, 31 May 2017 20:33:11 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170531203311.116e89fc@bahia.lan>
In-Reply-To: <20170531194046.6d6eed0f@p-imbrenda.boeblingen.de.ibm.com>
References: <20170531150933.10156-1-alex.bennee@linaro.org>
	<20170531150933.10156-3-alex.bennee@linaro.org>
	<20170531181737.230cbded@p-imbrenda.boeblingen.de.ibm.com>
	<20170531183324.03bf98fe@bahia.lan>
	<20170531185106.126f19ac@p-imbrenda.boeblingen.de.ibm.com>
	<20170531190629.1cd2089d@bahia.lan>
	<20170531194046.6d6eed0f@p-imbrenda.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/r/0DcbPLRRvycv6y06Xob//";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] gdbstub: don't fail on vCont; C04:0;
 c packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, pbonzini@redhat.com, doug16k@gmail.com, qemu-devel@nongnu.org

--Sig_/r/0DcbPLRRvycv6y06Xob//
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 31 May 2017 19:40:46 +0200
Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:

> On Wed, 31 May 2017 19:06:29 +0200
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > On Wed, 31 May 2017 18:51:06 +0200
> > Claudio Imbrenda <imbrenda@linux.vnet.ibm.com> wrote:
> > [...] =20
> > > > >=20
> > > > > This is strange. cpu_index() is defined as:
> > > > >=20
> > > > > static inline int cpu_index(CPUState *cpu)
> > > > > {
> > > > > #if defined(CONFIG_USER_ONLY)
> > > > >     return cpu->host_tid;
> > > > > #else
> > > > >     return cpu->cpu_index + 1;
> > > > > #endif
> > > > > }
> > > > >=20
> > > > > therefore it shouldn't return 0 under any circumstance,
> > > > > and       =20
> > > >=20
> > > > I think it is 0 for first_cpu in user mode.     =20
> > >=20
> > > in linux-user/syscall.c:
> > >=20
> > > info->tid =3D gettid();
> > > cpu->host_tid =3D info->tid;
> > >=20
> > > kernel thread-ids are system-wide unique and can't be 0
> > >     =20
> >=20
> > This is correct but these lines are in clone_func(). This gets called
> > for all threads but the "main" thread which I believe to be
> > associated to first_cpu. =20
>=20
> then IMHO that is a bug and it needs to be corrected. the host_tid
> should be, well, the host tid, and not 0, which is never a valid
> tid for Linux.
>=20

I tend to agree indeed. It isn't a problem for user mode though since it
doesn't use @host_tid. Only gdbstub does.

$ git grep host_tid
include/exec/gdbstub.h:    return cpu->host_tid;
include/qom/cpu.h: * @host_tid: Host thread ID.
include/qom/cpu.h:    uint32_t host_tid;
linux-user/syscall.c:    cpu->host_tid =3D info->tid;

> the current behaviour is simply the easiest for the "any CPU" case.
> Picking the last CPU or a random one would still be correct, and in
> that case there would be no way to explicitly address the first CPU.
>=20

I'm not familiar enough with gdbstub to know if this is a real problem.
But I guess it is possible to add a "first_cpu->host_tid =3D gettid();" line
somewhere in linux-user/main.c.

--Sig_/r/0DcbPLRRvycv6y06Xob//
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkvDGcACgkQAvw66wEB28IihgCgkpgKuEdUcTse+t/oD0cZIzz3
D70An1rdWEi3VyDQh13Cls8CmVK5nTXf
=lKFq
-----END PGP SIGNATURE-----

--Sig_/r/0DcbPLRRvycv6y06Xob//--
