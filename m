Received: from eggs.gnu.org ([2001:4830:134:3::10]:42331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBrht-0006Lp-IF
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1eBrhs-0001MM-HD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 19:25:33 -0500
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
	<20171002143919.207741-4-vsementsov@virtuozzo.com>
	<9e5c8b0a-d2f9-e051-f8fb-b9618982e6ea@redhat.com>
	<b3c404ca-54bd-7385-32eb-58addcf52714@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <104807ac-bde9-fdba-85cc-e380bed820d0@redhat.com>
Date: Mon, 6 Nov 2017 19:25:10 -0500
MIME-Version: 1.0
In-Reply-To: <b3c404ca-54bd-7385-32eb-58addcf52714@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] backup: init copy_bitmap from
 sync_bitmap for incremental
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org



On 10/12/2017 07:23 AM, Vladimir Sementsov-Ogievskiy wrote:
> 10.10.2017 01:56, John Snow wrote:
>>
>> On 10/02/2017 10:39 AM, Vladimir Sementsov-Ogievskiy wrote:
>>> We should not copy non-dirty clusters in write notifiers. So,
>>> initialize copy_bitmap from sync_bitmap.
>>>
>> ...! Duh, good find!!
>>
>> So, previously we'd copy extra sectors if they just so happened to be
>> written to during the backup process. These would be totally redundant
>> compared to the previous backups in the chain, by definition.
>>
>> Now, we allow the write to go through to the source image and let it
>> dirty the bdrv dirty bitmap we have on standby.
>>
>> Good fix.
>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>>> ---
>>> =C2=A0 block/backup.c | 45 ++++++++++++++++++++++++++++++++++++++++++=
++-
>>> =C2=A0 1 file changed, 44 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/backup.c b/block/backup.c
>>> index 08efec639f..07f4ae846b 100644
>>> --- a/block/backup.c
>>> +++ b/block/backup.c
>>> @@ -422,6 +422,43 @@ out:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>> =C2=A0 }
>>> =C2=A0 +/* init copy_bitmap from sync_bitmap */
>>> +static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmapIter *dbi;
>>> +=C2=A0=C2=A0=C2=A0 int64_t offset;
>>> +=C2=A0=C2=A0=C2=A0 int64_t end =3D
>>> DIV_ROUND_UP(bdrv_dirty_bitmap_size(job->sync_bitmap),
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 job->cluster_size);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 dbi =3D bdrv_dirty_iter_new(job->sync_bitmap);
>>> +=C2=A0=C2=A0=C2=A0 while ((offset =3D bdrv_dirty_iter_next(dbi)) !=3D=
 -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t cluster =3D offse=
t / job->cluster_size;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t next_cluster;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset +=3D bdrv_dirty_bi=
tmap_granularity(job->sync_bitmap);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset >=3D bdrv_dirt=
y_bitmap_size(job->sync_bitmap)) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
bitmap_set(job->copy_bitmap, cluster, end - cluster);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D bdrv_dirty_bit=
map_next_zero(job->sync_bitmap, offset);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (offset =3D=3D -1) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 h=
bitmap_set(job->copy_bitmap, cluster, end - cluster);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 next_cluster =3D DIV_ROUN=
D_UP(offset, job->cluster_size);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hbitmap_set(job->copy_bit=
map, cluster, next_cluster - cluster);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (next_cluster >=3D end=
) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> +
>> Did you look into initializing this from a lower layer, e.g. a call to
>> initialize-an-hbitmap-from-another-hbitmap?
>>
>> The loop might look a little cleaner that way and we might possibly ge=
t
>> more utility out of it than a custom coded loop here in the backup cod=
e.
>=20
> No, to be honest, I don't want to do it now, there are some difficultie=
s:
>=20
> 1. we init from bdrv bitmap, so we'll have to add a bit strange common
> interface init-hbitmap-from-bdrv-bitmap
> 2 (more hard). here copy_bitmap have other size: it's granularity is
> zero, it corresponds to clusters, not to bytes, and I don't want to
> change this.
> so, it's not a common case..
>=20

Fair enough, it just struck me as a slightly odd thing to code here in
the backup file, but it's true that nobody else needs this yet (or
perhaps ever.)

No problem. We'll figure it out when we get there. Thank you!

--js
