Received: from eggs.gnu.org ([2001:4830:134:3::10]:33103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1ciNcD-0006Ky-2i
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:53:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1ciNc8-0001hM-97
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:53:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1ciNc8-0001h6-0D
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:53:28 -0500
Date: Mon, 27 Feb 2017 16:53:24 +0100
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170227155324.GC5816@redhat.com>
References: <20170224172714.26026-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170224172714.26026-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] os: don't corrupt pre-existing
 memory-backend data with prealloc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Jitendra Kolhe <jitendra.kolhe@hpe.com>, Michal Privoznik <mprivozn@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

Hello,

On Fri, Feb 24, 2017 at 05:27:14PM +0000, Daniel P. Berrange wrote:
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 35012b9..2a5bb93 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -355,7 +355,20 @@ void os_mem_prealloc(int fd, char *area, size_t memory, Error **errp)
>  
>          /* MAP_POPULATE silently ignores failures */
>          for (i = 0; i < numpages; i++) {
> -            memset(area + (hpagesize * i), 0, 1);
> +            /*
> +             * Read & write back the same value, so we don't
> +             * corrupt existinng user/app data that might be
> +             * stored.
> +             *
> +             * 'volatile' to stop compiler optimizing this away
> +             * to a no-op
> +             *
> +             * TODO: get a better solution from kernel so we
> +             * don't need to write at all so we don't cause
> +             * wear on the storage backing the region...
> +             */

It would be better that if MAP_POPULATE failed like mlock does, at
least for those get_user_pages errors like -ENOMEM that are already a
retval for mmap it sounds weird that it's not being forwarded. It'd be
enough to call do_munmap to rollback all mmap work before returning
-ENOMEM from mmap instead of succees.

-EFAULT or other get_user_pages errors are more troublesome, as mmap
wouldn't otherwise return -EFAULT, but those would generally be qemu
bugs or hardware errors and MAP_POPULATE I doubt is meant to be a
debug/robustness aid.  All we care about here is memory resource
management and not to risk -ENOMEM at runtime and immediate peak
performance. So perhaps a kernel patch that forwards -ENOMEM from
__mm_populate to mmap retval would be enough to make it usable?

> +            volatile char val = *(area + (hpagesize * i));
> +            *(area + (hpagesize * i)) = val;

It's not "var" that should be volatile, nor the pointer, but only the
memory area you write to, because the write to the memory are is the
only thing we care about.

If "val" is volatile gcc could read the memory area and cache the
value of the memory area, write it into the volatile var, then read
the volatile var again, compare it with the cached value and skip the
write to the memory if it's equal. In practice it's likely not doing
that, and making var volatile has the same effect, so it's probably
only a theoretical issue of course.

I would suggest this to correct it (untested):

	char *tmparea = area + (hpagesize * i);
	*(volatile char *)tmparea = *tmparea;

Thanks,
Andrea
