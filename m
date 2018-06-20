Received: from eggs.gnu.org ([2001:4830:134:3::10]:39970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVgnA-0007d7-2W
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:21:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVgn8-00068I-Lg
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:21:12 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180612172614.60107-1-vsementsov@virtuozzo.com>
	<bba5e735-2c16-e6a6-7742-7bc2ddcd0380@redhat.com>
	<bf81ec94-7e29-d902-9f8d-34c7a5b50557@redhat.com>
	<32ef84ab-f979-8857-9bdc-c32d47e79aeb@virtuozzo.com>
Message-ID: <9a717235-5eda-25bb-477d-0bd62c5faf1d@virtuozzo.com>
Date: Wed, 20 Jun 2018 20:20:58 +0300
MIME-Version: 1.0
In-Reply-To: <32ef84ab-f979-8857-9bdc-c32d47e79aeb@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block/qcow2: fix logic around
 dirty_bitmaps_loaded
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, mreitz@redhat.com

20.06.2018 20:17, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2018 01:18, John Snow wrote:
>>
>> On 06/12/2018 06:11 PM, John Snow wrote:
>>>
>>> On 06/12/2018 01:26 PM, Vladimir Sementsov-Ogievskiy wrote:
>>>> First: this variable was introduced to handle reopens. We need it on
>>>> following qcow2_do_open, to don't try loading bitmaps again. So, we=20
>>>> are
>>>> fixing qcow2_invalidate_cache().
>>>>
>>>> However, if we fix only qcow2_invalidate_cache, iotest 169 fails on
>>>> case test__persistent__not_migbitmap__online_shared, because on first
>>>> target open, source is not yet closed, and is not yet stored bitmaps,
>>>> so, we are load nothing. And on second open, dirty_bitmaps_loaded is
>>>> already true, but we have no bitmaps to reopen with
>>>> qcow2_reopen_bitmaps_rw_hint(). So, we are fixing qcow2_do_open() too.
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>> =C2=A0 block/qcow2.c | 4 +++-
>>>> =C2=A0 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>> index 6fa5e1d71a..b4216a5830 100644
>>>> --- a/block/qcow2.c
>>>> +++ b/block/qcow2.c
>>>> @@ -1499,7 +1499,7 @@ static int coroutine_fn=20
>>>> qcow2_do_open(BlockDriverState *bs, QDict *options,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 qcow2_reopen_bitmaps_rw_hint(bs, &header_updated,=20
>>>> &local_err);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> -=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0 } else if (s->nb_bitmaps > 0) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 header_updated =
=3D qcow2_load_dirty_bitmaps(bs, &local_err);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->dirty_bitmap=
s_loaded =3D true;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> @@ -2178,6 +2178,7 @@ static void coroutine_fn=20
>>>> qcow2_co_invalidate_cache(BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QDict *options;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>>>> +=C2=A0=C2=A0=C2=A0 bool dirty_bitmaps_loaded =3D s->dirty_bitmaps_loa=
ded;
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Backing files are read-only whi=
ch makes all of their=20
>>>> metadata immutable,
>>>> @@ -2190,6 +2191,7 @@ static void coroutine_fn=20
>>>> qcow2_co_invalidate_cache(BlockDriverState *bs,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qcow2_close(bs);
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(s, 0, sizeof(BDRVQcow2Sta=
te));
>>>> +=C2=A0=C2=A0=C2=A0 s->dirty_bitmaps_loaded =3D dirty_bitmaps_loaded;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 options =3D qdict_clone_shallow(bs->opt=
ions);
>>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags &=3D ~BDRV_O_INACTIVE;
>>>>
>>> Ah, tch... I didn't realize that invalidate completely wipes the qcow2
>>> metadata.
>>>
>>> I guess the other three fields, nb_bitmaps, bitmap_directory_size and
>>> bitmap_directory_offset get initialized again on re-open.
>>>
>>> (I suppose this means I need to rethink caching bm_list more carefully,
>>> too...)
>>>
>>> I think this looks correct mechanically.
>>>
>> Oh, I meant:
>>
>> Reviewed-by: John Snow <jsnow@redhat.com>
>
> It is interesting, this patch also fixes iotest 169. It's not broken=20
> formally, but if we look at vm output of vm_b after migration, we'll see
>
> qemu-system-x86_64: Could not reopen qcow2 layer: Bitmap already=20
> exists: bitmap0
>
> which leads to failed invalidation and bs->drv =3D NULL :)
>
> I'll improve iotest somehow, to show this failure.
>

the bug can be shown with the following workaround:

diff --git a/tests/qemu-iotests/169 b/tests/qemu-iotests/169
index f243db9955..6dce24d29f 100755
--- a/tests/qemu-iotests/169
+++ b/tests/qemu-iotests/169
@@ -131,9 +131,13 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 break

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.check_bitmap(self.vm=
_b, sha256 if should_migrate else False)
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.vm_b.hmp_qemu_io('drive0',=
 'write 0 512')

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if should_migrate:
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
elf.vm_b.shutdown()
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print '=
=3D=3D=3D=3D'
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print s=
elf.vm_b.get_log()
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 print '=
=3D=3D=3D=3D'
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
 recreate vm_b, as we don't want -incoming option (this=20
will lead
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
 to "cat" process left alive after test finish)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s=
elf.vm_b =3D iotests.VM(path_suffix=3D'b')
@@ -152,7 +156,8 @@ for cmb in list(itertools.product((True, False),=20
repeat=3D4)):
 =C2=A0=C2=A0=C2=A0=C2=A0 name +=3D '_online' if cmb[2] else '_offline'
 =C2=A0=C2=A0=C2=A0=C2=A0 name +=3D '_shared' if cmb[3] else '_nonshared'

-=C2=A0=C2=A0=C2=A0 inject_test_case(TestDirtyBitmapMigration, name, 'do_te=
st_migration',
+=C2=A0=C2=A0=C2=A0 if name =3D=3D '_persistent__not_migbitmap__offline_sha=
red':
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 inject_test_case(TestDirtyBitma=
pMigration, name,=20
'do_test_migration',
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *list(cmb))




--=20
Best regards,
Vladimir
