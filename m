Received: from eggs.gnu.org ([2001:4830:134:3::10]:57113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7kXd-0001IM-QZ
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g7kXZ-0001bW-Ri
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:29 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:59579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g7kXX-0001aJ-Qw
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 13:02:25 -0400
Date: Wed, 3 Oct 2018 13:02:19 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181003170219.GA9925@flamenco>
References: <20181002212921.30982-1-cota@braap.org>
	<20181002212921.30982-3-cota@braap.org> <87h8i3l75j.fsf@linaro.org>
	<a01a9547-d182-daaf-724a-5a836dd9ff02@redhat.com>
	<20181003154844.GA27366@flamenco>
	<91494a20-1090-3e3f-e099-ed06bd6e0e51@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <91494a20-1090-3e3f-e099-ed06bd6e0e51@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] cputlb: serialize tlb updates with
 env->tlb_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>

On Wed, Oct 03, 2018 at 17:52:32 +0200, Paolo Bonzini wrote:
> On 03/10/2018 17:48, Emilio G. Cota wrote:
> >> it's probably best to do all atomic_set instead of just the memberwise copy.
> > Atomics aren't necessary here, as long as the copy is protected by the
> > lock. This allows other vCPUs to see a consistent view of the data (since
> > they always acquire the TLB lock), and since copy_tlb is only called
> > by the vCPU that owns the TLB, regular reads from this vCPU will always
> > see consistent data.
> 
> For reads I agree, but you may actually get a torn read if the writer
> doesn't use atomic_set.

But you cannot get a torn read if all reads that don't hold the lock
are coming from the same thread that performed the write.

> That's because in order to avoid UB all reads or writes that are
> concurrent with another write must be atomic, and the write must be
> atomic too.

Agreed, and that's why there's a patch adding atomic_read to all
.addr_write reads not protected by the lock.

> The lock does prevent write-write concurrent accesses, but
> not read-write, so the write must be atomic here.

But here we have no concurrent read-write, because the non-owner
thread always holds the lock, and the owner thread doesn't need
to synchronize with itself.

I'm appending a small example that might help make my point;
.addr_write corresponds to .written_by_all, and the other
fields correspond to .written_by_owner.

Thanks,

		E.

---
/*
 * baz.c
 * gcc -O3 -fsanitize=thread -o baz baz.c
 */
#include <pthread.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define atomic_read(ptr)   __atomic_load_n(ptr, __ATOMIC_RELAXED)
#define atomic_set(ptr, i) __atomic_store_n(ptr, i, __ATOMIC_RELAXED)

#define N_ITER 1000000

struct entry {
	int written_by_all;
	int written_by_owner;
};

static struct entry entry;
static pthread_mutex_t lock;

void *owner_thread(void *arg)
{
	int i;

	for (i = 0; i < N_ITER; i++) {
		if (i % 2) {
			volatile int a __attribute__((unused));
			volatile int b __attribute__((unused));

			a = atomic_read(&entry.written_by_all);
			b = entry.written_by_owner;
		} else {
			pthread_mutex_lock(&lock);
			entry.written_by_all++;
			entry.written_by_owner++;
			pthread_mutex_unlock(&lock);
		}
	}
	return NULL;
}

void *other_thread(void *arg)
{
	int i;

	for (i = 0; i < N_ITER; i++) {
		pthread_mutex_lock(&lock);
		atomic_set(&entry.written_by_all, entry.written_by_all + 1);
		pthread_mutex_unlock(&lock);
	}
	return NULL;
}

int main(int argc, char *argv[])
{
	pthread_t threads[2];
	int i;

	pthread_mutex_init(&lock, NULL);
	if (pthread_create(&threads[0], NULL, owner_thread, NULL)) {
		exit(1);
	}
	if (pthread_create(&threads[1], NULL, other_thread, NULL)) {
		exit(1);
	}
	for (i = 0; i < 2; i++) {
		pthread_join(threads[i], NULL);
	}
	return 0;
}
