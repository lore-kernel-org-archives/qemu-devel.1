Received: from eggs.gnu.org ([2001:4830:134:3::10]:53400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ewnPG-000622-8B
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ewnPC-0004cw-Hg
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:20:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36568
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1ewnPC-0004cP-6b
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 07:20:14 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <1520010495-58172-1-git-send-email-anton.nefedov@virtuozzo.com>
	<be2cf515-ddf8-74ef-7854-319329ee9209@ilande.co.uk>
Message-ID: <b73a9767-1a49-9e51-dc79-41a3547df969@ilande.co.uk>
Date: Fri, 16 Mar 2018 11:20:05 +0000
MIME-Version: 1.0
In-Reply-To: <be2cf515-ddf8-74ef-7854-319329ee9209@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ide: fix invalid TRIM range abortion for
 macio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jsnow@redhat.com, qemu-devel@nongnu.org
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>

On 05/03/18 21:54, Mark Cave-Ayland wrote:

> On 02/03/18 17:08, Anton Nefedov wrote:
> 
>> commit 947858b0 "ide: abort TRIM operation for invalid range"
>> is incorrect for macio; just ide_dma_error() without doing a callback
>> is not enough for that errorpath.
>>
>> Instead, pass -EINVAL to the callback and handle it there
>> (see related motivation for read/write in 58ac32113).
>>
>> It will however catch possible EINVAL from the block layer too.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   hw/ide/core.c | 17 +++++++++--------
>>   1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>> index 257b429..54510d4 100644
>> --- a/hw/ide/core.c
>> +++ b/hw/ide/core.c
>> @@ -402,7 +402,6 @@ typedef struct TrimAIOCB {
>>       QEMUIOVector *qiov;
>>       BlockAIOCB *aiocb;
>>       int i, j;
>> -    bool is_invalid;
>>   } TrimAIOCB;
>>   static void trim_aio_cancel(BlockAIOCB *acb)
>> @@ -430,11 +429,8 @@ static void ide_trim_bh_cb(void *opaque)
>>   {
>>       TrimAIOCB *iocb = opaque;
>> -    if (iocb->is_invalid) {
>> -        ide_dma_error(iocb->s);
>> -    } else {
>> -        iocb->common.cb(iocb->common.opaque, iocb->ret);
>> -    }
>> +    iocb->common.cb(iocb->common.opaque, iocb->ret);
>> +
>>       qemu_bh_delete(iocb->bh);
>>       iocb->bh = NULL;
>>       qemu_aio_unref(iocb);
>> @@ -462,7 +458,7 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>>                   }
>>                   if (!ide_sect_range_ok(s, sector, count)) {
>> -                    iocb->is_invalid = true;
>> +                    iocb->ret = -EINVAL;
>>                       goto done;
>>                   }
>> @@ -502,7 +498,6 @@ BlockAIOCB *ide_issue_trim(
>>       iocb->qiov = qiov;
>>       iocb->i = -1;
>>       iocb->j = 0;
>> -    iocb->is_invalid = false;
>>       ide_issue_trim_cb(iocb, 0);
>>       return &iocb->common;
>>   }
>> @@ -848,6 +843,12 @@ static void ide_dma_cb(void *opaque, int ret)
>>       if (ret == -ECANCELED) {
>>           return;
>>       }
>> +
>> +    if (ret == -EINVAL) {
>> +        ide_dma_error(s);
>> +        return;
>> +    }
>> +
>>       if (ret < 0) {
>>           if (ide_handle_rw_error(s, -ret, 
>> ide_dma_cmd_to_retry(s->dma_cmd))) {
>>               s->bus->dma->aiocb = NULL;
>>
> 
> Hi Anton,
> 
> Thanks for this. I applied this patch to git master with my macio patch 
> at https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06076.html 
> and it allowed to continue all the way through the Debian installer for 
> the PPC g3beige machine so I believe it is working.
> 
> Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Hi John,

I know that you're busy, but just wondering if you have managed to 
review these 2 TRIM patches? They are a candidate for 2.12 since they 
prevent a qemu-system-ppc segfault on Mac machines when issuing IDE TRIM 
commands.


ATB,

Mark.
