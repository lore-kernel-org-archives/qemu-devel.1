Received: from eggs.gnu.org ([2001:4830:134:3::10]:56610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIjBL-0007uv-6N
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:12:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dIjBG-00055Q-8m
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:12:03 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54109)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dIjBF-000555-NC
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:11:58 -0400
Date: Wed, 7 Jun 2017 18:11:56 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20170607221156.GA25936@flamenco>
References: <20170607155536.1193-1-rth@twiddle.net>
	<20170607155536.1193-2-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170607155536.1193-2-rth@twiddle.net>
Subject: Re: [Qemu-devel] [PATCH v4 1/7] util: add cacheinfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org

On Wed, Jun 07, 2017 at 08:55:30 -0700, Richard Henderson wrote:
(snip)
> +#elif defined(__APPLE__) \
> +      || defined(__FreeBSD__) || defined(__FreeBSD_kernel__)
> +# include <sys/sysctl.h>
> +# if defined(__APPLE__)
> +#  define SYSCTL_CACHELINE_NAME "hw.cachelinesize"
> +# else
> +#  define SYSCTL_CACHELINE_NAME "machdep.cacheline_size"
> +# endif
> +
> +static void sys_cache_info(void)
> +{
> +    /* There's only a single sysctl for both I/D cache line sizes.  */
> +    size_t len = sizeof(qemu_icache_linesize);
> +    if (!sysctlbyname(SYSCTL_CACHELINE_NAME, &qemu_icache_linesize,
> +                      &len, NULL, 0)) {
> +        qemu_dcache_linesize = qemu_icache_linesize;
> +    }
> +}

This doesn't work on the MacOS (Darwin 16.6.0) I have access to.

If we do
	long size; // <-- type here matters!
	size_t len = sizeof(size);
	sysctlbyname(..., &size, &len, ...);
then size == 64.

However, if instead of 'long size' we have 'int size' (as in the patch),
then  'size == 1' yet sysctlbyname still returns 0. (!)
This is why I was using an intermediate long in my previous patch,
although obviously a comment there would have been appropriate.

FWIW, if we query what length sysctlbyname expects for this param (by
calling sysctlbyname(NAME, NULL, &size, NULL, 0), we get len == 8;
I presume on both 32 and 64-bit systems passing a long will work
OK here.

		E.
