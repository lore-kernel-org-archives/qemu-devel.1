Received: from eggs.gnu.org ([2001:4830:134:3::10]:48005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gOiGY-0006Q4-3x
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 07:03:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gOi9w-0007Rm-5l
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 06:56:13 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 19 Nov 2018 11:55:48 +0000
Message-ID: <7c07d170-f520-1e78-7e38-f1b81a42e11b@virtuozzo.com>
References: <20181016132018.5054-1-vsementsov@virtuozzo.com>
	<20181116142903.GB9742@stefanha-x1.localdomain>
In-Reply-To: <20181116142903.GB9742@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <CC23E302B3BEEF4299329C75957159D1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] migration/block-dirty-bitmap: fix Coverity
 CID1390625
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "quintela@redhat.com" <quintela@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>, Denis Lunev <den@virtuozzo.com>

16.11.2018 17:29, Stefan Hajnoczi wrote:
> On Tue, Oct 16, 2018 at 04:20:18PM +0300, Vladimir Sementsov-Ogievskiy wr=
ote:
>> Theoretically possible that we finish the skipping loop with bs =3D NULL
>> and the following code will crash trying to dereference it. Fix that.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   migration/block-dirty-bitmap.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitm=
ap.c
>> index 477826330c..6de808f95f 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -288,6 +288,10 @@ static int init_dirty_bitmap_migration(void)
>>               bs =3D backing_bs(bs);
>>           }
>>  =20
>> +        if (!bs || bs->implicit) {
>=20
> Why is it necessary to check bs->implicit?
>=20


to be sure, that it is not implicit, as previous loop may finish with impli=
cit =3D true and bs!=3D NULL, if drv =3D=3D NULL. (hmm, may be we want to c=
heck drv too?)

same thing is in bdrv_query_info, without any checks, and in bdrv_block_dev=
ice_info with assert(bs).


--=20
Best regards,
Vladimir
