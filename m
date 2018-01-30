Received: from eggs.gnu.org ([2001:4830:134:3::10]:55757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egbG8-0005fx-2j
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:08:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1egbF5-0000Mt-JK
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 14:07:55 -0500
References: <1516633309-20803-1-git-send-email-mark.kanda@oracle.com>
	<20180124113123.GB17193@stefanha-x1.localdomain>
	<20180129154107.GI6141@localhost.localdomain>
	<20180130123823.GE15551@stefanha-x1.localdomain>
	<20180130155612.GA4503@localhost.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <00e31136-b4d2-d790-4637-edbbe32894eb@redhat.com>
Date: Tue, 30 Jan 2018 14:04:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180130155612.GA4503@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252
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
Cc: Mark Kanda <mark.kanda@oracle.com>, qemu-block@nongnu.org, ameya.more@oracle.com, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, pbonzini@redhat.com



On 01/30/2018 10:56 AM, Kevin Wolf wrote:
> Am 30.01.2018 um 13:38 hat Stefan Hajnoczi geschrieben:
>> On Mon, Jan 29, 2018 at 04:41:07PM +0100, Kevin Wolf wrote:
>>> Am 24.01.2018 um 12:31 hat Stefan Hajnoczi geschrieben:
>>>> On Mon, Jan 22, 2018 at 09:01:49AM -0600, Mark Kanda wrote:
>>>>> Add a BlockDriverState NULL check to virtio_blk_handle_request()
>>>>> to prevent a segfault if the drive is forcibly removed using HMP
>>>>> 'drive_del' (without performing a hotplug 'device_del' first).
>>>>>
>>>>> Signed-off-by: Mark Kanda <mark.kanda@oracle.com>
>>>>> Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
>>>>> Reviewed-by: Ameya More <ameya.more@oracle.com>
>>>>> ---
>>>>>  hw/block/virtio-blk.c | 7 +++++++
>>>>>  1 file changed, 7 insertions(+)
>>>>>
>>>>> diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
>>>>> index b1532e4..76ddbbf 100644
>>>>> --- a/hw/block/virtio-blk.c
>>>>> +++ b/hw/block/virtio-blk.c
>>>>> @@ -507,6 +507,13 @@ static int virtio_blk_handle_request(VirtIOBlockReq *req, MultiReqBuffer *mrb)
>>>>>          return -1;
>>>>>      }
>>>>>  
>>>>> +    /* If the drive was forcibly removed (e.g. HMP 'drive_del'), the block
>>>>> +     * driver state may be NULL and there is nothing left to do. */
>>>>> +    if (!blk_bs(req->dev->blk)) {
>>>>
>>>> Adding Markus Armbruster to check my understanding of drive_del:
>>>>
>>>> 1. If id is a node name (e.g. created via blockdev-add) then attempting
>>>>    to remove the root node produces the "Node %s is in use" error.  In
>>>>    that case this patch isn't needed.
>>>>
>>>> 2. If id is a BlockBackend (e.g. created via -drive) then removing the
>>>>    root node is allowed.  The BlockBackend stays in place but blk->root
>>>>    becomes NULL, hence this patch is needed.
>>>>
>>>> Markus: What are the valid use cases for #2?  If blk->bs becomes NULL I
>>>> would think a lot more code beyond virtio-blk can segfault.
>>>
>>> blk->root = NULL is completely normal, it is what happens with removable
>>> media when the drive is empty.
>>>
>>> The problem, which was first reported during the 2.10 RC phase and was
>>> worked around in IDE code then, is that Paolo's commit 99723548561 added
>>> unconditional bdrv_inc/dec_in_flight() calls. I am pretty sure that any
>>> segfaults that Mark is seeing have the same cause.
>>>
>>> We do need an in-flight counter even for those requests so that
>>> blk_drain() works correctly, so just making the calls condition wouldn't
>>> be right. However, this needs to become a separate counter in
>>> BlockBackend, and the drain functions must be changed to make use of it.
>>>
>>> I did post rough patches back then, but they weren't quite ready, and
>>> since then they have fallen through the cracks.
>>
>> Will you send a new version of that patch series?
> 
> I would like to continue my work on the drain functions (which this
> would be a part of) sooner or later, but the work to enable libvirt to
> use blockdev-add is at a higher priority at the moment.
> 
> So if you can wait, I'll get to it eventually. If not, feel free to pick
> up the patches.
> 
> Kevin
> 

It'd probably be nice for 2.12.

I'm not sure I understand the throttling well enough to do it /quickly/
and I have other priorities right now, but let's try to keep this one in
mind as something to fix before another release goes by.

--js
