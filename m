Received: from eggs.gnu.org ([2001:4830:134:3::10]:56973)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmd4r-0006b5-3V
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:44:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dmd4n-0003AM-VH
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:44:57 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34928)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dmd4n-0003A8-OX
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 05:44:53 -0400
Received: by mail-wm0-x244.google.com with SMTP id e204so402151wma.2
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 02:44:53 -0700 (PDT)
Date: Tue, 29 Aug 2017 10:44:50 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170829094450.GI25960@stefanha-x1.localdomain>
References: <20170828015654.2530-1-Sergio.G.DelReal@gmail.com>
	<20170828015654.2530-11-Sergio.G.DelReal@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170828015654.2530-11-Sergio.G.DelReal@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 10/14] hvf: refactor cpuid code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Aug 27, 2017 at 08:56:50PM -0500, Sergio Andres Gomez Del Real wrote:
> This commit adds code to request the cpuid features supported by the
> host and hvf; it calls hvf_get_supported_cpuid if hvf is compiled with
> QEMU and enabled.
> 
> Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
> ---
>  cpus.c                |   2 +
>  include/qom/cpu.h     |   6 +--
>  include/sysemu/hvf.h  |  18 ++++++---
>  target/i386/cpu-qom.h |   4 +-
>  target/i386/cpu.c     | 108 ++++++++++++++++++++++++++++++++++++++++----------
>  target/i386/hvf-all.c |  20 +++++-----
>  6 files changed, 113 insertions(+), 45 deletions(-)
> 
> diff --git a/cpus.c b/cpus.c
> index 6754ce17cc..2411dfcd3f 100644
> --- a/cpus.c
> +++ b/cpus.c
> @@ -37,7 +37,9 @@
>  #include "sysemu/hw_accel.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/hax.h"
> +#ifdef CONFIG_HVF
>  #include "sysemu/hvf.h"
> +#endif

Please avoid #ifdefs.  They are not necessary for kvm or hax.

>  #include "qmp-commands.h"
>  #include "exec/exec-all.h"
>  
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index c46eb61240..ef74c2ce3c 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -408,13 +408,9 @@ struct CPUState {
>       */
>      uint16_t pending_tlb_flush;
>  
> -    // HVF
>      bool hvf_vcpu_dirty;
>      uint64_t hvf_fd; // fd of vcpu created by HVF
> -    // Supporting data structures for VMCS capabilities
> -    // and x86 emulation state
> -    struct hvf_vcpu_caps* hvf_caps;
> -    struct hvf_x86_state* hvf_x86;
> +    struct hvf_x86_state *hvf_x86;

Please squash this with the change that adds these fields.  Patch series
should avoid "code churn" where code is added and then changed again in
the same patch series.  Arrange the patch series in a logical order and
squash down commits using git-rebase -i so new code is introduced in its
final state.  This makes review easier and the git commit history
cleaner (i.e. easier to bisect, backport, and use git-blame(1)).

There are more instances of code churn below.
