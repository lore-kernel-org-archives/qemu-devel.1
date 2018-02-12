Received: from eggs.gnu.org ([2001:4830:134:3::10]:45247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1elHwT-000081-3n
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1elHwO-0002Xu-HN
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:31:01 -0500
References: <20171220154945.88410-1-vsementsov@virtuozzo.com>
	<20171220154945.88410-4-vsementsov@virtuozzo.com>
	<20171228052418.GC9192@lemon>
	<f6637c9d-047b-b9f3-1a5a-4b59baf49cbc@virtuozzo.com>
	<20171229013140.GA13004@lemon>
	<9b13ad99-981c-f623-0a71-6d1aad73c159@redhat.com>
	<78110cb5-b69c-a35a-17ed-9bb1f121bc06@virtuozzo.com>
	<c7273453-a480-c041-8b42-6275a6182f46@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d5c082d0-908f-f6a5-3e9f-d372afdf8163@virtuozzo.com>
Date: Mon, 12 Feb 2018 20:30:47 +0300
MIME-Version: 1.0
In-Reply-To: <c7273453-a480-c041-8b42-6275a6182f46@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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

18.01.2018 13:09, Paolo Bonzini wrote:
> On 18/01/2018 10:55, Vladimir Sementsov-Ogievskiy wrote:
>>> Most functions that looks at the list are "called with BQL taken".
>>> Functions that write to the list are "called with BQL taken" and call
>>> bdrv_dirty_bitmaps_lock/bdrv_dirty_bitmaps_unlock themselves.
>> Paolo, could you please explain about bitmap locking in more details?
>> Why do we need mutexes?
> We have three cases:
>
> 1) monitor creates and destroy bitmaps.
>
> 2) monitor also has to read the list.  We know it operates with BQL.
>
> 3) users such as mirror.c create a dirty bitmap in the monitor command
> (under BQL), but they can operate without BQL in a separate iothread so
> we create a separate lock (bitmap->mutex).
>
> While in the second and third case, bitmaps cannot disappear.  So in the
> first case you operate with BQL+dirty bitmap mutex.  The result is that
> you lock out both the second and the third case while creating and
> destroying bitmaps.
>
>> Why do we do not need them
>> on read from the bitmap, only on write?
> Indeed, reading the bitmap also requires taking the lock.  So
> s/Modifying/Accessing/ in that comment.
>
> Paolo

So, finally, the whole thing is:

1. any access to dirty_bitmaps list needs BQL or dirty_bitmap_mutex
2. bitmap creation or removing needs both BQL and dirty_bitmap_mutex

yes?

and one more question:
Do we really have users, which accesses dirty bitmaps with only BQL? 
query-block uses dirty_bitmap_mutex..


-- 
Best regards,
Vladimir
