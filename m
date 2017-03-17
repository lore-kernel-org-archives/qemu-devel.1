Received: from eggs.gnu.org ([2001:4830:134:3::10]:39706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cou7f-0004dn-LU
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cou7b-0007c5-MK
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:48:59 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:53979)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cou7b-0007bf-FJ
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 11:48:55 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 8BE851DF6B
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 16:48:52 +0100 (CET)
Date: Fri, 17 Mar 2017 16:48:49 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317164849.6bf958e3@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20170317144300.GK8050@redhat.com>
References: <148976155089.11859.11860739290129101204.stgit@bahia>
	<20170317144300.GK8050@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/SbNhxBd7GVvtBK6EslHs/Dy";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: proxy: assert if unmarshal fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

--Sig_/SbNhxBd7GVvtBK6EslHs/Dy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Mar 2017 14:43:00 +0000
"Daniel P. Berrange" <berrange@redhat.com> wrote:

> On Fri, Mar 17, 2017 at 03:39:10PM +0100, Greg Kurz wrote:
> > Replies from the virtfs proxy are made up of a fixed-size header (8 byt=
es)
> > and a payload of variable size (maximum 64kb). When receiving a reply,
> > the proxy backend first reads the whole header and then unmarshals it.
> > If the header is okay, it then does the same operation with the payload.
> >=20
> > Since the proxy backend uses a pre-allocated buffer which has enough ro=
om
> > for a header and the maximum payload size, marshalling should never fail
> > with fixed size arguments. Any error here is likely to result from a mo=
re
> > serious corruption in QEMU and we'd better dump core right away.
> >=20
> > This patch adds error checks where they are missing and converts the
> > associated error paths into assertions.
> >=20
> > Note that we don't want to use sizeof() in the checks since the value
> > we want to use depends on the format rather than the size of the buffer.
> > Short marshal formats can be handled with numerical values. Size macros
> > are introduced for bigger ones (ProxyStat and ProxyStatFS).
> >=20
> > This should also address Coverity's complaints CID 1348519 and CID 1348=
520,
> > about not always checking the return value of proxy_unmarshal().
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > v2: - added PROXY_STAT_SZ and PROXY_STATFS_SZ macros
> >     - updated changelog
> > ---
> >  hw/9pfs/9p-proxy.c |   24 +++++++++++++-----------
> >  hw/9pfs/9p-proxy.h |   10 ++++++++--
> >  2 files changed, 21 insertions(+), 13 deletions(-)
> >=20
> > diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> > index f4aa7a9d70f8..363bea66035e 100644
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
> > +    assert(retval =3D=3D 8);
> >      /*
> >       * if response size > PROXY_MAX_IO_SZ, read the response but ignor=
e it and
> >       * return -ENOBUFS
> > @@ -194,15 +195,14 @@ static int v9fs_receive_response(V9fsProxy *proxy=
, int type,
> >      if (header.type =3D=3D T_ERROR) {
> >          int ret;
> >          ret =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> > -        if (ret < 0) {
> > -            *status =3D ret;
> > -        }
> > +        assert(ret =3D=3D 4);
> >          return 0;
> >      }
> > =20
> >      switch (type) {
> >      case T_LSTAT: {
> >          ProxyStat prstat;
> > +        QEMU_BUILD_BUG_ON(sizeof(prstat) !=3D PROXY_STAT_SZ); =20
>=20
> I'd just put this assert at the struct declaration
>=20
> ..snip...
>=20
> > diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
> > index b84301d001b0..918c45016a3c 100644
> > --- a/hw/9pfs/9p-proxy.h
> > +++ b/hw/9pfs/9p-proxy.h
> > @@ -79,7 +79,10 @@ typedef struct {
> >      uint64_t st_mtim_nsec;
> >      uint64_t st_ctim_sec;
> >      uint64_t st_ctim_nsec;
> > -} ProxyStat;
> > +} QEMU_PACKED ProxyStat;
> > +
> > +#define PROXY_STAT_SZ \
> > +    (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8) =20
>=20
> eg.
>=20
>   QEMU_BUILD_BUG_ON(sizeof(ProxyStat) !=3D
>       (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8));
>=20

Makes sense. I'll send a v3.

Thanks.

--
Greg

>=20
> Regards,
> Daniel


--Sig_/SbNhxBd7GVvtBK6EslHs/Dy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljMBWEACgkQAvw66wEB28JLkgCeNNfK86134C+n4miCWrXU6MGp
kb8An3tzh89ZVrrQMVVkNhN/GbGoruWQ
=yCG+
-----END PGP SIGNATURE-----

--Sig_/SbNhxBd7GVvtBK6EslHs/Dy--
