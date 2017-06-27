Received: from eggs.gnu.org ([2001:4830:134:3::10]:36589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPpJJ-0004Bf-Hw
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dPpJG-0000Kx-Cg
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:09:37 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170623124700.1389-2-el13635@mail.ntua.gr>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-2-el13635@mail.ntua.gr>
Date: Tue, 27 Jun 2017 14:08:54 +0200
Message-ID: <w51bmp9zl7t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFC v3 1/8] block: move ThrottleGroup
 membership to ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

On Fri 23 Jun 2017 02:46:53 PM CEST, Manos Pitsidianakis wrote:
> This commit gathers ThrottleGroup membership details from
> BlockBackendPublic into ThrottleGroupMember and refactors existing code
> to use the structure.
>
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>

Hey Manos, thanks for the patch. It looks good to me in general, I only
have a couple of comments:

>      /* If no IO are queued for scheduling on the next round robin token
> -     * then decide the token is the current bs because chances are
> -     * the current bs get the current request queued.
> +     * then decide the token is the current tgm because chances are
> +     * the current tgm get the current request queued.

I wonder if it's not better to use 'member' instead of 'tgm' in general.
My impression is that the former is clearer and not too long, but I
don't have a very strong opinion so you can keep it like this if you
want.

> -/* Check if an I/O request needs to be throttled, wait and set a timer
> - * if necessary, and schedule the next request using a round robin
> - * algorithm.
> +/* Check if an I/O request needs to be throttled, wait and set a timer if
> + * necessary, and schedule the next request using a round robin algorithm.
>   *

There's a few cases like this when you reformat a paragraph but don't
actually change the text. I think it just adds unnecessary noise to the
diff...

> --- a/include/qemu/throttle.h
> +++ b/include/qemu/throttle.h
> @@ -27,6 +27,7 @@
>  
>  #include "qemu-common.h"
>  #include "qemu/timer.h"
> +#include "qemu/coroutine.h"
>  
>  #define THROTTLE_VALUE_MAX 1000000000000000LL
>  
> @@ -153,4 +154,29 @@ bool throttle_schedule_timer(ThrottleState *ts,
>  
>  void throttle_account(ThrottleState *ts, bool is_write, uint64_t size);
>  
> +
> +/* The ThrottleGroupMember structure indicates membership in a ThrottleGroup
> + * and holds related data.
> + */
> +
> +typedef struct ThrottleGroupMember {
> +    /* throttled_reqs_lock protects the CoQueues for throttled requests.  */
> +    CoMutex      throttled_reqs_lock;
> +    CoQueue      throttled_reqs[2];
> +
> +    /* Nonzero if the I/O limits are currently being ignored; generally
> +     * it is zero.  Accessed with atomic operations.
> +     */
> +    unsigned int io_limits_disabled;
> +
> +    /* The following fields are protected by the ThrottleGroup lock.
> +     * See the ThrottleGroup documentation for details.
> +     * throttle_state tells us if I/O limits are configured. */
> +    ThrottleState *throttle_state;
> +    ThrottleTimers throttle_timers;
> +    unsigned       pending_reqs[2];
> +    QLIST_ENTRY(ThrottleGroupMember) round_robin;
> +
> +} ThrottleGroupMember;
> +

Any reason why you add this to throttle.h (which is generic throttling
code independent from the block layer) and not to throttle-groups.h?

Otherwise it all looks good to me, thanks!

Berto
