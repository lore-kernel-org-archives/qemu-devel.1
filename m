Received: from eggs.gnu.org ([2001:4830:134:3::10]:45101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6JHI-0004RG-Li
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:06:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d6JHH-0000YJ-QD
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:06:52 -0400
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-15-pbonzini@redhat.com>
	<20170504145906.GR32376@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a60d65e8-fff3-dbe3-7357-38095a91e83a@redhat.com>
Date: Thu, 4 May 2017 18:06:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170504145906.GR32376@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
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



On 04/05/2017 16:59, Stefan Hajnoczi wrote:
> On Thu, Apr 20, 2017 at 02:00:55PM +0200, Paolo Bonzini wrote:
>> Hot path reqs_lock critical sections are very small; the only large cr=
itical
>> sections happen when a request waits for serialising requests, and the=
se
>> should never happen in usual circumstances.
>>
>> We do not want these small critical sections to yield in any case,
>> which calls for using a spinlock while writing the list.
>=20
> Is this patch purely an optimization?

Yes, it is, and pretty much a no-op until we have true multiqueue.  But
I expect it to have a significant effect for multiqueue.

> I'm hesitant about using spinlocks in userspace.  There are cases where
> the thread is descheduled that are beyond our control.  Nested virt wil=
l
> probably make things worse.  People have been optimizing and trying
> paravirt approaches to kernel spinlocks for these reasons for years.

This is true, but here we're talking about a 5-10 instruction window for
preemption; it matches the usage of spinlocks in other parts of QEMU.
The long critical sections, which only happen with combination with
copy-on-read or RMW (large logical block sizes on the host), take the
CoMutex.

On one hand it's true that the more you nest, the more things get worse.
 On the other hand there can only ever be contention with multiqueue,
and the multiqueue scenarios are going to use pinning.

> Isn't a futex-based lock efficient enough?  That way we don't hog the
> CPU when there is contention.

It is efficient when there is no contention, but when there is, the
latency goes up by several orders of magnitude.

Paolo

> Also, there are no performance results included in this patch that
> justify the spinlock.
>=20
