Received: from eggs.gnu.org ([2001:4830:134:3::10]:48624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evNHE-0000MM-Si
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evNH8-0007nJ-VE
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 09:14:08 -0400
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
	<b570a199-9139-5652-5ad8-407820680620@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <540897fd-ceff-548e-ce96-11fc47ea4cd7@virtuozzo.com>
Date: Mon, 12 Mar 2018 16:13:49 +0300
MIME-Version: 1.0
In-Reply-To: <b570a199-9139-5652-5ad8-407820680620@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/9] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 23:40, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal realization: only one extent in server answer is supported.
>> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.
>>
>> Tests 140, 147 and 205 are fixed due to now server failed on searching
>> export in context of NBD_OPT_SET_META_CONTEXT option negotiation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>

[...]

> Instead of doing a memcpy() and then in-place bit-swizzling, you could 
> do the swapping as part of assignment, for one less function call (and 
> make the code a bit easier to extend, if we later drop our REQ_ONE 
> limitation on only having one extent, because you'll advance payload 
> as needed):
>
> extent->length = payload_advance32(&payload);
> extent->flags = payload_advance32(&payload);
>
> We should probably validate that the length field is a multiple of 
> min_block (if a server tells us that all operations must be 512-byte 
> aligned, then reports an extent that is smaller than 512 bytes, we 
> have no way to ask for the status of the second half of the sector). 
> Probably also something that needs to be explicitly stated in the NBD 
> spec. [1]

related question: what server should reply on zero-length request? I'll add

+     if (!bytes) {
+         *pnum = 0;
+         return 0;
+     }

to nbd_client_co_block_status, to prevent such situation, but looks like 
spec lacks the information.




-- 
Best regards,
Vladimir
