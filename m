Received: from eggs.gnu.org ([2001:4830:134:3::10]:59461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLTVI-0000j9-8A
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1dLTVF-0005Ox-42
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:04:00 -0400
Received: from mail-ve1eur01on0090.outbound.protection.outlook.com
	([104.47.1.90]:2880
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1dLTVE-0005OZ-Hp
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 08:03:57 -0400
Date: Thu, 15 Jun 2017 15:03:48 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170615120347.GB28349@rkaganb.sw.ru>
References: <20170614151117.42235246@nial.brq.redhat.com>
	<71b4d258-4299-43dd-ec0c-e7a2ab9e128e@redhat.com>
	<20170614132216.GF5016@thinpad.lan.raisama.net>
	<20170614153859.3d990da4@nial.brq.redhat.com>
	<20170614134523.GH5016@thinpad.lan.raisama.net>
	<20170614184035.GB20211@rkaganb.sw.ru>
	<20170614185900.GL5016@thinpad.lan.raisama.net>
	<3567a47c-6f01-eed6-febe-832eb2dc5d06@redhat.com>
	<20170615114024.GA28349@rkaganb.sw.ru>
	<fdeb0f6b-8aee-4069-01c4-6562312c75e4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdeb0f6b-8aee-4069-01c4-6562312c75e4@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

On Thu, Jun 15, 2017 at 01:42:56PM +0200, Paolo Bonzini wrote:
> 
> 
> On 15/06/2017 13:40, Roman Kagan wrote:
> > On Thu, Jun 15, 2017 at 10:26:58AM +0200, Paolo Bonzini wrote:
> >> On 14/06/2017 20:59, Eduardo Habkost wrote:
> >>> On Wed, Jun 14, 2017 at 09:40:37PM +0300, Roman Kagan wrote:
> >>>> One more data point is that until now there was no use for vp_index in
> >>>> QEMU, so it didn't care how KVM managed it.  In KVM the only
> >>>> vp_index-aware path that the guests could trigger was exactly reading of
> >>>> HV_X64_MSR_VP_INDEX.
> >>>>
> >>>> So let me try to sum up (to make sure I understand it right);
> >>>>
> >>>> 1) we add KVM_CAP_HYPERV_SYNIC2 to KVM; when QEMU enables it KVM
> >>>>    switches to using vcpu_id as vp_index and stops zeroing synic pages
> >>>
> >>> If we want to keep KVM code simpler, we could make QEMU
> >>> explicitly initialize vp_index using vcpu_id (== arch_id == apic_id)
> >>> if KVM_CAP_HYPERV_SYNIC2 is reported as supported.
> >>>
> >>>> 2) new QEMU refuses to start in non-compat mode when
> >>>>    KVM_CAP_HYPERV_SYNIC2 is not supported
> >>>
> >>> It depends on which cases are considered "in non-compat mode".
> >>> Getting a VM not runnable just because the machine-type was
> >>> updated is not desirable, especially considering that on most
> >>> cases we will create the VCPUs on the same order and things would
> >>> keep working.  Probably the best we can do on this case is to
> >>> automatically enable compat mode, but print a warning saying
> >>> future QEMU versions might break if the kernel is not upgraded.
> >>
> >> Anything that specifies hv_synic can be broken.  There was really no
> >> reason to specify it for anything except experimenting.
> > 
> > Hyper-V SynIC timers depend on it, and they work since QEMU 2.6 / KVM
> > 4.5 and even supported by libvirt since 1.3.3.
> 
> But who is using them, and why would they be doing that?  What is the
> advantage of using SynIC timers?

I guess because they are lighter-weight than HPET, and Windows used to
ignore apic timer so it would choose SynIC timers if available.
Dunno...

Roman.
