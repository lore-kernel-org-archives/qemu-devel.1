Received: from eggs.gnu.org ([2001:4830:134:3::10]:33772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1falxO-0002Qh-7z
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 13:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1falxL-0000on-4H
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 13:52:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48766)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1falxK-0000kP-Uv
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 13:52:43 -0400
Date: Wed, 4 Jul 2018 14:52:34 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180704175234.GX7451@localhost.localdomain>
References: <1530709942-87947-1-git-send-email-jingqi.liu@intel.com>
	<cfe2a879-d038-f80f-cbec-ae247afde702@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfe2a879-d038-f80f-cbec-ae247afde702@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] kvm: x86: Add support for -machine
 split-lock-ac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jingqi Liu <jingqi.liu@intel.com>, rth@twiddle.net, mtosatti@redhat.com, qemu-devel@nongnu.org, wei.w.wang@intel.com, "Hu, Robert" <robert.hu@intel.com>

On Wed, Jul 04, 2018 at 03:38:32PM +0200, Paolo Bonzini wrote:
> On 04/07/2018 15:12, Jingqi Liu wrote:
> > Add the option split-lock-ac to control whether the #AC
> > exception is generated for split locked accesses, which
> > is introduced for the machine, there is an example to enable it:
> > -machine split-lock-ac=on
> > It is disabled on default.
> > 
> > When bit 29 of the MSR (33H) is set, the processor
> > causes an #AC exception to be issued instead of suppressing LOCK on
> > bus(during split lock access).
> 
> This should be a CPU feature, not a machine feature.  As mentioned in
> the review of the kernel patch, please work with Robert to use the same
> infrastructure for both MSR_TEST_CTL and MSR_IA32_ARCH_CAPABILITIES.
> 
> (Robert, does IceLake have this feature?  If so, we cannot create the
> CPU model until everything is in place).

I don't think we need to block the CPU model because QEMU+KVM
doesn't support some features yet, as long as kernel versions
capable of running the 3.0 version of IceLake-Server will be also
capable of running the 3.1 version of IceLake-Server.

Now, if that condition won't be true and we have some IceLake
features that will added only to more recent kernels, it might be
a good idea to hold the inclusion of the CPU model until
everything is in place.


> 
> BTW, why is the availability of the feature not exposed with a CPUID
> bit?  It doesn't make much sense.

I have the same question.  Without a CPUID bit, guests may block
the VM from being migrated to older hosts because the additional
section for the MSR will appear.

-- 
Eduardo
