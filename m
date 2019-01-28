Received: from eggs.gnu.org ([209.51.188.92]:33781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCIY-0006d3-P7
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:10:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1goCIX-00074q-JO
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:10:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44201)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1goCIX-00074c-AQ
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 14:10:21 -0500
Date: Mon, 28 Jan 2019 17:10:17 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190128191017.GW4136@habkost.net>
References: <20190125114155.32062-1-vkuznets@redhat.com>
	<20190125114155.32062-5-vkuznets@redhat.com>
	<20190125124738.GB30730@rkaganb.sw.ru>
	<87bm44onnh.fsf@vitty.brq.redhat.com>
	<20190128113017.GA2435@rkaganb.sw.ru>
	<87lg34zy37.fsf@vitty.brq.redhat.com>
	<20190128182229.GF2585@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128182229.GF2585@work-vm>
Subject: Re: [Qemu-devel] [PATCH RFC 4/8] i386/kvm: Implement 'hv-all'
 pass-through mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>

On Mon, Jan 28, 2019 at 06:22:30PM +0000, Dr. David Alan Gilbert wrote:
> * Vitaly Kuznetsov (vkuznets@redhat.com) wrote:
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> > 
> > > On Fri, Jan 25, 2019 at 02:46:42PM +0100, Vitaly Kuznetsov wrote:
> > >> Roman Kagan <rkagan@virtuozzo.com> writes:
> > >> 
> > >> > On Fri, Jan 25, 2019 at 12:41:51PM +0100, Vitaly Kuznetsov wrote:
> > >> >> In many case we just want to give Windows guests all currently supported
> > >> >> Hyper-V enlightenments and that's where this new mode may come handy. We
> > >> >> pass through what was returned by KVM_GET_SUPPORTED_HV_CPUID.
> > >> >
> > >> > How is the compatibility ensured on migration between kernels reporting
> > >> > different feature sets?
> > >> 
> > >> AFAIU we don't change anything in this regard (or, my intention was to
> > >> not change anything): hv-all is converted to the individual hv-*
> > >> properties (hv_cpuid_check_and_set()) actually sets cpu->hyperv_* flags
> > >> according to what's supported by kernel so when we migrate we will
> > >> require all these features supported.
> > >
> > > Migration relies on the upper layer to run the destination QEMU with the
> > > identical command line (except for -incoming) as the source, and QEMU is
> > > then supposed to set up identical environment in the target VM as was in
> > > the source, or refuse to start if that's impossible.  (If I'm
> > > misunderstanding this Dave (cc-d) may want to correct me.)
> > >
> > > AFAICS this hv-all attribute will enable different feature sets
> > > depending on the kernel it's run on, so the migration between different
> > > kernels will appear to succeed, but the guest may suddenly encounter an
> > > incompatible change in the environment.
> > 
> > With 'hv-all' I'm trying to achieve behavior similar to '-cpu host' and
> > AFAIK these VMs are migratable 'at your own risk' (if you do it directly
> > from qemu). Libvirt (or whatever upper layer), however, would do CPU
> > feature comparison and in case you have less features on the destination
> > host than you had on the source code it will forbid the migration. I
> > think if this also works for Hyper-V features than were fine.
> > 
> > Dave, feel free to tell me I'm completely wrong with my assumptions)
> 
> It does sound like -cpu host, but -cpu host does come with a health
> warning and we often get subtle screwups where it doesn't quite behave
> the same on the two sides, also qemu now warns (and with 'enforce'
> enforces) a check at it's level rather than relying on libvirt.
> 
> So hmm, yes it sounds like -cpu host, but I'd generally say it's not a
> great thing to copy unless you're really really careful.
> For example, in the -cpu host world people might have two machines
> they think are the same - but then they find out one has HT disabled
> or nesting enabled and so they're not actually the same.
> 
> I'm not sure what the equivalent bear traps are in the Hyper-V world,
> but I'd be surprised if there weren't any; for example what happens
> when someone upgrades one of their hosts to some minor version that
> adds/removes a feature?
> 
> Also, how does libvirt figure out that the features are actually the
> same - does it need a bunch of detection code?

If libvirt is involved, it's much simpler and safer to use
something like <cpu mode="host-model">, which generates a
migration-safe CPU configuration based on the current host.  Live
migration support with "-cpu host" is only useful for experiments
and carefully controlled environments.

Is there a real need to make hv-all migratable?  What would be
the use case, exactly?  If there's no clear use case, I would
recommend making it a migration blocker.

-- 
Eduardo
