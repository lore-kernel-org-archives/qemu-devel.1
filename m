Received: from eggs.gnu.org ([2001:4830:134:3::10]:50040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcene-00075I-Qq
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 18:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fcend-0003rg-RB
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 18:38:30 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-3-vsementsov@virtuozzo.com>
	<e5373c81-a72f-57c2-794a-829b52865d10@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <3993399d-8ffd-1f6c-b346-37fe85cf840b@redhat.com>
Date: Mon, 9 Jul 2018 18:38:24 -0400
MIME-Version: 1.0
In-Reply-To: <e5373c81-a72f-57c2-794a-829b52865d10@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] block/qcow2: improve error message in
 qcow2_inactivate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 06/28/2018 08:16 AM, Eric Blake wrote:
> On 06/26/2018 08:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 block/qcow2.c | 6 +++---
>> =C2=A0 1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 945132f692..46194a33ca 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -2114,9 +2114,9 @@ static int qcow2_inactivate(BlockDriverState *bs=
)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcow2_store_persistent_dirty_bitmaps(bs=
, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result =3D -EIN=
VAL;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(local_err=
);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Persistent b=
itmaps are lost for node '%s'",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_get_device_or_no=
de_name(bs));
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_reportf_err(local_er=
r, "Persistent bitmaps are lost for
>> node "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "'%s', because failed to store them on qcow2 "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "inactivation: ",
>> bdrv_get_device_or_node_name(bs));
>=20
> That's longer, and has awkward grammar.
>=20
> Also, for a patch designed to improve an error message, it's nice if th=
e
> commit message demonstrates a before-and-after comparison of the two
> different wordings, along with a formula for reproducing the error (not
> mandatory, but it can sure help in reviewing).
>=20
> Shorter might be:
>=20
> "Lost persistent bitmaps during inactivation of node '%s': "
>=20
> since the local_err text appended after the colon will then make it
> obvious what the error was during inactivation.
>=20

I like Eric's phrasing suggestion.

If you haven't actually managed to trigger this error in real life, I
won't demand you artificially do so for the sake of demonstration.

--js
