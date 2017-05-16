Received: from eggs.gnu.org ([2001:4830:134:3::10]:36520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAbCo-0006Ha-Gd
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:03:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dAbCk-0000ik-4J
	for qemu-devel@nongnu.org; Tue, 16 May 2017 08:03:58 -0400
References: <20170426070034.10727-1-david@gibson.dropbear.id.au>
	<20170426070034.10727-20-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <0b2e2d1c-d7ba-7d43-42b5-04ba592bf3e8@redhat.com>
Date: Tue, 16 May 2017 14:03:31 +0200
MIME-Version: 1.0
In-Reply-To: <20170426070034.10727-20-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 19/48] spapr: allocate the ICPState object
 from under sPAPRCPUCore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: clg@kaod.org
Cc: David Gibson <david@gibson.dropbear.id.au>, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, qemu-ppc@nongnu.org

On 26/04/2017 09:00, David Gibson wrote:
> From: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> Today, all the ICPs are created before the CPUs, stored in an array
> under the sPAPR machine and linked to the CPU when the core threads
> are realized. This modeling brings some complexity when a lookup in
> the array is required and it can be simplified by allocating the ICPs
> when the CPUs are.
>=20
> This is the purpose of this proposal which introduces a new 'icp_type'
> field under the machine and creates the ICP objects of the right type
> (KVM or not) before the PowerPCCPU object are.
>=20
> This change allows more cleanups : the removal of the icps array under
> the sPAPR machine and the removal of the xics_get_cpu_index_by_dt_id()
> helper.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/intc/xics.c          | 11 -----------
>  hw/ppc/spapr.c          | 47 ++++++++++++++---------------------------=
------
>  hw/ppc/spapr_cpu_core.c | 18 ++++++++++++++----
>  include/hw/ppc/spapr.h  |  2 +-
>  include/hw/ppc/xics.h   |  2 --
>  5 files changed, 29 insertions(+), 51 deletions(-)
>=20

This commit breaks CPU re-hotplugging with KVM

the sequence "device_add, device_del, device_add" brings to the
following error message:

    Unable to connect CPUx to kernel XICS: Device or resource busy

It comes from icp_kvm_cpu_setup():

...
    ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_fd,
                              kvm_arch_vcpu_id(cs));
    if (ret < 0) {
        error_report("Unable to connect CPU%ld to kernel XICS: %s",
                     kvm_arch_vcpu_id(cs), strerror(errno));
        exit(1);
    }
..

It should be protected by cap_irq_xics_enabled:

...
    /*
     * If we are reusing a parked vCPU fd corresponding to the CPU
     * which was hot-removed earlier we don't have to renable
     * KVM_CAP_IRQ_XICS capability again.
     */
    if (icp->cap_irq_xics_enabled) {
        return;
    }
...
    ret =3D kvm_vcpu_enable_cap(...);
...
    icp->cap_irq_xics_enabled =3D true;
...

But since this commit, "icp" is a new object on each call:

spapr_cpu_core_realize_child()
...
    obj =3D object_new(spapr->icp_type);
...
    xics_cpu_setup(XICS_FABRIC(spapr), cpu, ICP(obj));
    ...
            icpc->cpu_setup(icp, cpu); -> icp_kvm_cpu_setup()
    ...
...

and "cap_irq_xics_enabled" is reinitialized.

Any idea how to fix that?

Thanks,
Laurent
