Received: from eggs.gnu.org ([2001:4830:134:3::10]:60583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1erKPe-0001gT-RY
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:22:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1erKPY-0002Z7-Hm
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 04:22:06 -0500
References: <20180228195320.165230-1-borntraeger@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <0d560e4e-6686-7801-6523-1bff7d035976@redhat.com>
Date: Thu, 1 Mar 2018 10:21:50 +0100
MIME-Version: 1.0
In-Reply-To: <20180228195320.165230-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] s390/kvm: implement clearing part of
 IPL clear
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>

On 28.02.2018 20:53, Christian Borntraeger wrote:
> When a guests reboots with diagnose 308 subcode 3 it requests the memor=
y
> to be cleared. We did not do it so far. This does not only violate the
> architecture, it also misses the chance to free up that memory on
> reboot, which would help on host memory over commitment.  By using
> ram_block_discard_range we can cover both cases.
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  target/s390x/kvm.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index 8f3a422288..2e145ad5c3 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -34,6 +34,8 @@
>  #include "qapi/error.h"
>  #include "qemu/error-report.h"
>  #include "qemu/timer.h"
> +#include "qemu/rcu_queue.h"
> +#include "sysemu/cpus.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/hw_accel.h"
>  #include "hw/boards.h"
> @@ -41,6 +43,7 @@
>  #include "sysemu/device_tree.h"
>  #include "exec/gdbstub.h"
>  #include "exec/address-spaces.h"
> +#include "exec/ram_addr.h"
>  #include "trace.h"
>  #include "qapi-event.h"
>  #include "hw/s390x/s390-pci-inst.h"
> @@ -1841,6 +1844,14 @@ static int kvm_arch_handle_debug_exit(S390CPU *c=
pu)
>      return ret;
>  }
> =20
> +static void release_all_rams(void)
> +{
> +    struct RAMBlock *rb;
> +
> +    QLIST_FOREACH_RCU(rb, &ram_list.blocks, next)
> +        ram_block_discard_range(rb, 0, rb->used_length);
> +}
> +
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  {
>      S390CPU *cpu =3D S390_CPU(cs);
> @@ -1853,6 +1864,14 @@ int kvm_arch_handle_exit(CPUState *cs, struct kv=
m_run *run)
>              ret =3D handle_intercept(cpu);
>              break;
>          case KVM_EXIT_S390_RESET:
> +            if (run->s390_reset_flags & KVM_S390_RESET_CLEAR) {
> +                /*
> +                 * We will stop other CPUs anyway, avoid spurious cras=
hes and
> +                 * get all CPUs out. The reset will take care of the r=
esume.
> +                 */
> +                pause_all_vcpus();
> +                release_all_rams();
> +            }

Hm, I have a patch lying around that tries to match pause/resume calls,
and only starts all CPUs again, once the last resume is called. (I
assume that there is the chance for a race between 2 callers of
pause/resume - you think it cannot happen, but as pause_all_vcpus() will
temporarily give up the qemu mutex, bad things can happen).

Can't we communicate that information to our ipl device and do the
clearing during the reset?

>              s390_reipl_request();
>              break;
>          case KVM_EXIT_S390_TSCH:
>=20


--=20

Thanks,

David / dhildenb
