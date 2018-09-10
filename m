Received: from eggs.gnu.org ([2001:4830:134:3::10]:50525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzOi0-00040B-55
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 12:06:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fzOSQ-0004UJ-Sf
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 11:50:41 -0400
References: <20180814121443.33114-1-vsementsov@virtuozzo.com>
	<20180814121443.33114-2-vsementsov@virtuozzo.com>
	<954db07e-d338-9cd4-341f-d8916470b89b@redhat.com>
	<647f800e-f5f6-598c-38f0-309ae2d80650@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <90be2c48-9396-48f2-1b58-7ab68287b57c@redhat.com>
Date: Mon, 10 Sep 2018 11:49:44 -0400
MIME-Version: 1.0
In-Reply-To: <647f800e-f5f6-598c-38f0-309ae2d80650@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 1/8] dirty-bitmap: improve
 bdrv_dirty_bitmap_next_zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, den@openvz.org



On 09/10/2018 10:59 AM, Eric Blake wrote:
> On 9/7/18 4:49 PM, John Snow wrote:
>>
>>
>> On 08/14/2018 08:14 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> Add bytes parameter to the function, to limit searched range.
>>>
>>
>> I'm going to assume that Eric Blake has been through here and commente=
d
>> on the interface itself.
>=20
> Actually, I haven't had time to look at this series in depth. Do you
> need me to?
>=20

Not necessarily, it's just that I didn't read v1 or v2 so I was just
being cautious against recommending changes that maybe we already
recommended against in a different direction.

Historically you've cared the most about start/end/offset/bytes naming
and conventions, so I just made an assumption.

--js

>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 include/block/dirty-bitmap.h |=C2=A0 3 ++-
>>> =C2=A0 include/qemu/hbitmap.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1=
0 ++++++++--
>>> =C2=A0 block/backup.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 block/dirty-bitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 5 +++--
>>> =C2=A0 nbd/server.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 tests/test-hbitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 2 +-
>>> =C2=A0 util/hbitmap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++++++++++-----
>>> =C2=A0 7 files changed, 36 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/include/block/dirty-bitmap.h b/include/block/dirty-bitma=
p.h
>>> index 259bd27c40..27f5299c4e 100644
>>> --- a/include/block/dirty-bitmap.h
>>> +++ b/include/block/dirty-bitmap.h
>>> @@ -98,7 +98,8 @@ bool
>>> bdrv_has_changed_persistent_bitmaps(BlockDriverState *bs);
>>> =C2=A0 BdrvDirtyBitmap *bdrv_dirty_bitmap_next(BlockDriverState *bs,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap);
>>> =C2=A0 char *bdrv_dirty_bitmap_sha256(const BdrvDirtyBitmap *bitmap, =
Error
>>> **errp);
>>> -int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap,
>>> uint64_t start);
>>> +int64_t bdrv_dirty_bitmap_next_zero(BdrvDirtyBitmap *bitmap,
>>> uint64_t start,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_=
t end);
>=20
> It's already seeming a bit odd to mix uint64_t AND int64_t for the two
> parameters.=C2=A0 Is the intent to allow -1 to mean "end of the bitmap
> instead of a specific end range"? But you can get that with UINT64_MAX
> just as easily, and still get away with spelling it -1 in the source.
>=20
>=20
>>> + * the bitmap end.
>>> =C2=A0=C2=A0 */
>>> -int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start);
>>> +int64_t hbitmap_next_zero(const HBitmap *hb, uint64_t start, int64_t
>>> end);
>>> =C2=A0=20
>>
>> The interface looks weird because we can define a 'start' that's beyon=
d
>> the 'end'.
>>
>> I realize that you need a signed integer for 'end' to signify EOF...
>> should we do a 'bytes' parameter instead? (Did you already do that in =
an
>> earlier version and we changed it?)
>>
>> Well, it's not a big deal to me personally.
>=20
> It should always be possible to convert in either direction between
> [start,end) and [start,start+bytes); it boils down to a question of
> convenience (which form is easier for the majority of callers) and
> consistency (which form do we use more frequently in the block layer). =
I
> haven't checked closely, but I think start+bytes is more common than en=
d
> in our public block layer APIs.
>=20
