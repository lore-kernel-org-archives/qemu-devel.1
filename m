Received: from eggs.gnu.org ([2001:4830:134:3::10]:58973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ffVN4-00038Z-Lu
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ffVN3-000571-Bg
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 15:10:50 -0400
References: <20180626135035.133432-1-vsementsov@virtuozzo.com>
	<20180626135035.133432-4-vsementsov@virtuozzo.com>
	<92c99cf7-7e60-236f-fe23-8341840e1d09@redhat.com>
	<e0c515bf-6618-74a7-aab4-6c828389a404@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <e0e9c08f-970d-5470-1e74-336abad23773@redhat.com>
Date: Tue, 17 Jul 2018 15:10:40 -0400
MIME-Version: 1.0
In-Reply-To: <e0c515bf-6618-74a7-aab4-6c828389a404@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] bloc/qcow2: drop dirty_bitmaps_loaded
 state variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, stefanha@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org



On 07/10/2018 03:43 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.07.2018 02:25, John Snow wrote:
>>
>> On 06/26/2018 09:50 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> This variable doesn't work as it should, because it is actually clear=
ed
>>> in qcow2_co_invalidate_cache() by memset(). Drop it, as the following
>>> patch will introduce new behavior.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/qcow2.h |=C2=A0 1 -
>>> =C2=A0 block/qcow2.c | 19 ++-----------------
>>> =C2=A0 2 files changed, 2 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/block/qcow2.h b/block/qcow2.h
>>> index 01b5250415..c9df19b6e6 100644
>>> --- a/block/qcow2.h
>>> +++ b/block/qcow2.h
>>> @@ -294,7 +294,6 @@ typedef struct BDRVQcow2State {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t nb_bitmaps;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t bitmap_directory_size;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t bitmap_directory_offset;
>>> -=C2=A0=C2=A0=C2=A0 bool dirty_bitmaps_loaded;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int flags;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int qcow_version;
>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>> index 46194a33ca..0044ff58e7 100644
>>> --- a/block/qcow2.c
>>> +++ b/block/qcow2.c
>>> @@ -1149,7 +1149,6 @@ static int coroutine_fn
>>> qcow2_do_open(BlockDriverState *bs, QDict *options,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t ext_end;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t l1_vm_state_index;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool update_header =3D false;
>>> -=C2=A0=C2=A0=C2=A0 bool header_updated =3D false;
>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D bdrv_pread(bs->file, 0,=
 &header, sizeof(header));
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>>> @@ -1488,23 +1487,9 @@ static int coroutine_fn
>>> qcow2_do_open(BlockDriverState *bs, QDict *options,
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->autoclear_f=
eatures &=3D QCOW2_AUTOCLEAR_MASK;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (s->dirty_bitmaps_loaded) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* It's some kind of reop=
en. There are no known cases where
>>> we need to
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reload bitmaps in=
 such a situation, so it's safer to skip
>>> them.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Moreover, if we h=
ave some readonly bitmaps and we are
>>> reopening for
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * rw we should reop=
en bitmaps correspondingly.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bdrv_has_readonly_bit=
maps(bs) &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !=
bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) &
>>> BDRV_O_INACTIVE))
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 q=
cow2_reopen_bitmaps_rw_hint(bs, &header_updated,
>>> &local_err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 } else {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_updated =3D qcow2_=
load_dirty_bitmaps(bs, &local_err);
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->dirty_bitmaps_loaded =3D=
 true;
>>> +=C2=A0=C2=A0=C2=A0 if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 update_header =3D false;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> -=C2=A0=C2=A0=C2=A0 update_header =3D update_header && !header_update=
d;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err !=3D NULL) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_propagat=
e(errp, local_err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D -EINVA=
L;
>>>
>> Usually I'd like to see the new behavior introduced before removing th=
e
>> old, imperfect solution... (it doesn't make any tests fail!? ...)
>>
>> At this point in the series I just have to trust that you will fix it =
to
>> be better :)
>=20
> As I understand, this field is actually always false, so it's safe to
> drop it.

Ah, you know, I think I was remembering a patch (?) where you explicitly
cache this value and restore it -- but that must have been a previous
incarnation of this patchset.

I realize now that as the code actually exists in origin/master that
it's always going to be false, yeah.

--js
