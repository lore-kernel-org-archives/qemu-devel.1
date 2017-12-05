Received: from eggs.gnu.org ([2001:4830:134:3::10]:45346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eMGnb-0000TH-2u
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:14:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eMGnW-0000nY-3H
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:14:27 -0500
References: <1511196664-85304-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1511196664-85304-3-git-send-email-anton.nefedov@virtuozzo.com>
	<w51po7t5hgh.fsf@maestria.local.igalia.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <1a1334cc-8fae-03bc-b0be-70ee4b8c4ac0@virtuozzo.com>
Date: Tue, 5 Dec 2017 20:14:03 +0300
MIME-Version: 1.0
In-Reply-To: <w51po7t5hgh.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] ide: account UNMAP (TRIM)
 operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@virtuozzo.com, armbru@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, John Snow <jsnow@redhat.com>



On 5/12/2017 6:21 PM, Alberto Garcia wrote:
> On Mon 20 Nov 2017 05:50:59 PM CET, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   hw/ide/core.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 471d0c9..2e4dea7 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -389,6 +389,7 @@ typedef struct TrimAIOCB {
>>       QEMUIOVector *qiov;
>>       BlockAIOCB *aiocb;
>>       int i, j;
>> +    BlockAcctCookie acct;
>>   } TrimAIOCB;
>>   
>>   static void trim_aio_cancel(BlockAIOCB *acb)
>> @@ -426,6 +427,14 @@ static void ide_trim_bh_cb(void *opaque)
>>   static void ide_issue_trim_cb(void *opaque, int ret)
>>   {
>>       TrimAIOCB *iocb = opaque;
>> +    if (iocb->i >= 0) {
>> +        if (ret >= 0) {
>> +            block_acct_done(blk_get_stats(iocb->blk), &iocb->acct);
>> +        } else {
>> +            block_acct_failed(blk_get_stats(iocb->blk), &iocb->acct);
>> +        }
>> +    }
> 
> This part looks fine, but don't you also need to account for invalid
> requests (in ide_dma_cb() or somewhere else) ?
> 
> Berto
> 

Good point; in fact, the TRIM sector range is never checked.
(well it should be, down at the block layer, and then counted as error).

The motivation was:

     commit d66168ed687325aa6d338ce3a3cff18ce3098ed6
     Author: Michael Tokarev <mjt@tls.msk.ru>
     Date:   Wed Aug 13 11:23:31 2014 +0400

     ide: only constrain read/write requests to drive size, not other types

     Commit 58ac321135a introduced a check to ide dma processing which
     constrains all requests to drive size.  However, apparently, some
     valid requests (like TRIM) does not fit in this constraint, and
     fails in 2.1.  So check the range only for reads and writes.


It seems like the removed check was at the wrong place (trim request has
to be parsed first to get offset and nbytes).
Probably it should be put to ide_issue_trim_cb() instead.

cc John (should have done it earlier)

/Anton
