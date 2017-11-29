Received: from eggs.gnu.org ([2001:4830:134:3::10]:46496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1eJu9W-0003FS-Vb
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:39:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1eJu9U-0000i3-V4
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:39:19 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48272
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1eJu9U-0000hy-OU
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 23:39:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vAT4d7um083182
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 23:39:13 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ehn3nj647-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 23:39:13 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Wed, 29 Nov 2017 04:39:11 -0000
Date: Wed, 29 Nov 2017 10:09:04 +0530
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Reply-To: bharata@linux.vnet.ibm.com
References: <20171128174310.15700-1-lvivier@redhat.com>
	<1511913509.2513.2.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1511913509.2513.2.camel@gmail.com>
Message-Id: <20171129043904.GA8600@in.ibm.com>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] pseries: fix TCG migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, Nov 29, 2017 at 10:58:29AM +1100, Suraj Jitindar Singh wrote:
> On Tue, 2017-11-28 at 18:43 +0100, Laurent Vivier wrote:
> > Migration of pseries is broken with TCG because
> > QEMU tries to restore KVM MMU state unconditionally.
> > 
> > The result is a SIGSEGV in kvm_vm_ioctl():
> > 
> >   #0  kvm_vm_ioctl (s=0x0, type=-2146390353)
> >       at qemu/accel/kvm/kvm-all.c:2032
> >   #1  0x00000001003e3e2c in kvmppc_configure_v3_mmu (cpu=<optimized
> > out>,
> >       radix=<optimized out>, gtse=<optimized out>,
> > proc_tbl=<optimized out>)
> >       at qemu/target/ppc/kvm.c:396
> >   #2  0x00000001002f8b88 in spapr_post_load (opaque=0x1019103c0,
> >       version_id=<optimized out>) at qemu/hw/ppc/spapr.c:1578
> >   #3  0x000000010059e4cc in vmstate_load_state (f=0x106230000,
> >       vmsd=0x1009479e0 <vmstate_spapr>, opaque=0x1019103c0,
> >       version_id=<optimized out>) at qemu/migration/vmstate.c:165
> >   #4  0x00000001005987e0 in vmstate_load (f=<optimized out>,
> > se=<optimized out>)
> >       at qemu/migration/savevm.c:748
> > 
> > This patch fixes the problem by not calling the KVM function with the
> > TCG mode.
> > 
> > Fixes: d39c90f5f3 ("spapr: Fix migration of Radix guests")
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> 
> Ah, guess I never hit this because I never tested tcg migration with a
> qemu compiled on a kvm enabled system. Nice catch :)

Same here. In fact I had the kvm_enabled() check in the initial verions
but removed later as kvmppc_configure_v3_mmu() was defined separately
as nop for !CONFIG_KVM. But obviously the above combination wasn't covered.

Regards,
Bharata.
