Received: from eggs.gnu.org ([2001:4830:134:3::10]:57497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhycH-0001qh-Ae
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:48:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fhycE-0002x2-Mh
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:48:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fhycE-0002wo-FL
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:48:42 -0400
Date: Tue, 24 Jul 2018 11:48:39 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180724144839.GG3896@localhost.localdomain>
References: <1519726932-13833-1-git-send-email-liran.alon@oracle.com>
	<20180724112911.GA2314@work-vm>
	<20180724143914.GE3896@localhost.localdomain>
	<baabc7d2-3945-b016-4f93-7a67a9842bf1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baabc7d2-3945-b016-4f93-7a67a9842bf1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] KVM: x86: Add support for save/load
 MSR_SMI_COUNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org, mtosatti@redhat.com, rth@twiddle.net, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, quintela@redhat.com

On Tue, Jul 24, 2018 at 04:40:15PM +0200, Paolo Bonzini wrote:
> On 24/07/2018 16:39, Eduardo Habkost wrote:
> > On Tue, Jul 24, 2018 at 12:29:12PM +0100, Dr. David Alan Gilbert wrote:
> >> * Liran Alon (liran.alon@oracle.com) wrote:
> >>> This MSR returns the number of #SMIs that occurred on
> >>> CPU since boot.
> >>>
> >>> KVM commit 52797bf9a875 ("KVM: x86: Add emulation of MSR_SMI_COUNT")
> >>> introduced support for emulating this MSR.
> >>>
> >>> This commit adds support for QEMU to save/load this
> >>> MSR for migration purposes.
> >>>
> >>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
> >>> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> >>
> >> Note this breaks 2.12->2.11 migration if SMM is enabled
> >> with a:
> >>
> >> qemu-system-x86_64: error while loading state for instance 0x0 of device 'cpu'
> > 
> > Right, the MSR can't be enabled unconditionally.
> > 
> > It looks like there's no CPUID bit for reporting the MSR as
> > available?  How exactly would guests know if the MSR is really
> > safe to use?
> 
> As far as we know, the only guest that uses it is ESX.  Like most other
> MSRs, the guest should in general be ready for it to cause a #GP fault.

True, guests are normally ready to handle both cases: 1) MSR
working as in bare metal; 2) MSR reads causing a #GP fault.

But with the current KVM code, old machine-types can't implement
either of those cases, but only a 3rd option: MSR read won't
cause #GP, but MSR can unexpectedly reset due to live migration.
Are guests ready to handle that?

-- 
Eduardo
