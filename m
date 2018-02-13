Received: from eggs.gnu.org ([2001:4830:134:3::10]:57689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elVHa-0001kr-V9
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1elVHa-00056H-62
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 02:45:43 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
	<f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
	<20171229013140.GA13004@lemon>
	<9b13ad99-981c-f623-0a71-6d1aad73c159@redhat.com>
	<78110cb5-b69c-a35a-17ed-9bb1f121bc06@virtuozzo.com>
	<c7273453-a480-c041-8b42-6275a6182f46@redhat.com>
	<d5c082d0-908f-f6a5-3e9f-d372afdf8163@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5ba25e73-3182-9053-2b7c-851b271029ba@redhat.com>
Date: Tue, 13 Feb 2018 08:45:07 +0100
MIME-Version: 1.0
In-Reply-To: <d5c082d0-908f-f6a5-3e9f-d372afdf8163@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 03/13] block/dirty-bitmap: add _locked
 version of bdrv_reclaim_dirty_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

On 12/02/2018 18:30, Vladimir Sementsov-Ogievskiy wrote:
> 18.01.2018 13:09, Paolo Bonzini wrote:>> We have three cases:
>>
>> 1) monitor creates and destroy bitmaps.
>>
>> 2) monitor also has to read the list.=C2=A0 We know it operates with B=
QL.
>>
>> 3) users such as mirror.c create a dirty bitmap in the monitor command
>> (under BQL), but they can operate without BQL in a separate iothread s=
o
>> we create a separate lock (bitmap->mutex).
>>
>> While in the second and third case, bitmaps cannot disappear.=C2=A0 So=
 in the
>> first case you operate with BQL+dirty bitmap mutex.=C2=A0 The result i=
s that
>> you lock out both the second and the third case while creating and
>> destroying bitmaps.
>>
>>> Why do we do not need them
>>> on read from the bitmap, only on write?
>>
>> Indeed, reading the bitmap also requires taking the lock.=C2=A0 So
>> s/Modifying/Accessing/ in that comment.
>=20
> So, finally, the whole thing is:
>=20
> 1. any access to dirty_bitmaps list needs BQL or dirty_bitmap_mutex
> 2. bitmap creation or removing needs both BQL and dirty_bitmap_mutex

3. any access to a dirty bitmap needs dirty_bitmap_mutex

Paolo

> yes?
>=20
> and one more question:
> Do we really have users, which accesses dirty bitmaps with only BQL?
> query-block uses dirty_bitmap_mutex..
>=20
>=20
