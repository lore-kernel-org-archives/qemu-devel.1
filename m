Received: from eggs.gnu.org ([2001:4830:134:3::10]:59556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1edgFB-00037Y-SR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1edgFA-0007SD-Gl
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 12:50:53 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
	<f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
	<20171229013140.GA13004@lemon>
	<9b13ad99-981c-f623-0a71-6d1aad73c159@redhat.com>
	<78110cb5-b69c-a35a-17ed-9bb1f121bc06@virtuozzo.com>
	<c7273453-a480-c041-8b42-6275a6182f46@redhat.com>
	<e8635926-315b-d454-73ab-0875203e9b7c@virtuozzo.com>
	<41e11a98-98e9-1766-17e9-8bb5182f4b91@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <1ec6118d-a6f1-ed5c-edfd-79551bc3f98f@redhat.com>
Date: Mon, 22 Jan 2018 12:50:33 -0500
MIME-Version: 1.0
In-Reply-To: <41e11a98-98e9-1766-17e9-8bb5182f4b91@virtuozzo.com>
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
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, mreitz@redhat.com, dgilbert@redhat.com



On 01/22/2018 07:14 AM, Vladimir Sementsov-Ogievskiy wrote:
> 19.01.2018 17:12, Vladimir Sementsov-Ogievskiy wrote:
>> 18.01.2018 13:09, Paolo Bonzini wrote:
>>> On 18/01/2018 10:55, Vladimir Sementsov-Ogievskiy wrote:
>>>>> Most functions that looks at the list are "called with BQL taken".
>>>>> Functions that write to the list are "called with BQL taken" and ca=
ll
>>>>> bdrv_dirty_bitmaps_lock/bdrv_dirty_bitmaps_unlock themselves.
>>>> Paolo, could you please explain about bitmap locking in more details=
?
>>>> Why do we need mutexes?
>>> We have three cases:
>>>
>>> 1) monitor creates and destroy bitmaps.
>>>
>>> 2) monitor also has to read the list.=C2=A0 We know it operates with =
BQL.
>>>
>>> 3) users such as mirror.c create a dirty bitmap in the monitor comman=
d
>>> (under BQL), but they can operate without BQL in a separate iothread =
so
>>> we create a separate lock (bitmap->mutex).
>>>
>>> While in the second and third case, bitmaps cannot disappear. So in t=
he
>>> first case you operate with BQL+dirty bitmap mutex.=C2=A0 The result =
is that
>>> you lock out both the second and the third case while creating and
>>> destroying bitmaps.
>>>
>>>> Why do we do not need them
>>>> on read from the bitmap, only on write?
>>> Indeed, reading the bitmap also requires taking the lock.=C2=A0 So
>>> s/Modifying/Accessing/ in that comment.
>>>
>>> Paolo
>>
>> so,
>>
>> =C2=A0=C2=A0=C2=A0 /* Writing to the list requires the BQL_and_=C2=A0 =
the dirty_bitmap_mutex.
>> =C2=A0=C2=A0=C2=A0=C2=A0 * Reading from the list can be done with eith=
er the BQL or the
>> =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex.=C2=A0 Accessing a bitma=
p only requires
>> =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex. */
>> =C2=A0=C2=A0=C2=A0 QemuMutex dirty_bitmap_mutex;
>>
>>
>>
>> so, accessing the bitmap needs mutex lock?
>>
>> Then what do you mean under accessing the bitmap? Any touch of
>> BdrvDirtyBitmap fields? Then "reading the list" will require bitmap
>> mutex too.
>> Or accessing the bitmap is accessing any field except
>> BdrvDirtyBitmap.list? Then in (2), what do you mean? For example
>> query-block will go through
>> the list, but it touches other fields too, so it should lock mutex.
>>
>=20
> and one more question:
>=20
> What about qmp transactions? Should we lock mutex during the whole
> transaction?
>=20

For bitmaps?

hmm...

at the moment, Transactions still do the tepid bdrv_drain_all() prior to
the transaction, and then I suspect they rely on the QMP context holding
the big lock to prevent any new IO occurring.

It should be a quiescent point, I think, but I've lost track of how
exactly it behaves presently. Didn't we need a
bdrv_drained_all_begin/_end pair here? Did we not do that? I forget why..=
.

(...is it related to how we don't know how to implement this in a
context where graph changes might occur, which can happen during a
transaction?)

it might not be possible to grab the bitmap locks during .prepare and
release them in .cleanup, because we might want to add two actions to
the same transaction that operate on the same bitmap (full backup +
clear, for instance?) and they'll deadlock against each other.

It might be sufficient to just lock and release per each action, until
the deeper issues with transactions are resolved. If the transaction is
properly quiescent, you shouldn't run into any bitmap inconsistency
problems anyway.

Hoping Kevin and Paolo can chime in to remind me of the details, here.
