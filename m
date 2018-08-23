Received: from eggs.gnu.org ([2001:4830:134:3::10]:53407)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fstXE-0004nb-CA
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:36:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fstX9-0007PZ-5h
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:36:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fstX8-0007Oc-UB
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 13:36:35 -0400
Date: Thu, 23 Aug 2018 14:36:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180823173632.GN3778@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
	<20180817131810.GA15372@localhost.localdomain>
	<1534577221.4104.20.camel@linux.intel.com>
	<20180818150548.GN15372@localhost.localdomain>
	<1535005708.4104.34.camel@linux.intel.com>
	<20180823171158.GI3778@localhost.localdomain>
	<f59a30a4-6415-3c15-a3c1-5769eee04ad6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f59a30a4-6415-3c15-a3c1-5769eee04ad6@redhat.com>
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

On Thu, Aug 23, 2018 at 07:28:25PM +0200, Paolo Bonzini wrote:
> On 23/08/2018 19:11, Eduardo Habkost wrote:
> >>> We don't want QEMU to refuse to run if the kernel doesn't have
> >>> KVM_CAP_GET_MSR_FEATURES.  We can treat missing capability as
> >>> equivalent to returning an empty list of MSRs.
> >> Yes. I'll let caller (kvm_arch_init) ignore the return value but a
> >> simple warning.
> > Warnings tend to be ignored and are generally a sign that QEMU
> > isn't doing the right thing.  Sometimes we have no choice, but I
> > don't think that's the case here.
> > 
> > As far as I can see, we have only two possibilities here:
> > 1) The host can run a VM that behaves exactly as requested on the
> >    command-line (no warning required).
> > 2) The host can't run the requested configuration (fatal error,
> >    not a warning).
> 
> Right, but if KVM_CAP_GET_MSR_FEATURES is not available I guess you can
> assume the MSRs to be zero for everything except "-cpu host".

Yes, that would be simplest way to implement the above.  Then
QEMU would refuse to run if the feature was part of the requested
configuration (2), or not care at all because the feature was not
set in the configuration (1).

But I'm not sure I follow the suggestion to not consider the MSR
to be zero on "-cpu host".  If we don't need and KVM-side code to
support a given MSR feature, we can enable it on all models.  IF
we need KVM-side code, we can't enable it even on "-cpu host".
This is not different from CPUID-based features.

-- 
Eduardo
