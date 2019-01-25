Received: from eggs.gnu.org ([209.51.188.92]:48341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmxht-0002GE-2q
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gmxhp-0000J4-JB
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 04:23:24 -0500
Date: Fri, 25 Jan 2019 10:23:05 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190125102305.76f1bc71.cohuck@redhat.com>
In-Reply-To: <1548349076-350255-1-git-send-email-imammedo@redhat.com>
References: <1548349076-350255-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: remove direct reference to mem_path
 global form s90x code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org

On Thu, 24 Jan 2019 17:57:56 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> I plan to deprecate -mem-path option and replace it with memory-backend,
> for that it's necessary to get rid of mem_path global variable.
> Do it for s390x case, replacing it with alternative way to enable
> 1Mb hugepages capability.

Getting rid of accessing mem_path directly sounds good.

> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> PS:
> Original code nor the new one probably is not entirely correct when
> huge pages are enabled in case where mixed initial RAM and memory
> backends are used, backend's page size might not match initial RAM's
> so I'm not sure if enabling 1MB cap is correct in this case on s390
> (should it be the same for all RAM???).
> With new approach 1Mb cap is not enabled if the smallest page size
> is not 1Mb.
> ---
>  target/s390x/kvm.c | 37 ++++++++++++++++---------------------
>  1 file changed, 16 insertions(+), 21 deletions(-)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 2ebf26a..22e868a 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -285,33 +285,28 @@ void kvm_s390_crypto_reset(void)
>      }
>  }
>  
> -static int kvm_s390_configure_mempath_backing(KVMState *s)
> +static int kvm_s390_configure_hugepage_backing(KVMState *s)
>  {
> -    size_t path_psize = qemu_mempath_getpagesize(mem_path);
> +    size_t psize = qemu_getrampagesize();
>  
> -    if (path_psize == 4 * KiB) {
> -        return 0;
> -    }
> -
> -    if (!hpage_1m_allowed()) {
> -        error_report("This QEMU machine does not support huge page "
> -                     "mappings");
> -        return -EINVAL;
> -    }
> +    if (psize == 1 * MiB) {
> +        if (!hpage_1m_allowed()) {
> +            error_report("This QEMU machine does not support huge page "
> +                         "mappings");
> +            return -EINVAL;
> +        }
>  
> -    if (path_psize != 1 * MiB) {
> +        if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
> +            error_report("Memory backing with 1M pages was specified, "
> +                         "but KVM does not support this memory backing");
> +            return -EINVAL;
> +        }
> +        cap_hpage_1m = 1;
> +    } else if (psize == 2 * GiB) {
>          error_report("Memory backing with 2G pages was specified, "
>                       "but KVM does not support this memory backing");
>          return -EINVAL;
>      }
> -
> -    if (kvm_vm_enable_cap(s, KVM_CAP_S390_HPAGE_1M, 0)) {
> -        error_report("Memory backing with 1M pages was specified, "
> -                     "but KVM does not support this memory backing");
> -        return -EINVAL;
> -    }
> -
> -    cap_hpage_1m = 1;
>      return 0;

Just to compare, the old code did:
- 4K pages -> all fine, do nothing
- 1MB pages not allowed -> get out, regardless of the actual huge page
  size
- 1MB pages -> try to enable, if possible
- all other sizes -> moan about 2G pages and get out

And the new code does:
- 1M pages -> get out if 1MB not allowed, otherwise try to enable
- 2G pages -> moan about 2G pages and get out
- all other sizes -> all fine, do nothing

So, now the user will:
- get a different error if they try to run with a 2G backing but
  hpage_1m_allowed is off (which does not sound like a problem to me)
- get the all-clear if they specified a hypothetical different page
  size, while the code always complained about 2G pages before

Are there any chances at all that there may Yet Another Size? If not,
this looks fine.

>  }
>  
> @@ -319,7 +314,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> -    if (mem_path && kvm_s390_configure_mempath_backing(s)) {
> +    if (kvm_s390_configure_hugepage_backing(s)) {
>          return -EINVAL;
>      }
>  
