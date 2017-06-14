Received: from eggs.gnu.org ([2001:4830:134:3::10]:60861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8by-0006BA-CM
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:45:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dL8bv-0001qU-8k
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dL8bv-0001pY-1i
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 09:45:27 -0400
Date: Wed, 14 Jun 2017 10:45:23 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170614134523.GH5016@thinpad.lan.raisama.net>
References: <20170606181948.16238-1-rkagan@virtuozzo.com>
	<20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
	<20170614130149.GD5016@thinpad.lan.raisama.net>
	<20170614151117.42235246@nial.brq.redhat.com>
	<71b4d258-4299-43dd-ec0c-e7a2ab9e128e@redhat.com>
	<20170614132216.GF5016@thinpad.lan.raisama.net>
	<20170614153859.3d990da4@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614153859.3d990da4@nial.brq.redhat.com>
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

On Wed, Jun 14, 2017 at 03:38:59PM +0200, Igor Mammedov wrote:
> On Wed, 14 Jun 2017 10:22:16 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Wed, Jun 14, 2017 at 03:17:54PM +0200, Paolo Bonzini wrote:
> > > 
> > > 
> > > On 14/06/2017 15:11, Igor Mammedov wrote:  
> > > >> No, KVM really uses the VCPU _index_ for HV_X64_MSR_VP_INDEX:  
> > > >
> > > > and as you pointed out that works just by luck,
> > > > as soon as we there would be out of order created CPUs
> > > > returned value won't match cpu_index.
> > > > 
> > > > So instead of spreading this nonsense out to QEMU, is it possible
> > > > to fix kernel(kvm+guest) to use apic_id instead?  
> > > 
> > > Yes, definitely.  At this point let's add a new "KVM_CAP_HYPERV_SYNIC2"
> > > capability and declare the old one broken, that will make things easier.  
> > 
> > What do we need a capability for?
> > Can't we just call
> > KVM_SET_MSRS using arch_id (== apic_id) and warn the user if it
> > doesn't work?
> warn won't solve issue, and it's called rather late in vcpu creation
> chain without any error propagation so it's not possible (hard) to
> gracefully fail cpu hotplug.

The issue is unsolvable on old kernels (and I don't think we want
to prevent the VM from starting), hence the warning.  But the
ability to report errors gracefully on CPU hotplug is a very good
reason.  Good point.

> 
> with KVM_CAP_HYPERV_SYNIC2 we could easily turn on compat property for
> SYNC device (needs QOMification) that would turn on broken compat
> logic if capability is not present/old machine type.

I was going to propose enabling the compat logic if KVM_SET_MSRS
failed, but you have a good point about KVM_SET_MSRS being called
very late.

-- 
Eduardo
