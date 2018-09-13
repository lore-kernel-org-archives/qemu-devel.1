Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0N4y-0000fk-F3
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1g0N4s-0000PO-K8
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 04:34:21 -0400
Date: Thu, 13 Sep 2018 16:34:05 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180913083405.GP2526@lemon.usersys.redhat.com>
References: <20180912171040.1732-1-pbonzini@redhat.com>
	<20180912171040.1732-2-pbonzini@redhat.com>
	<20180913065639.GL2526@lemon.usersys.redhat.com>
	<a4190f46-474b-38fb-5028-703754f598a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4190f46-474b-38fb-5028-703754f598a6@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/3] aio-posix: fix concurrent
 access to poll_disable_cnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 09/13 10:29, Paolo Bonzini wrote:
> On 13/09/2018 08:56, Fam Zheng wrote:
> >> +    /* No need to order poll_disable_cnt writes against other updates;
> >> +     * the counter is only used to avoid wasting time and latency on
> >> +     * iterated polling when the system call will be ultimately necessary.
> >> +     * Changing handlers is a rare event, and a little wasted polling until
> >> +     * the aio_notify below is not an issue.
> >> +     */
> >> +    atomic_set(&ctx->poll_disable_cnt,
> >> +               atomic_read(&ctx->poll_disable_cnt) + poll_disable_change);
> >
> > Why not atomic_add?
> 
> This is not lockless, it's protected by list_lock, so there's no race
> condition involved.  I'm just mimicking what is done for other similar
> cases, for example involving seqlocks.

Yeah, no doubt about the correctness. Just curious about the preference since
atomic_add is less typing and one less atomic_* op.

Fam

> 
> The alternative would be to add a full set of
> atomic_{add,sub,...}_relaxed atomics.
> 
> Paolo
