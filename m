Received: from eggs.gnu.org ([2001:4830:134:3::10]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWSmH-0004Rs-Db
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:35:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fWSmG-0005vj-DM
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 16:35:29 -0400
References: <20180622201122.9358-1-jsnow@redhat.com>
	<63db09f9-1f4a-15d3-cd5b-f1f5006e3eac@amsat.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <fbc39ad9-21c1-89f0-cc25-95c9223c0e2d@redhat.com>
Date: Fri, 22 Jun 2018 16:35:18 -0400
MIME-Version: 1.0
In-Reply-To: <63db09f9-1f4a-15d3-cd5b-f1f5006e3eac@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Appease coverity,
 skip empty block trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 06/22/2018 04:24 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/22/2018 05:11 PM, John Snow wrote:
>> If a tree consists exclusively of implicit filter nodes, we might cras=
h
>> QEMU. This configuration should not exist in practice, but if it did,
>> skipping it would be fine.
>>
>> For the purposes of debug builds, throw an assert to remind us that
>> this configuration is truly unexpected, but if it's compiled out we
>> will cope just fine.
>=20
> Well... with your explanation, your patch is correct.
> But do we really want to maintain a 'debug with assert' vs 'production
> without assertions' codebase?
>

I might have misremembered, but I seem to recall that it is literally
possible to disable glib assertions. We endeavor not to, but it's
*possible*.

In this case I'd prefer to have a runtime behavior that makes sense:
skipping such trees is sensible because they won't have any bitmaps for
us to migrate.

However, this is a really bizarre block configuration that I suspect
cannot exist in practice. If it does, I'd rather not ignore it in the
development context.

> $ git grep g_assert_not_reached | egrep -v '^tests/' | wc -l
> 406
>=20
> Does Coverity require all these 406 lines to behave with a
> "configuration [that] should not exist in practice"?
>=20
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  migration/block-dirty-bitmap.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bi=
tmap.c
>> index 3bafbbdc4c..02725293dd 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>> @@ -287,6 +287,10 @@ static int init_dirty_bitmap_migration(void)
>>          while (bs && bs->drv && bs->implicit) {
>>              bs =3D backing_bs(bs);
>>          }
>> +        if (!bs) {
>> +            g_assert_not_reached();
>> +            continue;
>=20
> Can we choose one or the other?
>=20

Ask someone more familiar with assert policy and a fondness for paint hue=
s.

--js

>> +        }
>> =20
>>          for (bitmap =3D bdrv_dirty_bitmap_next(bs, NULL); bitmap;
>>               bitmap =3D bdrv_dirty_bitmap_next(bs, bitmap))
>>
