Received: from eggs.gnu.org ([2001:4830:134:3::10]:53519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coupy-0003AS-QP
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:34:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1coupv-00089g-JX
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:34:46 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:41863)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1coupv-00082l-9v
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 12:34:43 -0400
Received: from player738.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 7216D1DE41
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 17:34:34 +0100 (CET)
Date: Fri, 17 Mar 2017 17:34:29 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170317173429.3de37f9f@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <1e00c09b-c5c6-1f72-8494-d135f842cd63@amsat.org>
References: <148976155089.11859.11860739290129101204.stgit@bahia>
	<20170317144300.GK8050@redhat.com>
	<1e00c09b-c5c6-1f72-8494-d135f842cd63@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/JSZn2dhMOa9woQ3jMbKPujq";
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
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

--Sig_/JSZn2dhMOa9woQ3jMbKPujq
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Mar 2017 12:06:39 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 03/17/2017 11:43 AM, Daniel P. Berrange wrote:
> > On Fri, Mar 17, 2017 at 03:39:10PM +0100, Greg Kurz wrote: =20
> >> Replies from the virtfs proxy are made up of a fixed-size header (8 by=
tes)
> >> and a payload of variable size (maximum 64kb). When receiving a reply,
> >> the proxy backend first reads the whole header and then unmarshals it.
> >> If the header is okay, it then does the same operation with the payloa=
d.
> >>
> >> Since the proxy backend uses a pre-allocated buffer which has enough r=
oom
> >> for a header and the maximum payload size, marshalling should never fa=
il
> >> with fixed size arguments. Any error here is likely to result from a m=
ore
> >> serious corruption in QEMU and we'd better dump core right away.
> >>
> >> This patch adds error checks where they are missing and converts the
> >> associated error paths into assertions.
> >>
> >> Note that we don't want to use sizeof() in the checks since the value
> >> we want to use depends on the format rather than the size of the buffe=
r.
> >> Short marshal formats can be handled with numerical values. Size macros
> >> are introduced for bigger ones (ProxyStat and ProxyStatFS). =20
>=20
> :) maybe this comment should go somewhere in <hw/9pfs/9p-proxy.h>
>=20
> >> This should also address Coverity's complaints CID 1348519 and CID 134=
8520,
> >> about not always checking the return value of proxy_unmarshal().
> >>
> >> Signed-off-by: Greg Kurz <groug@kaod.org>
> >> ---
> >> v2: - added PROXY_STAT_SZ and PROXY_STATFS_SZ macros
> >>     - updated changelog
> >> ---
> >>  hw/9pfs/9p-proxy.c |   24 +++++++++++++-----------
> >>  hw/9pfs/9p-proxy.h |   10 ++++++++--
> >>  2 files changed, 21 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/hw/9pfs/9p-proxy.c b/hw/9pfs/9p-proxy.c
> >> index f4aa7a9d70f8..363bea66035e 100644
> >> --- a/hw/9pfs/9p-proxy.c
> >> +++ b/hw/9pfs/9p-proxy.c
> >> @@ -165,7 +165,8 @@ static int v9fs_receive_response(V9fsProxy *proxy,=
 int type,
> >>          return retval;
> >>      }
> >>      reply->iov_len =3D PROXY_HDR_SZ;
> >> -    proxy_unmarshal(reply, 0, "dd", &header.type, &header.size);
> >> +    retval =3D proxy_unmarshal(reply, 0, "dd", &header.type, &header.=
size);
> >> +    assert(retval =3D=3D 8);
> >>      /*
> >>       * if response size > PROXY_MAX_IO_SZ, read the response but igno=
re it and
> >>       * return -ENOBUFS
> >> @@ -194,15 +195,14 @@ static int v9fs_receive_response(V9fsProxy *prox=
y, int type,
> >>      if (header.type =3D=3D T_ERROR) {
> >>          int ret;
> >>          ret =3D proxy_unmarshal(reply, PROXY_HDR_SZ, "d", status);
> >> -        if (ret < 0) {
> >> -            *status =3D ret;
> >> -        }
> >> +        assert(ret =3D=3D 4);
> >>          return 0;
> >>      }
> >>
> >>      switch (type) {
> >>      case T_LSTAT: {
> >>          ProxyStat prstat;
> >> +        QEMU_BUILD_BUG_ON(sizeof(prstat) !=3D PROXY_STAT_SZ); =20
> >
> > I'd just put this assert at the struct declaration
> >
> > ..snip...
> > =20
> >> diff --git a/hw/9pfs/9p-proxy.h b/hw/9pfs/9p-proxy.h
> >> index b84301d001b0..918c45016a3c 100644
> >> --- a/hw/9pfs/9p-proxy.h
> >> +++ b/hw/9pfs/9p-proxy.h
> >> @@ -79,7 +79,10 @@ typedef struct {
> >>      uint64_t st_mtim_nsec;
> >>      uint64_t st_ctim_sec;
> >>      uint64_t st_ctim_nsec;
> >> -} ProxyStat;
> >> +} QEMU_PACKED ProxyStat;
> >> +
> >> +#define PROXY_STAT_SZ \
> >> +    (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8) =
=20
> >
> > eg.
> >
> >   QEMU_BUILD_BUG_ON(sizeof(ProxyStat) !=3D
> >       (8 + 8 + 8 + 4 + 4 + 4 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8));=
 =20
>=20
> or
>=20
>      QEMU_BUILD_BUG_ON(sizeof(ProxyStat) !=3D
>          proxy_unmarshal_calcsize("qqqdddqqqqqqqqqq"));
>=20

The purpose of QEMU_BUILD_BUG_ON(x) is to break the build if the condition
is false.

It expands to something like:

typedef struct { int:(cond) ? -1 : 1; } qemu_build_bug_on__5 __attribute__(=
(unused));

and causes gcc to fail if cond is 0:

error: negative width in bit-field =E2=80=98<anonymous>=E2=80=99

This really only makes sense if cond is constant, otherwise gcc complains w=
ith:

error: bit-field =E2=80=98<anonymous>=E2=80=99 width not an integer constant

And I can't think of any way of implementing proxy_unmarshal_calcsize() so
that it boils down to a constant at build time. Also, the protocol is stable
and won't ever change: it is ok to compute the sizes once and for all.

> or eventually stricter using some gcc/clang Statement Expressions:
>=20
> #define proxy_unmarshal_strict(in_sg, in_sg_sz, offset, fmt, args...) \
>      ({ \
>          ssize_t retval; \
>          retval =3D v9fs_iov_unmarshal(in_sg, 1, offset, 0, fmt, ##args);=
 \
>          QEMU_BUILD_BUG_ON(in_sg_sz !=3D proxy_unmarshal_calcsize(fmt)); \

This should be an assert() actually, and, again, proxy_unmarshal_calcsize()
cannot be a constant, and I certainly don't want to do anything but compari=
ng
two integers here at runtime.

>          retval; \
>      })
>=20
> so we could use:
>=20
>      retval =3D proxy_unmarshal_strict(reply, sizeof(reply), 0, "dd",
>                                      &header.type, &header.size);
>=20

I wanted to do something like this initially but I decided not to because
of the reasons exposed above. But if you have a solution, I'll gladly
give a try. :)

Thanks

--
Greg


> >
> >
> > Regards,
> > Daniel
> > =20


--Sig_/JSZn2dhMOa9woQ3jMbKPujq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljMEBUACgkQAvw66wEB28IR8gCfTkkn/bzOh+hUJEgDAtCYcZ2q
P1AAoJjQsVf1o3bgBxmaGz//zyh5F8gK
=Jx0t
-----END PGP SIGNATURE-----

--Sig_/JSZn2dhMOa9woQ3jMbKPujq--
