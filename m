Received: from eggs.gnu.org ([209.51.188.92]:60034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YdE-0007kO-TO
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h1YdD-0006ET-PZ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 10:38:56 -0500
References: <20190305234337.18353-1-jsnow@redhat.com>
	<20190305234337.18353-4-jsnow@redhat.com>
	<2329eba6-bba0-46ea-7960-b19eb16623d4@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <77d25e45-9304-f5f0-264a-0514ae45f49c@redhat.com>
Date: Wed, 6 Mar 2019 10:38:39 -0500
MIME-Version: 1.0
In-Reply-To: <2329eba6-bba0-46ea-7960-b19eb16623d4@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] block/qcow2-bitmap: don't remove
 bitmaps on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "eblake@redhat.com" <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>



On 3/6/19 10:28 AM, Vladimir Sementsov-Ogievskiy wrote:
> 06.03.2019 2:43, John Snow wrote:
>> We tend to remove bitmaps when we flush them to disk, but it's not appropriate
>> in all cases. let the reopen mechanism use the lighter weight flush instead of
>> the heavier store.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   block/qcow2-bitmap.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
>> index 4e11b6b05a..9373055d3b 100644
>> --- a/block/qcow2-bitmap.c
>> +++ b/block/qcow2-bitmap.c
>> @@ -1560,7 +1560,7 @@ int qcow2_reopen_bitmaps_ro(BlockDriverState *bs, Error **errp)
>>       BdrvDirtyBitmap *bitmap;
>>       Error *local_err = NULL;
>>   
>> -    qcow2_store_persistent_dirty_bitmaps(bs, &local_err);
>> +    qcow2_flush_persistent_dirty_bitmaps(bs, &local_err);
>>       if (local_err != NULL) {
>>           error_propagate(errp, local_err);
>>           return -EINVAL;
>>
> 
> 
> hmm will it work? if we call qcow2_open after that, it will fail to load bitmaps, as they
> are already exist
> 

Hmm, maybe you're right. I didn't test this very well. It seemed wrong
to me so I "fixed" it... let me write a test that covers this.
