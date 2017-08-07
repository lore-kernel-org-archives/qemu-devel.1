Received: from eggs.gnu.org ([2001:4830:134:3::10]:48016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1deh0y-0006xj-74
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:20:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1deh0s-00023B-Vs
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:20:08 -0400
References: <1501597152-25342-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1501597152-25342-3-git-send-email-anton.nefedov@virtuozzo.com>
	<444f8ae2-dbf2-b4d5-a979-586142edae67@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <378dfffd-0ae8-8103-9c76-292a171d5670@virtuozzo.com>
Date: Mon, 7 Aug 2017 15:19:44 +0300
MIME-Version: 1.0
In-Reply-To: <444f8ae2-dbf2-b4d5-a979-586142edae67@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/15] blkverify: set supported
 write/zero flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, kwolf@redhat.com, mreitz@redhat.com

On 08/04/2017 06:23 PM, Eric Blake wrote:
> On 08/01/2017 09:18 AM, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/blkverify.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
> 
> Basically, blkverify supports a flag if BOTH of its underlying files
> also support the flag; if either side can't handle the flag, then we
> fall back to emulation for both sides.
> 
> With more overhead, we COULD state that we support both bits if at least
> one of the two underlying BDS supports the bit, and then emulate support
> for the bit on the second BDS where it was lacking, so that at least the
> first BDS doesn't suffer from the penalties of the fallbacks.  But that
> means duplicating the block layer fallback code in blkverify, which is
> already something that we don't necessarily expect high performance from.
> 
> For FUA, failure to implement the bit merely means that we have more
> device-wide flush calls (instead of per-transaction mini-flushes), but
> the end data should be the same.  But for MAY_UNMAP, I'm worried that we
> may have situations where a plain BDS will create holes, while running
> the same device paired through blkverify will fall back to slower
> explicit zeroes.  I'm wondering whether this will bite us, if we have
> scenarios where the mere fact of trying to verify block device behavior
> changes what behavior we are even verifying.
> 
> Thus, while I think the code change _looks_ okay, I'm not sure if it is
> correct design-wise, nor whether it is 2.10 material.
> 

But this change doesn't make things worse, does it?
Blkverify will support at least the matching bytes, while now it drops
them all.

Will the 'reference' driver (I guess it's raw/file in most of the cases)
usually support a superset of 'tested' driver supported bits?
Maybe we should report an error otherwise?


>> +    bs->supported_write_flags = BDRV_REQ_FUA &
>> +        bs->file->bs->supported_write_flags &
>> +        s->test_file->bs->supported_write_flags;
>> +
>> +    bs->supported_zero_flags =
>> +        (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
>> +        bs->file->bs->supported_zero_flags &
>> +        s->test_file->bs->supported_zero_flags;
>> +
>>       ret = 0;
>>   fail:
>>       qemu_opts_del(opts);
>>
> 
/Anton
