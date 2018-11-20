Received: from eggs.gnu.org ([2001:4830:134:3::10]:45183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP6HC-000199-3h
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:41:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gP6H7-0007nS-R4
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:41:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gP6H7-0007lg-GS
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 08:41:09 -0500
Date: Tue, 20 Nov 2018 11:41:06 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181120134106.GH4755@habkost.net>
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<20180921082217.29481-4-rkagan@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921082217.29481-4-rkagan@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH 03/10] hyperv: only add SynIC in compatible
 configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>

On Fri, Sep 21, 2018 at 11:22:10AM +0300, Roman Kagan wrote:
> Certain configurations do not allow SynIC to be used in QEMU.  In
> particular,
> 
> - when hyperv_vpindex is off, SINT routes can't be used as they refer to
>   the destination vCPU by vp_index
> 
> - older KVM (which doesn't expose KVM_CAP_HYPERV_SYNIC2) zeroes out
>   SynIC message and event pages on every msr load, breaking migration
> 
> OTOH in-KVM users of SynIC -- SynIC timers -- do work in those
> configurations, and we shouldn't stop the guest from using them.
> 
> To cover both scenarios, introduce an X86CPU property that makes CPU
> init code to skip creation of the SynIC object (and thus disables any
> SynIC use in QEMU) but keeps the KVM part of the SynIC working.
> The property is clear by default but is set via compat logic for older
> machine types.
> 
> As a result, when hv_synic and a modern machine type are specified, QEMU
> will refuse to run unless vp_index is on and the kernel is recent
> enough.  OTOH with an older machine type QEMU will run fine with
> hv_synic=on against an older kernel and/or without vp_index enabled but
> will disallow the in-QEMU uses of SynIC (in e.g. VMBus).
> 
> Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> ---
>  include/hw/i386/pc.h |  8 ++++++++
>  target/i386/cpu.h    |  1 +
>  target/i386/cpu.c    |  2 ++
>  target/i386/kvm.c    | 30 ++++++++++++++++++++++--------
>  4 files changed, 33 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index 6894f37df1..dfe6746692 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -294,6 +294,14 @@ int e820_add_entry(uint64_t, uint64_t, uint32_t);
>  int e820_get_num_entries(void);
>  bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
>  
> +#define PC_COMPAT_3_0 \
> +    HW_COMPAT_3_0 \
> +    {\
> +        .driver   = TYPE_X86_CPU,\
> +        .property = "x-hv-synic-kvm-only",\
> +        .value    = "on",\
> +    }

Oops.  This macro does nothing if the 3.1 machine-types aren't
updated to use it.  This patch breaks compatibility on pc-*-3.1.

> [...]

-- 
Eduardo
