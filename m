Received: from eggs.gnu.org ([2001:4830:134:3::10]:54602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPdj-0002Ni-1B
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:59:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fBPdf-0008Q2-W6
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:59:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fBPdf-0008Pu-Pg
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 14:59:35 -0400
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
	<20180425124608.17182.4528.stgit@pasha-VirtualBox>
From: Eric Blake <eblake@redhat.com>
Message-ID: <613234ff-4a1a-6ab1-4003-3326a6bf508f@redhat.com>
Date: Wed, 25 Apr 2018 13:59:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180425124608.17182.4528.stgit@pasha-VirtualBox>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Q9E2CaacVYTX8usKTaNnDwxJlmhfg2TtU"
Subject: Re: [Qemu-devel] [RFC PATCH 06/17] migration: introduce icount
 field for snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com, armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Q9E2CaacVYTX8usKTaNnDwxJlmhfg2TtU
From: Eric Blake <eblake@redhat.com>
To: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com,
 pbonzini@redhat.com, quintela@redhat.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, crosthwaite.peter@gmail.com, zuban32s@gmail.com,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, alex.bennee@linaro.org,
 dgilbert@redhat.com, rth@twiddle.net
Message-ID: <613234ff-4a1a-6ab1-4003-3326a6bf508f@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/17] migration: introduce icount field
 for snapshots
References: <20180425124533.17182.53165.stgit@pasha-VirtualBox>
 <20180425124608.17182.4528.stgit@pasha-VirtualBox>
In-Reply-To: <20180425124608.17182.4528.stgit@pasha-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2018 07:46 AM, Pavel Dovgalyuk wrote:
> Saving icount as a parameters of the snapshot allows navigation between=

> them in the execution replay scenario.
> This information can be used for finding a specific snapshot for rewind=
ing
> the recorded execution to the specific moment of the time.
> E.g., 'reverse step' action needs to load the nearest snapshot which is=

> prior to the current moment of time .
>=20
> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> ---
>  block/qapi.c             |   11 +++++++----
>  blockdev.c               |    3 +++
>  include/block/snapshot.h |    1 +
>  migration/savevm.c       |    1 +
>  qapi/block-core.json     |    5 ++++-
>  qapi/block.json          |    3 ++-
>  6 files changed, 18 insertions(+), 6 deletions(-)

Using scripts/git.orderfile may make your patches easier to review, by
hoisting interfaces above implementation.

> +++ b/qapi/block-core.json
> @@ -25,13 +25,16 @@
>  #
>  # @vm-clock-nsec: fractional part in nano seconds to be used with vm-c=
lock-sec
>  #
> +# @icount: current instruction count for execution record/replay

Missing a '(since 2.13)' tag.

> +#
>  # Since: 1.3
>  #
>  ##
>  { 'struct': 'SnapshotInfo',
>    'data': { 'id': 'str', 'name': 'str', 'vm-state-size': 'int',
>              'date-sec': 'int', 'date-nsec': 'int',
> -            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int' } }
> +            'vm-clock-sec': 'int', 'vm-clock-nsec': 'int',
> +            'icount': 'int' } }

'icount' should be optional, as older qcow2 images will not have that
information available.  Also, putting patch 7 before this patch may make
more sense.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Q9E2CaacVYTX8usKTaNnDwxJlmhfg2TtU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrg0A0ACgkQp6FrSiUn
Q2rw9QgAqCA54nCjHw9owMGW5fUDQvhqQgSeDkoi/SXSokSf3dWQBJ4+9k39ygtM
5NnbUgWob2ZdS4fnNGvTlOEENXzkRrCyJ2vUziJHV7bLY2hMshwBE1x7NA+kMg34
FT639mn8p+gkYhaIVe2XwnMVhDFzH8nrjzbIIBhuumNAhw37J+njTYUQCMmbbq3C
oy9JMYDVXdXELbyfr7SUG1Wpwzt+aJ8cWd0z5UpEkeQvZ5jvQiTsifTvrtC1cU0O
ZSnqgLDZBSHT5WzETdI/PULIHzUBSLlpbFlg2jUBSfy139AELkX/UahciTJepW6o
krFg5NQMur2cfwTX/sZCNTqAi5A1Cg==
=19XK
-----END PGP SIGNATURE-----

--Q9E2CaacVYTX8usKTaNnDwxJlmhfg2TtU--
