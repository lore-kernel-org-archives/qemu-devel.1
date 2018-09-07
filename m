Received: from eggs.gnu.org ([2001:4830:134:3::10]:36068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyF7c-0008Ue-SO
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fyF7b-0007vu-17
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 07:40:20 -0400
References: <20180904170930.28619-1-jsnow@redhat.com>
	<20180904170930.28619-6-jsnow@redhat.com>
	<ba536682-1d9a-d7e1-a925-143c384aaf2e@redhat.com>
	<9cda4756-3bcf-01a9-5fbc-755a4e722581@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f87e7b52-7fd2-8e70-b677-67f6ebca2b42@redhat.com>
Date: Fri, 7 Sep 2018 13:40:04 +0200
MIME-Version: 1.0
In-Reply-To: <9cda4756-3bcf-01a9-5fbc-755a4e722581@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="yBsXMJZKyxAqLQS9zzKkoTWn9sdR5eDFv"
Subject: Re: [Qemu-devel] [PATCH v4 05/15] block/mirror: don't install
 backing chain on abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--yBsXMJZKyxAqLQS9zzKkoTWn9sdR5eDFv
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Jeff Cody <jcody@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, jtc@redhat.com, Eric Blake <eblake@redhat.com>
Message-ID: <f87e7b52-7fd2-8e70-b677-67f6ebca2b42@redhat.com>
Subject: Re: [PATCH v4 05/15] block/mirror: don't install backing chain on
 abort
References: <20180904170930.28619-1-jsnow@redhat.com>
 <20180904170930.28619-6-jsnow@redhat.com>
 <ba536682-1d9a-d7e1-a925-143c384aaf2e@redhat.com>
 <9cda4756-3bcf-01a9-5fbc-755a4e722581@redhat.com>
In-Reply-To: <9cda4756-3bcf-01a9-5fbc-755a4e722581@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-09-05 17:39, John Snow wrote:
>=20
>=20
> On 09/05/2018 06:40 AM, Max Reitz wrote:
>> On 2018-09-04 19:09, John Snow wrote:
>>> In cases where we abort the block/mirror job, there's no point in
>>> installing the new backing chain before we finish aborting.
>>>
>>> Move this to the "success" portion of mirror_exit.
>>
>> Sounds a bit weird now that you don't do any moving.
>>
>=20
> I ought to proofread my commit messages when I make changes...
>=20
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  block/mirror.c | 7 ++-----
>>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index cba555b4ef..3365bcfdfb 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -642,7 +642,7 @@ static void mirror_exit(Job *job)
>>>       * required before it could become a backing file of target_bs. =
*/
>>>      bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,=

>>>                              &error_abort);
>>> -    if (s->backing_mode =3D=3D MIRROR_SOURCE_BACKING_CHAIN) {
>>> +    if (ret =3D=3D 0 && s->backing_mode =3D=3D MIRROR_SOURCE_BACKING=
_CHAIN) {
>>>          BlockDriverState *backing =3D s->is_none_mode ? src : s->bas=
e;
>>>          if (backing_bs(target_bs) !=3D backing) {
>>>              bdrv_set_backing_hd(target_bs, backing, &local_err);
>>> @@ -659,10 +659,7 @@ static void mirror_exit(Job *job)
>>>      }
>>> =20
>>>      if (s->should_complete && ret =3D=3D 0) {
>>> -        BlockDriverState *to_replace =3D src;
>>> -        if (s->to_replace) {
>>> -            to_replace =3D s->to_replace;
>>> -        }
>>> +        BlockDriverState *to_replace =3D s->to_replace ? s->to_repla=
ce : src;
>>> =20
>>>          if (bdrv_get_flags(target_bs) !=3D bdrv_get_flags(to_replace=
)) {
>>>              bdrv_reopen(target_bs, bdrv_get_flags(to_replace), NULL)=
;
>>
>> And this hunk now looks out of place.  Sure, it makes sense, but why i=
s
>> it in this patch now? :-)
>>
>> (Moving it into the next patch would make more sense, I think.)
>>
>> I'd like to give an R-b anyway, but I know that I shouldn't, so I won'=
t.
>>
>> Max
>>
>=20
> I have to admit that my appetite for patch purity is just... low. I kno=
w
> it's something we care a lot in the QEMU project, but after a number of=

> years I'm just not overwhelmed to care about it in any significant capa=
city.
>=20
> I suppose the main argument for this practice is ease of backporting, y=
es?

I suppose.  And ease of bisecting.  And ease of reviewing.

Max


--yBsXMJZKyxAqLQS9zzKkoTWn9sdR5eDFv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluSY5QACgkQ9AfbAGHV
z0BJDwgAuK0eiU2i+dkiC2q7udqmJrNf7M2nFM8ro5FmCRnBGD3Qmpr8SkzBCi0E
WC84AGNWUCM7CC3YT1leeLmurkt6FKd4jW8Nh9CuMGnydAuzWPNiezu21iikwxd9
s7riTyzE+8K+dTA6xaWZKlX6+T767+C+nok5/+9Q/1/m7L0PmXlysR4shXfAQALU
gHUYL8KB4Zyj7HRo35NtjogqqsMlCJvbWumdrvpT8cr6msj5s6/MJFLf4cE5R99E
+rlUtVdhCRvG7bNQoGNQjNP8ZRsQra4JdisZKN8dKKMjaKJ6yA3yw7jHPUZsBTKk
bK9FsrcJzBDwO3rEDHhmUemIy1b0Bw==
=PbdX
-----END PGP SIGNATURE-----

--yBsXMJZKyxAqLQS9zzKkoTWn9sdR5eDFv--
