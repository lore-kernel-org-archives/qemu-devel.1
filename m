Received: from eggs.gnu.org ([2001:4830:134:3::10]:59585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRfWq-000427-AE
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cRfWl-0004Ch-N8
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:34:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cRfWl-0004CS-EJ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:34:51 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 435B8C0528CA
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 13:34:51 +0000 (UTC)
Date: Thu, 12 Jan 2017 21:34:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170112133445.GE26504@lemon>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/10] qemu-thread: optimize QemuLockCnt
 with futexes on Linux
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, 01/04 14:26, Paolo Bonzini wrote:
> diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> new file mode 100644
> index 0000000..852d612
> --- /dev/null
> +++ b/include/qemu/futex.h
> @@ -0,0 +1,36 @@
> +/*
> + * Wrappers around Linux futex syscall
> + *
> + * Copyright Red Hat, Inc. 2015

2015 - 2017, too?

> + *
> + * Author:
> + *  Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <sys/syscall.h>
> +#include <linux/futex.h>
> +
> +#define qemu_futex(...)              syscall(__NR_futex, __VA_ARGS__)
> +
> +static inline void qemu_futex_wake(void *f, int n)
> +{
> +    qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
> +}
> +
> +static inline void qemu_futex_wait(void *f, unsigned val)
> +{
> +    while (qemu_futex(f, FUTEX_WAIT, (int) val, NULL, NULL, 0)) {
> +        switch (errno) {
> +        case EWOULDBLOCK:
> +            return;
> +        case EINTR:
> +            break; /* get out of switch and retry */
> +        default:
> +            abort();
> +        }
> +    }
> +}
> diff --git a/util/lockcnt.c b/util/lockcnt.c
> index 78ed1e4..40cc02a 100644
> --- a/util/lockcnt.c
> +++ b/util/lockcnt.c
> @@ -9,7 +9,288 @@
>  #include "qemu/osdep.h"
>  #include "qemu/thread.h"
>  #include "qemu/atomic.h"
> +#include "trace.h"
>  
> +#ifdef CONFIG_LINUX
> +#include "qemu/futex.h"
> +
> +/* On Linux, bits 0-1 are a futex-based lock, bits 2-31 are the counter.
> + * For the mutex algorithm see Ulrich Drepper's "Futexes Are Tricky" (ok,
> + * this is not the most relaxing citation I could make...).  It is similar
> + * to mutex2 in the paper.
> + */
> +
> +#define QEMU_LOCKCNT_STATE_MASK    3
> +#define QEMU_LOCKCNT_STATE_FREE    0
> +#define QEMU_LOCKCNT_STATE_LOCKED  1

I find the macro names a bit incomplete in describing the semantics but maybe
you want to limit the length, making it harder to understand the mutex
implementation without reading the paper. How about adding a comment saying
"locked" is "locked but _not waited_" and "waiting" is "_locked_ and waited"?
It's up to you, because this is trivial compared to the real complexity of this
patch. :)

> +#define QEMU_LOCKCNT_STATE_WAITING 2
> +
> +#define QEMU_LOCKCNT_COUNT_STEP    4
> +#define QEMU_LOCKCNT_COUNT_SHIFT   2
> +
> +void qemu_lockcnt_init(QemuLockCnt *lockcnt)
> +{
> +    lockcnt->count = 0;
> +}
> +
> +void qemu_lockcnt_destroy(QemuLockCnt *lockcnt)
> +{
> +}
> +
> +/* *val is the current value of lockcnt->count.
> + *
> + * If the lock is free, try a cmpxchg from *val to new_if_free; return
> + * true and set *val to the old value found by the cmpxchg in
> + * lockcnt->count.
> + *
> + * If the lock is taken, wait for it to be released and return false
> + * *without trying again to take the lock*.  Again, set *val to the
> + * new value of lockcnt->count.
> + *
> + * new_if_free's bottom two bits must not be QEMU_LOCKCNT_STATE_LOCKED
> + * if calling this function a second time after it has returned
> + * false.

"and waited"? I think it is possible this function return false with the lock
actually being free, when ...

> + */
> +static bool qemu_lockcnt_cmpxchg_or_wait(QemuLockCnt *lockcnt, int *val,
> +                                         int new_if_free, bool *waited)
> +{
> +    /* Fast path for when the lock is free.  */
> +    if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_FREE) {
> +        int expected = *val;
> +
> +        trace_lockcnt_fast_path_attempt(lockcnt, expected, new_if_free);
> +        *val = atomic_cmpxchg(&lockcnt->count, expected, new_if_free);
> +        if (*val == expected) {
> +            trace_lockcnt_fast_path_success(lockcnt, expected, new_if_free);
> +            *val = new_if_free;
> +            return true;
> +        }
> +    }
> +
> +    /* The slow path moves from locked to waiting if necessary, then
> +     * does a futex wait.  Both steps can be repeated ad nauseam,
> +     * only getting out of the loop if we can have another shot at the
> +     * fast path.  Once we can, get out to compute the new destination
> +     * value for the fast path.
> +     */
> +    while ((*val & QEMU_LOCKCNT_STATE_MASK) != QEMU_LOCKCNT_STATE_FREE) {
> +        if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_LOCKED) {
> +            int expected = *val;
> +            int new = expected - QEMU_LOCKCNT_STATE_LOCKED + QEMU_LOCKCNT_STATE_WAITING;
> +
> +            trace_lockcnt_futex_wait_prepare(lockcnt, expected, new);

... the holder thread releases the lock at this point. In this case a second
call to this function in qemu_lockcnt_dec_and_lock does pass
QEMU_LOCKCNT_STATE_LOCKED in new_if_free, because 'waited' is left false there.
The code is okay, but the comment above is too strict.

> +            *val = atomic_cmpxchg(&lockcnt->count, expected, new);
> +            if (*val == expected) {
> +                *val = new;
> +            }
> +            continue;
> +        }
> +
> +        if ((*val & QEMU_LOCKCNT_STATE_MASK) == QEMU_LOCKCNT_STATE_WAITING) {
> +            *waited = true;
> +            trace_lockcnt_futex_wait(lockcnt, *val);
> +            qemu_futex_wait(&lockcnt->count, *val);
> +            *val = atomic_read(&lockcnt->count);
> +            trace_lockcnt_futex_wait_resume(lockcnt, *val);
> +            continue;
> +        }
> +
> +        abort();
> +    }
> +    return false;
> +}
> +
> +void qemu_lockcnt_inc(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);
> +    bool waited = false;
> +
> +    for (;;) {
> +        if (val >= QEMU_LOCKCNT_COUNT_STEP) {
> +            int expected = val;
> +            val = atomic_cmpxchg(&lockcnt->count, val, val + QEMU_LOCKCNT_COUNT_STEP);
> +            if (val == expected) {
> +                break;
> +            }
> +        } else {
> +            /* The fast path is (0, unlocked)->(1, unlocked).  */
> +            if (qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, QEMU_LOCKCNT_COUNT_STEP,
> +                                             &waited)) {
> +                break;
> +            }
> +        }
> +    }
> +
> +    /* If we were woken by another thread, we should also wake one because
> +     * we are effectively releasing the lock that was given to us.  This is
> +     * the case where qemu_lockcnt_lock would leave QEMU_LOCKCNT_STATE_WAITING
> +     * in the low bits, and qemu_lockcnt_inc_and_unlock would find it and
> +     * wake someone.
> +     */
> +    if (waited) {
> +        lockcnt_wake(lockcnt);
> +    }
> +}
> +
> +/* Decrement a counter, and return locked if it is decremented to zero.
> + * If the function returns true, it is impossible for the counter to
> + * become nonzero until the next qemu_lockcnt_unlock.
> + */
> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);
> +    int locked_state = QEMU_LOCKCNT_STATE_LOCKED;
> +    bool waited = false;
> +
> +    for (;;) {
> +        if (val >= 2 * QEMU_LOCKCNT_COUNT_STEP) {
> +            int expected = val;
> +            int new = val - QEMU_LOCKCNT_COUNT_STEP;
> +            val = atomic_cmpxchg(&lockcnt->count, val, new);
> +            if (val == expected) {
> +                break;
> +            }

If (val != expected && val >= 2 * QEMU_LOCKCNT_COUNT_STEP), should this
atomic_cmpxchg be retried before trying qemu_lockcnt_cmpxchg_or_wait?

> +        }
> +
> +        /* If count is going 1->0, take the lock. The fast path is
> +         * (1, unlocked)->(0, locked) or (1, unlocked)->(0, waiting).
> +         */
> +        if (qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, locked_state, &waited)) {
> +            return true;
> +        }
> +
> +        if (waited) {
> +            /* At this point we do not know if there are more waiters.  Assume
> +             * there are.
> +             */
> +            locked_state = QEMU_LOCKCNT_STATE_WAITING;
> +        }
> +    }
> +
> +    /* If we were woken by another thread, but we're returning in unlocked
> +     * state, we should also wake a thread because we are effectively
> +     * releasing the lock that was given to us.  This is the case where
> +     * qemu_lockcnt_lock would leave QEMU_LOCKCNT_STATE_WAITING in the low
> +     * bits, and qemu_lockcnt_unlock would find it and wake someone.
> +     */
> +    if (waited) {
> +        lockcnt_wake(lockcnt);
> +    }
> +    return false;
> +}
> +
> +/* If the counter is one, decrement it and return locked.  Otherwise do
> + * nothing.
> + *
> + * If the function returns true, it is impossible for the counter to
> + * become nonzero until the next qemu_lockcnt_unlock.
> + */
> +bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);
> +    int locked_state = QEMU_LOCKCNT_STATE_LOCKED;
> +    bool waited = false;
> +
> +    while (val < 2 * QEMU_LOCKCNT_COUNT_STEP) {
> +        /* If count is going 1->0, take the lock. The fast path is
> +         * (1, unlocked)->(0, locked) or (1, unlocked)->(0, waiting).
> +         */
> +        if (qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, locked_state, &waited)) {
> +            return true;
> +        }
> +
> +        if (waited) {
> +            /* At this point we do not know if there are more waiters.  Assume
> +             * there are.
> +             */
> +            locked_state = QEMU_LOCKCNT_STATE_WAITING;
> +        }
> +    }
> +
> +    /* If we were woken by another thread, but we're returning in unlocked
> +     * state, we should also wake a thread because we are effectively
> +     * releasing the lock that was given to us.  This is the case where
> +     * qemu_lockcnt_lock would leave QEMU_LOCKCNT_STATE_WAITING in the low
> +     * bits, and qemu_lockcnt_inc_and_unlock would find it and wake someone.
> +     */
> +    if (waited) {
> +        lockcnt_wake(lockcnt);
> +    }
> +    return false;
> +}
> +
> +void qemu_lockcnt_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);
> +    int step = QEMU_LOCKCNT_STATE_LOCKED;
> +    bool waited = false;
> +
> +    /* The third argument is only used if the low bits of val are 0
> +     * (QEMU_LOCKCNT_STATE_FREE), so just blindly mix in the desired
> +     * state.
> +     */
> +    while (!qemu_lockcnt_cmpxchg_or_wait(lockcnt, &val, val + step, &waited)) {
> +        if (waited) {
> +            /* At this point we do not know if there are more waiters.  Assume
> +             * there are.
> +             */
> +            step = QEMU_LOCKCNT_STATE_WAITING;
> +        }
> +    }
> +}
> +
> +void qemu_lockcnt_inc_and_unlock(QemuLockCnt *lockcnt)
> +{
> +    int expected, new, val;
> +
> +    val = atomic_read(&lockcnt->count);
> +    do {
> +        expected = val;
> +        new = (val + QEMU_LOCKCNT_COUNT_STEP) & ~QEMU_LOCKCNT_STATE_MASK;
> +        trace_lockcnt_unlock_attempt(lockcnt, val, new);
> +        val = atomic_cmpxchg(&lockcnt->count, val, new);
> +    } while (val != expected);
> +
> +    trace_lockcnt_unlock_success(lockcnt, val, new);
> +    if (val & QEMU_LOCKCNT_STATE_WAITING) {
> +        lockcnt_wake(lockcnt);
> +    }
> +}

Fam
