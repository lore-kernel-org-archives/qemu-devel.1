Received: from eggs.gnu.org ([2001:4830:134:3::10]:43746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRIdi-0008KH-NL
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1gRIdd-0002o8-PC
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:17:34 -0500
Received: from mail-bgr052101135016.outbound.protection.outlook.com
	([52.101.135.16]:25184
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1gRIdd-0002hv-8w
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 10:17:29 -0500
From: Roman Kagan <rkagan@virtuozzo.com>
Date: Mon, 26 Nov 2018 15:17:15 +0000
Message-ID: <20181126151710.GA2285@rkaganb.sw.ru>
References: <20180921082217.29481-1-rkagan@virtuozzo.com>
	<20180921082217.29481-4-rkagan@virtuozzo.com>
	<20181126154503.291d395a@redhat.com>
In-Reply-To: <20181126154503.291d395a@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1DD50ED5795154AADB9EA4D50EC250D@eurprd08.prod.outlook.com>
MIME-Version: 1.0
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>

On Mon, Nov 26, 2018 at 03:45:03PM +0100, Igor Mammedov wrote:
> On Fri, 21 Sep 2018 11:22:10 +0300
> Roman Kagan <rkagan@virtuozzo.com> wrote:
> 
> > Certain configurations do not allow SynIC to be used in QEMU.  In
> > particular,
> > 
> > - when hyperv_vpindex is off, SINT routes can't be used as they refer to
> >   the destination vCPU by vp_index
> > 
> > - older KVM (which doesn't expose KVM_CAP_HYPERV_SYNIC2) zeroes out
> >   SynIC message and event pages on every msr load, breaking migration
> > 
> > OTOH in-KVM users of SynIC -- SynIC timers -- do work in those
> > configurations, and we shouldn't stop the guest from using them.
> > 
> > To cover both scenarios, introduce an X86CPU property that makes CPU
> > init code to skip creation of the SynIC object (and thus disables any
> > SynIC use in QEMU) but keeps the KVM part of the SynIC working.
> > The property is clear by default but is set via compat logic for older
> > machine types.
> > 
> > As a result, when hv_synic and a modern machine type are specified, QEMU
> > will refuse to run unless vp_index is on and the kernel is recent
> > enough.  OTOH with an older machine type QEMU will run fine with
> > hv_synic=on against an older kernel and/or without vp_index enabled but
> > will disallow the in-QEMU uses of SynIC (in e.g. VMBus).
> > 
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> 
> With current upstream and x-hv-synic-kvm-only=on QEMU will SIGSEGV.
> Problem was unnoticed since added compat property wasn't actually used
> until much later commit
>   4a93722f9c hw/i386: add pc-i440fx-3.1 & pc-q35-3.1
> which put compat property in use.
> 
> qemu-system-x86_64 -machine pc-i440fx-2.10,accel=kvm \
>  -cpu host,-vmx,hv-relaxed,hv_spinlocks=0x1fff,hv-vpindex,hv-synic 
> 
> simpler reproducer:
>  qemu-system-x86_64 -enable-kvm -cpu host,hv-synic,x-hv-synic-kvm-only=on
> 
> Reported-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Thanks for the report, fix is on the way to ML.

Roman.
