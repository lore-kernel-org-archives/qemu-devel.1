Received: from eggs.gnu.org ([2001:4830:134:3::10]:59042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWSGj-0006qM-LG
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:26:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cWSGi-0003eT-Ld
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:26:05 -0500
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
	<b77236d0-edde-3d14-4282-c61a7c7615af@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <285b1ef0-b63a-c256-ae7c-0b876e918b15@redhat.com>
Date: Wed, 25 Jan 2017 19:25:54 +0100
MIME-Version: 1.0
In-Reply-To: <b77236d0-edde-3d14-4282-c61a7c7615af@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IIebsWHbCVLpVrSL0pFFggleQ2PS3GGma"
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename
 when searching protocol filenames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IIebsWHbCVLpVrSL0pFFggleQ2PS3GGma
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu block <qemu-block@nongnu.org>
Message-ID: <285b1ef0-b63a-c256-ae7c-0b876e918b15@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] block: check full backing filename when
 searching protocol filenames
References: <9a93d47ddba5f86d36cbdf884d86e2fa6f5542ae.1485364872.git.jcody@redhat.com>
 <b77236d0-edde-3d14-4282-c61a7c7615af@redhat.com>
In-Reply-To: <b77236d0-edde-3d14-4282-c61a7c7615af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 25.01.2017 19:24, Eric Blake wrote:
> On 01/25/2017 11:22 AM, Jeff Cody wrote:
>> In bdrv_find_backing_image(), if we are searching an image for a backi=
ng
>> file that contains a protocol, we currently only compare unmodified
>> paths.
>>
>> However, some management software will change the backing filename to =
be
>> a relative filename in a path.  QEMU is able to handle this fine,
>> because internally it will use path_combine to put together the full
>> protocol URI.
>>
>> However, this can lead to an inability to match an image during a QAPI=

>> command that needs to use bdrv_find_backing_image() to find the image,=

>> when it is searched by the full URI.
>>
>> When searching for a protocol filename, if the straight comparison
>> fails, this patch will also compare against the full backing filename =
to
>> see if that is a match.
>>
>> Signed-off-by: Jeff Cody <jcody@redhat.com>
>> ---
>>  block.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>=20
> Does this overlap with Max' work on 'block: Fix some filename generatio=
n
> issues'?  But in isolation, it looks okay to me,

Yes, it does, but it's not too hard to fix up in my series. Better get
this in first and then do the trivial change on my side.

> Reviewed-by: Eric Blake <eblake@redhat.com>

Noted :-)

Max

>>
>> diff --git a/block.c b/block.c
>> index 39ddea3..a173afc 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3145,6 +3145,7 @@ BlockDriverState *bdrv_find_backing_image(BlockD=
riverState *bs,
>>      int is_protocol =3D 0;
>>      BlockDriverState *curr_bs =3D NULL;
>>      BlockDriverState *retval =3D NULL;
>> +    Error *local_error =3D NULL;
>=20
> I might have scoped this...
>=20
>> =20
>>      if (!bs || !bs->drv || !backing_file) {
>>          return NULL;
>> @@ -3165,6 +3166,17 @@ BlockDriverState *bdrv_find_backing_image(Block=
DriverState *bs,
>>                  retval =3D curr_bs->backing->bs;
>>                  break;
>>              }
>=20
> ...as the first line within the if that uses it. But no big deal.
>=20
>> +            /* Also check against the full backing filename for the i=
mage */
>> +            bdrv_get_full_backing_filename(curr_bs, backing_file_full=
, PATH_MAX,
>> +                                           &local_error);
>> +            if (local_error =3D=3D NULL) {
>> +                if (strcmp(backing_file, backing_file_full) =3D=3D 0)=
 {
>> +                    retval =3D curr_bs->backing->bs;
>> +                    break;
>> +                }
>> +            } else {
>> +                error_free(local_error);
>> +            }
>>          } else {
>>              /* If not an absolute filename path, make it relative to =
the current
>>               * image's filename path */
>>
>=20



--IIebsWHbCVLpVrSL0pFFggleQ2PS3GGma
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliI7bISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AG/cIAIm0YhPp2JpEmeNlp/Bx0/eoE3rvdeh+
wAjdW/d1EKnO5ka9+MC0ez/Fvt39p144dJMcApGCPXjhbYy3guSLgNyDBcgIa54W
gWhx+5DM1QjmlqcxQCAuvYlhU2He4sz2K6bRyhYmbzAoeNBvKYH67liljWvZtKTR
gmhqhN86dIemsI927HEv81cA5DHqE/f8PIDFYtSGTVnufAiL/mdTNIQM9aC/aR4A
362UG/MCaWkys9VzYKFhEcbreFuz1AuONPmGtSXtsFbsfmNGNbAyDQbvxkTSepa6
jU/vhqxAss4IJJvki8whMZVx+9cKSAaV/zHGYh1ntC4kbQqep6wEGDo=
=gW3C
-----END PGP SIGNATURE-----

--IIebsWHbCVLpVrSL0pFFggleQ2PS3GGma--
