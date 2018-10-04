Received: from eggs.gnu.org ([2001:4830:134:3::10]:43312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g85DO-0000JH-5a
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:07:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1g85D8-0005Ys-Jp
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:06:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15123)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1g85D6-0004eu-Sq
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:06:42 -0400
Date: Thu, 4 Oct 2018 10:05:22 -0500
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20181004150522.sr2woe74vdlpo52k@kamzik.brq.redhat.com>
References: <cover.1537868529.git.manish.jaggi@cavium.com>
	<CAFEAcA-_5MzdykGKja1sJggx2QVOUXT69NF-Ya2sE8RZFu53fA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA-_5MzdykGKja1sJggx2QVOUXT69NF-Ya2sE8RZFu53fA@mail.gmail.com>
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
Cc: mjaggi@caviumnetworks.com, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, "quintela@redhat.com" <quintela@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dgilbert@redhat.com" <dgilbert@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Jaggi, Manish" <Manish.Jaggi@cavium.com>, "Nowicki, Tomasz" <Tomasz.Nowicki@cavium.com>

On Tue, Oct 02, 2018 at 02:07:38PM +0100, Peter Maydell wrote:
> On 27 September 2018 at 02:13,  <mjaggi@caviumnetworks.com> wrote:
> > From: Manish Jaggi <manish.jaggi@cavium.com>
> >
> > QEMU on arm systems use -machine virt -cpu host option for a VM.
> > Migration thus is limited between machines with same cpu.
> >
> > This is a limitation if migration is desired between cpus which are of same
> > family and have only few diferences like bug fixes which have no effect on
> > VM operation. They just differ in say MIDR values.
> >
> > This patchset introduces a command line option -skipinvariant. Invariant
> > registers will be skipped from being restored from guests context on migrated
> > host.
> >
> > Mailing list discussion on this topic:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg560043.html
> 
> Hi; thanks for this patch. The issue I see with this patch
> is that the KVM/ARM QEMU approach to system registers so far
> has been "the kernel knows about these and it is in control".
> So we ask the kernel for the list of registers, and just save
> and restore those. That would suggest that if there are sysregs
> where it's OK in fact to ignore a difference between two constant
> register values, it should be the kernel doing the "actually, this
> mismatch is OK" behaviour...

I don't think the kernel should have to maintain all that logic. If a user
wants to load guest registers, then the kernel should do it, as long as
it's safe from the host's integrity/security PoV, and the hardware would
actually support it. Anything that can only break the guest, but not the
host, should be allowed. The KVM userspace can certainly ask the kernel
what it recommends first (i.e. read the invariant registers first, before
deciding what to write), but the decision of what to write should be left
up to the user.

> 
> For instance, it's probably OK to ignore a MIDR_EL1 difference
> that just indicates a minor revision bump; but not to ignore
> one that indicates you just tried to migrate a Cortex-A53
> over to a Cavium CPU.

If the user does that, then the guest will break - oh well. That's not the
host kernel's problem.

Thanks,
drew
