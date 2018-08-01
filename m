Received: from eggs.gnu.org ([2001:4830:134:3::10]:37317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkpKm-0006Vk-9N
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fkpKh-0000Lj-W6
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:30:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39648 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fkpKh-0000LP-Iv
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 07:30:23 -0400
Reply-To: thuth@redhat.com
References: <20180731120908.9202-1-frankja@linux.ibm.com>
	<20180731120908.9202-3-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d527b326-5ebd-ad1b-46a2-a6b175bd3202@redhat.com>
Date: Wed, 1 Aug 2018 13:30:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180731120908.9202-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] s390x: Enable KVM huge page backing
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com

On 07/31/2018 02:09 PM, Janosch Frank wrote:
> QEMU has had huge page support for a longer time already, but KVM
> memory management under s390x needed some changes to work with huge
> backings.
> 
> Now that we have support, let's enable it if requested and
> available. Otherwise we now properly tell the user if there is no
> support and back out instead of failing to run the VM later on.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  target/s390x/kvm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index d923cf4240..f961c3b84a 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -34,6 +34,7 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/mmap-alloc.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/hw.h"
> @@ -285,6 +286,20 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
> +    if (mem_path) {
> +        if (qemu_mempath_getpagesize(mem_path) != (1 << 20)) {
> +            error_report("Huge page backing with pages > 1M was specified, "
> +                         "but KVM does not support this memory backing");
> +            return -EINVAL;

I think you should use ">" instead of "!=" here. It does not make much
too much sense, but it is still possible that the user specifies a
mem_path with 4k, and you don't want to trigger the error message here
(try something like qemu-system-s390x -mem-path /tmp/... for example).

 Thomas
