Received: from eggs.gnu.org ([2001:4830:134:3::10]:40547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clH9B-0007aj-GE
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:35:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clH97-0000OA-IY
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:35:33 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:33515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clH97-0000Nr-Bw
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:35:29 -0500
Received: by mail-wm0-x22e.google.com with SMTP id v203so10963299wmg.0
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 07:35:29 -0800 (PST)
References: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1488896348-13560-1-git-send-email-borntraeger@de.ibm.com>
Date: Tue, 07 Mar 2017 15:35:36 +0000
Message-ID: <878tohhzg7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>


Christian Borntraeger <borntraeger@de.ibm.com> writes:

> I sometimes got "Cannot access memory" when using the x command
> on the monitor. Turns out that the cpu env did contain stale data
> (e.g. wrong control register content for page table origin).
> We must synchronize the state of the CPU before walking the page
> tables. A similar issues happens for a remote gdb, so lets
> do the cpu_synchronize_state in cpu_memory_rw_debug.
>
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

This seems like the wrong place to put it. Would we end up doing a
potentially expensive sync operations for every byte/word we dump out?

Certainly when I was messing around with ARM KVM debug I did the
synchronise state as we entered the debug handling (e.g.
gdb_handle_packet/memory_dump)?

--
Alex Bennée
