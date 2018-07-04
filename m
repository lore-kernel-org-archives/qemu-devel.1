Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faeHN-0006Lu-0I
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1faeHJ-0008K1-Tu
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:40:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47708 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1faeHJ-0008Iz-Oc
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:40:49 -0400
References: <1530098844-236851-1-git-send-email-robert.hu@linux.intel.com>
	<1530098844-236851-2-git-send-email-robert.hu@linux.intel.com>
	<20180627170304.GD914@localhost.localdomain>
	<1530177956.22880.32.camel@linux.intel.com>
	<ce3282a7-310c-6c53-05b8-f00afb787279@redhat.com>
	<1530607697.22880.46.camel@linux.intel.com>
	<b7c410af-ebc0-537c-84c4-588842fec111@redhat.com>
	<6ef13b94-7aa1-78c2-95ca-8fec04510454@redhat.com>
	<1530686022.22880.56.camel@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79c8466a-83d2-2861-e87d-a4ac7aaa8fa3@redhat.com>
Date: Wed, 4 Jul 2018 11:40:45 +0200
MIME-Version: 1.0
In-Reply-To: <1530686022.22880.56.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/5] i386: Add support for IA32_PRED_CMD
 and IA32_ARCH_CAPABILITIES MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Robert Hoo <robert.hu@linux.intel.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, wei.w.wang@intel.com

On 04/07/2018 08:33, Robert Hoo wrote:
>>> And, if I implemented ARCH_CAPABILITIES-bits features in
> FeatureWord,
>>> then no necessity of having it in kvm_msr_entries, right?
> Hi Paolo, would you confirm this? I mean your previous patch "KVM: VMX:
> support MSR_IA32_ARCH_CAPABILITIES as a feature MSR" is not necessary
> now?
> 

The patch is necessary.  However, ARCH_CAPABILITIES is not needed in
kvm_msr.  It is retrieved with KVM_GET_MSR on the *virtual machine* file
descriptor, while kvm_msr is for the KVM_GET/SET_MSR on the *vCPU* file
descriptor.

You still need to do KVM_SET_MSR on each vCPU when it is initialized;
however, that is done separately from the other MSRs.

Paolo
