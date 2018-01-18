Received: from eggs.gnu.org ([2001:4830:134:3::10]:52951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ec6uc-0006T4-6N
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:55:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ec6uZ-0003Mb-4d
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 04:55:10 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
	<f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
	<20171229013140.GA13004@lemon>
	<9b13ad99-981c-f623-0a71-6d1aad73c159@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <78110cb5-b69c-a35a-17ed-9bb1f121bc06@virtuozzo.com>
Date: Thu, 18 Jan 2018 12:55:00 +0300
MIME-Version: 1.0
In-Reply-To: <9b13ad99-981c-f623-0a71-6d1aad73c159@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
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
To: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, peter.maydell@linaro.org, lirans@il.ibm.com, qemu-block@nongnu.org, quintela@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, den@openvz.org, amit.shah@redhat.com, mreitz@redhat.com, dgilbert@redhat.com

18.01.2018 11:43, Paolo Bonzini wrote:
> On 29/12/2017 02:31, Fam Zheng wrote:
>>> we have the following comment:
>>>
>>>  =C2=A0=C2=A0=C2=A0 /* Writing to the list requires the BQL _and_ the d=
irty_bitmap_mutex.
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 * Reading from the list can be done with eith=
er the BQL or the
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex.=C2=A0 Modifying a bitma=
p only requires
>>>  =C2=A0=C2=A0=C2=A0=C2=A0 * dirty_bitmap_mutex. */
>>>  =C2=A0=C2=A0=C2=A0 QemuMutex dirty_bitmap_mutex;
>>>
>>> (I don't understand well the logic, why is it so. Paolo introduced the =
lock,
>>> but didn't update some functions..)
>>>
>>> so, actually, here we need both BQL and mutex.
>> Yes, because of that comment my interpretion has been both "BQL and the =
mutex"
>> whereever we say "within bdrv_dirty_bitmap_lock..unlock", as to some oth=
er
>> places in this file.
> A bit late, but---no, "within bdrv_dirty_bitmap_lock..unlock" means it's
> the "modifying the bitmap" case.
>
> Most functions that looks at the list are "called with BQL taken".
> Functions that write to the list are "called with BQL taken" and call
> bdrv_dirty_bitmaps_lock/bdrv_dirty_bitmaps_unlock themselves.
>
> Paolo

Paolo, could you please explain about bitmap locking in more details?=20
Why do we need mutexes? Why do we do not need them
on read from the bitmap, only on write?

I imaging the following cases for locks:

- mutex + BQL(do aio_context_acquire take it?)
- only mutex
- only BQL
- no locks

and following operation on bitmaps:

- r/w bitmaps list (i.e. change .next fields of bitmaps and head of the=20
list)
- r/w BdrvDirtyBitmap fields
- r/w HBitmap fields
- r/w HBitmap levels (set/unset/read bits)

what is the relations between locking cases and operations and why?

Sorry if I'm asking stupid questions :(

--=20
Best regards,
Vladimir
