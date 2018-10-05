Received: from eggs.gnu.org ([2001:4830:134:3::10]:37998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g8Lmx-0000G2-Ku
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g8Lmu-0005yx-Dp
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:48:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1g8Lmu-0005yl-5e
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 04:48:44 -0400
Date: Fri, 5 Oct 2018 09:48:35 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181005084835.GB2285@work-vm>
References: <cover.1537868529.git.manish.jaggi@cavium.com>
	<CAFEAcA-_5MzdykGKja1sJggx2QVOUXT69NF-Ya2sE8RZFu53fA@mail.gmail.com>
	<20181004150522.sr2woe74vdlpo52k@kamzik.brq.redhat.com>
	<CAFEAcA_JfsuFknwTs=Mq1=A+WoSJSdYnC3NUZxQiuS=jdg0FfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_JfsuFknwTs=Mq1=A+WoSJSdYnC3NUZxQiuS=jdg0FfA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC] [PATCH 0/3] qemu: arm: Migration between
 machines with different MIDR values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Jones <drjones@redhat.com>, mjaggi@caviumnetworks.com, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 4 October 2018 at 16:05, Andrew Jones <drjones@redhat.com> wrote:
> > On Tue, Oct 02, 2018 at 02:07:38PM +0100, Peter Maydell wrote:
> >> Hi; thanks for this patch. The issue I see with this patch
> >> is that the KVM/ARM QEMU approach to system registers so far
> >> has been "the kernel knows about these and it is in control".
> >> So we ask the kernel for the list of registers, and just save
> >> and restore those. That would suggest that if there are sysregs
> >> where it's OK in fact to ignore a difference between two constant
> >> register values, it should be the kernel doing the "actually, this
> >> mismatch is OK" behaviour...
> >
> > I don't think the kernel should have to maintain all that logic. If a user
> > wants to load guest registers, then the kernel should do it, as long as
> > it's safe from the host's integrity/security PoV, and the hardware would
> > actually support it. Anything that can only break the guest, but not the
> > host, should be allowed. The KVM userspace can certainly ask the kernel
> > what it recommends first (i.e. read the invariant registers first, before
> > deciding what to write), but the decision of what to write should be left
> > up to the user.
> 
> I can see the logic of that approach. But right now QEMU
> userspace knows basically nothing about the system registers
> when we're using KVM: all that knowledge is in the kernel.
> So we don't have a place really to put policy info (and
> not really anywhere to put policy info that depends on the
> host CPU type when mostly we let the kernel care about that).

It would seem wrong to put this logic in the kernel because the
priviliged code should be as small as possible.

Dave

> >> For instance, it's probably OK to ignore a MIDR_EL1 difference
> >> that just indicates a minor revision bump; but not to ignore
> >> one that indicates you just tried to migrate a Cortex-A53
> >> over to a Cavium CPU.
> >
> > If the user does that, then the guest will break - oh well. That's not the
> > host kernel's problem.
> 
> Patching QEMU to ignore all attempts to write wrong values
> to read-only registers would be easy. It just wouldn't
> be very helpful to the user...
> 
> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
