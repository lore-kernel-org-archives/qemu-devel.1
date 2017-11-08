Received: from eggs.gnu.org ([2001:4830:134:3::10]:46607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1eCRPp-0007hU-1y
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1eCRPj-0003SY-8s
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:33:17 -0500
References: <20171108063447.2842-1-slp@redhat.com>
	<f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
	<CAAiTLFV80SfMneuhs7tdYENOb+zV7kJ43B9ZgALk2tva1ZDpUw@mail.gmail.com>
	<5d4d9db6-f740-c114-9f21-d575eb2d897f@redhat.com>
	<CAAiTLFXHC5LS7NdmL6oO+QfiLh1fj+k8_74OnH6TFwzDx5EAgw@mail.gmail.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <baa6250c-cb3f-76cd-2562-f7e89f418be5@virtuozzo.com>
Date: Wed, 8 Nov 2017 17:32:23 +0300
MIME-Version: 1.0
In-Reply-To: <CAAiTLFXHC5LS7NdmL6oO+QfiLh1fj+k8_74OnH6TFwzDx5EAgw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] util/async: use atomic_mb_set in
 qemu_bh_cancel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 08.11.2017 17:24, Sergio Lopez wrote:
> On Wed, Nov 8, 2017 at 3:15 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 08/11/2017 15:10, Sergio Lopez wrote:
>>>> I'm not quite sure that the pre-fetched is involved in this issue,
>>>> because pre-fetch reading a certain addresses should be invalidated by
>>>> write on another core to the same addresses. In our case write
>>>> req->state = THREAD_DONE should invalidate read req->state == THREAD_DONE.
>>>> I am inclined to think that there is a memory-reordering read with
>>>> write. It's a very real case for x86 and I don't see the reasons which
>>>> can prevent it:
>>>>
>>> Yes, you're right. This is actually a memory reordering issue. I'm
>>> going to rewrite that paragraph.
>>
>> Well, memory reordering _is_ caused by speculative prefetching, delayed
>> cache invalidation (store buffers), and so on.
>>
>> But it's probably better indeed to replace "pre-fetched" with
>> "outdated".  Whoever commits the patch can do the substitution (I can too).
>>
> 
> Alternatively, if we want to explicitly mention the memory barrier, we
> can replace the third paragraph with something like this:
> 
> <snip>
> This was considered to be safe, as the completion function restarts the
> loop just after the call to qemu_bh_cancel. But, as this loop lacks a HW
> memory barrier, the read of req->state may actually happen _before_ the
> call, seeing it still as THREAD_QUEUED, and ending the completion
> function without having processed a pending TPE linked at pool->head:
> </snip>

Yes, that's better. Thank you.

> ---
> Sergio
> 
