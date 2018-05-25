Received: from eggs.gnu.org ([2001:4830:134:3::10]:44062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fMDXc-0000I4-M6
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fMDXY-0008Ga-NQ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:18:00 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45555)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fMDXY-0008G1-GJ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 10:17:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id w3-v6so2357315pgv.12
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 07:17:56 -0700 (PDT)
References: <20180525132755.21839-1-peter.maydell@linaro.org>
	<20180525132755.21839-5-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <decba0c5-91d8-57f4-762d-fe4bf584eea5@redhat.com>
Date: Fri, 25 May 2018 16:17:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180525132755.21839-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/6] target/i386/kvm.c: Handle renaming of
 KVM_HINTS_DEDICATED
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On 25/05/2018 15:27, Peter Maydell wrote:
> In kernel header commit 633711e8287, the define KVM_HINTS_DEDICATED
> was renamed to KVM_HINTS_REALTIME. Work around this compatibility
> break by (a) using the new constant name, and (b) defining it
> if the headers don't.
> 
> Part (b) can be removed once we've updated our copy of the kernel
> headers to a version that defines KVM_HINTS_REALTIME.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/i386/kvm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
> index 6511329d11..c2699f2f44 100644
> --- a/target/i386/kvm.c
> +++ b/target/i386/kvm.c
> @@ -48,6 +48,11 @@
>  #include "exec/memattrs.h"
>  #include "trace.h"
>  
> +/* Work around this kernel header constant changing its name */
> +#ifndef KVM_HINTS_REALTIME
> +#define KVM_HINTS_REALTIME KVM_HINTS_DEDICATED
> +#endif
> +
>  //#define DEBUG_KVM
>  
>  #ifdef DEBUG_KVM
> @@ -387,7 +392,7 @@ uint32_t kvm_arch_get_supported_cpuid(KVMState *s, uint32_t function,
>              ret &= ~(1U << KVM_FEATURE_PV_UNHALT);
>          }
>      } else if (function == KVM_CPUID_FEATURES && reg == R_EDX) {
> -        ret |= 1U << KVM_HINTS_DEDICATED;
> +        ret |= 1U << KVM_HINTS_REALTIME;
>          found = 1;
>      }
>  
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

I would be okay with squashing 4-6 too though.

Paolo
