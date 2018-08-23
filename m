Received: from eggs.gnu.org ([2001:4830:134:3::10]:53771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsw9E-000292-08
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:24:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fsw98-0005Jy-LY
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:24:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34270 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fsw98-0005JY-G3
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 16:23:58 -0400
References: <1533909989-56115-1-git-send-email-robert.hu@linux.intel.com>
	<1533909989-56115-3-git-send-email-robert.hu@linux.intel.com>
	<20180817131810.GA15372@localhost.localdomain>
	<1534577221.4104.20.camel@linux.intel.com>
	<20180818150548.GN15372@localhost.localdomain>
	<1535005708.4104.34.camel@linux.intel.com>
	<20180823171158.GI3778@localhost.localdomain>
	<f59a30a4-6415-3c15-a3c1-5769eee04ad6@redhat.com>
	<20180823173632.GN3778@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <92a99591-ad6c-6b8a-b934-8da5616cf70e@redhat.com>
Date: Thu, 23 Aug 2018 22:23:53 +0200
MIME-Version: 1.0
In-Reply-To: <20180823173632.GN3778@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Robert Hoo <robert.hu@linux.intel.com>, robert.hu@intel.com, rth@twiddle.net, thomas.lendacky@amd.com, qemu-devel@nongnu.org, jingqi.liu@intel.com

On 23/08/2018 19:36, Eduardo Habkost wrote:
>> Right, but if KVM_CAP_GET_MSR_FEATURES is not available I guess you ca=
n
>> assume the MSRs to be zero for everything except "-cpu host".
> Yes, that would be simplest way to implement the above.  Then
> QEMU would refuse to run if the feature was part of the requested
> configuration (2), or not care at all because the feature was not
> set in the configuration (1).
>=20
> But I'm not sure I follow the suggestion to not consider the MSR
> to be zero on "-cpu host".  If we don't need and KVM-side code to
> support a given MSR feature, we can enable it on all models.

The case I was thinking about, is where there is no KVM-side code to
support the MSR feature, but you still need the host CPU to have it.
Without KVM's feature MSR support, you cannot read the host value of the
MSR.

My idea was that feature MSRs will default to the host value returned by
KVM_GET_MSR on the /dev/kvm file descriptor, so "-cpu host" could just
ignore KVM_CAP_GET_MSR_FEATURES and use KVM's default value of the MSRs.

However, I guess we can just use the default value for _all_ CPU models,
because in practice the only effect would be on nested VMX MSRs, and
nested VMX can only be migrated on kernels that have
KVM_CAP_GET_MSR_FEATURES.  So in practice people using nested VMX are
using "-cpu host" anyway, not "-cpu SandyBridge,+vmx".

My proposalis: basically, if KVM_CAP_GET_MSR_FEATURES is unavailable:

- MSR-based features would cause an error if specified on the command lin=
e;

- kvm_arch_init_vcpu would skip the KVM_SET_MSR for feature MSRs complete=
ly.

What do you think?

Paolo
