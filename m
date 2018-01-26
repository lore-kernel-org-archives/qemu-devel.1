Received: from eggs.gnu.org ([2001:4830:134:3::10]:39267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ef9XU-00076O-Dx
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ef9XP-00010b-TV
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:19:52 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53204)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ef9XP-0000zX-JZ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 14:19:47 -0500
Received: by mail-wm0-f67.google.com with SMTP id g1so3286973wmg.2
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 11:19:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180125175949.7780-3-pbonzini@redhat.com>
References: <20180125175949.7780-1-pbonzini@redhat.com>
	<20180125175949.7780-3-pbonzini@redhat.com>
From: Fam Zheng <famz@redhat.com>
Date: Fri, 26 Jan 2018 13:24:36 +0800
Message-ID: <CAK1Eb9msYD25pPUGq0GeJ3UnWzbUPwUmqCB=rBrhDOuFQHZ0KA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 2/5] lockable: add QemuLockable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jan 26, 2018 at 1:59 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> QemuLockable is a polymorphic lock type that takes an object and
> knows which function to use for locking and unlocking.  The
> implementation could use C11 _Generic, but since the support is
> not very widespread I am instead using __builtin_choose_expr and
> __builtin_types_compatible_p, which are already used by
> include/qemu/atomic.h.
>
> QemuLockable can be used to implement lock guards, or to pass around
> a lock in such a way that a function can release it and re-acquire it.
> The next patch will do this for CoQueue.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v2->v3: now it works :(  Also, QEMU_MAKE_LOCKABLE(NULL) returns NULL.
>                 The argument of QEMU_MAKE_LOCKABLE is expected to be a constant,
>                 so the test is optimized away.
>
>  include/qemu/compiler.h  | 40 ++++++++++++++++++++++
>  include/qemu/coroutine.h |  4 +--
>  include/qemu/lockable.h  | 88 ++++++++++++++++++++++++++++++++++++++++++++++++
>  include/qemu/thread.h    |  5 ++-
>  include/qemu/typedefs.h  |  4 +++
>  tests/test-coroutine.c   | 25 ++++++++++++++
>  6 files changed, 161 insertions(+), 5 deletions(-)
>  create mode 100644 include/qemu/lockable.h
>
> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
> index 340e5fdc09..5179bedb1e 100644
> --- a/include/qemu/compiler.h
> +++ b/include/qemu/compiler.h
> @@ -111,4 +111,44 @@
>  #define GCC_FMT_ATTR(n, m)
>  #endif
>
> +/* Implement C11 _Generic via GCC builtins.  Example:
> + *
> + *    QEMU_GENERIC(x, (float, sinf), (long double, sinl), sin) (x)
> + *
> + * The first argument is the discriminator.  The last is the default value.
> + * The middle ones are tuples in "(type, expansion)" format.
> + */
> +
> +/* First, find out the number of generic cases.  */
> +#define QEMU_GENERIC(x, ...) \
> +    QEMU_GENERIC_(typeof(x), __VA_ARGS__, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)
> +
> +/* There will be extra arguments, but they are not used.  */
> +#define QEMU_GENERIC_(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9, count, ...) \
> +    QEMU_GENERIC##count(x, a0, a1, a2, a3, a4, a5, a6, a7, a8, a9)
> +
> +/* Two more helper macros, this time to extract items from a parenthesized
> + * list.
> + */
> +#define QEMU_FIRST_(a, b) a
> +#define QEMU_SECOND_(a, b) b
> +
> +/* ... and a final one for the common part of the "recursion".  */
> +#define QEMU_GENERIC_IF(x, type_then, else_)                                   \
> +    __builtin_choose_expr(__builtin_types_compatible_p(x,                      \
> +                                                       QEMU_FIRST_ type_then), \
> +                          QEMU_SECOND_ type_then, else_)
> +
> +/* CPP poor man's "recursion".  */
> +#define QEMU_GENERIC1(x, a0, ...) (a0)
> +#define QEMU_GENERIC2(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC1(x, __VA_ARGS__))
> +#define QEMU_GENERIC3(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC2(x, __VA_ARGS__))
> +#define QEMU_GENERIC4(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC3(x, __VA_ARGS__))
> +#define QEMU_GENERIC5(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC4(x, __VA_ARGS__))
> +#define QEMU_GENERIC6(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC5(x, __VA_ARGS__))
> +#define QEMU_GENERIC7(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC6(x, __VA_ARGS__))
> +#define QEMU_GENERIC8(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC7(x, __VA_ARGS__))
> +#define QEMU_GENERIC9(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC8(x, __VA_ARGS__))
> +#define QEMU_GENERIC10(x, a0, ...) QEMU_GENERIC_IF(x, a0, QEMU_GENERIC9(x, __VA_ARGS__))
> +
>  #endif /* COMPILER_H */
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index ce2eb73670..8a5129741c 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -121,7 +121,7 @@ bool qemu_coroutine_entered(Coroutine *co);
>   * Provides a mutex that can be used to synchronise coroutines
>   */
>  struct CoWaitRecord;
> -typedef struct CoMutex {
> +struct CoMutex {
>      /* Count of pending lockers; 0 for a free mutex, 1 for an
>       * uncontended mutex.
>       */
> @@ -142,7 +142,7 @@ typedef struct CoMutex {
>      unsigned handoff, sequence;
>
>      Coroutine *holder;
> -} CoMutex;
> +};
>
>  /**
>   * Initialises a CoMutex. This must be called before any other operation is used
> diff --git a/include/qemu/lockable.h b/include/qemu/lockable.h
> new file mode 100644
> index 0000000000..f527d0ddb2
> --- /dev/null
> +++ b/include/qemu/lockable.h
> @@ -0,0 +1,88 @@
> +/*
> + * Polymorphic locking functions (aka poor man templates)
> + *
> + * Copyright Red Hat, Inc. 2017
> + *
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + *
> + */
> +
> +#ifndef QEMU_LOCKABLE_H
> +#define QEMU_LOCKABLE_H
> +
> +#include "qemu/coroutine.h"
> +#include "qemu/thread.h"
> +
> +typedef void QemuLockUnlockFunc(void *);
> +
> +struct QemuLockable {
> +    void *object;
> +    QemuLockUnlockFunc *lock;
> +    QemuLockUnlockFunc *unlock;
> +};
> +
> +/* This function gives link-time errors if an invalid, non-NULL
> + * pointer type is passed to QEMU_MAKE_LOCKABLE.
> + */
> +void unknown_lock_type(void *);
> +
> +static inline __attribute__((__always_inline__)) QemuLockable *
> +qemu_make_lockable(void *x, QemuLockable *lockable)
> +{
> +    /* We cannot test this in a macro, otherwise we get * compiler
> +     * warnings like "the address of 'm' will always evaluate as 'true'".
> +     */
> +    return x ? lockable : NULL;
> +}
> +
> +/* Auxiliary macros to simplify QEMU_MAKE_LOCABLE.  */
> +#define QEMU_LOCK_FUNC(x) ((QemuLockUnlockFunc *)    \
> +    QEMU_GENERIC(x,                                  \
> +                 (QemuMutex *, qemu_mutex_lock),     \
> +                 (CoMutex *, qemu_co_mutex_lock),    \
> +                 (QemuSpin *, qemu_spin_lock),       \
> +                 unknown_lock_type))

This optimization doesn't seem to work with --enable-gcov, I think
without gcc -O the function is always referenced:

https://travis-ci.org/famz/qemu/jobs/333563215

Fam
