Received: from eggs.gnu.org ([2001:4830:134:3::10]:54071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8DH-0001aW-CO
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:20:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8DD-0001I2-Dn
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:19:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dL8DD-0001Ho-7Z
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:19:55 -0400
Date: Wed, 14 Jun 2017 10:19:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170614131952.GE5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
	<20170614130149.GD5016@thinpad.lan.raisama.net>
	<20170614151117.42235246@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614151117.42235246@nial.brq.redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 03:11:17PM +0200, Igor Mammedov wrote:
> On Wed, 14 Jun 2017 10:01:49 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Jun 14, 2017 at 01:26:44PM +0200, Paolo Bonzini wrote:
> > > 
> > > 
> > > On 14/06/2017 13:25, Roman Kagan wrote:  
> > > >> The problem with that is that it will break as soon as we create
> > > >> VCPUs in a different order.  Unsolvable on hosts that don't allow
> > > >> HV_X64_MSR_VP_INDEX to be set, however.  
> > > > Right, thanks for putting together a detailed explanation.
> > > > 
> > > > This was a thinko back then, not to have HV_X64_MSR_VP_INDEX maintained
> > > > by QEMU.  I'm going to post a patch to KVM fixing that.
> > > > 
> > > > Meanwhile QEMU needs a way to maintain its notion of vp_index that is
> > > >   1) in sync with kernel's notion
> > > >   2) also with kernels that don't support setting the msr
> > > >   3) persistent across migrations
> > > > 
> > > > cpu_index looked like a perfect candidate.
> > > >   
> > > 
> > > What you want is the APIC id, which _is_ cpu_index but may not be in the
> > > future.  But the APIC id is also the KVM vcpu_id, so there's no need to
> > > have VP_INDEX maintained by QEMU.  
> > 
> > No, KVM really uses the VCPU _index_ for HV_X64_MSR_VP_INDEX:
> and as you pointed out that works just by luck,
> as soon as we there would be out of order created CPUs
> returned value won't match cpu_index.

This is true, which makes it even worse.

> 
> So instead of spreading this nonsense out to QEMU, is it possible
> to fix kernel(kvm+guest) to use apic_id instead?

It is possible to fix the kernel, but if we want to support older
kernels, QEMU has no choice but creating the VCPUs always in the
same order.

-- 
Eduardo
