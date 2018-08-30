Received: from eggs.gnu.org ([2001:4830:134:3::10]:47426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fvETN-0001Gl-3S
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <robert.hu@linux.intel.com>) id 1fvETI-0001Kb-6b
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:22:21 -0400
Received: from mga18.intel.com ([134.134.136.126]:16455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <robert.hu@linux.intel.com>)
	id 1fvETH-0001Jx-Tu
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 00:22:16 -0400
Message-ID: <1535602930.4104.41.camel@linux.intel.com>
From: Robert Hoo <robert.hu@linux.intel.com>
Date: Thu, 30 Aug 2018 12:22:10 +0800
In-Reply-To: <20180823171158.GI3778@localhost.localdomain>
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
	<20180817131810.GA15372@localhost.localdomain>
	<1534577221.4104.20.camel@linux.intel.com>
	<20180818150548.GN15372@localhost.localdomain>
	<1535005708.4104.34.camel@linux.intel.com>
	<20180823171158.GI3778@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: robert.hu@intel.com, robert.hu@linux.intel.com, pbonzini@redhat.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On Thu, 2018-08-23 at 14:11 -0300, Eduardo Habkost wrote:
> On Thu, Aug 23, 2018 at 02:28:28PM +0800, Robert Hoo wrote:
> > On Sat, 2018-08-18 at 12:05 -0300, Eduardo Habkost wrote:
> [...]
> > > We don't want QEMU to refuse to run if the kernel doesn't have
> > > KVM_CAP_GET_MSR_FEATURES.  We can treat missing capability as
> > > equivalent to returning an empty list of MSRs.
> > Yes. I'll let caller (kvm_arch_init) ignore the return value but a
> > simple warning.
> 
> Warnings tend to be ignored and are generally a sign that QEMU
> isn't doing the right thing.  Sometimes we have no choice, but I
> don't think that's the case here.
> 
> As far as I can see, we have only two possibilities here:
> 1) The host can run a VM that behaves exactly as requested on the
>    command-line (no warning required).
> 2) The host can't run the requested configuration (fatal error,
>    not a warning).
> 
I mean the kvm_arch_init() --> kvm_get_supported_feature_msrs(), when
kvm_get_supported_feature_msrs() returns error, can we ignore it?
The cases of kvm_get_supported_feature_msrs() returning error:
1) underlying KVM doesn't support GET_MSR_FEATURES capability.
2) error in KVM_GET_MSR_FEATURE_INDEX_LIST.

given the principle you guided before, I think we can ignore above error
cases, and later kvm_arch_get_supported_msr_feature() would always
return 0 (of course, except those special cases like
IA32_ARCH_CAPABILITIES.RSBA)
