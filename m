Received: from eggs.gnu.org ([2001:4830:134:3::10]:59024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyp32-0001b8-BJ
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 21:29:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1eyp2x-0001PK-Dl
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 21:29:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52957)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1eyp2x-0001Og-7H
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 21:29:39 -0400
Date: Wed, 21 Mar 2018 21:29:37 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20180322012937.GB16453@flamenco>
References: <20180309132922.24211-1-pbonzini@redhat.com>
	<20180309132922.24211-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309132922.24211-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] membarrier: add --enable-membarrier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Mar 09, 2018 at 14:29:22 +0100, Paolo Bonzini wrote:
> Actually enable the global memory barriers if supported by the OS.
> Because only recent versions of Linux include the support, they
> are disabled by default.  Note that it also has to be disabled
> for QEMU to run under Wine.
> 
> Before this patch, rcutorture reports 85 ns/read for my machine,
> after the patch it reports 12.5 ns/read.  On the other hand updates
> go from 50 *micro*seconds to 20 *milli*seconds.

It is indeed hard to see a large impact on performance given the
large size of our critical sections. But hey, rcu_read_unlock
goes down from 0.24% to 0.08% of execution time when booting
aarch64 linux!

As we remove bottlenecks though we should be able to gain
more benefits from this, at least in MTTCG where vcpu threads
exit the execution loop quite often.

I did some tests on qht-bench, moving the rcu_read_lock/unlock
pair to wrap each lookup instead of wrapping the entire test.
The results are great; without membarrier lookup throughput
goes down by half; with it, throughput only goes down by 5%.

(snip)
> +##########################################
> +# check for usable membarrier system call
> +if test "$membarrier" = "yes"; then
> +    have_membarrier=no
> +    if test "$mingw32" = "yes" ; then
> +        have_membarrier=yes
> +    elif test "$linux" = "yes" ; then
> +        cat > $TMPC << EOF
> +    #include <linux/membarrier.h>
> +    #include <sys/syscall.h>
> +    #include <unistd.h>
> +    int main(void) {
> +        syscall(__NR_membarrier, MEMBARRIER_CMD_QUERY, 0);
> +        syscall(__NR_membarrier, MEMBARRIER_CMD_SHARED, 0);
> +    }

I think we should also check here that MEMBARRIER_CMD_SHARED is
actually supported; it is possible for a kernel to have
the system call yet not support it (e.g. when the
kernel is compiled with nohz_full). Instead of failing at run-time
(in smp_mb_global_init) we should perhaps bark at configure time
as well.

Other than that the patches look good. Thanks for doing this!

		Emilio
