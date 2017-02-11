Received: from eggs.gnu.org ([2001:4830:134:3::10]:32961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ccUHV-0006bF-Ho
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 04:47:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ccUHS-0006ew-Bb
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 04:47:49 -0500
Received: from 8.mo179.mail-out.ovh.net ([46.105.75.26]:45987)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ccUHS-0006bQ-1N
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 04:47:46 -0500
Received: from player732.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 387A4217A4
	for <qemu-devel@nongnu.org>; Sat, 11 Feb 2017 10:47:36 +0100 (CET)
Date: Sat, 11 Feb 2017 10:47:32 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170211104732.3e5f4569@bahia.lan>
In-Reply-To: <c5731fb9-3768-499b-d5ae-d1087f47619c@amsat.org>
References: <148640163738.20116.15256467457494672940.stgit@bahia>
	<c5731fb9-3768-499b-d5ae-d1087f47619c@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/v_4Z_HJUqUdxJ4IQqvPnpqx";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/v_4Z_HJUqUdxJ4IQqvPnpqx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Feb 2017 01:25:17 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Greg,
>=20

Hi Philippe,

> On 02/06/2017 02:20 PM, Greg Kurz wrote:
> > Replies from the virtfs proxy are made up of a fixed-size header (8 byt=
es)
> > and a payload of variable size (maximum 64kb). When receiving a reply,
> > the proxy backend first reads the whole header and then unmarshals it.
> > If the header is okay, it then does the same operation with the payload.
> >
> > Since the proxy backend uses a pre-allocated buffer which has enough ro=
om
> > for a header and the maximum payload size, marshalling should never fail
> > with fixed size arguments. Let's make this clear with assertions.
> >
> > This should also address Coverity's complaints CID 1348519 and CID 1348=
520,
> > about not always checking the return value of proxy_unmarshal().
> >
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/9pfs/9p-proxy.c |   22 +++++++++++-----------
> >  1 file changed, 11 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> > index f4aa7a9d70f8..4ad42a1ad158 100644
> > --- a/hw/9pfs/9p-proxy.c
> > +++ b/hw/9pfs/9p-proxy.c
> > @@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, =
int type,
> >          return retval;
> >      }
> >      reply->iov_len =3D PROXY_HDR_SZ;
> > -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> > +    retval =3D proxy_unmarshal(reply, 0, "dd", &header.type, &header.s=
ize);
> > +    assert(retval =3D=3D 8); =20
>=20
> I'd be more specific:
>=20
> assert(retval =3D=3D PROXY_HDR_SZ);
>=20

I deliberately chose to open code values according to the format string. No
matter what could happen to the code, "dd" means two 32-bit integers, i.e.
8 bytes... and to be honest, I don't find this PROXY_HDR_SZ macro that
useful, the code should use 8 as well, the same way we use 7 for the size
of the 9P header (size[4] type[1] tag[2]).

> >      /*
> >       * if response size > PROXY_MAX_IO_SZ, read the response but ignor=
e it and
> >       * return -ENOBUFS
> > @@ -194,9 +195,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, =
int type,
> >      if (header.type =3D=3D T_ERROR) {
> >          int ret;
> >          ret =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> > -        if (ret < 0) {
> > -            *status =3D ret;
> > -        }
> > +        assert(ret =3D=3D 4); =20
>=20
> assert(ret =3D=3D sizeof(status));
>=20

If status is converted to a larger type, this assertion will trigger, even
though 4 is really what we expect when passing "d".

Cheers.

--
Greg

> >          return 0;
> >      }
> >
> > @@ -213,6 +212,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, =
int type,
> >                                   &prstat.st_atim_sec, &prstat.st_atim_=
nsec,
> >                                   &prstat.st_mtim_sec, &prstat.st_mtim_=
nsec,
> >                                   &prstat.st_ctim_sec, &prstat.st_ctim_=
nsec);
> > +        assert(retval =3D=3D sizeof(prstat));
> >          prstat_to_stat(response, &prstat);
> >          break;
> >      }
> > @@ -225,6 +225,7 @@ static int v9fs_receive_response(V9fsProxy *proxy, =
int type,
> >                                   &prstfs.f_files, &prstfs.f_ffree,
> >                                   &prstfs.f_fsid[0], &prstfs.f_fsid[1],
> >                                   &prstfs.f_namelen, &prstfs.f_frsize);
> > +        assert(retval =3D=3D sizeof(prstfs));
> >          prstatfs_to_statfs(response, &prstfs);
> >          break;
> >      }
> > @@ -246,7 +247,8 @@ static int v9fs_receive_response(V9fsProxy *proxy, =
int type,
> >          break;
> >      }
> >      case T_GETVERSION:
> > -        proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
> > +        retval =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "q", response);
> > +        assert(retval =3D=3D 8); =20
>=20
> assert(retval =3D=3D PROXY_HDR_SZ);
>=20
> >          break;
> >      default:
> >          return -1;
> > @@ -274,18 +276,16 @@ static int v9fs_receive_status(V9fsProxy *proxy,
> >          return retval;
> >      }
> >      reply->iov_len =3D PROXY_HDR_SZ;
> > -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> > -    if (header.size !=3D sizeof(int)) {
> > -        *status =3D -ENOBUFS;
> > -        return 0;
> > -    }
> > +    retval =3D proxy_unmarshal(reply, 0, "dd", &header.type, &header.s=
ize);
> > +    assert(retval =3D=3D 8); =20
>=20
> same
>=20
> >      retval =3D socket_read(proxy->sockfd,
> >                           reply->iov_base + PROXY_HDR_SZ, header.size);
> >      if (retval < 0) {
> >          return retval;
> >      }
> >      reply->iov_len +=3D header.size;
> > -    proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> > +    retval =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> > +    assert(retval =3D=3D 4); =20
>=20
> assert(ret =3D=3D sizeof(status));
>=20
> >      return 0;
> >  }
> >
> >
> > =20


--Sig_/v_4Z_HJUqUdxJ4IQqvPnpqx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlie3bQACgkQAvw66wEB28KoLwCfYe8O0FkVaWZPsb2zUyEJ1V7H
pwYAoKSzzsG2vDAIhyw1fFOAQMQXzzPl
=sjwo
-----END PGP SIGNATURE-----

--Sig_/v_4Z_HJUqUdxJ4IQqvPnpqx--
