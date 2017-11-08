Received: from eggs.gnu.org ([2001:4830:134:3::10]:44158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1eCRHr-0003bo-81
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:25:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slopezpa@redhat.com>) id 1eCRHo-0006p2-35
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:25:03 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:44805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <slopezpa@redhat.com>) id 1eCRHn-0006or-Uj
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 09:25:00 -0500
Received: by mail-vk0-f54.google.com with SMTP id x65so1819381vkx.1
	for <qemu-devel@nongnu.org>; Wed, 08 Nov 2017 06:24:59 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5d4d9db6-f740-c114-9f21-d575eb2d897f@redhat.com>
References: <20171108063447.2842-1-slp@redhat.com>
	<f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
	<CAAiTLFV80SfMneuhs7tdYENOb+zV7kJ43B9ZgALk2tva1ZDpUw@mail.gmail.com>
	<5d4d9db6-f740-c114-9f21-d575eb2d897f@redhat.com>
From: Sergio Lopez <slp@redhat.com>
Date: Wed, 8 Nov 2017 15:24:58 +0100
Message-ID: <CAAiTLFXHC5LS7NdmL6oO+QfiLh1fj+k8_74OnH6TFwzDx5EAgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Pavel Butsykin <pbutsykin@virtuozzo.com>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On Wed, Nov 8, 2017 at 3:15 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 08/11/2017 15:10, Sergio Lopez wrote:
>>> I'm not quite sure that the pre-fetched is involved in this issue,
>>> because pre-fetch reading a certain addresses should be invalidated by
>>> write on another core to the same addresses. In our case write
>>> req->state = THREAD_DONE should invalidate read req->state == THREAD_DONE.
>>> I am inclined to think that there is a memory-reordering read with
>>> write. It's a very real case for x86 and I don't see the reasons which
>>> can prevent it:
>>>
>> Yes, you're right. This is actually a memory reordering issue. I'm
>> going to rewrite that paragraph.
>
> Well, memory reordering _is_ caused by speculative prefetching, delayed
> cache invalidation (store buffers), and so on.
>
> But it's probably better indeed to replace "pre-fetched" with
> "outdated".  Whoever commits the patch can do the substitution (I can too).
>

Alternatively, if we want to explicitly mention the memory barrier, we
can replace the third paragraph with something like this:

<snip>
This was considered to be safe, as the completion function restarts the
loop just after the call to qemu_bh_cancel. But, as this loop lacks a HW
memory barrier, the read of req->state may actually happen _before_ the
call, seeing it still as THREAD_QUEUED, and ending the completion
function without having processed a pending TPE linked at pool->head:
</snip>

---
Sergio
