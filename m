Received: from eggs.gnu.org ([2001:4830:134:3::10]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cZMiU-0001tV-DM
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:06:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1cZMiT-0001JT-Hj
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 14:06:46 -0500
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20161206014943.GA25612@flamenco>
References: <20161129114707.2975-1-pbonzini@redhat.com>
	<20161129114707.2975-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161129114707.2975-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/10] qemu-thread: introduce QemuLockCnt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Thu, 02 Feb 2017 19:06:47 -0000
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Nov 29, 2016 at 12:46:59 +0100, Paolo Bonzini wrote:
> A QemuLockCnt comprises a counter and a mutex, with primitives
> to increment and decrement the counter, and to take and release the
> mutex.  It can be used to do lock-free visits to a data structure
> whenever mutexes would be too heavy-weight and the critical section
> is too long for RCU.
> 
> This could be implemented simply by protecting the counter with the
> mutex, but QemuLockCnt is harder to misuse and more efficient.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(snip)
> +++ b/docs/lockcnt.txt
> @@ -0,0 +1,343 @@
> +DOCUMENTATION FOR LOCKED COUNTERS (aka QemuLockCnt)
> +===================================================
(snip)
> +    bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt);
> +
> +        If the count is 1, decrement the count to zero, lock
> +        the mutex and return true.  Otherwise, return false.
> +
(snip)
> +++ b/util/lockcnt.c
(snip)
> +void qemu_lockcnt_init(QemuLockCnt *lockcnt)
> +{
> +    qemu_mutex_init(&lockcnt->mutex);
> +    lockcnt->count = 0;

Minor nit: a release barrier here wouldn't harm.

> +}
> +
> +void qemu_lockcnt_destroy(QemuLockCnt *lockcnt)
> +{
> +    qemu_mutex_destroy(&lockcnt->mutex);
> +}
> +
> +void qemu_lockcnt_inc(QemuLockCnt *lockcnt)
> +{
> +    int old;
> +    for (;;) {
> +        old = atomic_read(&lockcnt->count);
> +        if (old == 0) {
> +            qemu_lockcnt_lock(lockcnt);
> +            qemu_lockcnt_inc_and_unlock(lockcnt);
> +            return;
> +        } else {
> +            if (atomic_cmpxchg(&lockcnt->count, old, old + 1) == old) {
> +                return;
> +            }
> +        }
> +    }
> +}
> +
> +void qemu_lockcnt_dec(QemuLockCnt *lockcnt)
> +{
> +    atomic_dec(&lockcnt->count);
> +}
> +
> +/* Decrement a counter, and return locked if it is decremented to zero.
> + * It is impossible for the counter to become nonzero while the mutex
> + * is taken.
> + */
> +bool qemu_lockcnt_dec_and_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_read(&lockcnt->count);
> +    while (val > 1) {
> +        int old = atomic_cmpxchg(&lockcnt->count, val, val - 1);
> +        if (old != val) {
> +            val = old;
> +            continue;
> +        }
> +
> +        return false;
> +    }

Minor nit:
	while (val > 1) {
		int old = cmpxchg();
		if (old == val) {
			return false;
		}
		val = old;
	}
seems to me a little easier to read.

> +    qemu_lockcnt_lock(lockcnt);
> +    if (atomic_fetch_dec(&lockcnt->count) == 1) {
> +        return true;
> +    }
> +
> +    qemu_lockcnt_unlock(lockcnt);
> +    return false;
> +}
> +
> +/* Decrement a counter and return locked if it is decremented to zero.
> + * Otherwise do nothing.

This comment doesn't match the code below nor the description in the
.txt file (quoted above) [we might not decrement the counter at all!]

> + *
> + * It is impossible for the counter to become nonzero while the mutex
> + * is taken.
> + */
> +bool qemu_lockcnt_dec_if_lock(QemuLockCnt *lockcnt)
> +{
> +    int val = atomic_mb_read(&lockcnt->count);
> +    if (val > 1) {
> +        return false;
> +    }
> +
> +    qemu_lockcnt_lock(lockcnt);
> +    if (atomic_fetch_dec(&lockcnt->count) == 1) {
> +        return true;
> +    }
> +
> +    qemu_lockcnt_inc_and_unlock(lockcnt);

The choice of dec+(maybe)inc over cmpxchg seems a little odd to me.

		Emilio
