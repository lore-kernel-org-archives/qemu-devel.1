Received: from eggs.gnu.org ([2001:4830:134:3::10]:57302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edYHF-0004xv-Ea
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1edYH9-0006V2-EO
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 04:20:29 -0500
References: <20180116125427.18540-1-vsementsov@virtuozzo.com>
	<8cb52056-e57c-ec72-60a1-adc41f21b9c3@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d64cd344-bbcb-a088-f74d-a3e5446085f4@virtuozzo.com>
Date: Mon, 22 Jan 2018 12:20:08 +0300
MIME-Version: 1.0
In-Reply-To: <8cb52056-e57c-ec72-60a1-adc41f21b9c3@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 0/6] qmp dirty bitmap API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mnestratov@virtuozzo.com, mreitz@redhat.com, nshirokovskiy@virtuozzo.com, den@openvz.org

20.01.2018 02:30, John Snow wrote:
>
> On 01/16/2018 07:54 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Hi all.
>>
>> There are three qmp commands, needed to implement external backup API.
>>
>> Using these three commands, client may do all needed bitmap management by
>> hand:
>>
>> on backup start we need to do a transaction:
>>   {disable old bitmap, create new bitmap}
>>
>> on backup success:
>>   drop old bitmap
>>
>> on backup fail:
>>   enable old bitmap
>>   merge new bitmap to old bitmap
>>   drop new bitmap
>>
>> v2: fix merge command deadlock
>>    add new patches: 1 and 6
>>
>> Vladimir Sementsov-Ogievskiy (6):
>>    block: maintain persistent disabled bitmaps
>>    block/dirty-bitmap: add lock to bdrv_enable/disable_dirty_bitmap
>>    qapi: add block-dirty-bitmap-enable/disable
>>    qmp: transaction support for block-dirty-bitmap-enable/disable
>>    qapi: add block-dirty-bitmap-merge
>>    qapi: add disabled parameter to block-dirty-bitmap-add
>>
>>   qapi/block-core.json         |  92 ++++++++++++++++++++++-
>>   qapi/transaction.json        |   4 +
>>   block/qcow2.h                |   2 +-
>>   include/block/dirty-bitmap.h |   3 +-
>>   block/dirty-bitmap.c         |  42 ++++++-----
>>   block/qcow2-bitmap.c         |  12 +--
>>   block/qcow2.c                |   2 +-
>>   blockdev.c                   | 169 +++++++++++++++++++++++++++++++++++++++++--
>>   8 files changed, 287 insertions(+), 39 deletions(-)
>>
> Fails to apply to master (b384cd95) on patch four and five. Only
> contextual problems, I've patched it up and I'll review that.
>
> (mirrored here if you want to check my rebase work:
> https://github.com/jnsnow/qemu/tree/vlad-review)
>
> Since I was full of such bad and stupid ideas last time, I'd like
> someone else to look over this one for design and I'll just review it
> for accuracy.
>
> --js

Thank you for review, John!

Ok, so, I'll going to:

- take patch 1 into migration and respin it today (I hope) with test 
about qcow2-based bitmap migration disabled.
- separate fixes and refactoring from here (locking + _bitmap_clear 
transaction), send them separately
- than, make test for external backup and respin these series with it

-- 
Best regards,
Vladimir
