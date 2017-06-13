Received: from eggs.gnu.org ([2001:4830:134:3::10]:35665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dKmaD-0003Jg-EX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dKma9-0000rV-9U
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:14:13 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:36281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dKma9-0000qm-30
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:14:09 -0400
Received: by mail-wr0-x235.google.com with SMTP id 36so23632655wry.3
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 07:14:07 -0700 (PDT)
References: <1497351329-12936-1-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1497351329-12936-1-git-send-email-thuth@redhat.com>
Date: Tue, 13 Jun 2017 15:14:39 +0100
Message-ID: <87wp8ght4g.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/ppc/excp_helper: Take BQL before
 calling cpu_interrupt()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


Thomas Huth <thuth@redhat.com> writes:

> Since the introduction of MTTCG, using the msgsnd instruction
> abort()s if being called without holding the BQL. So let's protect
> that part of the code now with qemu_mutex_lock_iothread().
>
> Buglink: https://bugs.launchpad.net/qemu/+bug/1694998
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

p.s. I was checking the ppc code for other CPU_FOREACH patterns and I
noticed the tlb_flush calls could probably use the tlb_flush_all_cpus
API instead of manually looping themselves. You should also double check
the semantics to make sure none of them need to use the _synced variant
and a cpu_exit if the flush needs to complete w.r.t the originating CPU.

> ---
>  target/ppc/excp_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 9cb2123..3a9f086 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -17,6 +17,7 @@
>   * License along with this library; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/main-loop.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
> @@ -1132,6 +1133,7 @@ void helper_msgsnd(target_ulong rb)
>          return;
>      }
>
> +    qemu_mutex_lock_iothread();
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu = POWERPC_CPU(cs);
>          CPUPPCState *cenv = &cpu->env;
> @@ -1141,5 +1143,6 @@ void helper_msgsnd(target_ulong rb)
>              cpu_interrupt(cs, CPU_INTERRUPT_HARD);
>          }
>      }
> +    qemu_mutex_unlock_iothread();
>  }
>  #endif


--
Alex Bennée
