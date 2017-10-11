Received: from eggs.gnu.org ([2001:4830:134:3::10]:34039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FjM-0007oz-7M
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:03:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e2FjL-0000WM-5k
	for qemu-devel@nongnu.org; Wed, 11 Oct 2017 08:03:20 -0400
References: <20170913181910.29688-1-mreitz@redhat.com>
	<20170913181910.29688-11-mreitz@redhat.com>
	<20171010094738.GF4177@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3cc56061-d4e4-a07c-cc24-c8162a87fa0b@redhat.com>
Date: Wed, 11 Oct 2017 14:02:56 +0200
MIME-Version: 1.0
In-Reply-To: <20171010094738.GF4177@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nULmsXhCrDhh4KoneO10HLonwF8aSbTBu"
Subject: Re: [Qemu-devel] [PATCH 10/18] block/mirror: Make source the file
 child
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nULmsXhCrDhh4KoneO10HLonwF8aSbTBu
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Fam Zheng
 <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <3cc56061-d4e4-a07c-cc24-c8162a87fa0b@redhat.com>
Subject: Re: [PATCH 10/18] block/mirror: Make source the file child
References: <20170913181910.29688-1-mreitz@redhat.com>
 <20170913181910.29688-11-mreitz@redhat.com>
 <20171010094738.GF4177@dhcp-200-186.str.redhat.com>
In-Reply-To: <20171010094738.GF4177@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-10 11:47, Kevin Wolf wrote:
> Am 13.09.2017 um 20:19 hat Max Reitz geschrieben:
>> Regarding the source BDS, the mirror BDS is arguably a filter node.
>> Therefore, the source BDS should be its "file" child.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> TODO: Justification why this doesn't break things like
> bdrv_is_allocated_above() that iterate through the backing chain.

Er, well, yes.

>>  block/mirror.c             | 127 ++++++++++++++++++++++++++++++++++--=
---------
>>  block/qapi.c               |  25 ++++++---
>>  tests/qemu-iotests/141.out |   4 +-
>>  3 files changed, 119 insertions(+), 37 deletions(-)
>>
>> diff --git a/block/qapi.c b/block/qapi.c
>> index 7fa2437923..ee792d0cbc 100644
>> --- a/block/qapi.c
>> +++ b/block/qapi.c
>> @@ -147,9 +147,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBack=
end *blk,
>> =20
>>          /* Skip automatically inserted nodes that the user isn't awar=
e of for
>>           * query-block (blk !=3D NULL), but not for query-named-block=
-nodes */
>> -        while (blk && bs0->drv && bs0->implicit) {
>> -            bs0 =3D backing_bs(bs0);
>> -            assert(bs0);
>> +        while (blk && bs0 && bs0->drv && bs0->implicit) {
>> +            if (bs0->backing) {
>> +                bs0 =3D backing_bs(bs0);
>> +            } else {
>> +                assert(bs0->file);
>> +                bs0 =3D bs0->file->bs;
>> +            }
>>          }
>>      }
>=20
> Maybe backing_bs() should skip filters? If so, need to show that all
> existing users of backing_bs() really want to skip filters. If not,
> explain why the missing backing_bs() callers don't need it (I'm quite
> sure that some do).

Arguably any BDS is a filter BDS regarding its backing BDS.  So maybe I
could add a new function filter_child_bs().

> Also, if we attack this at the backing_bs() level, we need to audit
> code that it doesn't directly use bs->backing.

Yup.

Maybe the best idea is to leave this patch for a follow-up...

>> @@ -1135,44 +1146,88 @@ static const BlockJobDriver commit_active_job_=
driver =3D {
>>      .drain                  =3D mirror_drain,
>>  };
>> =20
>> +static void source_child_inherit_fmt_options(int *child_flags,
>> +                                             QDict *child_options,
>> +                                             int parent_flags,
>> +                                             QDict *parent_options)
>> +{
>> +    child_backing.inherit_options(child_flags, child_options,
>> +                                  parent_flags, parent_options);
>> +}
>> +
>> +static char *source_child_get_parent_desc(BdrvChild *c)
>> +{
>> +    return child_backing.get_parent_desc(c);
>> +}
>> +
>> +static void source_child_cb_drained_begin(BdrvChild *c)
>> +{
>> +    BlockDriverState *bs =3D c->opaque;
>> +    MirrorBDSOpaque *s =3D bs->opaque;
>> +
>> +    if (s && s->job) {
>> +        block_job_drained_begin(&s->job->common);
>> +    }
>> +    bdrv_drained_begin(bs);
>> +}
>> +
>> +static void source_child_cb_drained_end(BdrvChild *c)
>> +{
>> +    BlockDriverState *bs =3D c->opaque;
>> +    MirrorBDSOpaque *s =3D bs->opaque;
>> +
>> +    if (s && s->job) {
>> +        block_job_drained_end(&s->job->common);
>> +    }
>> +    bdrv_drained_end(bs);
>> +}
>> +
>> +static BdrvChildRole source_child_role =3D {
>> +    .inherit_options    =3D source_child_inherit_fmt_options,
>> +    .get_parent_desc    =3D source_child_get_parent_desc,
>> +    .drained_begin      =3D source_child_cb_drained_begin,
>> +    .drained_end        =3D source_child_cb_drained_end,
>> +};
>=20
> Wouldn't it make much more sense to use a standard child role and just
> implement BlockDriver callbacks for .bdrv_drained_begin/end? It seems
> that master still only has .bdrv_co_drain (which is begin), but one of
> Manos' pending series adds the missing end callback.

OK then. :-)

Max


--nULmsXhCrDhh4KoneO10HLonwF8aSbTBu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlneCHASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxbEH/A1eggfbibtho7UDL+N2xO3Q3cliyJgL
he8j7KJRErsYzkELwrSPPRq6e/hldysqUZ5/mWc+J73P+B6r2zkJ8VPCqsSNamjT
EugPzUAjaA6Rx9+HNoCligiNGTWrfeL019GmrF6dI/ZnsWsHzukDfSeI13KxA402
RcoszZeYEhROJUdNPXyvDQ5pUW+cquy0UPTF0T4tcf380/2HKCqKtNFUPkcbjYld
PxY0bOdnpXFt3ITi+BQzVK9Ea4w1OXHXIkQ9Nzj6ASebDycfk5oMz2mrEtAJ/lhI
GaJioE6/iK6Htrbl4BSAsKr7bBf7CCN8xRWBKQ1/EtZ/1GqPdjzvVEk=
=1G1K
-----END PGP SIGNATURE-----

--nULmsXhCrDhh4KoneO10HLonwF8aSbTBu--
