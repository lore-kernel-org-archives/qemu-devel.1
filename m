Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fMV45-0002BO-Nj
	for qemu-devel@nongnu.org; Sat, 26 May 2018 05:00:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fMV41-0007ZA-S3
	for qemu-devel@nongnu.org; Sat, 26 May 2018 05:00:41 -0400
Received: from 8.mo3.mail-out.ovh.net ([87.98.172.249]:60603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fMV41-0007X5-Kt
	for qemu-devel@nongnu.org; Sat, 26 May 2018 05:00:37 -0400
Received: from player794.ha.ovh.net (unknown [10.109.108.89])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 02D2B1B7CF3
	for <qemu-devel@nongnu.org>; Sat, 26 May 2018 11:00:32 +0200 (CEST)
Date: Sat, 26 May 2018 11:00:21 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180526110021.31a80772@bahia.lan>
In-Reply-To: <a443ba0b-26cd-14c4-3768-412f7ea8fa53@redhat.com>
References: <152725285229.537901.6934923933763529191.stgit@bahia.lan>
	<a443ba0b-26cd-14c4-3768-412f7ea8fa53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: don't call KVM_PPC_CONFIGURE_V3_MMU
 if HPT is in userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>, qemu-stable@nongnu.org

On Fri, 25 May 2018 16:13:13 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> On 25/05/2018 14:54, Greg Kurz wrote:
> > Since the kernel commit "dbfcf3cb9c68 powerpc/64: Call H_REGISTER_PROC_TBL
> > when running as a HPT guest on POWER9", a nested guest running with PR KVM
> > hangs at boot:
> > 
> > Preparing to boot Linux version 4.16.0-kvm-pr-hang-gku+ (greg@qemu2222.boston16) (gcc version 8.1.1 20180502 (Red Hat 8.1.1-1) (GCC)) #19 SMP Fri May 25 08:41:55 CEST 2018
> > Detected machine type: 0000000000000101
> > command line: root=UUID=22128c5c-30b1-4e0a-ac16-95853df31131 ro rhgb console=hvc0 early_printk disable-radix=on
> > Max number of cores passed to firmware: 1024 (NR_CPUS = 1024)
> > Calling ibm,client-architecture-support... done
> > memory layout at init:
> >   memory_limit : 0000000000000000 (16 MB aligned)
> >   alloc_bottom : 0000000001b80000
> >   alloc_top    : 0000000030000000
> >   alloc_top_hi : 0000000100000000
> >   rmo_top      : 0000000030000000
> >   ram_top      : 0000000100000000
> > instantiating rtas at 0x000000002fff0000... done
> > prom_hold_cpus: skipped
> > copying OF device tree...
> > Building dt strings...
> > Building dt structure...
> > Device tree strings 0x0000000003d90000 -> 0x0000000003d90abb
> > Device tree struct  0x0000000003da0000 -> 0x0000000003db0000
> > Quiescing Open Firmware ...
> > Booting Linux via __start() @ 0x0000000000400000 ...
> > 
> > This happens because the H_REGISTER_PROC_TBL implementation in QEMU
> > always call KVM_PPC_CONFIGURE_V3_MMU when KVM is present. This fails
> > in the case of PR KVM, which doesn't implement it, and QEMU returns
> > H_PARAMETER to the guest, which is a BUG() condition in linux.
> > 
> > In the case of PR, the HPT is allocated in userspace by QEMU, so it
> > doesn't make sense to call KVM_PPC_CONFIGURE_V3_MMU in the first
> > place. So, skip it in this case and let the guest boot.
> > 
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> > 
> > Note that PR KVM requires this patch from Paul to work on POWER9:
> > 
> >     https://patchwork.ozlabs.org/patch/916766/
> > 
> > The original request was coming from people who want to run openQA in
> > fedora28 under PowerVM on a POWER9 system. This requires PR KVM, which
> > will be running in HPT-mode since pHyp doesn't do radix.
> > 
> > Cc'ing stable because fedora28 ships QEMU 2.11.x.
> > ---
> >  hw/ppc/spapr_hcall.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 022f6d810182..12cbb317e5e8 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -1420,7 +1420,7 @@ static target_ulong h_register_process_table(PowerPCCPU *cpu,
> >                    ((flags & FLAG_GTSE) ? LPCR_GTSE : 0),
> >                    LPCR_UPRT | LPCR_GTSE);
> >  
> > -    if (kvm_enabled()) {
> > +    if (kvm_enabled() && !spapr->htab) {
> >          return kvmppc_configure_v3_mmu(cpu, flags & FLAG_RADIX,
> >                                         flags & FLAG_GTSE, cproc);
> >      }
> >   
> 
> I'm wondering if you should use kvmppc_has_cap_mmu_hash_v3() instead?
> 

The meaning of KVM_CAP_PPC_HASH_MMU_V3 is basically: KVM supports POWER9
hash... even if that would *work* when using PR KVM, I'm not sure this
helps to understand.

The true reason for not calling kvmppc_configure_v3_mmu() is that we
already know that we're using a QEMU-side HPT.

> Thanks,
> Laurent

Cheers,

--
Greg
