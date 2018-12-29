Received: from eggs.gnu.org ([208.118.235.92]:59779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gd3Y5-0008AH-Ec
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 20:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gd3QC-0000hq-Tq
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 20:28:16 -0500
Date: Fri, 28 Dec 2018 23:28:05 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181229012805.GB6817@habkost.net>
References: <20181221124410.11920-1-pbonzini@redhat.com>
	<82D7661F83C1A047AF7DC287873BF1E172C97D77@SHSMSX101.ccr.corp.intel.com>
	<ed344ef0-c519-1c71-c0ad-fb523a5dc516@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed344ef0-c519-1c71-c0ad-fb523a5dc516@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kang, Luwei" <luwei.kang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>

On Fri, Dec 28, 2018 at 02:53:22PM +0100, Paolo Bonzini wrote:
> On 25/12/18 09:23, Kang, Luwei wrote:
> >> From: Qemu-devel [mailto:qemu-devel-bounces+luwei.kang=intel.com@nongnu.org] On Behalf Of Paolo Bonzini
> >> Sent: Friday, December 21, 2018 8:44 PM
> >> To: qemu-devel@nongnu.org
> >> Cc: ehabkost@redhat.com; qemu-stable@nongnu.org
> >> Subject: [Qemu-devel] [PATCH] i386: mark the 'INTEL_PT' CPUID bit as unmigratable
> >>
> >> Marshaling of processor tracing MSRs is not yet implemented in QEMU, mark the feature as unmigratable.
> > 
> > Hi Paolo,
> >     I think Intel PT has supported live migration. I don't understand what you mean.
> > 
> >     commit b77146e9a129bcdb60edc23639211679ae846a92
> >     Author: Chao Peng <chao.p.peng@linux.intel.com>
> >     Date:   Mon Mar 5 00:48:36 2018 +0800
> >     i386: Add support to get/set/migrate Intel Processor Trace feature
> 
> Indeed.  I had forgotten this patch because it was committed so long
> before the kernel parts (which really should not happen, but Eduardo and
> I miscommunicated on it).  Can you check that it still works?

My mistake, sorry.  I should have checked the status of the
kernel code before merging the original series, or waited for
your review.

I'm re-reading the code now and I'm worried about two things:

The code will break if GET_SUPPORTED_CPUID returns INTEL_PT, but
the MSR emulation code is not present yet.  Maybe it won't be an
issue in practice because it happens only between the two Linux
commits (commit 86f5201df0d3 "KVM: x86: Add Intel Processor Trace
cpuid emulation" and commit bf8c55d8dc09 "KVM: x86: Implement
Intel PT MSRs read/write emulation") and shipping a kernel with
the CPUID code without the MSR commit seems pointless.

The kvm_arch_get_supported_cpuid() call inside kvm_get_msrs()
looks suspicious.  What should happen if we try to migrate to a
host that returns a smaller number on
kvm_arch_get_supported_cpuid(0x14, 1, R_EAX)?

-- 
Eduardo
