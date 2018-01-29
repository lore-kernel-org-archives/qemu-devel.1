Received: from eggs.gnu.org ([2001:4830:134:3::10]:43564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1egC4d-0003AQ-4I
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.kanda@oracle.com>) id 1egC4c-0002gf-09
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 11:14:23 -0500
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
	<20180124113123.GB17193@stefanha-x1.localdomain>
	<20180129154107.GI6141@localhost.localdomain>
From: Mark Kanda <mark.kanda@oracle.com>
Message-ID: <302cdbe4-e363-b9ee-f40a-cafb080a7a2a@oracle.com>
Date: Mon, 29 Jan 2018 10:13:02 -0600
MIME-Version: 1.0
In-Reply-To: <20180129154107.GI6141@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] virtio-blk: check for NULL
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, ameya.more@oracle.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 1/29/2018 9:41 AM, Kevin Wolf wrote:
> Am 24.01.2018 um 12:31 hat Stefan Hajnoczi geschrieben:
>> On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
>>> Add a BlockDriverState NULL check to virtio_blk_handle_request()
>>> to prevent a segfault if the drive is forcibly removed using HMP
>>> 'drive_del' (without performing a hotplug 'device_del' first).
>>>
>>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>>> Reviewed-by: Ameya More <ameya.more@oracle.com>
>>> ---
>>>   hw/block/virtio-blk.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>> index b1532e4..76ddbbf 100644
>>> --- a/hw/block/virtio-blk.c
>>> +++ b/hw/block/virtio-blk.c
>>> @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>>>           return -1;
>>>       }
>>>   
>>> +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), the block
>>> +     * driver state may be NULL and there is nothing left to do. */
>>> +    if (!blk_bs(req->dev->blk)) {
>>
>> Adding Markus Armbruster to check my understanding of drive_del:
>>
>> 1. If id is a node name (e.g. created via blockdev-add) then attempting
>>     to remove the root node produces the "Node %s is in use" error.  In
>>     that case this patch isn't needed.
>>
>> 2. If id is a BlockBackend (e.g. created via -drive) then removing the
>>     root node is allowed.  The BlockBackend stays in place but blk->root
>>     becomes NULL, hence this patch is needed.
>>
>> Markus: What are the valid use cases for #2?  If blk->bs becomes NULL I
>> would think a lot more code beyond virtio-blk can segfault.
> 
> blk->root = NULL is completely normal, it is what happens with removable
> media when the drive is empty.
> 
> The problem, which was first reported during the 2.10 RC phase and was
> worked around in IDE code then, is that Paolo's commit 99723548561 added
> unconditional bdrv_inc/dec_in_flight() calls. I am pretty sure that any
> segfaults that Mark is seeing have the same cause.

That's correct. The segfault I encountered was the bdrv_inc_in_flight() 
call in blk_aio_prwv().

Thanks,

-Mark

> We do need an in-flight counter even for those requests so that
> blk_drain() works correctly, so just making the calls condition wouldn't
> be right. However, this needs to become a separate counter in
> BlockBackend, and the drain functions must be changed to make use of it.
> 
> I did post rough patches back then, but they weren't quite ready, and
> since then they have fallen through the cracks.
> 
> Kevin
> 
