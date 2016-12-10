Received: from eggs.gnu.org ([2001:4830:134:3::10]:45571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFi9T-0008LF-A4
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 08:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cFi9O-0007Xu-Eo
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 08:57:23 -0500
Received: from 8.mo6.mail-out.ovh.net ([178.33.42.204]:42516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cFi9O-0007XI-8W
	for qemu-devel@nongnu.org; Sat, 10 Dec 2016 08:57:18 -0500
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 880286677A
	for <qemu-devel@nongnu.org>; Sat, 10 Dec 2016 14:57:13 +0100 (CET)
Date: Sat, 10 Dec 2016 14:57:08 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20161210145708.7a1d7b93@bahia>
In-Reply-To: <85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
References: <148127558476.2633.13433882390740185948.stgit@bahia>
	<148127568042.2633.5084932697061472826.stgit@bahia>
	<85cb0570-87e5-8396-dd04-eb6400226278@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/d6ERiLuZEc9oj4RY/8ZoObm";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 3/8] 9pfs: fix P9_NOTAG and P9_NOFID macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/d6ERiLuZEc9oj4RY/8ZoObm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 9 Dec 2016 15:25:55 -0600
Eric Blake <eblake@redhat.com> wrote:

> On 12/09/2016 03:28 AM, Greg Kurz wrote:
> > The u16 and u32 types don't exist in QEMU common headers. It never broke
> > build because these two macros aren't use by the current code, but this
> > is about to change with the future addition of functional tests for 9P.
> >=20
> > This patch convert the types to uintXX_t.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p.h |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> > index 3976b7fe3dcd..89c904bdb7e7 100644
> > --- a/hw/9pfs/9p.h
> > +++ b/hw/9pfs/9p.h
> > @@ -99,8 +99,8 @@ enum p9_proto_version {
> >      V9FS_PROTO_2000L =3D 0x02,
> >  };
> > =20
> > -#define P9_NOTAG    (u16)(~0)
> > -#define P9_NOFID    (u32)(~0)
> > +#define P9_NOTAG    (uint16_t)(~0)
> > +#define P9_NOFID    (uint32_t)(~0) =20
>=20
> Don't you want to write ((uint16_t)(~0)), to ensure that this expression
> can be used as a drop-in in any other syntactical situation?
>=20

These defines come from the linux kernel sources and I must admit it
didn't cross my mind... can you share a case where this would cause
troubles ?

> Or even write it as UINT16_C(~0) (using <stdint.h>), or as UINT16_MAX.
> (Be aware: the type of (uint16_t)(~0) is uint16_t, while the type of
> UINT16_MAX is int, due to the rules of integer promotion, if that matters)
>=20

UINT16_C(~0) expands to ~0 and UINT16_MAX expands to (65535), at least on
my laptop (glibc-headers-2.23.1-11.fc24.x86_64)... doesn't that mean the
type of UINT16_C(~0) is also int ? Please enlighten me.

The 9P spec at http://man.cat-v.org/plan_9/5/version says "(ushort)~0". My
understanding is 16 bits all ones. I guess I'd rather then go for
((uint16_t)(~0)).

Thanks!

--
Greg

--Sig_/d6ERiLuZEc9oj4RY/8ZoObm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlhMCbQACgkQAvw66wEB28LrCQCfZH/dIvBjeIdLooUkne90zXbN
c1AAmgJupevWU6E7vU8/dtqchuALjYfQ
=bvzq
-----END PGP SIGNATURE-----

--Sig_/d6ERiLuZEc9oj4RY/8ZoObm--
