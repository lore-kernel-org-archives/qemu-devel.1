Received: from eggs.gnu.org ([2001:4830:134:3::10]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpEt8-00051B-Cw
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 09:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cpEt7-0004uN-B3
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 09:59:22 -0400
Received: from mail-wr0-x231.google.com ([2a00:1450:400c:c0c::231]:33941)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cpEt7-0004t3-3G
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 09:59:21 -0400
Received: by mail-wr0-x231.google.com with SMTP id l37so67486220wrc.1
	for <qemu-devel@nongnu.org>; Sat, 18 Mar 2017 06:59:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1489508300-48184-4-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
	<1489508300-48184-4-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Mar 2017 13:58:57 +0000
Message-ID: <CAFEAcA95AnRfZ+m01a-trDP_RwdRjeiGX0xJ4BczuWzMpdyWsw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 03/18] mem-prealloc: reduce large guest
 start-up and migration time.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jitendra Kolhe <jitendra.kolhe@hpe.com>

On 14 March 2017 at 16:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
> From: Jitendra Kolhe <jitendra.kolhe@hpe.com>
>
> Using "-mem-prealloc" option for a large guest leads to higher guest
> start-up and migration time. This is because with "-mem-prealloc" option
> qemu tries to map every guest page (create address translations), and
> make sure the pages are available during runtime. virsh/libvirt by
> default, seems to use "-mem-prealloc" option in case the guest is
> configured to use huge pages. The patch tries to map all guest pages
> simultaneously by spawning multiple threads. Currently limiting the
> change to QEMU library functions on POSIX compliant host only, as we are
> not sure if the problem exists on win32. Below are some stats with
> "-mem-prealloc" option for guest configured to use huge pages.

> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -55,6 +55,21 @@
>  #include "qemu/error-report.h"
>  #endif
>
> +#define MAX_MEM_PREALLOC_THREAD_COUNT (MIN(sysconf(_SC_NPROCESSORS_ONLN), 16))

sysconf() can fail, in which case it will return -1...

> +static bool touch_all_pages(char *area, size_t hpagesize, size_t numpages,
> +                            int smp_cpus)
> +{
> +    uint64_t numpages_per_thread, size_per_thread;
> +    char *addr = area;
> +    int i = 0;
> +
> +    memset_thread_failed = false;
> +    memset_num_threads = MIN(smp_cpus, MAX_MEM_PREALLOC_THREAD_COUNT);

...and memset_num_threads (being signed) will also end up -1 here...

> +    memset_thread = g_new0(MemsetThread, memset_num_threads);

...which we then pass to g_new0(), which will not have good
results.

(Spotted by Coverity, CID 1372465.)

Hiding a sysconf() behind a macro that looks like it's going
to be a constant integer is a bit confusing, incidentally,
and we only use it in one place. I'd just have a memset_num_threads()
function which calls sysconf and determines the right number from
that and smp_cpus and 16, and handles sysconf failing gracefully.

thanks
-- PMM
