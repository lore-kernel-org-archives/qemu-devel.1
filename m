Received: from eggs.gnu.org ([2001:4830:134:3::10]:49619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1vS4-0005o6-4Q
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:24:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e1vRy-0001Lu-Gt
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:24:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e1vRy-0001LZ-B2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:24:02 -0400
Date: Tue, 10 Oct 2017 16:23:54 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171010162354.78381c3a.cohuck@redhat.com>
In-Reply-To: <20170928203708.9376-3-david@redhat.com>
References: <20170928203708.9376-1-david@redhat.com>
	<20170928203708.9376-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/30] s390x/tcg: cleanup service
 interrupt injection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <richard.henderson@linaro.org>

On Thu, 28 Sep 2017 22:36:40 +0200
David Hildenbrand <david@redhat.com> wrote:

> There are still some leftovers from old virtio interrupts in there.
> Most importantly, we don't have to queue service interrupts anymore.
> Just like KVM, we can simply multiplex the SCLP service interrupts and
> avoid the queue.
> 
> Also, now only valid parametes/cpu_addr will be stored on service

s/parametes/parameters/

> interrupts.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.c         |  2 --
>  target/s390x/cpu.h         | 10 +---------
>  target/s390x/excp_helper.c | 16 +++++-----------
>  target/s390x/internal.h    |  2 --
>  target/s390x/interrupt.c   | 18 ++++--------------
>  5 files changed, 10 insertions(+), 38 deletions(-)
> 

> diff --git a/target/s390x/interrupt.c b/target/s390x/interrupt.c
> index b9c30f86d7..cbc7b7696d 100644
> --- a/target/s390x/interrupt.c
> +++ b/target/s390x/interrupt.c
> @@ -54,22 +54,12 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen)
>  }
>  
>  #if !defined(CONFIG_USER_ONLY)
> -void cpu_inject_ext(S390CPU *cpu, uint32_t code, uint32_t param,
> -                    uint64_t param64)
> +static void cpu_inject_service(S390CPU *cpu, uint32_t param)
>  {
>      CPUS390XState *env = &cpu->env;
>  
> -    if (env->ext_index == MAX_EXT_QUEUE - 1) {
> -        /* ugh - can't queue anymore. Let's drop. */
> -        return;
> -    }
> -
> -    env->ext_index++;
> -    assert(env->ext_index < MAX_EXT_QUEUE);
> -
> -    env->ext_queue[env->ext_index].code = code;
> -    env->ext_queue[env->ext_index].param = param;
> -    env->ext_queue[env->ext_index].param64 = param64;
> +    /* multiplexing is good enough for sclp - also kvm does that internally */

"kvm does that internally as well"?

(Can fix while applying.)

> +    env->service_param |= param;
>  
>      env->pending_int |= INTERRUPT_EXT_SERVICE;
>      cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HARD);
> @@ -145,7 +135,7 @@ void s390_sclp_extint(uint32_t parm)
>      } else {
>          S390CPU *dummy_cpu = s390_cpu_addr2state(0);
>  
> -        cpu_inject_ext(dummy_cpu, EXT_SERVICE, parm, 0);
> +        cpu_inject_service(dummy_cpu, parm);
>      }
>  }
>  
