Received: from eggs.gnu.org ([2001:4830:134:3::10]:33253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egV9U-0000md-Vy
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:36:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1egV9U-0002EN-4F
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 07:36:41 -0500
References: <1516297747-107232-1-git-send-email-anton.nefedov@virtuozzo.com>
	<1516297747-107232-5-git-send-email-anton.nefedov@virtuozzo.com>
	<e6a78f65-3be4-9c14-401c-ea7f1fd5fb9c@redhat.com>
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Message-ID: <931c225d-7d0a-ea1e-59a9-d9f7a257274a@virtuozzo.com>
Date: Tue, 30 Jan 2018 15:36:26 +0300
MIME-Version: 1.0
In-Reply-To: <e6a78f65-3be4-9c14-401c-ea7f1fd5fb9c@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 4/9] block: treat BDRV_REQ_ALLOCATE as
 serialising
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, eblake@redhat.com, den@virtuozzo.com, berto@igalia.com



On 29/1/2018 10:48 PM, Max Reitz wrote:
> On 2018-01-18 18:49, Anton Nefedov wrote:
>> The idea is that ALLOCATE requests may overlap with other requests.
>> Reuse the existing block layer infrastructure for serialising requests.
>> Use the following approach:
>>    - mark ALLOCATE serialising, so subsequent requests to the area wait
>>    - ALLOCATE request itself must never wait if another request is in flight
>>      already. Return EAGAIN, let the caller reconsider.
>>
>> Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/io.c | 27 +++++++++++++++++++--------
>>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> The basic principle looks good to me.
> 
>> diff --git a/block/io.c b/block/io.c
>> index cf2f84c..4b0d34f 100644
>> --- a/block/io.c
>> +++ b/block/io.c
> 
> [...]
> 
>> @@ -1717,7 +1728,7 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
>>           struct iovec head_iov;
>>   
>>           mark_request_serialising(&req, align);
>> -        wait_serialising_requests(&req);
>> +        wait_serialising_requests(&req, false);
> 
> What if someone calls bdrv_co_pwritev() with BDRV_REQ_ZERO_WRITE |
> BDRV_REQ_ALLOCATE?  

Either

     assert(!(qiov && (flags & BDRV_REQ_ALLOCATE)));

will fail or bdrv_co_do_zero_pwritev() will be used.

> .. Then this should do exactly the same as
> bdrv_co_do_zero_pwritev(), which it currently does not -- besides this
> serialization, this includes returning -ENOTSUP if there is a head or
> tail to write.
> 

Another question is if that assertion is ok.
In other words: should (qiov!=NULL && REQ_ALLOCATE) be a valid case?
e.g. with qiov filled with zeroes?

I'd rather document that not supported (and leave the assertion).

Actually, even (qiov!=NULL && REQ_ZERO_WRITE) looks kind of
unsupported/broken? Alignment code in bdrv_co_pwritev() zeroes out the
head and tail by passing the flag down bdrv_aligned_pwritev()
