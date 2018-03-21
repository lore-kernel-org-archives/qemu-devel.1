Received: from eggs.gnu.org ([2001:4830:134:3::10]:39800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eybd2-0006Vq-Mo
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eybcx-0008Ce-Kw
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:10:00 -0400
Received: from mail-he1eur01hn0211.outbound.protection.outlook.com
	([104.47.0.211]:15497
	helo=EUR01-HE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eybcx-0008Bg-7v
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:09:55 -0400
Date: Wed, 21 Mar 2018 14:09:39 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180321110939.GB14983@rkaganb.sw.ru>
References: <20180320173500.32065-1-vkuznets@redhat.com>
	<20180320173500.32065-2-vkuznets@redhat.com>
	<20180320183227.GW3417@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320183227.GW3417@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Tue, Mar 20, 2018 at 03:32:27PM -0300, Eduardo Habkost wrote:
> On Tue, Mar 20, 2018 at 06:34:59PM +0100, Vitaly Kuznetsov wrote:
> > @@ -1747,6 +1760,15 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
> >              if (cpu->hyperv_time) {
> >                  kvm_msr_entry_add(cpu, HV_X64_MSR_REFERENCE_TSC,
> >                                    env->msr_hv_tsc);
> > +
> > +                if (has_msr_hv_reenlightenment) {
> 
> I see that the current code is inconsistent: some entries check
> for has_msr_hv_*, other entries check cpu->hyperv_*.
> 
> I suggest changing all of them (including this one) to check
> cpu->hyperv_* instead.
> 
> The difference between both approaches is that checking just
> has_msr_hv_* would let a non-cooperating guest prevent itself
> from being migrated to an older host by writing a non-zero value
> to a MSR, even if hyperv support was not enabled in the VM
> configuration at all.  I don't think we want that.

Agreed.  We accumulated a number of these over time; it's mostly my
fault, so I don't feel it's just to ask Vitaly to fix the existing ones,
but let's not add new ones.  

Roman.
