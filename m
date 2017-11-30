Received: from eggs.gnu.org ([2001:4830:134:3::10]:50695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnYs-0002lJ-Sp
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eKnXy-0001l8-Ey
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 10:49:10 -0500
References: <20171012185916.22776-1-eblake@redhat.com>
	<20171012185916.22776-18-eblake@redhat.com>
	<0517a634-6585-2d3b-25b7-14d470adecc1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83497921-5ef7-9bad-5cfd-e7542ab441a4@redhat.com>
Date: Thu, 30 Nov 2017 17:18:15 -0600
MIME-Version: 1.0
In-Reply-To: <0517a634-6585-2d3b-25b7-14d470adecc1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 17/20] vmdk: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/30/2017 05:39 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.10.2017 21:59, Eric Blake wrote:
>> We are gradually moving away from sector-based interfaces, towards
>> byte-based.=C2=A0 Update the vmdk driver accordingly.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> ---
>> v4: rebase to interface tweak
>> v3: no change
>> v2: rebase to mapping flag
>> ---
>> =C2=A0 block/vmdk.c | 28 +++++++++++++---------------
>> =C2=A0 1 file changed, 13 insertions(+), 15 deletions(-)

>> +static int coroutine_fn vmdk_co_block_status(BlockDriverState *bs,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool want_zero,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t offset, int64_t=20
>> bytes,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t *pnum, int64_t=20
>> *map,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState **file)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BDRVVmdkState *s =3D bs->opaque;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int64_t index_in_cluster, n, ret;
>> -=C2=A0=C2=A0=C2=A0 uint64_t offset;
>> +=C2=A0=C2=A0=C2=A0 uint64_t cluster_offset;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VmdkExtent *extent;
>>
>> -=C2=A0=C2=A0=C2=A0 extent =3D find_extent(s, sector_num, NULL);
>> +=C2=A0=C2=A0=C2=A0 extent =3D find_extent(s, offset >> BDRV_SECTOR_BI=
TS, NULL);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!extent) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;

Pre-existing bug - this returns 0, but did not set pnum.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
