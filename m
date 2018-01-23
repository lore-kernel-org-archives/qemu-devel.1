Received: from eggs.gnu.org ([2001:4830:134:3::10]:38560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1edvz9-0008Bt-M9
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1edvz8-0002K4-Pi
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:39:23 -0500
References: <1516366207-109842-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516366207-109842-4-git-send-email-anton.nefedov@virtuozzo.com>
	<45080fc9-c869-a8c8-0f20-ca9d950fb2cc@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <7155aa65-468a-c339-0c54-6eaf4d3a0ef0@virtuozzo.com>
Date: Tue, 23 Jan 2018 13:39:08 +0300
MIME-Version: 1.0
In-Reply-To: <45080fc9-c869-a8c8-0f20-ca9d950fb2cc@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 3/8] ide: account UNMAP (TRIM) operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, den@virtuozzo.com



On 22/1/2018 11:48 PM, Eric Blake wrote:
> On 01/19/2018 06:50 AM, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   hw/ide/core.c | 13 +++++++++++++
>>   1 file changed, 13 insertions(+)
>>
> 
>> @@ -460,10 +468,15 @@ static void ide_issue_trim_cb(void *opaque, int ret)
>>                   }
>>   
>>                   if (!ide_sect_range_ok(s, sector, count)) {
>> +                    block_acct_invalid(blk_get_stats(s->blk),
>> +                                       BLOCK_ACCT_UNMAP);
>>                       iocb->is_invalid = true;
>>                       goto done;
>>                   }
>>   
>> +                block_acct_start(blk_get_stats(s->blk), &s->acct,
>> +                                 count << BDRV_SECTOR_BITS, BLOCK_ACCT_UNMAP);
> 
> We're still mixing bytes- and block-based reporting; how easy or hard
> would it be to flip block_acct_start() and friends to be byte-based?

Quite easy, they already are :)
