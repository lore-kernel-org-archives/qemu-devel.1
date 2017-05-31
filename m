Received: from eggs.gnu.org ([2001:4830:134:3::10]:40840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG50d-0007Il-Vf
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dG50Z-0000DY-Q2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 10:54:04 -0400
References: <20170524202842.26724-1-eblake@redhat.com>
	<20170524202842.26724-4-eblake@redhat.com>
	<20170525063444.GC27936@lemon.lan>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6d1ca99c-ea04-1ce1-cf46-7d95d5d0cdb8@redhat.com>
Date: Wed, 31 May 2017 16:53:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170525063444.GC27936@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nNT7dSQe8e8sW9ovqNG6Cc5OeiRfKOG8O"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block: Allow NULL file for
 bdrv_get_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nNT7dSQe8e8sW9ovqNG6Cc5OeiRfKOG8O
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jeff Cody <jcody@redhat.com>
Message-ID: <6d1ca99c-ea04-1ce1-cf46-7d95d5d0cdb8@redhat.com>
Subject: Re: [PATCH v2 3/5] block: Allow NULL file for bdrv_get_block_status()
References: <20170524202842.26724-1-eblake@redhat.com>
 <20170524202842.26724-4-eblake@redhat.com> <20170525063444.GC27936@lemon.lan>
In-Reply-To: <20170525063444.GC27936@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-25 08:34, Fam Zheng wrote:
> On Wed, 05/24 15:28, Eric Blake wrote:
>> Not all callers care about which BDS owns the mapping for a given
>> range of the file.  This patch merely simplifies the callers by
>> consolidating the logic in the common call point, while guaranteeing
>> a non-NULL file to all the driver callbacks, for no semantic change.
>>
>> However, this will also set the stage for a future cleanup: when a
>> caller does not care about which BDS owns an offset, it would be
>> nice to allow the driver to optimize things to not have to return
>> BDRV_BLOCK_OFFSET_VALID in the first place.  In the case of fragmented=

>> allocation (for example, it's fairly easy to create a qcow2 image
>> where consecutive guest addresses are not at consecutive host
>> addresses), the current contract requires bdrv_get_block_status()
>> to clamp *pnum to the limit where host addresses are no longer
>> consecutive, but allowing a NULL file means that *pnum could be
>> set to the full length of known-allocated data.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v2: new patch
>=20
> Yes. any particular reason why this patch is useful, besides simplifyin=
g
> callers?
>=20
>=20
>> ---
>>  block/io.c     | 15 +++++++++------
>>  block/mirror.c |  3 +--
>>  block/qcow2.c  |  4 +---
>>  qemu-img.c     | 10 ++++------
>>  4 files changed, 15 insertions(+), 17 deletions(-)
>>
>> diff --git a/block/io.c b/block/io.c
>> index 8e6c3fe..eea74cb 100644
>> --- a/block/io.c
>> +++ b/block/io.c
>> @@ -706,7 +706,6 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFl=
ags flags)
>>  {
>>      int64_t target_sectors, ret, nb_sectors, sector_num =3D 0;
>>      BlockDriverState *bs =3D child->bs;
>> -    BlockDriverState *file;
>>      int n;
>>
>>      target_sectors =3D bdrv_nb_sectors(bs);
>> @@ -719,7 +718,7 @@ int bdrv_make_zero(BdrvChild *child, BdrvRequestFl=
ags flags)
>>          if (nb_sectors <=3D 0) {
>>              return 0;
>>          }
>> -        ret =3D bdrv_get_block_status(bs, sector_num, nb_sectors, &n,=
 &file);
>> +        ret =3D bdrv_get_block_status(bs, sector_num, nb_sectors, &n,=
 NULL);
>>          if (ret < 0) {
>>              error_report("error getting block status at sector %" PRI=
d64 ": %s",
>>                           sector_num, strerror(-ret));
>> @@ -1737,8 +1736,9 @@ typedef struct BdrvCoGetBlockStatusData {
>>   * 'nb_sectors' is the max value 'pnum' should be set to.  If nb_sect=
ors goes
>>   * beyond the end of the disk image it will be clamped.
>>   *
>> - * If returned value is positive and BDRV_BLOCK_OFFSET_VALID bit is s=
et, 'file'
>> - * points to the BDS which the sector range is allocated in.
>> + * If returned value is positive, BDRV_BLOCK_OFFSET_VALID bit is set,=
 and
>> + * 'file' is non-NULL, then '*file' points to the BDS which the secto=
r range
>> + * is allocated in.
>=20
> Sounds good.
>=20
>>   */
>>  static int64_t coroutine_fn bdrv_co_get_block_status(BlockDriverState=
 *bs,
>>                                                       int64_t sector_n=
um,
>> @@ -1748,7 +1748,11 @@ static int64_t coroutine_fn bdrv_co_get_block_s=
tatus(BlockDriverState *bs,
>>      int64_t total_sectors;
>>      int64_t n;
>>      int64_t ret, ret2;
>> +    BlockDriverState *tmpfile;
>>
>> +    if (!file) {
>> +        file =3D &tmpfile;
>> +    }
>=20
> I don't like this hunk. Instead, how about replacing all "*file =3D ...=
" with
> "tmpfile =3D ..." and add "if (file) { *file =3D tmpfile; }" before ret=
urning?

Sounds fine to me, but in that case I'd like to request a different
variable name. Maybe do what we have with errp/local_error and make it
local_file or something?

Max


--nNT7dSQe8e8sW9ovqNG6Cc5OeiRfKOG8O
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLtjzEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQMPI
CACe1yQlmG2RdHqMh4EEjgRArfeWrpalybzm+oohtgzFCGrhFWcGa1AlSVInaTva
h/wXwIlo+sn9WFWiUIj7aTRaAjLyATeIR51EB64WvYuezy4FjmGw9sjAWWvBB9Hi
c8eIsTIJv613AhUZDFG1nLZsKl1cBjYhrL9kzA5ITsE8C7Dh/Qys7bSU6qECG6gt
VO2oDrAHRE06gXtELJhxNSzR17q1v9AUUIKXW+wg4EeI70Rx2spnkA7rWTJQWrpm
d/P6gEDEHrgez6i7utujKdSw1VRgzVHytHuxYZecFGDKtO4vLdgATaJ6MRDMx+Me
BK4zzA1rtrDcStCiN4gUSdYk
=dW5j
-----END PGP SIGNATURE-----

--nNT7dSQe8e8sW9ovqNG6Cc5OeiRfKOG8O--
