Received: from eggs.gnu.org ([209.51.188.92]:53046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggxiq-0001Gy-U9
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:11:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ggxin-0000yN-P0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 15:11:36 -0500
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <187ceef9-dc1f-4748-6d0c-dd97a3a85c7e@redhat.com>
Date: Tue, 8 Jan 2019 14:11:16 -0600
MIME-Version: 1.0
In-Reply-To: <20190108194552.45453-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="aQNM3bqVHHMVKjVdfevC2bhxCyoOaKw02"
Subject: Re: [Qemu-devel] [PATCH] file-posix: add rough-block-status
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--aQNM3bqVHHMVKjVdfevC2bhxCyoOaKw02
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, fam@euphon.net, stefanha@redhat.com, den@openvz.org
Message-ID: <187ceef9-dc1f-4748-6d0c-dd97a3a85c7e@redhat.com>
Subject: Re: [PATCH] file-posix: add rough-block-status parameter
References: <20190108194552.45453-1-vsementsov@virtuozzo.com>
In-Reply-To: <20190108194552.45453-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/8/19 1:45 PM, Vladimir Sementsov-Ogievskiy wrote:
> bdrv_co_block_status digs bs->file for additional, more accurate search=

> for hole inside region, reported as DATA by bs since 5daa74a6ebc.
>=20
> This accuracy is not free: assume we have qcow2 disk. Actually, qcow2
> knows, where are holes and where is data.

Not when it is has been preallocated (at which point the qcow2 metadata
says the entire file is data, even though much of it may still be zeroes)=
=2E

> But every block_status
> request calls lseek additionally. Assume a big disk, full of
> data, in any iterative copying block job (or img convert) we'll call
> lseek(HOLE) on every iteration, and each of these lseeks will have to
> iterate through all metadata up to the end of file. It's obviously
> ineffective behavior. And for many scenarios we don't need this lseek
> at all.

This part is true, and we have had several complaints from various
places about the time spent doing lseek()s where the block layer fails
to cache what was learned on the previous iteration, coupled with
inefficient kernel/filesystem implementations where lseek is not as
cheap as it should be.

>=20
> So, add an option to omit calling lseek.

The commit message would do well with an example showing the usage of
the parameter via a typical qemu-img command line that is currently
negatively impacted.  Or even better, where is the iotests change that
serves as a unit test of the new knob?

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>=20
> Hi all!
>=20
> This is a continuation of "do not lseek in qcow2 block_status" thread
> (https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg05749.html)
>=20
>  qapi/block-core.json |  6 +++++-
>  block/file-posix.c   | 13 ++++++++++++-
>  2 files changed, 17 insertions(+), 2 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 762000f31f..ec5549e5c2 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2645,6 +2645,9 @@
>  #                         migration.  May cause noticeable delays if t=
he image
>  #                         file is large, do not use in production.
>  #                         (default: off) (since: 3.0)

Pre-existing: "off" isn't a valid QAPI bool; better would be fixing all
instances of this to "default: false".

> +# @rough-block-status: If set, on block-status querying assume that th=
e whole
> +#                      file is data and do not try to find holes throu=
gh system
> +#                      calls (default: off) (since 4.0)

You merely copied and pasted bad wording for the default section, but
you might as well fix it, whether or not we also fix the other instances
in a separate patch.

Possible better wording:
@rough-block-status: True to skip system calls that probe for holes when
querying for block status (default: false)

Bike-shedding: Since the point of this knob is to skip zero probing,
could we instead name it '@probe-zeroes: True to use lseek to probe for
holes (default: true)'?

>  #
>  # Since: 2.9
>  ##
> @@ -2653,7 +2656,8 @@
>              '*pr-manager': 'str',
>              '*locking': 'OnOffAuto',
>              '*aio': 'BlockdevAioOptions',
> -            '*x-check-cache-dropped': 'bool' } }
> +            '*x-check-cache-dropped': 'bool',
> +            '*rough-block-status': 'bool' } }
> =20
>  ##
>  # @BlockdevOptionsNull:
> diff --git a/block/file-posix.c b/block/file-posix.c
> index d8f0b93752..3f6d76a5dc 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -167,6 +167,7 @@ typedef struct BDRVRawState {
>      bool has_fallocate;
>      bool needs_alignment;
>      bool check_cache_dropped;
> +    bool rough_block_status;
> =20
>      PRManager *pr_mgr;
>  } BDRVRawState;
> @@ -439,6 +440,13 @@ static QemuOptsList raw_runtime_opts =3D {
>              .type =3D QEMU_OPT_BOOL,
>              .help =3D "check that page cache was dropped on live migra=
tion (default: off)"
>          },
> +        {
> +            .name =3D "rough-block-status",
> +            .type =3D QEMU_OPT_BOOL,
> +            .help =3D "If set, on block-status querying assume that th=
e whole "
> +                    "file is data and do not try to find holes through=
 system "
> +                    "calls (default: off)"

Whatever wording changes we make to QAPI should be copied here.

The idea makes sense, but without unit test coverage, I'm reluctant to
leave R-b yet.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--aQNM3bqVHHMVKjVdfevC2bhxCyoOaKw02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw1A+QACgkQ3g5py3or
ov0fkQf+OHuAYLUNCNmi0UttYqyEqJ09JPJtk858ROQ5ascUhJk3ZNopk7KnJjnB
JA3yr3MmGejkiG7iIJMiarXv48OljHgZ3LIFLj4af9mUJIYFZaqtl5fTnGQmnEmJ
zEZG+GDgAZ2WgwLO7B/UC6/t+svVUcNlSjRfKYkAgDbAWnwGMMh3r3DXG0/kKq1l
Z7uAvIjJu/akoBi45t1UfMAv3IJyeiwYmcY7KilA0he/oy6ZD0zLH8upNQOw16Rm
Z6sHamxmDzTnjfOaEqjKJQrcpm6F6ZC0AD26tP7Vh4VgczX+l9EF2aPAvMXBxTXb
gc+jMe7PqjC9csjCXuX6vbmDqtqtmg==
=aJ9x
-----END PGP SIGNATURE-----

--aQNM3bqVHHMVKjVdfevC2bhxCyoOaKw02--
