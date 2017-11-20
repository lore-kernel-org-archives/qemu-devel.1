Received: from eggs.gnu.org ([2001:4830:134:3::10]:37906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGlhL-0002Gc-9n
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:01:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eGlhC-0004tf-27
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:01:15 -0500
Date: Mon, 20 Nov 2017 14:00:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171120140052.48c7f646.cohuck@redhat.com>
In-Reply-To: <20171120123525.147663-3-borntraeger@de.ibm.com>
References: <20171120123525.147663-1-borntraeger@de.ibm.com>
	<20171120123525.147663-3-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] s390x/kvm: use valgrind annotations
 for kvm device attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On Mon, 20 Nov 2017 13:35:25 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> the KVM_GET/SET_DEVICE_ATTR calls have non-self-describing
> side effects. Use valgrind annotations to properly mark
> all storage changes instead of using memset or designated
> initializers.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-skeys-kvm.c    | 12 ++++++++++-
>  hw/s390x/s390-stattrib-kvm.c |  7 ++++++
>  target/s390x/kvm.c           | 51 ++++++++++++++++++++++++++++++++++++++++----
>  3 files changed, 65 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/s390x/s390-skeys-kvm.c b/hw/s390x/s390-skeys-kvm.c
> index dc54ed8..0986795 100644
> --- a/hw/s390x/s390-skeys-kvm.c
> +++ b/hw/s390x/s390-skeys-kvm.c
> @@ -13,6 +13,9 @@
>  #include "hw/s390x/storage-keys.h"
>  #include "sysemu/kvm.h"
>  #include "qemu/error-report.h"
> +#ifdef CONFIG_VALGRIND_H
> +#include <valgrind/memcheck.h>
> +#endif
>  
>  static int kvm_s390_skeys_enabled(S390SKeysState *ss)
>  {
> @@ -35,8 +38,15 @@ static int kvm_s390_skeys_get(S390SKeysState *ss, uint64_t start_gfn,
>          .count = count,
>          .skeydata_addr = (__u64)keys
>      };
> +    int ret;
>  
> -    return kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
> +    ret = kvm_vm_ioctl(kvm_state, KVM_S390_GET_SKEYS, &args);
> +    if (!ret) {
> +#ifdef CONFIG_VALGRIND_H
> +        VALGRIND_MAKE_MEM_DEFINED(keys, count);
> +#endif

This looks ugly :(

Is s390x the only one hitting those side effects? If we need to
sprinkle those all over the source code, it improves valgrind results
but makes the code harder to read...

(And no, I don't have a better idea.)

> +    }
> +    return ret;
>  }
