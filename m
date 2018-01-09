Received: from eggs.gnu.org ([2001:4830:134:3::10]:33664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYwou-00026M-Do
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:32:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYwop-0005Ce-Gx
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:32:12 -0500
Date: Tue, 9 Jan 2018 17:31:37 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109173137.5b8bd15f.cohuck@redhat.com>
In-Reply-To: <20171211134740.8235-6-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
	<20171211134740.8235-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 05/15] s390x/tcg: simplify
 machine check handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Mon, 11 Dec 2017 14:47:30 +0100
David Hildenbrand <david@redhat.com> wrote:

> We currently only support CRW machine checks. This is a preparation for
> real floating interrupt support.
> 
> Get rid of the queue and handle it via the bit INTERRUPT_MCHK. We don't
> rename it for now, as it will be soon gone (when moving crw machine checks
> into the flic).
> 
> Please note that this is the same way also KVM handles it: only one
> instance of a machine check can be pending at a time. So no need for a
> queue.

That's basically architecture (IIRC, it's been a while). More pending
machine checks are handled by merging into the mcic.

> 
> While at it, make sure we try to deliver only if env->cregs[14]
> actually indicates that CRWs are accepted.
> 
> Drop two unused defines on the way (we already have PSW_MASK_...).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c         |  2 --
>  target/s390x/cpu.h         | 10 ----------
>  target/s390x/excp_helper.c | 29 +++++------------------------
>  target/s390x/interrupt.c   | 18 +++++++-----------
>  4 files changed, 12 insertions(+), 47 deletions(-)
