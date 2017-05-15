Received: from eggs.gnu.org ([2001:4830:134:3::10]:51499)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dAGZl-0002je-2j
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:02:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dAGZg-0001jK-1b
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:02:17 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:56856 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dAGZf-0001hy-OV
	for qemu-devel@nongnu.org; Mon, 15 May 2017 10:02:11 -0400
References: <1494842563-6534-1-git-send-email-pl@kamp.de>
	<20170515105032.GD23262@lemon.lan>
	<26b2441d-e80c-eeef-fba1-67b2529e9287@kamp.de>
	<20170515115318.GA7305@lemon.lan>
	<243331f2-3822-3c0e-b4a5-9f3de2302fe4@kamp.de>
	<20170515122802.GB7305@lemon.lan>
	<b850c6d3-c104-b171-0e7d-40ebf6780d6e@kamp.de>
	<20170515125202.GC7305@lemon.lan>
	<0e904501-91c6-7186-f5e6-8c2b60bda8cf@kamp.de>
	<20170515133515.GD7305@lemon.lan>
From: Peter Lieven <pl@kamp.de>
Message-ID: <498e1918-4e53-02b9-1528-5220d3b9cca8@kamp.de>
Date: Mon, 15 May 2017 16:02:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170515133515.GD7305@lemon.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] qemu-io: add drain/undrain cmd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, jsnow@redhat.com

Am 15.05.2017 um 15:35 schrieb Fam Zheng:
> On Mon, 05/15 15:01, Peter Lieven wrote:
>> Am 15.05.2017 um 14:52 schrieb Fam Zheng:
>>> On Mon, 05/15 14:32, Peter Lieven wrote:
>>>> Am 15.05.2017 um 14:28 schrieb Fam Zheng:
>>>>> On Mon, 05/15 13:58, Peter Lieven wrote:
>>>>>> Am 15.05.2017 um 13:53 schrieb Fam Zheng:
>>>>>>> On Mon, 05/15 13:26, Peter Lieven wrote:
>>>>>>>> Am 15.05.2017 um 12:50 schrieb Fam Zheng:
>>>>>>>>> On Mon, 05/15 12:02, Peter Lieven wrote:
>>>>>>>>>> Hi Block developers,
>>>>>>>>>>
>>>>>>>>>> I would like to add a feature to Qemu to drain all traffic from a block so that
>>>>>>>>>> I can take external snaphosts without the risk to that in the middle of a write
>>>>>>>>>> operation. Its meant for cases where where QGA freeze/thaw is not available.
>>>>>>>>>>
>>>>>>>>>> For me its enough to have this through qemu-io, but Kevin asked me to check
>>>>>>>>>> if its not worth to have a stable API for it and present it via QMP/HMP.
>>>>>>>>>>
>>>>>>>>>> What are your thoughts?
>>>>>>>>> For debugging purpose or a "hacky" usage where you know what you are doing, it
>>>>>>>>> may be fine to have this. The only issue is it should be a separate flag, like
>>>>>>>>> BlockJob.user_paused.
>>>>>>>> How can I add, remove such a flag?
>>>>>>> Like bs->user_drained. Set it in "drain" command, then increment
>>>>>>> bs->quiesce_counter if toggled; vise versa.
>>>>>> Ah okay. You wouldn't use bdrv_drained_begin/end? Because in these functions
>>>>>> the counter is incremented already.
>>>>> You're right, calling bdrv_drained_begin() is better.
>>>>>
>>>>>>>>> What happens from guest perspective? In the case of virtio, the request queue is
>>>>>>>>> not handled and -ETIMEDOUT may happen. With IDE, I/O commands are still handled,
>>>>>>>>> the command is not effective (or rather the implementation is not complete).
>>>>>>>> That it only works with virtio is fine. However, the thing it does not work correctly
>>>>>>>> apply then also to all other users of the drained_begin/end functions, right?
>>>>>>>> As for the timeout I only plan to drain the device for about 1 second.
>>>>>>> It didn't matter because for IDE, the invariant (staying quiesced as long as
>>>>>>> necessary) is already ensured by BQL.  Virtio is different because it supports
>>>>>>> ioeventfd and data plane.
>>>>>> Okay understood. So my use of bdrv_drained_begin/end is more an abuse of
>>>>>> these functions?
>>>>> Sort of. But it's not unreasonable to "extend" bdrv_drained_begin/end to cover
>>>>> IDE, I just haven't thought about "how".
>>>>>
>>>>>> Do you have another idea how to achieve what I want? I was thinking of throttle
>>>>>> the I/O to zero. It would be enough to do this for writes, reading doesn't hurt in
>>>>>> my case.
>>>>> Maybe add a block filter on top of the drained node, drain it when doing so,
>>>>> then queue all further requests with a CoQueue until "undrain".  (It is then not
>>>>> quite to "drain" but to "halt" or "pause", though.)
>>>> To get the drain for free was why I was looking at this approach. If I read correctly
>>>> if I keep using bdrv_drained_begin/end its too hacky to implement it in QMP?
>>> I think so.
>>>
>>>> If yes, would support adding it to qemu-io?
>>> I'm under the impression that you are looking to a real use case, I don't think
>>> I like the idea. Also, accessing the image from other processes while QEMU is
>>> using it is strongly discouraged, and there is the coming image locking
>>> mechanism to prevent this from happening. Why is the blockdev-snapshot command
>>> not enough?
>> blockdev-snapshot is enough, but I still fear the case there is suddenly too much I/O
>> for the live-commit. And that the whole snapshot / commit code is more senstive than
>> just stopping I/O for a second or two.
> In this case, the image fleecing approach may be what you need. It creates a
> temporary point in time snapshot which is lightweight and disposable. Something
> like:
>
> https://lists.gnu.org/archive/html/qemu-devel/2014-03/msg01359.html
>
> (Ccing John who may have more up-to-date pointers)

We discussed about it a few months ago. But maybe he has an update.

>
>> do you have a pointer to the image locking mechanism?
> It hit qemu.git master just a moment ago. See raw_check_perm.

which master are you looking at?

$ git fetch upstream
$ git log upstream/master --oneline
3a87606 Merge tag 'tracing-pull-request' into staging
b54933e Merge tag 'block-pull-request' into staging
3753e25 Merge remote-tracking branch 'kwolf/tags/for-upstream' into staging
5651743 trace: add sanity check
321d1db aio: add missing aio_notify() to aio_enable_external()
ee29d6a block: Simplify BDRV_BLOCK_RAW recursion
33c53c5 coroutine: remove GThread implementation
ecc1f5a maintainers: Add myself as linux-user reviewer
d541e20 Merge remote-tracking branch 'mreitz/tags/pull-block-2017-05-11' into queue-block
8dd30c8 MAINTAINERS: Add qemu-progress to the block layer
d2cb36a qcow2: Discard/zero clusters by byte count
f10ee13 qcow2: Assert that cluster operations are aligned
fbaa6bb qcow2: Optimize write zero of unaligned tail cluster
e249d51 iotests: Add test 179 to cover write zeroes with unmap
d9ca221 iotests: Improve _filter_qemu_img_map
06cc5e2 qcow2: Optimize zero_single_l2() to minimize L2 churn
fdfab37 qcow2: Make distinction between zero cluster types obvious
3ef9521 qcow2: Name typedef for cluster type
4341df8 qcow2: Correctly report status of preallocated zero clusters
4c41cb4 block: Update comments on BDRV_BLOCK_* meanings

Thanks,
Peter
