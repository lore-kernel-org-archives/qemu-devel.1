Received: from eggs.gnu.org ([208.118.235.92]:46455)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ftcLJ-0006Sq-QN
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:27:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ftcLF-0004V5-Ny
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:27:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ftcLF-0004T6-FI
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 13:27:17 -0400
Date: Sat, 25 Aug 2018 14:27:12 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180825172712.GC9609@Unicamp-Visitante-177-220-23-12.wifi.unicamp.br>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
	<20180817131810.GA15372@localhost.localdomain>
	<1534577221.4104.20.camel@linux.intel.com>
	<20180818150548.GN15372@localhost.localdomain>
	<1535005708.4104.34.camel@linux.intel.com>
	<20180823171158.GI3778@localhost.localdomain>
	<f59a30a4-6415-3c15-a3c1-5769eee04ad6@redhat.com>
	<20180823173632.GN3778@localhost.localdomain>
	<92a99591-ad6c-6b8a-b934-8da5616cf70e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92a99591-ad6c-6b8a-b934-8da5616cf70e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 2/3] kvm: Add support to
 KVM_GET_MSR_FEATURE_INDEX_LIST and KVM_GET_MSRS system ioctl
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Robert Hoo <robert.hu@linux.intel.com>, robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Thu, Aug 23, 2018 at 10:23:53PM +0200, Paolo Bonzini wrote:
> On 23/08/2018 19:36, Eduardo Habkost wrote:
> >> Right, but if KVM_CAP_GET_MSR_FEATURES is not available I guess you can
> >> assume the MSRs to be zero for everything except "-cpu host".
> > Yes, that would be simplest way to implement the above.  Then
> > QEMU would refuse to run if the feature was part of the requested
> > configuration (2), or not care at all because the feature was not
> > set in the configuration (1).
> > 
> > But I'm not sure I follow the suggestion to not consider the MSR
> > to be zero on "-cpu host".  If we don't need and KVM-side code to
> > support a given MSR feature, we can enable it on all models.
> 
> The case I was thinking about, is where there is no KVM-side code to
> support the MSR feature, but you still need the host CPU to have it.
> Without KVM's feature MSR support, you cannot read the host value of the
> MSR.

Don't we always need some KVM code to support the feature, even
if it's just to make KVM enable the feature by default?

> 
> My idea was that feature MSRs will default to the host value returned by
> KVM_GET_MSR on the /dev/kvm file descriptor, so "-cpu host" could just
> ignore KVM_CAP_GET_MSR_FEATURES and use KVM's default value of the MSRs.
> 
> However, I guess we can just use the default value for _all_ CPU models,
> because in practice the only effect would be on nested VMX MSRs, and
> nested VMX can only be migrated on kernels that have
> KVM_CAP_GET_MSR_FEATURES.  So in practice people using nested VMX are
> using "-cpu host" anyway, not "-cpu SandyBridge,+vmx".

If the default is to use the host value, I see two problems:
1) we can't use the default on any migration-safe CPU model
(i.e.  all except "host"); 2) it will be unsafe for older QEMU
versions (that don't know yet how to call KVM_SET_MSR for that
MSR).

If this is just about VMX caps, this shouldn't be a problem
because we already treat VMX as not migration-safe.  We will need
to keep that in mind if we want to make VMX migration-safe in the
future, though.

> 
> My proposalis: basically, if KVM_CAP_GET_MSR_FEATURES is unavailable:
> 
> - MSR-based features would cause an error if specified on the command line;
> 
> - kvm_arch_init_vcpu would skip the KVM_SET_MSR for feature MSRs completely.

If we already had some MSR features being enabled by default
before KVM_CAP_GET_MSR_FEATURES was introduced (I didn't know we
had such cases), this sense.  But I don't think we should
do it for new MSRs.

-- 
Eduardo
