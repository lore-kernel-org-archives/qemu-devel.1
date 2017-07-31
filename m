Received: from eggs.gnu.org ([2001:4830:134:3::10]:52836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcCe9-0006Fn-2j
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dcCe7-0005Iz-SS
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 11:30:17 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170731125111.28052-1-kwolf@redhat.com>
	<20170731143809.GC22129@localhost.localdomain>
	<5e788182-b778-e027-2250-8e7c643786ae@amsat.org>
	<20170731151724.GH6240@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a5fc2f57-87da-ec06-ee4f-3f6919235c83@amsat.org>
Date: Mon, 31 Jul 2017 12:30:04 -0300
MIME-Version: 1.0
In-Reply-To: <20170731151724.GH6240@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.10] block/qapi: Remove redundat NULL
 check to silence Coverity
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-block@nongnu.org

On 07/31/2017 12:17 PM, Jeff Cody wrote:
> On Mon, Jul 31, 2017 at 11:54:57AM -0300, Philippe Mathieu-Daudé wrote:
>> On 07/31/2017 11:38 AM, Jeff Cody wrote:
>>> On Mon, Jul 31, 2017 at 02:51:11PM +0200, Kevin Wolf wrote:
>>>> When skipping implicit nodes in bdrv_block_device_info(), we know that
>>>> bs0 is always non-NULL; initially, because it's taken from a BdrvChild
>>>
>>> Not to mention, we deference bs0 in the chunk of code right above this, so
>>> we'd segfault anyway if the initial value was NULL.
>>
>> Yes, please move your assert before:
>>
>> 137:    if (bs0->drv && bs0->backing) {
>>
>> Once there:
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>
> 
> I don't think moving the assert() is the correct thing to do, as it is
> useful when iterating in the while() via backing_bs().
> 
> But maybe adding some asserts would be useful, if we are really concerned.
> Looking at the code:
> 
> 135         }
> 136
> 
> Maybe add an assert(bs0) here, as you suggest...
> 
> 137         if (bs0->drv && bs0->backing) {
> 138             info->backing_file_depth++;
> 139             bs0 = bs0->backing->bs;
> 
> But then maybe we want one here, too?  Or maybe that is overkill :)
> 
> 140             (*p_image_info)->has_backing_image = true;
> 141             p_image_info = &((*p_image_info)->backing_image);
> 142         } else {
> 143             break;
> 144         }
> 145
> 146         /* Skip automatically inserted nodes that the user isn't aware of for
> 147          * query-block (blk != NULL), but not for query-named-block-nodes */
> 148         while (blk && bs0 && bs0->drv && bs0->implicit) {
> 149             bs0 = backing_bs(bs0);
> 150         }

I first thought of inverting the if():

         if (!(bs0->drv && bs0->backing)) {
             break;
         }
         info->backing_file_depth++;
         bs0 = bs0->backing->bs;
         assert(bs0);
         (*p_image_info)->has_backing_image = true;
         p_image_info = &((*p_image_info)->backing_image);

then read your mail and Kevin's one and realized if 3 ppl disagree 
commenting the same piece of code that fast, it means this code is not 
simple enough and surely need refactoring. Now it is not just about 
silencing Coverity :)

>>>
>>>> and a BdrvChild never has a NULL bs, and after the first iteration
>>>> because implicit nodes always have a backing file.
>>>>
>>>> Remove the NULL check and add an assertion that the implicit node does
>>>> indeed have a backing file.
>>>>
>>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>>
>>>
>>> Reviewed-by: Jeff Cody <jcody@redhat.com>
>>>
>>>
>>>
>>>> ---
>>>>   block/qapi.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/block/qapi.c b/block/qapi.c
>>>> index d2b18ee9df..5f1a71f5d2 100644
>>>> --- a/block/qapi.c
>>>> +++ b/block/qapi.c
>>>> @@ -145,8 +145,9 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>>>>           /* Skip automatically inserted nodes that the user isn't aware of for
>>>>            * query-block (blk != NULL), but not for query-named-block-nodes */
>>>> -        while (blk && bs0 && bs0->drv && bs0->implicit) {
>>>> +        while (blk && bs0->drv && bs0->implicit) {
>>>>               bs0 = backing_bs(bs0);
>>>> +            assert(bs0);
>>>>           }
>>>>       }
>>>> -- 
>>>> 2.13.3
>>>>
>>>>
>>>
