Received: from eggs.gnu.org ([2001:4830:134:3::10]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mike.kravetz@oracle.com>) id 1fpiZd-0001JI-6l
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mike.kravetz@oracle.com>) id 1fpiYv-00021t-Bt
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:17:20 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:50902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mike.kravetz@oracle.com>)
	id 1fpiYj-0001rs-5n
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 19:17:10 -0400
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
	<20180629115359.GH2568@work-vm> <20180725101836.GI2479@xz-mi>
	<20180725191736.GE2365@work-vm> <20180725200456.GM18452@redhat.com>
	<e1c85e53-1b94-b1df-b7ee-6d93bb43caf6@redhat.com>
	<20180726092307.GL2479@xz-mi>
	<d1370a77-3d67-9c83-8214-3cba291744a1@virtuozzo.com>
	<20180813190019.GH2488@work-vm>
From: Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <52144105-420c-4b35-4cb0-cf6a2ff5cd88@oracle.com>
Date: Tue, 14 Aug 2018 16:16:33 -0700
MIME-Version: 1.0
In-Reply-To: <20180813190019.GH2488@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v0 0/7] Background snapshots
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, rppt@linux.vnet.ibm.com

On 08/13/2018 12:00 PM, Dr. David Alan Gilbert wrote:
> cc'ing in Mike*2
> * Denis Plotnikov (dplotnikov@virtuozzo.com) wrote:
>>
>>
>> On 26.07.2018 12:23, Peter Xu wrote:
>>> On Thu, Jul 26, 2018 at 10:51:33AM +0200, Paolo Bonzini wrote:
>>>> On 25/07/2018 22:04, Andrea Arcangeli wrote:
>>>>>
>>>>> It may look like the uffd-wp model is wish-feature similar to an
>>>>> optimization, but without the uffd-wp model when the WP fault is
>>>>> triggered by kernel code, the sigsegv model falls apart and requires
>>>>> all kind of ad-hoc changes just for this single feature. Plus uffd-wp
>>>>> has other benefits: it makes it all reliable in terms of not
>>>>> increasing the number of vmas in use during the snapshot. Finally it
>>>>> makes it faster too with no mmap_sem for reading and no sigsegv
>>>>> signals.
>>>>>
>>>>> The non cooperative features got merged first because there was much
>>>>> activity on the kernel side on that front, but this is just an ideal
>>>>> time to nail down the remaining issues in uffd-wp I think. That I
>>>>> believe is time better spent than trying to emulate it with sigsegv
>>>>> and changing all drivers to send new events down to qemu specific to
>>>>> the sigsegv handling. We considered this before doing uffd for
>>>>> postcopy too but overall it's unreliable and more work (no single
>>>>> change was then needed to KVM code with uffd to handle postcopy and
>>>>> here it should be the same).
>>>>
>>>> I totally agree.  The hard part in userfaultfd was the changes to the
>>>> kernel get_user_pages API, but the payback was huge because _all_ kernel
>>>> uses (KVM, vhost-net, syscalls, etc.) just work with userfaultfd.  Going
>>>> back to mprotect would be a huge mistake.
>>>
>>> Thanks for explaining the bits.  I'd say I wasn't aware of the
>>> difference before I started the investigation (and only until now I
>>> noticed that major difference between mprotect and userfaultfd).  I'm
>>> really glad that it's much clear (at least for me) on which way we
>>> should choose.
>>>
>>> Now I'm thinking whether we can move the userfault write protect work
>>> forward.  The latest discussion I saw so far is in 2016, when someone
>>> from Huawei tried to use the write protect feature for that old
>>> version of live snapshot but reported issue:
>>>
>>>    https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01127.html
>>>
>>> Is that the latest status for userfaultfd wr-protect?
>>>
>>> If so, I'm thinking whether I can try to re-verify the work (I tried
>>> his QEMU repository but I failed to compile somehow, so I plan to
>>> write some even simpler code to try) to see whether I can get the same
>>> KVM error he encountered.
>>>
>>> Thoughts?
>>
>> Just to sum up all being said before.
>>
>> Using mprotect is a bad idea because VM's memory can be accessed from the
>> number of places (KVM, vhost, ...) which need their own special care
>> of tracking memory accesses and notifying QEMU which makes the mprotect
>> using unacceptable.
>>
>> Protected memory accesses tracking can be done via userfaultfd's WP mode
>> which isn't available right now.
>>
>> So, the reasonable conclusion is to wait until the WP mode is available and
>> build the background snapshot on top of userfaultfd-wp.
>> But, works on adding the WP-mode is pending for a quite a long time already.
>>
>> Is there any way to estimate when it could be available?
> 
> I think a question is whether anyone is actively working on it; I
> suspect really it's on a TODO list rather than moving at the moment.
> 

I am not working on it, and it is not on my TODO list.

However, if someone starts making progress I will jump in and work on
hugetlbfs support.  My intention would be to not let hugetlbfs support
'fall behind' general uffd support.

-- 
Mike Kravetz
