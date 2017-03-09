Received: from eggs.gnu.org ([2001:4830:134:3::10]:36342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm19d-0004ao-UE
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm19X-0000WG-U0
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:43:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm19X-0000Vm-ME
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:42:59 -0500
References: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3352a566-4e04-01e7-722a-7f154d2156fc@redhat.com>
Date: Thu, 9 Mar 2017 17:42:57 +0100
MIME-Version: 1.0
In-Reply-To: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH/RFC] exec: add cpu_synchronize_state to
 cpu_memory_rw_debug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>



On 07/03/2017 15:19, Christian Borntraeger wrote:
> I sometimes got "Cannot access memory" when using the x command
> on the monitor. Turns out that the cpu env did contain stale data
> (e.g. wrong control register content for page table origin).
> We must synchronize the state of the CPU before walking the page
> tables. A similar issues happens for a remote gdb, so lets
> do the cpu_synchronize_state in cpu_memory_rw_debug.

Makes sense (the bit missing from the commit message, at least the one
that I had to look up, is that cpu_memory_rw_debug takes virtual addresses).

Paolo

> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  exec.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index aabb035..e754a03 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -43,6 +43,7 @@
>  #include "exec/ioport.h"
>  #include "sysemu/dma.h"
>  #include "sysemu/numa.h"
> +#include "sysemu/hw_accel.h"
>  #include "exec/address-spaces.h"
>  #include "sysemu/xen-mapcache.h"
>  #include "trace-root.h"
> @@ -3309,6 +3310,7 @@ int cpu_memory_rw_debug(CPUState *cpu, target_ulong addr,
>      hwaddr phys_addr;
>      target_ulong page;
>  
> +    cpu_synchronize_state(cpu);
>      while (len > 0) {
>          int asidx;
>          MemTxAttrs attrs;
> 
