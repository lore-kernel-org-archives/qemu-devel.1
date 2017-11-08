Received: from eggs.gnu.org ([2001:4830:134:3::10]:51014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1eCTMG-0006gR-E0
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbutsykin@virtuozzo.com>) id 1eCTMF-0000xA-IH
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 11:37:44 -0500
References: <20171108063447.2842-1-slp@redhat.com>
	<f18d01b4-6ae6-75d9-63ba-83fb22b6a43d@virtuozzo.com>
	<CAAiTLFV80SfMneuhs7tdYENOb+zV7kJ43B9ZgALk2tva1ZDpUw@mail.gmail.com>
	<5d4d9db6-f740-c114-9f21-d575eb2d897f@redhat.com>
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
Message-ID: <71cba021-1d61-8dc5-1685-c52f40098072@virtuozzo.com>
Date: Wed, 8 Nov 2017 19:36:53 +0300
MIME-Version: 1.0
In-Reply-To: <5d4d9db6-f740-c114-9f21-d575eb2d897f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>, Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, stefanha@redhat.com, qemu-block@nongnu.org



On 08.11.2017 17:15, Paolo Bonzini wrote:
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

what do you mean?

If we are speaking about x86, then a write on another core
(like req->state = THREAD_DONE in this issue) should invalidate
prefetch read(req->state = THREAD_DONE) and this is prevented in
hardware. The prefetch is locked to the L1, when another cpu
invalidates the cache lines, the prefetch is invalidated also
(As far as I understand it).

> But it's probably better indeed to replace "pre-fetched" with
> "outdated".  Whoever commits the patch can do the substitution (I can too).
> 
> Paolo
> 
