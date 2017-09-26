Received: from eggs.gnu.org ([2001:4830:134:3::10]:33502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwvXn-0001IO-Ul
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dwvXm-0004Oj-V6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 15:29:23 -0400
References: <20170913160333.23622-1-eblake@redhat.com>
	<20170913160333.23622-4-eblake@redhat.com>
	<c8c520f0-7bd2-db54-bb07-3d1ee0cf87df@redhat.com>
	<87c590cd-e35e-81a7-c1ea-0efccdeed6ab@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <b17bdc57-6203-cb15-c84d-2beda28f6b57@redhat.com>
Date: Tue, 26 Sep 2017 15:29:11 -0400
MIME-Version: 1.0
In-Reply-To: <87c590cd-e35e-81a7-c1ea-0efccdeed6ab@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 03/23] block: Make
 bdrv_round_to_clusters() signature more useful
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>



On 09/26/2017 03:18 PM, Eric Blake wrote:
> On 09/26/2017 01:51 PM, John Snow wrote:
>>
>>
>> On 09/13/2017 12:03 PM, Eric Blake wrote:
>>> In the process of converting sector-based interfaces to bytes,
>>> I'm finding it easier to represent a byte count as a 64-bit
>>> integer at the block layer (even if we are internally capped
>>> by SIZE_MAX or even INT_MAX for individual transactions, it's
>>> still nicer to not have to worry about truncation/overflow
>>> issues on as many variables).  Update the signature of
>>> bdrv_round_to_clusters() to uniformly use int64_t, matching
>>> the signature already chosen for bdrv_is_allocated and the
>>> fact that off_t is also a signed type, then adjust clients
>>> according to the required fallout.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> Reviewed-by: Fam Zheng <famz@redhat.com>
>>>
> 
>>> @@ -946,7 +946,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>>>      struct iovec iov;
>>>      QEMUIOVector bounce_qiov;
>>>      int64_t cluster_offset;
>>> -    unsigned int cluster_bytes;
>>> +    int64_t cluster_bytes;
>>>      size_t skip_bytes;
>>>      int ret;
>>>
>>> @@ -967,6 +967,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
>>>      trace_bdrv_co_do_copy_on_readv(bs, offset, bytes,
>>>                                     cluster_offset, cluster_bytes);
>>>
>>> +    assert(cluster_bytes < SIZE_MAX);
>>
>> later in this function, is there any real or imagined risk of
>> cluster_bytes exceeding INT_MAX when it's passed to
>> bdrv_co_do_pwrite_zeroes?
>>
>>>      iov.iov_len = cluster_bytes;
> 
> cluster_bytes is the input 'unsigned int bytes' rounded out to cluster

Ah, yes, we're probably not going to exceed that, you're right.

> boundaries, but where we know 'bytes <= BDRV_REQUEST_MAX_BYTES' (which
> is 2^31 - 511).  Still, I guess you are right that rounding to a cluster
> size could produce a larger value of exactly 2^31 (bigger than INT_MAX,
> but still fits in 32-bit unsigned int, so my assert was to make sure
> that truncating 64 bits to size_t iov.iov_len still works on 32-bit
> platforms).
> 
> In theory, I don't think we ever attempt an unaligned operation near
> 2^31 that would round up to INT_MAX overflow (if we can, that's a
> pre-existing bug that should be fixed separately).
> 
> Should I tighten the assertion to assert(cluster_bytes <=
> BDRV_REQUEST_MAX_BYTES), then see if I can come up with a case where we
> can violate that?
> 

*Only* if you think it's worth your time. You'd know better than me at
this point if this is remotely possible or not. Just a simple width
check that caught my eye.

(Gotta prove to everyone I'm reading these, right? :p)

>> Everything else looks obviously correct to me.
>>
> 
