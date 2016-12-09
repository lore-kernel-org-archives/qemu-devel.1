Received: from eggs.gnu.org ([2001:4830:134:3::10]:43560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cFPPB-0005xF-4E
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cFPP8-00036d-2g
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:56:21 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:23912 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cFPP7-000367-O5
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:56:18 -0500
References: <1479835586-74394-1-git-send-email-vsementsov@virtuozzo.com>
	<1479835586-74394-14-git-send-email-vsementsov@virtuozzo.com>
	<919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <74e1aec8-b604-fb86-48fa-70a16ae29a0c@virtuozzo.com>
Date: Fri, 9 Dec 2016 20:55:52 +0300
MIME-Version: 1.0
In-Reply-To: <919ac9f1-cc7a-8679-c9f4-1da26bc27bf4@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 13/21] qcow2: add
 .bdrv_store_persistent_dirty_bitmaps()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

09.12.2016 20:05, Max Reitz wrote:
> On 22.11.2016 18:26, Vladimir Sementsov-Ogievskiy wrote:
>> Realize block bitmap storing interface, to allow qcow2 images store
>> persistent bitmaps.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/qcow2-bitmap.c | 451 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   block/qcow2.c        |   1 +
>>   block/qcow2.h        |   1 +
>>   3 files changed, 453 insertions(+)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 81be1ca..a975388 100644
>> --- a/block/qcow2-bitmap.c

[...]

>> +            return;
>> +        }
>> +    }
>> +
>> +    /* check constraints and names */
>> +    for (bitmap = bdrv_dirty_bitmap_next(bs, NULL); bitmap != NULL;
>> +            bitmap = bdrv_dirty_bitmap_next(bs, bitmap)) {
> Alignment to the opening parenthesis, please.

Hmm.. without an alignment it is not so simple to distinguish for-loop 
header from its body.


[...]

> [1] What about bitmaps that have BME_FLAG_IN_USE set but do not have a
> corresponding BDS bitmap?
>
> If such a bitmap does not have BME_FLAG_AUTO set, we didn't set the
> flag, so we should keep it unchanged. That's what this function is
> currently doing.
>
> However, if such a bitmap does have BME_FLAG_AUTO set, it was definitely
> us who set the IN_USE flag (because otherwise we would have aborted
> loading the bitmaps, and thus also aborted bdrv_open_common()).
> Therefore, the only explanation is that the bitmap was deleted in the
> meantime, and that means we should also delete it in the qcow2 file.

Right. Or, alternatively, these bitmaps may be deleted on corresponding 
BdrvDirtyBitmap deletion.


-- 
Best regards,
Vladimir
