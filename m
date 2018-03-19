Received: from eggs.gnu.org ([2001:4830:134:3::10]:40620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exxIC-0004SM-LS
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exxI2-0001Kh-W0
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:05:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32934 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1exxI2-0001KD-QQ
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 12:05:38 -0400
Date: Mon, 19 Mar 2018 17:05:25 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180319170525.1016391d@igors-macbook-pro.local>
In-Reply-To: <1521450289-5005-1-git-send-email-chao.qin@linux.intel.com>
References: <1521450289-5005-1-git-send-email-chao.qin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hax: Properly handle IA32_APIC_BASE MSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: chao.qin@linux.intel.com
Cc: qemu-devel@nongnu.org, yu.ning@linux.intel.com, Qin Chao <chao.qin@intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Mon, 19 Mar 2018 17:04:49 +0800
chao.qin@linux.intel.com wrote:

> From: Qin Chao <chao.qin@intel.com>
> 
> Emulation of IA32_APIC_BASE MSR in HAXM is not correct, such as bit
> 8, which is BSP flag and should be set to 1 for the bootstrap
> processor and set to 0 for the application processors, but it's set
> to 0 for all processors in HAXM. So guest OSes that expect a valid
> BSP flag, such as Zircon (the core of Google Fuchsia OS), cannot
> boot with "-accel hax". To solve this problem, HAXM (which lacks
> APIC virtualization) and QEMU must notify each other of any change
> to guest IA32_APIC_BASE MSR. The HAXM patch has been merged into
> HAXM source. QEMU needs to use the new HAXM API (apic_base in
> "struct hax_tunnel") to initialize the guest IA32_APIC_BASE MSR,
> and then, update its own copy at every return from
> HAX_VCPU_IOCTL_RUN.
> 
> There will be a backward compatility issue caused by the new field
> "apic_base" added into "struct hax_tunnel". In order to fix the
> problem, the validation for size of "struct hax_tunnel" is removed
> and a new capability flag "HAX_CAP_TUNNEL_PAGE" is added, which
> means that one page (4KB) is allocated in HAXM kernel to store
> "struct hax_tunnel", instead of the size of "struct hax_tunnel".
> 
> Change-Id: I8505bc1d75c495dd2765e581d6014125dcb538f3
> Signed-off-by: Qin Chao <chao.qin@intel.com>
> ---
>  target/i386/hax-all.c       | 24 +++++++++++++++++++-----
>  target/i386/hax-darwin.c    |  6 ------
>  target/i386/hax-i386.h      |  2 +-
>  target/i386/hax-interface.h |  3 +++
>  target/i386/hax-windows.c   |  5 -----
>  5 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
> index cad7531..6a840d9 100644
> --- a/target/i386/hax-all.c
> +++ b/target/i386/hax-all.c
[...]
> @@ -933,6 +944,9 @@ static int hax_set_msrs(CPUArchState *env)
>      hax_msr_entry_set(&msrs[n++], MSR_FMASK, env->fmask);
>      hax_msr_entry_set(&msrs[n++], MSR_KERNELGSBASE, env->kernelgsbase);
>  #endif
> +    hax_msr_entry_set(&msrs[n++], MSR_IA32_APICBASE, \
> +                      cpu_get_apic_base(x86_env_get_cpu(env)->apic_state));
> +
>      md.nr_msr = n;
>      md.done = 0;
Does it work for you if you drop everything except of this chunk?

There is no much point in syncing BPS flag from HAXM since Seabios
nor OVMF do not implement BSP selection protocol, it's
hard-coded in QEMU that BSP is the first CPU.

Considering that typically no sane OS does change MSR_IA32_APICBASE
there is no need to sync it back to QEMU.
So no need to introduce all that complexity for no gain.

[...]
