Received: from eggs.gnu.org ([2001:4830:134:3::10]:57118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d7oPG-0002H3-H3
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d7oPC-00034P-KA
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:33:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d7oPC-00034E-BQ
	for qemu-devel@nongnu.org; Mon, 08 May 2017 15:33:14 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v48JORCm052117
	for <qemu-devel@nongnu.org>; Mon, 8 May 2017 15:33:12 -0400
Received: from e24smtp05.br.ibm.com (e24smtp05.br.ibm.com [32.104.18.26])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2aaky6g6ee-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 08 May 2017 15:33:11 -0400
Received: from localhost
	by e24smtp05.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Mon, 8 May 2017 16:33:09 -0300
Date: Mon, 8 May 2017 16:32:59 -0300
From: joserz@linux.vnet.ibm.com
References: <20170508091858.GA27774@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170508091858.GA27774@in.ibm.com>
Message-Id: <20170508193259.GA22292@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] ppc/spapr: Radix guest causing host
 kernel oops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, rnsastry@linux.vnet.ibm.com, qemu-ppc@nongnu.org, sam.bobroff@au1.ibm.com, david@gibson.dropbear.id.au

On Mon, May 08, 2017 at 02:48:58PM +0530, Bharata B Rao wrote:
> Hi,
> 
> With ppc-for-2.10 branch of dwg's tree, starting a radix guest is currently
> causing a host kernel oops like this:
> 
> Unable to handle kernel paging request for data at address 0xe64bb17da64ab078
> Faulting instruction address: 0xc0000000002c3ddc
> Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=1024
> NUMA
> PowerNV
> task: c0000003bfb8b880 task.stack: c0000003c215c000
> NIP: c0000000002c3ddc LR: c0000000002c3e80 CTR: c0000000000ce2e0
> REGS: c0000003c215f150 TRAP: 0380   Not tainted  (4.11.0-1.git4a6869a.el7.centos.ppc64le)
> MSR: 9000000000001031 <SF,HV,ME,IR,DR,LE>
>   CR: 44008024  XER: 20000000
> CFAR: c0000000002c3e7c SOFTE: 1
> GPR00: 000000000000018f c0000003c215f3d0 c00000000131fd00 0000000000000000
> GPR04: 0000000000000005 00000000000001ff 0000000000000000 7db04aa67db14ba6
> GPR08: 264bb17da64ab000 e64bb17da64ab000 0000000000000078 0000000000000000
> GPR12: c0000003c32f0008 c00000000fdc0000 c00000000000e148 0000000000000000
> GPR16: 0000000008000000 0000000020000000 0000000000000000 c0000003c215f4c0
> GPR20: c0000001fd033000 c0000001fd0330e0 c0000001ffff8f50 c0000001f25afff8
> GPR24: 0000000000000200 00000001f25b0000 0000000000000010 0000000000020000
> GPR28: 0800000000000000 00000001f25b0000 000000007db04aa6 00000000a64ab07d
> NIP [c0000000002c3ddc] vmalloc_to_page+0x19c/0x220
> LR [c0000000002c3e80] vmalloc_to_pfn+0x20/0x50
> Call Trace:
> [c0000003c215f3d0] [7265677368657265] 0x7265677368657265 (unreliable)
> [c0000003c215f400] [c0000000002c3e80] vmalloc_to_pfn+0x20/0x50
> [c0000003c215f420] [c0000000000637e8] vmalloc_to_phys+0x28/0x60
> [c0000003c215f450] [c0000000000ce480] kvmppc_rm_h_put_tce_indirect+0x1a0/0x540
> [c0000003c215f590] [c0000000000d0314] hcall_try_real_mode+0x60/0x7c
> [c0000003c215f600] [c0000000000cefac] kvmppc_call_hv_entry+0x8/0x17c
> [c0000003c215f670] [c00800000357a970] __kvmppc_vcore_entry+0x13c/0x1ac [kvm_hv]
> [c0000003c215f840] [c0080000035774a8] kvmppc_run_core+0x788/0x1650 [kvm_hv]
> [c0000003c215fa00] [c0080000035790b8] kvmppc_vcpu_run_hv+0x388/0x1200 [kvm_hv]
> [c0000003c215fb30] [c008000002f34684] kvmppc_vcpu_run+0x34/0x50 [kvm]
> [c0000003c215fb50] [c008000002f30b54] kvm_arch_vcpu_ioctl_run+0x114/0x2a0 [kvm]
> [c0000003c215fbd0] [c008000002f23dd8] kvm_vcpu_ioctl+0x5e8/0x7c0 [kvm]
> [c0000003c215fd40] [c000000000350b50] do_vfs_ioctl+0xd0/0x8c0
> [c0000003c215fde0] [c000000000351414] SyS_ioctl+0xd4/0xf0
> [c0000003c215fe30] [c00000000000b8e0] system_call+0x38/0xfc
> Instruction dump:
> 53dfc42e 790807c6 394affff 7d08fb78 78638402 79081764 7d4a07b4 7c6a5038
> 7908f5e6 7d094b78 794a1f24 38600000 <7d2a482a> 7924cfe3 41820040 79260022
> 
> Reverting the below commit allows the radix guest to boot successfully.
> 
> commit 3dc410ae83e6cb76c81ea30a05d62596092b3165
> Author: Alexey Kardashevskiy <aik@ozlabs.ru>
> Date:   Mon Mar 27 16:22:19 2017 +1100
> 
>     target-ppc/kvm: Enable in-kernel TCE acceleration for multi-tce
>     
>     This enables in-kernel handling of H_PUT_TCE_INDIRECT and
>     H_STUFF_TCE hypercalls. The host kernel support is there since v4.6,
>     in particular d3695aa4f452
>     ("KVM: PPC: Add support for multiple-TCE hcalls").
>     
>     H_PUT_TCE is already accelerated and does not need any special enablement.
> 
> Regards,
> Bharata.
> 
> 

I'll send a revert commit, ok? At least to get some time to investigate
why this problem happens before re-enabling TCE again.

Thanks
