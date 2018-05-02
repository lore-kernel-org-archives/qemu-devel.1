Received: from eggs.gnu.org ([2001:4830:134:3::10]:48816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzQg-0002i0-Kv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDzQf-0001rI-Cv
	for qemu-devel@nongnu.org; Wed, 02 May 2018 17:36:50 -0400
References: <20180502213219.7842-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4a341a93-f08b-c91a-f94e-b4c21dcc763e@redhat.com>
Date: Wed, 2 May 2018 23:36:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7S8j2NV6hblsm2jrS0EDg1iXuij8jOko2"
Subject: Re: [Qemu-devel] [Qemu-block] [RFC 0/7] block: Try to use correctly
 typed blockdev options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7S8j2NV6hblsm2jrS0EDg1iXuij8jOko2
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <4a341a93-f08b-c91a-f94e-b4c21dcc763e@redhat.com>
Subject: Re: [Qemu-block] [RFC 0/7] block: Try to use correctly typed blockdev
 options
References: <20180502213219.7842-1-mreitz@redhat.com>
In-Reply-To: <20180502213219.7842-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-02 23:32, Max Reitz wrote:
> (Sorry, Markus, sorry, Kevin, if this series makes you angry.)
>=20
> The subject says it all, I think.  The original issue I was assigned to=

> solve is this:
>=20
>     $ ./qemu-img info --image-opts driver=3Dnull-co,size=3D42
>     image: json:{"driver": "null-co", "size": "42"}
>     [...]
>=20
> As you can see, "size" gets a string value in the json:{} object
> although it is an integer, according to the QAPI schema.  (Buglink:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1534396)
>=20
> My first approach to fix this was to try to pipe the full_open_options
> dict generated in bdrv_refresh_filename() through a keyval input visito=
r
> and then an output visitor (which would have depended on my filename
> series).  This did not work out because bs->options (where all of the
> reconstructed options come from) may either be correctly typed or not,
> and keyval chokes on non-string values.  I could have probably converte=
d
> bs->options to fully string values before trying to pipe it through
> keyval, but I decided I didn't like that very much.  (I suppose I can b=
e
> convinced otherwise, though.)
>=20
> So I decided to venture into the territory of what we actually want at
> some point: Correctly typed bs->options.  Or, rather, in the end we wan=
t
> bs->options to be BlockdevOptions, but let's not be too hasty here.
>=20
> So it turns out that with really just a bit of work we can separate the=

> interfaces that generate correctly typed options (e.g. blockdev-add)
> from the ones that generate pure string-valued options (e.g. qemu-img
> --image-opts) rather well.  Once we have done that, we can pipe all of
> the pure string options through keyval and back to get correctly typed
> options.
>=20
> So far the theory.  Now, in practice we of course have pitfalls, and
> those are not addressed by this series, which is the main reason this i=
s
> an RFC.
>=20
> The first pitfall (I can see...) is that json:{} allows you to specify
> mixed options -- some values are incorrectly strings, others are
> non-strings.  keyval cannot cope with that, so the result after this
> series is that those options end up in bs->options just like that.  I
> suppose we could just forbid that mixed-typed case, though, and call it=

> a bug fix.
>=20
> The second problem (and I think the big reason why we have not
> approached this issue so far) is that there are options which you can
> give as strings, but which are not covered by the schema.  In such a
> case, the input visitor will reject the QDict and we will just use it
> as-is, that is, full of strings.  Now that is not what we want in the
> end, of course -- we want everything to be converted into something tha=
t
> is covered by the schema.
>=20
> My reasoning for sending this series anyway is that it doesn't make
> things worse (bs->options is a mess already, you can never be certain
> that it contains correctly typed values or just strings or both), and
> that it at least gives a starting point from which we can continue on.
> After this series, we have a clear separation between the interfaces
> that use purely string values and the ones that provide correct typing
> (well, and json:{}).
>=20
> Oh, and it fixes the above BZ for the more common cases.
>=20
>=20
> Max Reitz (7):
>   qdict: Add qdict_set_default_bool()
>   block: Let change-medium add detect-zeroes as bool
>   block: Make use of qdict_set_default_bool()
>   block: Add bdrv_open_string_opts()
>   block: Add blk_new_open_string_opts()
>   block: Use {blk_new,bdrv}_open_string_opts()
>   iotests: Test internal option typing
>=20
>  include/block/block.h          |  2 +
>  include/qapi/qmp/qdict.h       |  1 +
>  include/sysemu/block-backend.h |  2 +
>  block.c                        | 96 ++++++++++++++++++++++++++++++++++=
++++----
>  block/block-backend.c          | 30 ++++++++++++-
>  block/vvfat.c                  |  4 +-
>  blockdev.c                     | 33 ++++++++++-----
>  qemu-img.c                     |  3 +-
>  qemu-io.c                      |  2 +-
>  qemu-nbd.c                     |  2 +-
>  qobject/qdict.c                | 13 ++++++
>  tests/test-replication.c       |  6 +--
>  tests/qemu-iotests/089         | 12 ++++++
>  tests/qemu-iotests/089.out     |  5 +++
>  14 files changed, 183 insertions(+), 28 deletions(-)

(Forgot to mention: This series depends on my "qemu-io/img: Fix
-U/force-share conflict testing" series.

Based-on: <20180502202051.15493-1-mreitz@redhat.com>

But who builds an RFC anyway... *me ducks*)


--7S8j2NV6hblsm2jrS0EDg1iXuij8jOko2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrqL2kACgkQ9AfbAGHV
z0BUKQf/aB4xvT6v3Sgk7zMgg+7TYDj+aAcJNkrSMBI5BDo/qe6UZelG/7HjU1pi
OpnyheDunKZSqL8WZejeIo6Crzx/A59qqfgQUD613TcoFTVMU9hoxnnDhISAMoU+
gaLtTD+gl/ft32F+UsgqZcQQubE+8Lq+OaOdiG/Z5iYDSFTtSy866MtPeBiVCplQ
1qI+7EsrhQpa7I/ZSg2+NIvp1vgEdKmvjWD3f4hZTp1JdIxdv4tKRiemr9m1Qa1x
xkRYo21KQhBPhNQVsphXqOReoA42L7kzeTUv2kKgEWFWTQp9L8fd9Wn/MpgBpdpC
0A43kmDaJwOnJegdIvYWIvlwt6o85g==
=Mij/
-----END PGP SIGNATURE-----

--7S8j2NV6hblsm2jrS0EDg1iXuij8jOko2--
