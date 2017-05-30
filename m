Received: from eggs.gnu.org ([2001:4830:134:3::10]:60768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFiWt-0006VF-Gk
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:53:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFiWq-0000DL-UJ
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:53:51 -0400
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
	<20170530104857.70083-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
Date: Tue, 30 May 2017 09:53:34 -0500
MIME-Version: 1.0
In-Reply-To: <20170530104857.70083-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BGC3nRXkLhnmKLx1T8viLQgx1M6ivisx0"
Subject: Re: [Qemu-devel] [PATCH 1/4] block: add bdrv_get_format_alloc_stat
 format interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BGC3nRXkLhnmKLx1T8viLQgx1M6ivisx0
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <21763282-556d-4389-29b5-664f6f4f4479@redhat.com>
Subject: Re: [PATCH 1/4] block: add bdrv_get_format_alloc_stat format
 interface
References: <20170530104857.70083-1-vsementsov@virtuozzo.com>
 <20170530104857.70083-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170530104857.70083-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 05:48 AM, Vladimir Sementsov-Ogievskiy wrote:
> The function should collect statistics, about allocted/unallocated by
> top-level format driver space (in its .file) and allocation status
> (allocated/hole/after eof) of corresponding areas in this .file.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 16 ++++++++++++++++
>  include/block/block.h     |  3 +++
>  include/block/block_int.h |  2 ++
>  qapi/block-core.json      | 26 ++++++++++++++++++++++++++
>  4 files changed, 47 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 50ba264143..7d720ae0c2 100644
> --- a/block.c

> +++ b/qapi/block-core.json
> @@ -139,6 +139,32 @@
>             '*format-specific': 'ImageInfoSpecific' } }
> =20
>  ##
> +# @BlockFormatAllocInfo:
> +#
> +# Information about allocations, including metadata. All fields are in=
 bytes.
> +#
> +# @alloc_alloc: allocated by format driver and allocated in underlying=
 file
> +#

New structs should favor naming with '-' rather than '_'. So this should
be 'alloc-alloc', if we like the name.

So this statistic represents the portions of the format file that are in
use by the format, and which are backed by data in the underlying protoco=
l.

> +# @alloc_hole: allocated by format driver but actually is a hole in
> +#              underlying file

The portions of the format file in use by the format, but where the
entire cluster is a hole in the underlying file (note that with cluster
size large enough, you can get a cluster that is part-data/part-hole in
the underlying file, it looks like you are counting those as data).

> +#
> +# @alloc_overhead: allocated by format driver after end of underlying =
file

The portions of the format file in use by the format, but where the
entire cluster is beyond the end of the underlying file (the effective
hole).  Do we really need to distinguish between hole within the
underlying file and hole beyond the end of the file? Or can this number
be combined with the previous?

> +#
> +# @hole_alloc: not allocated by format driver but allocated in underly=
ing file

I'm not sure I like this name.  "Hole" in file-system terminology means
"reads-as-zero" - but here we are talking about portions of the format
layer that are unallocated (defer to backing file, and we can't
guarantee they read as zero unless there is no backing file).

This statistic represents the portion of the underlying file that has
been previously allocated to hold data, but which is now unused by the
format layer (in other words, leaked clusters that can be reclaimed, or
which can be reused instead of growing the underlying the file if new
clusters are allocated).

> +#
> +# @hole_hole: not allocated by format driver hole in underlying file

This statistic represents fragmentation - portions of the format layer
that are no longer in use, but which are also occupying no space in the
underlying file.  A refragmentation operation (if we ever implemented
one) could remove the address space used by these clusters, but would
not change the disk usage.

> +#
> +# Since: 2.10
> +#
> +##
> +{ 'struct': 'BlockFormatAllocInfo',
> +  'data': {'alloc_alloc':    'uint64',
> +           'alloc_hole':     'uint64',
> +           'alloc_overhead': 'uint64',
> +           'hole_alloc':     'uint64',
> +           'hole_hole':      'uint64' } }

The idea seems okay, but the naming needs to be fixed.  Also, I'm not
sure if we need all 5, or if 4 is enough; and I'm not sure if we have
the right names ("how does alloc-hole differ from hole-alloc?"), or if
we can come up with something more descriptive.  Particularly since
"hole-" is not a hole in the filesystem sense, so much as unused
clusters.  But I'm also not coming up with better names to suggest at
the moment.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--BGC3nRXkLhnmKLx1T8viLQgx1M6ivisx0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLYduAAoJEKeha0olJ0NqGdYH/AgQqrxxdeKwQH5HyNzw5abr
XbHbue3Z8Oha26sYalg/Ko22fI0Wd53KXxLZJMj3J6gbDkwywUSJTx4tNy4wMkLE
AUgSZ86mBP+Y7vSPJdhvVgcVGQveixWY8pKwVZjm5gkZ8n5SmeSJljP7VgwjhgNJ
5ilgcheWW+Nk/2CxIwzvhuxl2lLApzAHTbJJV25TJndModprcS+dl0lrsQBbRPGu
8KN9C+YCMlWoGq+WLyr4ixgQ/p+NfkDAOVVctHl5RhanlXYqHt18dZBD3ke9WuYx
sW5OpfefjD+loJcoIFQg7kDvo+HeuuXH1oR8LpmnbR1gbDqUvS43f7dxDfQXceI=
=Nr9g
-----END PGP SIGNATURE-----

--BGC3nRXkLhnmKLx1T8viLQgx1M6ivisx0--
