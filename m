Received: from eggs.gnu.org ([2001:4830:134:3::10]:35221)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6B3Z-00035n-St
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d6B3Y-0005Kc-C9
	for qemu-devel@nongnu.org; Thu, 04 May 2017 03:20:09 -0400
Date: Thu, 4 May 2017 15:19:57 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170504071957.GD19184@lemon.lan>
References: <20170420120058.28404-1-pbonzini@redhat.com>
	<20170420120058.28404-10-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170420120058.28404-10-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 09/17] util: add stats64 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Thu, 04/20 14:00, Paolo Bonzini wrote:
> This module provides fast paths for 64-bit atomic operations on machines
> that only have 32-bit atomic access.

Interesting patch!

Out of curiosity: what are the machines here, besides i386? It strikes me as
they are old and slow anyway, then why this optimization?

> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/stats64.h | 210 +++++++++++++++++++++++++++++++++++++++++++++++++
>  util/Makefile.objs     |   1 +
>  util/stats64.c         | 135 ++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 include/qemu/stats64.h
>  create mode 100644 util/stats64.c
> 
> diff --git a/include/qemu/stats64.h b/include/qemu/stats64.h
> new file mode 100644
> index 0000000..70963f4
> --- /dev/null
> +++ b/include/qemu/stats64.h
> @@ -0,0 +1,210 @@
> +/*
> + * Atomic operations on 64-bit quantities.
> + *
> + * Copyright (C) 2017 Red Hat, Inc.
> + *
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef QEMU_STATS64_H
> +#define QEMU_STATS64_H 1
> +
> +#include "qemu/atomic.h"

Include qemu/osdep.h first, to honor scripts/clean-includes?

> +
> +/* FIXME: i386 doesn't need the spinlock.  Are there any others? */
> +#if __SIZEOF_LONG__ < 8
> +#define STAT64_NEED_SPINLOCK 1
> +#endif
> +
> +/* This provides atomic operations on 64-bit type, using a reader-writer
> + * spinlock on architectures that do not have 64-bit accesses.  However
> + * it tries hard not to take the lock.
> + */
> +
> +typedef struct Stat64 {
> +#ifdef STAT64_NEED_SPINLOCK
> +    uint32_t low, high;
> +    uint32_t lock;
> +#else
> +    uint64_t value;
> +#endif
> +} Stat64;
> +
> +#ifndef STAT64_NEED_SPINLOCK
> +static inline void stat64_init(Stat64 *s, uint64_t value)
> +{
> +    /* This is not guaranteed to be atomic! */
> +    *s = (Stat64) { value };
> +}
> +
> +static inline uint64_t stat64_get(const Stat64 *s)
> +{
> +    return atomic_read(&s->value);
> +}
> +
> +static inline void stat64_add(Stat64 *s, uint64_t value)
> +{
> +    atomic_add(&s->value, value);
> +}
> +
> +static inline void stat64_min(Stat64 *s, uint32_t value)
> +{
> +    for (;;) {
> +        uint64_t orig = atomic_read(&s->value);
> +        if (orig <= value) {
> +            break;
> +        }
> +        orig = atomic_cmpxchg(&s->value, orig, value);
> +        if (orig <= value) {
> +            break;
> +        }
> +    }
> +}
> +
> +static inline void stat64_max(Stat64 *s, uint32_t value)
> +{
> +    for (;;) {
> +        uint64_t orig = atomic_read(&s->value);
> +        if (orig >= value) {
> +            break;
> +        }
> +        orig = atomic_cmpxchg(&s->value, orig, value);
> +        if (orig >= value) {
> +            break;
> +        }
> +    }
> +}
> +#else
> +uint64_t stat64_get(const Stat64 *s);
> +bool stat64_min_slow(Stat64 *s, uint64_t value);
> +bool stat64_max_slow(Stat64 *s, uint64_t value);
> +bool stat64_add32_carry(Stat64 *s, uint32_t low, uint32_t high);
> +
> +static inline void stat64_init(Stat64 *s, uint64_t value)
> +{
> +    /* This is not guaranteed to be atomic! */
> +    *s = (Stat64) { .low = value, .high = value >> 32, .lock = 0 };
> +}
> +
> +static inline void stat64_add(Stat64 *s, uint64_t value)
> +{
> +    uint32_t low, high;
> +    high = value >> 32;
> +    low = (uint32_t) value;
> +    if (!low) {
> +        if (high) {
> +            atomic_add(&s->high, high);
> +        }
> +        return;
> +    }
> +
> +    for (;;) {
> +        uint32_t orig = s->low;
> +        uint32_t result = orig + low;
> +        uint32_t old;
> +
> +        if (result < low || high) {
> +            /* If the high part is affected, take the lock.  */
> +            if (stat64_add32_carry(s, low, high)) {
> +                return;
> +            }
> +            continue;
> +        }
> +
> +        /* No carry, try with a 32-bit cmpxchg.  The result is independent of
> +         * the high 32 bits, so it can race just fine with stat64_add32_carry
> +         * and even stat64_get!
> +         */
> +        old = atomic_cmpxchg(&s->low, orig, result);
> +        if (orig == old) {
> +            return;
> +        }
> +    }
> +}
> +
> +static inline void stat64_min(Stat64 *s, uint64_t value)
> +{
> +    uint32_t low, high;
> +    uint32_t orig_low, orig_high;
> +
> +    high = value >> 32;
> +    low = (uint32_t) value;
> +    do {
> +        orig_high = atomic_read(&s->high);
> +        if (orig_high < high) {
> +            return;
> +        }
> +
> +        if (orig_high == high) {
> +            /* High 32 bits are equal.  Read low after high, otherwise we
> +             * can get a false positive (e.g. 0x1235,0x0000 changes to
> +             * 0x1234,0x8000 and we read it as 0x1234,0x0000). Pairs with
> +             * the write barrier in stat64_min_slow.
> +             */
> +            smp_rmb();
> +            orig_low = atomic_read(&s->low);
> +            if (orig_low <= low) {
> +                return;
> +            }
> +
> +            /* See if we were lucky and a writer raced against us.  The
> +             * barrier is theoretically unnecessary, but if we remove it
> +             * we may miss being lucky.
> +             */
> +            smp_rmb();
> +            orig_high = atomic_read(&s->high);
> +            if (orig_high < high) {
> +                return;
> +            }
> +        }
> +
> +        /* If the value changes in any way, we have to take the lock.  */
> +    } while (!stat64_min_slow(s, value));
> +}
> +
> +static inline void stat64_max(Stat64 *s, uint64_t value)
> +{
> +    uint32_t low, high;
> +    uint32_t orig_low, orig_high;
> +
> +    high = value >> 32;
> +    low = (uint32_t) value;
> +    do {
> +        orig_high = atomic_read(&s->high);
> +        if (orig_high > high) {
> +            return;
> +        }
> +
> +        if (orig_high == high) {
> +            /* High 32 bits are equal.  Read low after high, otherwise we
> +             * can get a false positive (e.g. 0x1234,0x8000 changes to
> +             * 0x1235,0x0000 and we read it as 0x1235,0x8000). Pairs with
> +             * the write barrier in stat64_max_slow.
> +             */
> +            smp_rmb();
> +            orig_low = atomic_read(&s->low);
> +            if (orig_low >= low) {
> +                return;
> +            }
> +
> +            /* See if we were lucky and a writer raced against us.  The
> +             * barrier is theoretically unnecessary, but if we remove it
> +             * we may miss being lucky.
> +             */
> +            smp_rmb();
> +            orig_high = atomic_read(&s->high);
> +            if (orig_high > high) {
> +                return;
> +            }
> +        }
> +
> +        /* If the value changes in any way, we have to take the lock.  */
> +    } while (!stat64_max_slow(s, value));
> +}
> +
> +#endif
> +
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index c6205eb..8a333d3 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -42,4 +42,5 @@ util-obj-y += log.o
>  util-obj-y += qdist.o
>  util-obj-y += qht.o
>  util-obj-y += range.o
> +util-obj-y += stats64.o
>  util-obj-y += systemd.o
> diff --git a/util/stats64.c b/util/stats64.c
> new file mode 100644
> index 0000000..b9238d7
> --- /dev/null
> +++ b/util/stats64.c
> @@ -0,0 +1,135 @@
> +/*
> + * Atomic operations on 64-bit quantities.
> + *
> + * Copyright (C) 2017 Red Hat, Inc.
> + *
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/atomic.h"
> +#include "qemu/stats64.h"
> +
> +#ifdef STAT64_NEED_SPINLOCK
> +static inline void stat64_rdlock(Stat64 *s)
> +{
> +    /* Keep out incoming writers to avoid them starving us. */
> +    atomic_add(&s->lock, 2);
> +
> +    /* If there is a concurrent writer, wait for it.  */
> +    while (atomic_read(&s->lock) & 1) {
> +        g_usleep(5);
> +    }
> +}
> +
> +static inline void stat64_rdunlock(Stat64 *s)
> +{
> +    atomic_sub(&s->lock, 2);
> +}
> +
> +static inline bool stat64_wrtrylock(Stat64 *s)
> +{
> +    return atomic_cmpxchg(&s->lock, 0, 1) == 0;
> +}
> +
> +static inline void stat64_wrunlock(Stat64 *s)
> +{
> +    atomic_dec(&s->lock);
> +}
> +
> +uint64_t stat64_get(const Stat64 *s)
> +{
> +    uint32_t high, low;
> +
> +    stat64_rdlock((Stat64 *)s);
> +
> +    /* 64-bit writes always take the lock, so we can read in
> +     * any order.
> +     */
> +    high = atomic_read(&s->high);
> +    low = atomic_read(&s->low);
> +    stat64_rdunlock((Stat64 *)s);
> +
> +    return ((uint64_t)high << 32) | low;
> +}
> +
> +bool stat64_add32_carry(Stat64 *s, uint32_t low, uint32_t high)

Maybe add "try" in the name too, for this, and the two below?

> +{
> +    uint32_t old;
> +
> +    if (!stat64_wrtrylock(s)) {
> +        return false;
> +    }
> +
> +    /* 64-bit reads always take the lock, so they don't care about the
> +     * order of our update.  By updating s->low first, we can check
> +     * whether we have to carry into s->high.
> +     */
> +    old = atomic_fetch_add(&s->low, value);
> +    high += (old + value < old);
> +    atomic_add(&s->high, high);
> +    stat64_wrunlock(s);
> +    return true;
> +}
> +
> +bool stat64_min_slow(Stat64 *s, uint64_t value)
> +{
> +    uint32_t high, low;
> +    uint64_t orig;
> +
> +    if (!stat64_wrtrylock(s)) {
> +        return false;
> +    }
> +
> +    high = atomic_read(&s->high);
> +    low = atomic_read(&s->low);
> +
> +    orig = ((uint64_t)high << 32) | low;
> +    if (orig < value) {
> +        /* The value may become higher temporarily, but stat64_get does not
> +         * notice (it takes the lock) and the only effect on stat64_min is
> +         * that the slow path may be triggered unnecessarily.
> +         *
> +         * But, we have to set low before high, just like stat64_min reads
> +         * high before low.
> +         */
> +        atomic_set(&s->low, (uint32_t)value);
> +        smp_wmb();
> +        atomic_set(&s->high, value >> 32);
> +    }
> +    stat64_wrunlock(s);
> +    return true;
> +}
> +
> +bool stat64_max_slow(Stat64 *s, uint64_t value)
> +{
> +    uint32_t high, low;
> +    uint64_t orig;
> +
> +    if (!stat64_wrtrylock(s)) {
> +        return false;
> +    }
> +
> +    high = atomic_read(&s->high);
> +    low = atomic_read(&s->low);
> +
> +    orig = ((uint64_t)high << 32) | low;
> +    if (orig > value) {
> +        /* The value may become lower temporarily, but stat64_get does not
> +         * notice (it takes the lock) and the only effect on stat64_max is
> +         * that the slow path may be triggered unnecessarily.
> +         *
> +         * But, we have to set low before high, just like stat64_max reads
> +         * high before low.
> +         */
> +        atomic_set(&s->low, (uint32_t)value);
> +        smp_wmb();
> +        atomic_set(&s->high, value >> 32);
> +    }
> +    stat64_wrunlock(s);
> +    return true;
> +}
> +#endif
> -- 
> 2.9.3
> 
> 
> 
