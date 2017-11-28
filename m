Received: from eggs.gnu.org ([2001:4830:134:3::10]:41726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eJlX4-0000Ys-LR
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:27:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1eJlX1-0006OT-BL
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:27:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57456
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1eJlX1-0006O4-5t
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:26:59 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vASJPiqO050497
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 14:26:56 -0500
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ehapdacnv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 14:26:56 -0500
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Tue, 28 Nov 2017 14:26:55 -0500
References: <20171128174310.15700-1-lvivier@redhat.com>
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Tue, 28 Nov 2017 17:26:48 -0200
MIME-Version: 1.0
In-Reply-To: <20171128174310.15700-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Message-Id: <bfd918cf-6ca0-deef-a151-bd70ffec681f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>



On 11/28/2017 03:43 PM, Laurent Vivier wrote:
> Migration of pseries is broken with TCG because
> QEMU tries to restore KVM MMU state unconditionally.
>
> The result is a SIGSEGV in kvm_vm_ioctl():
>
>    #0  kvm_vm_ioctl (s=0x0, type=-2146390353)
>        at qemu/accel/kvm/kvm-all.c:2032
>    #1  0x00000001003e3e2c in kvmppc_configure_v3_mmu (cpu=<optimized out>,
>        radix=<optimized out>, gtse=<optimized out>, proc_tbl=<optimized out>)
>        at qemu/target/ppc/kvm.c:396
>    #2  0x00000001002f8b88 in spapr_post_load (opaque=0x1019103c0,
>        version_id=<optimized out>) at qemu/hw/ppc/spapr.c:1578
>    #3  0x000000010059e4cc in vmstate_load_state (f=0x106230000,
>        vmsd=0x1009479e0 <vmstate_spapr>, opaque=0x1019103c0,
>        version_id=<optimized out>) at qemu/migration/vmstate.c:165
>    #4  0x00000001005987e0 in vmstate_load (f=<optimized out>, se=<optimized out>)
>        at qemu/migration/savevm.c:748
>
> This patch fixes the problem by not calling the KVM function with the
> TCG mode.
>
> Fixes: d39c90f5f3 ("spapr: Fix migration of Radix guests")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
> v2: fix the comment to keep GDB backtrace lines starting with '#'
>
>   hw/ppc/spapr.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 9efddeaee5..a471de6cab 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1570,7 +1570,7 @@ static int spapr_post_load(void *opaque, int version_id)
>           err = spapr_rtc_import_offset(&spapr->rtc, spapr->rtc_offset);
>       }
>
> -    if (spapr->patb_entry) {
> +    if (kvm_enabled() && spapr->patb_entry) {

As an alternative, I believe you can also do:

if (!!spapr->patb_entry) {

because the !! will return false if patb_entry is either undefined (as in
TCG) or zero (as set in spapr_reallocate_hpt). This is the same logic used
in spapr_patb_entry_needed too.

But I am fine with what you did and it's also clearer, so


Reviewed-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>



>           PowerPCCPU *cpu = POWERPC_CPU(first_cpu);
>           bool radix = !!(spapr->patb_entry & PATBE1_GR);
>           bool gtse = !!(cpu->env.spr[SPR_LPCR] & LPCR_GTSE);
