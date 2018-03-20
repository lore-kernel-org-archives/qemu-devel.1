Received: from eggs.gnu.org ([2001:4830:134:3::10]:35502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eyLog-00085c-Ma
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:16:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eyLod-00011N-G1
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eyLod-00010e-9Y
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 14:16:55 -0400
Date: Tue, 20 Mar 2018 15:16:52 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180320181652.GV3417@localhost.localdomain>
References: <20180316170020.8212-1-vkuznets@redhat.com>
	<20180316170020.8212-2-vkuznets@redhat.com>
	<20180319170603.GA12962@rkaganb.sw.ru>
	<87a7v47z4r.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7v47z4r.fsf@vitty.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org

On Mon, Mar 19, 2018 at 06:29:08PM +0100, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
> > On Fri, Mar 16, 2018 at 06:00:19PM +0100, Vitaly Kuznetsov wrote:
> >> KVM recently gained support for Hyper-V Reenlightenment MSRs which are
> >> required to make KVM-on-Hyper-V enable TSC page clocksource to its guests
> >> when INVTSC is not passed to it (and it is not passed by default in Qemu
> >> as it effectively blocks migration).
> >> 
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >> Changes since v1:
> >> - add vmstate_msr_hyperv_reenlightenment subsection to vmstate_x86_cpu
> >>   [Paolo Bonzini]
> >> ---
[...]
> >> +
> >> +        if (has_msr_hv_reenlightenment) {
> >> +            env->features[FEAT_HYPERV_EAX] |=
> >> +                HV_ACCESS_REENLIGHTENMENTS_CONTROL;
> >> +        }
> >
> > Can you please add a matching comment to the definition of
> > feature_word_info[FEAT_HYPERV_EAX].feat_names[]?
> >
> 
> Sure, missed that.
> 
> > Also there appears to be no cpu property to turn this on/off, does it?
> > It's enabled based only on the support in the KVM it's running against.
> > So I guess we may have a problem migrating between the hosts with
> > different KVM versions, one supporting it and the other not.
> 
> Currently nested workloads don't migrate so I decided to take the
> opportunity and squeeze the new feature in without adding a new
> hv_reenlightenment cpu property (which would have to be added to libvirt
> at least).
> 
> > (This is also a problem with has_msr_hv_frequencies, and is in general a
> > long-standing issue of hv_* properties being done differently from the
> > rest of CPUID features.)
> 
> Suggestions? (To be honest I don't really like us adding new hv_*
> property for every new Hyper-V feature we support. I doubt anyone needs
> 'partial' Hyper-V emulation. It would be nice to have a single versioned
> 'hv' feature implying everything. We may then forbid migrations to older
> hv versions. But I don't really know the history of why we decided to go
> with a separate hv_* for every feature we add).

You will need "partial" emulation if you want to support
live-migration to/from a host where the KVM or QEMU don't support
all the features from the current host.

Is this something the current Hyper-V code already supports, or
it's something known to be broken?

-- 
Eduardo
