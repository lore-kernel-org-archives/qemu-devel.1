Received: from eggs.gnu.org ([2001:4830:134:3::10]:34542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eeeg1-0001FN-9X
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:22:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eeefv-0004gd-JM
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:22:37 -0500
Date: Thu, 25 Jan 2018 11:22:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180125112223.77261b78.cohuck@redhat.com>
In-Reply-To: <20180117174047.6382-8-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
	<20180117174047.6382-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 07/18] s390x/tcg: tolerate wrong wakeups
 due to floating interrupts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Wed, 17 Jan 2018 18:40:36 +0100
David Hildenbrand <david@redhat.com> wrote:

> This is a prparation for floating interrupt support and only applies to

s/prparation/preparation/

(can fix while applying)

> MTTCG, single threaded TCG works just fine. If a floating interrupt wakes
> up a VCPU and the CPU thinks it can run (clearing cs->halted), at
> the point where the interrupt would be delivered, already another VCPU
> might have picked up the interrupt, resulting in a wakeup without an
> interrupt (executing wrong code).
> 
> It is wrong to let the VCPU continue to execute (the WAIT PSW). Instead,
> we have to put the VCPU back to sleep.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/excp_helper.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index a18842ccbd..eeffb49f63 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -503,6 +503,11 @@ bool s390_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
>              s390_cpu_do_interrupt(cs);
>              return true;
>          }
> +        if (env->psw.mask & PSW_MASK_WAIT) {
> +            /* Woken up because of a floating interrupt but it has already
> +             * been delivered. Go back to sleep. */
> +            cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
> +        }
>      }
>      return false;
>  }
