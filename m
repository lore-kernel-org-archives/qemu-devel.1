Received: from eggs.gnu.org ([2001:4830:134:3::10]:58087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTTHp-0003PO-SI
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:27:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dTTHl-000248-TQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:27:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dTTHl-00022l-Ml
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 09:27:05 -0400
Date: Fri, 7 Jul 2017 15:27:00 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170707152700.4e18f6f9@nial.brq.redhat.com>
In-Reply-To: <20170707124719.GA17544@rkaganb.sw.ru>
References: <20170621162424.10462-1-rkagan@virtuozzo.com>
	<20170621162424.10462-15-rkagan@virtuozzo.com>
	<20170629170546.6450586d@nial.brq.redhat.com>
	<20170629175100.GB13435@rkaganb.sw.ru>
	<20170707142220.4d0f14fe@nial.brq.redhat.com>
	<20170707124719.GA17544@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/23] hyperv: qom-ify SynIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: "Denis V . Lunev" <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Fri, 7 Jul 2017 15:47:19 +0300
Roman Kagan <rkagan@virtuozzo.com> wrote:

> On Fri, Jul 07, 2017 at 02:22:20PM +0200, Igor Mammedov wrote:
> > On Thu, 29 Jun 2017 20:51:01 +0300
> > Roman Kagan <rkagan@virtuozzo.com> wrote:
> >   
> > > On Thu, Jun 29, 2017 at 05:05:46PM +0200, Igor Mammedov wrote:  
> > > > On Wed, 21 Jun 2017 19:24:15 +0300
> > > > Roman Kagan <rkagan@virtuozzo.com> wrote:    
> > [...]  
> > >   
> > > > > +    if (cpu->hyperv_synic) {
> > > > > +        if (kvm_vcpu_enable_cap(CPU(cpu), KVM_CAP_HYPERV_SYNIC, 0)) {
> > > > > +            fprintf(stderr, "failed to enable Hyper-V SynIC\n");
> > > > > +            return -ENOSYS;
> > > > > +        }
> > > > > +
> > > > > +        hyperv_synic_add(cpu);    
> > > > is synic KVM specific or may it work with TCG accel?    
> > > 
> > > No, it's exclusively KVM.  Actually most of it sits in the kernel.
> > >   
> > > > in either case, looks like hyperv_synic_add() should be called from
> > > > x86_cpu_realizefn(), the same like we do with APIC creating it
> > > > depending feature being enabled.    
> > > 
> > > I'm not sure I understand the reason, in view of it being exclusively
> > > KVM.  
> > couldn't synic be emulated (if missing QEMU part is written) in TCG mode
> > or it relies on specific KVM features?  
> 
> At the moment it depends on KVM and, in particular, relies on lapic
> being in KVM.  I guess with certain effort it can be done in TCG too,
> but we didn't even consider this so far, and have no plans for it.
we would avoid rewriting synic code if you can keep synic parts
that could be reused by TCG outside of kvm specific files.

Refactoring to qom/device and moving that code in separate file
is a good time to start doing it and keeping kvm related parts isolated/minimal
should help in future when TCG synic model could be written.
(but I don't insist on it).
