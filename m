Received: from eggs.gnu.org ([2001:4830:134:3::10]:57201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dG6v6-0008Lg-P0
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1dG6v2-00049p-T7
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:56:28 -0400
Received: from mail-he1eur01on0104.outbound.protection.outlook.com
	([104.47.0.104]:53098
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
	id 1dG6v2-00048u-3C
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:56:24 -0400
References: <1495186480-114192-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1495186480-114192-6-git-send-email-anton.nefedov@virtuozzo.com>
	<20170526081142.GB7211@noname.str.redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <bc6d0fdf-aded-cff4-465a-cb22bd934197@virtuozzo.com>
Date: Wed, 31 May 2017 19:56:10 +0300
MIME-Version: 1.0
In-Reply-To: <20170526081142.GB7211@noname.str.redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/13] qcow2: set inactive flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, den@virtuozzo.com, mreitz@redhat.com

On 05/26/2017 11:11 AM, Kevin Wolf wrote:
> Am 19.05.2017 um 11:34 hat Anton Nefedov geschrieben:
>> Qcow2State and BlockDriverState flags have to be in sync
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> ---
>>   block/qcow2.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/block/qcow2.c b/block/qcow2.c
>> index 6e7ce96..07c1706 100644
>> --- a/block/qcow2.c
>> +++ b/block/qcow2.c
>> @@ -1939,6 +1939,7 @@ static int qcow2_inactivate(BlockDriverState *bs)
>>   
>>       if (result == 0) {
>>           qcow2_mark_clean(bs);
>> +        s->flags |= BDRV_O_INACTIVE;
>>       }
> 
> Good catch.
> 
> But can't we simply use bs->open_flags and completely get rid of
> s->flags?
> 
> Kevin
> 

the problem is that qcow2_close() or qcow2_inactivate() have to
consider the flags that the image was opened with,
but bs->open_flags (at least in invalidate_cache() case) at that point
contain the new flags already

/Anton
