Received: from eggs.gnu.org ([2001:4830:134:3::10]:54890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6alN-0001XV-Uj
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1d6alN-0001Xz-3K
	for qemu-devel@nongnu.org; Fri, 05 May 2017 06:47:05 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-15-pbonzini@redhat.com>
	<20170504145906.GR32376@stefanha-x1.localdomain>
	<a60d65e8-fff3-dbe3-7357-38095a91e83a@redhat.com>
	<20170505102550.GA11350@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1bf3079d-3af5-ffa9-c074-660b77874ff7@redhat.com>
Date: Fri, 5 May 2017 12:45:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170505102550.GA11350@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 14/17] block: optimize access
 to reqs_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/05/2017 12:25, Stefan Hajnoczi wrote:
> On Thu, May 04, 2017 at 06:06:39PM +0200, Paolo Bonzini wrote:
>> On 04/05/2017 16:59, Stefan Hajnoczi wrote:
>>> On Thu, Apr 20, 2017 at 02:00:55PM +0200, Paolo Bonzini wrote:
>>>> Hot path reqs_lock critical sections are very small; the only large critical
>>>> sections happen when a request waits for serialising requests, and these
>>>> should never happen in usual circumstances.
>>>>
>>>> We do not want these small critical sections to yield in any case,
>>>> which calls for using a spinlock while writing the list.
>>>
>>> Is this patch purely an optimization?
>>
>> Yes, it is, and pretty much a no-op until we have true multiqueue.  But
>> I expect it to have a significant effect for multiqueue.
>>
>>> I'm hesitant about using spinlocks in userspace.  There are cases where
>>> the thread is descheduled that are beyond our control.  Nested virt will
>>> probably make things worse.  People have been optimizing and trying
>>> paravirt approaches to kernel spinlocks for these reasons for years.
>>
>> This is true, but here we're talking about a 5-10 instruction window for
>> preemption; it matches the usage of spinlocks in other parts of QEMU.
> 
> Only util/qht.c uses spinlocks, it's not a widely used primitive.

Right, but the idea is the same---very short, heavy and
performance-critical cases use spinlocks.  (util/qht.c is used heavily
in TCG mode).

>> It is efficient when there is no contention, but when there is, the
>> latency goes up by several orders of magnitude.
> 
> Doesn't glibc spin for a while before waiting on the futex?  i.e. the
> best of both worlds.

You have to specify that manually with pthread_mutexattr_settype(...,
PTHRED_MUTEX_ADAPTIVE_NP).  It is not enabled by default because IIUC
the adaptive one doesn't support pthread_mutex_timedlock.

Paolo
