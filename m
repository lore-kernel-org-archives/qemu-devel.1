Received: from eggs.gnu.org ([2001:4830:134:3::10]:47778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFlKl-0000ex-Mc
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:25:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eFlKk-0005cX-W0
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 13:25:47 -0500
References: <20171030163309.75770-1-vsementsov@virtuozzo.com>
	<20171030163309.75770-3-vsementsov@virtuozzo.com>
	<5027d8bb-fdec-a6ce-8150-96730d3a5ce4@redhat.com>
	<8f3d2255-22e8-13a0-33f8-8b2db0d17bec@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ae98b3f3-f51e-f8fa-b445-3fbfd6d71b63@redhat.com>
Date: Fri, 17 Nov 2017 13:25:34 -0500
MIME-Version: 1.0
In-Reply-To: <8f3d2255-22e8-13a0-33f8-8b2db0d17bec@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 02/14] block/dirty-bitmap: add locked
 version of bdrv_release_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, famz@redhat.com, lirans@il.ibm.com, quintela@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com



On 11/17/2017 03:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.11.2017 01:52, John Snow wrote:
>>
>> On 10/30/2017 12:32 PM, Vladimir Sementsov-Ogievskiy wrote:
>>> It is needed to realize bdrv_dirty_bitmap_release_successor in
>>> the following patch.
>>>
>> OK, but...
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/dirty-bitmap.c | 25 ++++++++++++++++++++-----
>>> =C2=A0 1 file changed, 20 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
>>> index 81adbeb6d4..981f99d362 100644
>>> --- a/block/dirty-bitmap.c
>>> +++ b/block/dirty-bitmap.c
>>> @@ -326,13 +326,13 @@ static bool
>>> bdrv_dirty_bitmap_has_name(BdrvDirtyBitmap *bitmap)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!bdrv_dirty_bitmap_name(bitmap=
);
>>> =C2=A0 }
>>> =C2=A0 -/* Called with BQL taken.=C2=A0 */
>>> -static void bdrv_do_release_matching_dirty_bitmap(
>>> +/* Called within bdrv_dirty_bitmap_lock..unlock */
>> ...Add this so it will compile:
>=20
> how do you compile to get an error? and what is unused?
>=20

.../src/qemu/block/dirty-bitmap.c:368:13: error:
=E2=80=98bdrv_release_dirty_bitmap_locked=E2=80=99 defined but not used
[-Werror=3Dunused-function]
 static void bdrv_release_dirty_bitmap_locked(BlockDriverState *bs,
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors


I commented on the wrong prototype. The ((__unused__)) attribute just
quiets this warning so it can compile without you having to refactor.

--js
