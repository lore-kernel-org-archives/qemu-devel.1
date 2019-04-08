Received: from eggs.gnu.org ([209.51.188.92]:59725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZ5S-0002UD-RX
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:33:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDZ5R-0002az-Gq
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:33:42 -0400
References: <20190408083627.7479-1-armbru@redhat.com>
	<20190408083627.7479-3-armbru@redhat.com>
	<20190408172202.GH3926@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com>
Date: Mon, 8 Apr 2019 20:33:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190408172202.GH3926@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB"
Subject: Re: [Qemu-devel] Whither qemu's ssh driver? (was: Re: [PATCH 02/15]
 block/ssh: Do not report read/write/flush errors to the user)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, ptoscano@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB
From: Max Reitz <mreitz@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, ptoscano@redhat.com, berrange@redhat.com
Message-ID: <d40c9fd6-6ae2-95f3-2f63-151ee1f13d0f@redhat.com>
Subject: Re: Whither qemu's ssh driver? (was: Re: [PATCH 02/15] block/ssh: Do
 not report read/write/flush errors to the user)
References: <20190408083627.7479-1-armbru@redhat.com>
 <20190408083627.7479-3-armbru@redhat.com> <20190408172202.GH3926@redhat.com>
In-Reply-To: <20190408172202.GH3926@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.04.19 19:22, Richard W.M. Jones wrote:
> I don't know much about this patch which looks like internal qemu
> rearrangements so I guess fine.  However I do have a few things to say
> about the ssh driver ...
>=20
> As you know I wrote this a few years ago, and it uses libssh2.
> libssh2 has not evolved as quickly as we'd like and it may be better
> to use libssh instead -- despite the names, these are two separate and
> unrelated libraries.  libssh supports a wider range of SSH encryption
> and has more features.  It's generally more likely to work against a
> random SSH server.  It has also been through the FIPS process.  Indeed
> Red Hat made the decision to switch exclusively to libssh in RHEL 8,
> if that carries any weight.
>=20
> Pino posted a libssh2 -> libssh conversion patch a while back, but it
> has been somewhat stuck in review.  If I recall the latest concern was
> whether it performs as well as the libssh2 version.
>=20
>   https://lists.gnu.org/archive/html/qemu-devel/2018-06/msg07267.html
>=20
> In the meantime I added libssh support to nbdkit.  nbdkit can be used
> as a complete replacement for qemu's ssh driver.
>=20
>   nbdkit ssh host=3Dfoo.example.com disk.img -U tmpdirXXXXXX/sock
>   qemu -hda nbd:unix:tmpdirXXXXXX/sock
>=20
> In fact it's somewhat superior (IMHO) because all of the tricky code
> handling libssh runs outside qemu in a separate process, improving
> isolation and potentially allowing separate, restrictive security
> policies to be applied.  For example it would no longer be necessary
> to give qemu permission to connect to remote SSH servers.
>=20
> Could we make this really smooth somehow?  nbdkit has a concept
> [https://www.mankier.com/1/nbdkit-captive] where we make it easy to
> manage external commands owned by nbdkit.  Is there an equivalent
> feature of qemu where:
>=20
>   qemu -object exec,id=3Dnbd1,cmd=3D'nbdkit -f -U $sock ssh ...' \
>        -drive file.driver=3Dnbd,file.socket=3Dnbd1
>=20
> would run the command but also allocate a socket and kill the
> subcommand on exit (of qemu)?
>=20
> Basically I'm trying to think about how to make this a reality:
>=20
>   https://rwmj.files.wordpress.com/2018/10/drawing2-svg.png
>=20
> Rich.

I don=E2=80=99t disagree with anything you say.  I would prefer to move t=
he less
well maintained drivers (for which there is no strict performance
requirement) into a separate process.  nbdkit is perfectly suited for
that, and the drivers are there, as you say (ssh, curl, vvfat).

Having a nicer interface in qemu would make the transition simple,
because we could tell users exactly how to change their command line so
their use case continues to work.  I=E2=80=99m not sure whether it really=
 works,
though, because I don=E2=80=99t think there is such a simple replacement =
for
being able to simply pass "ssh://host/path" to qemu and have it work.

But I think it=E2=80=99s still worth it.

Max


--adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyrk/IACgkQ9AfbAGHV
z0AFRAf7BoU58cNYAaKkUiTPDMvaMPUpWqWn3TYyJA7cyaOoiARh/nvhrx4iXJSg
yoesVHmnWnAsjcK6lseLyoGQxeuqrZX8hWIrcmy2tTLJNX4OS7ffmQqrkJ347DK8
GQAJpEwWdBxtCfv956JS2jM6f3yiKh5vQpX9auteJA2WZ4eVRROtcHEIZ+283r+O
gZWbMkUvMOIXk7+BfSganz3SeEZRdER+tf/usR6i4mtgD7ZbqOvVdeUXZO5qDqqo
yicDkq2DtYt/k1wxbl4X3W/ISGNXr7voDmohta5M2wfD37PpWtrqDzIeLLBE/zuL
L8hyQH7sRhAezikt8yFG68eXD9yXGA==
=SNfH
-----END PGP SIGNATURE-----

--adjrWjB2gRXjuQItw1jypAmoqGzeJzUYB--
