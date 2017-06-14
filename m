Received: from eggs.gnu.org ([2001:4830:134:3::10]:39400)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLDE3-0003IM-Fk
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:41:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLDE0-0004ZO-Qo
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:41:07 -0400
Received: from mail-eopbgr50094.outbound.protection.outlook.com
	([40.107.5.94]:33313
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dLDE0-0004ZA-79
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 14:41:04 -0400
Date: Wed, 14 Jun 2017 21:40:37 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170614184035.GB20211@rkaganb.sw.ru>
References: <20170606181948.16238-6-rkagan@virtuozzo.com>
	<20170613185752.GZ5016@thinpad.lan.raisama.net>
	<20170614112506.GI2004@rkaganb.sw.ru>
	<6bb8f5e3-b6bf-c62a-93f3-9fe338d43881@redhat.com>
	<20170614130149.GD5016@thinpad.lan.raisama.net>
	<20170614151117.42235246@nial.brq.redhat.com>
	<71b4d258-4299-43dd-ec0c-e7a2ab9e128e@redhat.com>
	<20170614132216.GF5016@thinpad.lan.raisama.net>
	<20170614153859.3d990da4@nial.brq.redhat.com>
	<20170614134523.GH5016@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170614134523.GH5016@thinpad.lan.raisama.net>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Wed, Jun 14, 2017 at 10:45:23AM -0300, Eduardo Habkost wrote:
> On Wed, Jun 14, 2017 at 03:38:59PM +0200, Igor Mammedov wrote:
> > On Wed, 14 Jun 2017 10:22:16 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > 
> > > On Wed, Jun 14, 2017 at 03:17:54PM +0200, Paolo Bonzini wrote:
> > > > 
> > > > 
> > > > On 14/06/2017 15:11, Igor Mammedov wrote:  
> > > > >> No, KVM really uses the VCPU _index_ for HV_X64_MSR_VP_INDEX:  
> > > > >
> > > > > and as you pointed out that works just by luck,
> > > > > as soon as we there would be out of order created CPUs
> > > > > returned value won't match cpu_index.
> > > > > 
> > > > > So instead of spreading this nonsense out to QEMU, is it possible
> > > > > to fix kernel(kvm+guest) to use apic_id instead?  
> > > > 
> > > > Yes, definitely.  At this point let's add a new "KVM_CAP_HYPERV_SYNIC2"
> > > > capability and declare the old one broken, that will make things easier.  
> > > 
> > > What do we need a capability for?
> > > Can't we just call
> > > KVM_SET_MSRS using arch_id (== apic_id) and warn the user if it
> > > doesn't work?
> > warn won't solve issue, and it's called rather late in vcpu creation
> > chain without any error propagation so it's not possible (hard) to
> > gracefully fail cpu hotplug.
> 
> The issue is unsolvable on old kernels (and I don't think we want
> to prevent the VM from starting), hence the warning.  But the
> ability to report errors gracefully on CPU hotplug is a very good
> reason.  Good point.
> 
> > 
> > with KVM_CAP_HYPERV_SYNIC2 we could easily turn on compat property for
> > SYNC device (needs QOMification) that would turn on broken compat
> > logic if capability is not present/old machine type.
> 
> I was going to propose enabling the compat logic if KVM_SET_MSRS
> failed, but you have a good point about KVM_SET_MSRS being called
> very late.

Thanks for this discussion, I didn't realize all the implications
(including that hotplug issue too).

One more data point is that until now there was no use for vp_index in
QEMU, so it didn't care how KVM managed it.  In KVM the only
vp_index-aware path that the guests could trigger was exactly reading of
HV_X64_MSR_VP_INDEX.

So let me try to sum up (to make sure I understand it right);

1) we add KVM_CAP_HYPERV_SYNIC2 to KVM; when QEMU enables it KVM
   switches to using vcpu_id as vp_index and stops zeroing synic pages

2) new QEMU refuses to start in non-compat mode when
   KVM_CAP_HYPERV_SYNIC2 is not supported

3) old QEMU or new QEMU in compat mode enables KVM_CAP_HYPERV_SYNIC
   making KVM keep using internal cpu index as vp_index and zeroing
   synic pages

4) new QEMU in compat mode refuses vmbus or sint route creation

Is this what is proposed?  My only problem here is that KVM will have to
somehow guarantee stable numbering in the old synic mode.  How can this
be ensured?  And should it be at all?

Thanks,
Roman.
