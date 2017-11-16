Received: from eggs.gnu.org ([2001:4830:134:3::10]:44255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFH9G-00010k-3B
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:11:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1eFH9E-0007s3-So
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 05:11:54 -0500
References: <1510654613-47868-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1510654613-47868-5-git-send-email-anton.nefedov@virtuozzo.com>
	<b9d9b3f9-480c-6e59-0e8a-1fd4f5e84b6a@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <aa7e78db-1604-547e-d11f-3c033de4feab@virtuozzo.com>
Date: Thu, 16 Nov 2017 13:11:37 +0300
MIME-Version: 1.0
In-Reply-To: <b9d9b3f9-480c-6e59-0e8a-1fd4f5e84b6a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] block-stream: add compress option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, stefanha@redhat.com, famz@redhat.com, den@virtuozzo.com, jcody@redhat.com, armbru@redhat.com, dgilbert@redhat.com



On 15/11/2017 10:16 PM, Max Reitz wrote:
> On 2017-11-14 11:16, Anton Nefedov wrote:
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   qapi/block-core.json      |  4 ++++
>>   include/block/block_int.h |  4 +++-
>>   block/stream.c            | 16 ++++++++++++----
>>   blockdev.c                | 13 ++++++++++++-
>>   hmp.c                     |  2 ++
>>   hmp-commands.hx           |  4 ++--
>>   6 files changed, 35 insertions(+), 8 deletions(-)
> 
> Looks good to me overall, two notes below.
> 
> Max
> 
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index ab96e34..b0d022f 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2007,6 +2007,9 @@
>>   #
>>   # @speed:  the maximum speed, in bytes per second
>>   #
>> +# @compress: true to compress data, if the target format supports it.
>> +#            (default: false). Since 2.12.
>> +#
> 
> Too many full stops (one before, one after the parentheses).  Also, this
> makes it sound a bit like it would still be possible to specify this
> parameter even if the target doesn't support it (and it would just be
> ignored then), but that's not true.
> 
> Also, the format most parameter documentation follows for block-stream
> is more "@parameter: Description. Default. (Since version)".
> 
> So I'd suggest:
> 
> "true to compress data; may only be set if the target format supports
> it.  Defaults to false if omitted.  (Since 2.12)"
> 
> But I won't argue too much over the format, so the following is OK, too:
> 
> "true to compress data; may only be set if the target format supports it
> (default: false). (Since 2.12)"
> 

Thanks, will fix.

[..]

>> @@ -3034,11 +3039,17 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
>>           goto out;
>>       }
>>   
>> +    if (compress && bs->drv->bdrv_co_pwritev_compressed == NULL) {
>> +        error_setg(errp, "Compression is not supported for this drive %s",
>> +                   bdrv_get_device_name(bs));
> 
> I think just device instead of bdrv_get_device_name(bs) is better (or
> bdrv_get_device_or_node_name(bs) at least).
> 

device should be enough indeed, done.

/Anton
