Received: from eggs.gnu.org ([2001:4830:134:3::10]:55925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dcQPj-0008CX-1q
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:12:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dcQPe-0007sy-1b
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:12:19 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:31720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dcQPd-0007sm-Os
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 02:12:13 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OTZ00MWOT89U200@mailout1.w1.samsung.com> for
	qemu-devel@nongnu.org; Tue, 01 Aug 2017 07:12:09 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <14d99c86-d096-2244-5ddd-d7d086cf4985@samsung.com>
Date: Tue, 01 Aug 2017 09:12:06 +0300
MIME-version: 1.0
In-reply-to: <20170801060248.GG15697@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-2-git-send-email-peterx@redhat.com>
	<20170731163414.GB2122@work-vm>
	<CGME20170801021152epcas1p28d9b21ba2ddcddd0c1f3d6f9df4b04f1@epcas1p2.samsung.com>
	<20170801021137.GA15697@pxdev.xzpeter.org>
	<11b966a9-529f-eb17-d40d-e32be54bfd87@samsung.com>
	<20170801060248.GG15697@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 01/29] migration: fix incorrect postcopy
 recved_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On 08/01/2017 09:02 AM, Peter Xu wrote:
> On Tue, Aug 01, 2017 at 08:48:18AM +0300, Alexey Perevalov wrote:
>> On 08/01/2017 05:11 AM, Peter Xu wrote:
>>> On Mon, Jul 31, 2017 at 05:34:14PM +0100, Dr. David Alan Gilbert wrote:
>>>> * Peter Xu (peterx@redhat.com) wrote:
>>>>> The bitmap setup during postcopy is incorrectly when the pgaes are huge
>>>>> pages. Fix it.
>>>>>
>>>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>>>> ---
>>>>>   migration/postcopy-ram.c | 2 +-
>>>>>   migration/ram.c          | 8 ++++++++
>>>>>   migration/ram.h          | 2 ++
>>>>>   3 files changed, 11 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>>>> index 276ce12..952b73a 100644
>>>>> --- a/migration/postcopy-ram.c
>>>>> +++ b/migration/postcopy-ram.c
>>>>> @@ -578,7 +578,7 @@ static int qemu_ufd_copy_ioctl(int userfault_fd, void *host_addr,
>>>>>           ret = ioctl(userfault_fd, UFFDIO_ZEROPAGE, &zero_struct);
>>>>>       }
>>>>>       if (!ret) {
>>>>> -        ramblock_recv_bitmap_set(host_addr, rb);
>>>>> +        ramblock_recv_bitmap_set_range(rb, host_addr, pagesize / getpagesize());
>>>> isn't that   pagesize / qemu_target_page_size() ?
>>>>
>>>> Other than that it looks OK.
>>> Yes, I should have fixed this before.
>>>
>>> I guess Alexey will handle this change (along with the copied bitmap
>>> series)?  Anyway, I'll fix it as well in my series, until Alexey post
>>> the new version that I can rebase to.  Thanks,
>>>
>> I'll squash it, and I'll resend it today.
>> Are you agree to add
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>
>> to my patch?
> Firstly, if you are squashing the patch, fixing the issue that Dave
> has pointed out, please feel free to add my R-b on the patch.
Of course I'll take into account David's suggestion.
>
> I don't know whether it would be suitable to add my S-o-b here - since
> most of the patch content is written by you, not me. But I'm totally
> fine if you want to include that (btw, thanks for the offer :).
>
> So either one R-b or S-o-b is okay to me.  Thanks,
>

-- 
Best regards,
Alexey Perevalov
