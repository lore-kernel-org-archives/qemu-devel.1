Received: from eggs.gnu.org ([2001:4830:134:3::10]:39315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLU5m-0004bu-Om
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:41:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLU5i-0000tz-Qt
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:41:42 -0400
Received: from mail-he1eur01on0102.outbound.protection.outlook.com
	([104.47.0.102]:43232
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dLU5i-0000se-7p
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:41:38 -0400
Date: Thu, 15 Jun 2017 15:41:08 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170615124106.GA2046@rkaganb.sw.ru>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
	<20170614150027.12e5626e@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614150027.12e5626e@nial.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/23] hyperv: ensure VP index equal to
 QEMU cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 03:00:27PM +0200, Igor Mammedov wrote:
> On Wed, 14 Jun 2017 13:26:44 +0200
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
> > On 14/06/2017 13:25, Roman Kagan wrote:
> > >> The problem with that is that it will break as soon as we create
> > >> VCPUs in a different order.  Unsolvable on hosts that don't allow
> > >> HV_X64_MSR_VP_INDEX to be set, however.  
> > > Right, thanks for putting together a detailed explanation.
> > > 
> > > This was a thinko back then, not to have HV_X64_MSR_VP_INDEX maintained
> > > by QEMU.  I'm going to post a patch to KVM fixing that.
> > > 
> > > Meanwhile QEMU needs a way to maintain its notion of vp_index that is
> > >   1) in sync with kernel's notion
> > >   2) also with kernels that don't support setting the msr
> > >   3) persistent across migrations
> > > 
> > > cpu_index looked like a perfect candidate.
> > >   
> > 
> > What you want is the APIC id,
> 
> > which _is_ cpu_index but may not be in the
> depending on topology cpu_index won't be the same as APIC ID/vcpu_id
> /AMDs odd core count/.

So vcpu_id can be sparse?

> > future.  But the APIC id is also the KVM vcpu_id, so there's no need to
> > have VP_INDEX maintained by QEMU.
> agreed it'd be better to reuse vcpu_id/apic id as interface between
> qemu/kvm/guest instead of adding additional cpu_index concept in ABI

Having consulted the spec, I'm not so confident any more this is the
right move.

> 7.8.1 Virtual Processor Index
> 
> Virtual processors are identified by using an index (VP index). The
> maximum number of virtual processors per partition supported by the
> current implementation of the hypervisor can be obtained through CPUID
> leaf 0x40000005. A virtual processor index must be less than the
> maximum number of virtual processors per partition.

This seems to imply that VP index should be dense.  As if they use it
directly as an index into an array whose length is equal to the max
number of vcpus.  (BTW the value we report for it is currently hardcoded
to 0x40 which probably needs fixing, too.)

I'm starting to drift back to adding SET_MSRS support to
HV_X64_MSR_VP_INDEX in KVM to delegate the control to QEMU, and having
QEMU use cpu_index as its value...  :-/

Roman.
