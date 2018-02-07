Received: from eggs.gnu.org ([2001:4830:134:3::10]:40856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejUmW-0005EQ-6x
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:49:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1ejUmS-0005Qz-AQ
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:49:20 -0500
Received: from mail-db5eur03hn0233.outbound.protection.outlook.com
	([104.47.10.233]:54779
	helo=EUR03-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1ejUmS-0005QV-0N
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 13:49:16 -0500
Date: Wed, 7 Feb 2018 21:49:03 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180207184903.GB18247@rkaganb.sw.ru>
References: <20180206203048.11096-1-rkagan@virtuozzo.com>
	<20180206203048.11096-10-rkagan@virtuozzo.com>
	<9db7ccde-9f6c-7074-7d4c-46a16d687774@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9db7ccde-9f6c-7074-7d4c-46a16d687774@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 09/34] hyperv: block SynIC use in QEMU
 in incompatible configurations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Ben Warren <ben@skyportsystems.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Krish Sadhukhan <krish.sadhukhan@oracle.com>, "Marcos E. Matsunaga" <Marcos.Matsunaga@oracle.com>, Jan Dakinevich <jan.dakinevich@virtuozzo.com>, Vadim Rozenfeld <vrozenfe@redhat.com>, "Denis V. Lunev" <den@openvz.org>, si-wei liu <si-wei.liu@oracle.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Cathy Avery <cavery@redhat.com>

On Wed, Feb 07, 2018 at 11:46:30AM +0100, Paolo Bonzini wrote:
> On 06/02/2018 21:30, Roman Kagan wrote:
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
> > To cover both scenarios, introduce a (user-invisible) SynIC property
> > that disallows to use the SynIC within QEMU but not in KVM.  The
> > property is clear by default but is set via compat logic for older
> > machine types.
> > 
> > As a result, when hv_synic and a modern machine type are specified, QEMU
> > will refuse to run unless vp_index is on and the kernel is recent
> > enough.  OTOH with older machine types QEMU will fine run against an
> > older kernel and/or without vp_index enabled but will refuse the in-QEMU
> > uses of SynIC (e.g. VMBus).
> > 
> > Also a function is added that allows the devices to query the status of
> > SynIC support across vCPUs.
> > 
> > Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
> 
> FWIW I'm okay with just requiring a new-enough kernel when using SynIC.
> It's always been experimental.

Well, synic timers are available since linux-4.5 and qemu-2.6, and
they're also supported in libvirt for some time, so there probably are
VMs using it.  It would be harsh to make them fail migrating to a new
QEMU.

Roman.
