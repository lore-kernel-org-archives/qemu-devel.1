Received: from eggs.gnu.org ([2001:4830:134:3::10]:33120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eH8uW-0002FU-E1
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:48:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eH8uV-00078D-Je
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 08:48:24 -0500
Date: Tue, 21 Nov 2017 14:47:54 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171121134754.GB11073@localhost.localdomain>
References: <cover.1511230683.git.jcody@redhat.com>
	<1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f0fd95c2096688add2c7b3cfcd7016756ef19fb.1511230683.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11 2/4] coroutine: abort if we try
 to schedule or enter a pending coroutine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com

Am 21.11.2017 um 03:23 hat Jeff Cody geschrieben:
> The previous patch fixed a race condition, in which there were
> coroutines being executing doubly, or after coroutine deletion.
> 
> We can detect common scenarios when this happens, and print an error
> message and abort before we corrupt memory / data, or segfault.
> 
> This patch will abort if an attempt to enter a coroutine is made while
> it is currently pending execution, either in a specific AioContext bh,
> or pending execution via a timer.  It will also abort if a coroutine
> is scheduled, before a prior scheduled run has occured.
> 
> We cannot rely on the existing co->caller check for recursive re-entry
> to catch this, as the coroutine may run and exit with
> COROUTINE_TERMINATE before the scheduled coroutine executes.
> 
> (This is the scenario that was occuring and fixed in the previous
> patch).
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  include/qemu/coroutine_int.h |  6 ++++++
>  util/async.c                 | 11 +++++++++++
>  util/qemu-coroutine-sleep.c  | 11 +++++++++++
>  util/qemu-coroutine.c        | 11 +++++++++++
>  4 files changed, 39 insertions(+)
> 
> diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
> index cb98892..56e4c48 100644
> --- a/include/qemu/coroutine_int.h
> +++ b/include/qemu/coroutine_int.h
> @@ -53,6 +53,12 @@ struct Coroutine {
>  
>      /* Only used when the coroutine has yielded.  */
>      AioContext *ctx;
> +
> +    /* Used to catch and abort on illegal co-routine entry.
> +     * Will contain the name of the function that had first
> +     * scheduled the coroutine. */
> +    const char *scheduled;

Not sure if it makes any difference in practice, but I just want to
mention that the new field is right after a cacheline boundary and
the only field that is used in qemu_aio_coroutine_enter() and accesses
this second cacheline.

I'm not paying much attention to this kind of thing in most contexts,
but entering a coroutine is a hot path that we want to be fast, so maybe
it's worth having a second look.

Kevin
