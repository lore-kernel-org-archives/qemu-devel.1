Received: from eggs.gnu.org ([2001:4830:134:3::10]:50573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fvrVa-0001C3-Vl
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:03:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fvrVV-0001bp-SW
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:03:14 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46251)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1fvrVV-0001bW-Ju
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:03:09 -0400
Date: Fri, 31 Aug 2018 18:03:08 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180831220308.GA18048@flamenco>
References: <20180820150903.1224-1-pbonzini@redhat.com>
	<20180820150903.1224-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180820150903.1224-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] cpus: protect all icount computation
 with seqlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Aug 20, 2018 at 17:09:00 +0200, Paolo Bonzini wrote:
> Using the seqlock makes the atomic_read__nocheck safe, because it now
> happens always inside a seqlock and any torn reads will be retried.

Using a seqlock makes regular accesses safe as well, for the same
reason. It's undefined behaviour but I don't see how to avoid
it if the host might not have wide-enough atomics (see below).

> qemu_icount_bias and icount_time_shift also need to be accessed with
> atomics.

But qemu_icount_bias is always accessed through the seqlock, so regular
accesses should be fine there.

Moreover, seqlock + regular accesses allow us not to worry about
32-bit hosts without __atomic builtins, which might choke on
atomic accesses to u64's (regardless of __nocheck) like this one:

> -#ifdef CONFIG_ATOMIC64
> +    /* The read is protected by the seqlock, so __nocheck is okay.  */
>      return atomic_read__nocheck(&timers_state.qemu_icount);
> -#else /* FIXME: we need 64bit atomics to do this safely */
> -    return timers_state.qemu_icount;
> -#endif

So I think we should convert these to regular accesses. I just
wrote a patch to perform the conversion (after noticing the same
misuse of __nocheck + seqlock in qsp.c, which is my fault); however,
I have a question on patch 3, which I'd like to address first.

Thanks,

		Emilio
