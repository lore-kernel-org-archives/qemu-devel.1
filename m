Received: from eggs.gnu.org ([2001:4830:134:3::10]:55810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3ZzV-0004t4-42
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:53:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e3ZzS-0005ib-2Z
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:53:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e3ZzR-0005gN-Ps
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:53:25 -0400
Date: Sun, 15 Oct 2017 11:53:18 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171015035318.GA22780@pxdev.xzpeter.org>
References: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
	<20171013170143.GB3370@work-vm>
	<20171013111403.293919fe@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013111403.293919fe@t450s.home>
Subject: Re: [Qemu-devel] host physical address width issues/questions for
 x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Prasad Singamsetty <prasad.singamsetty@oracle.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Sunit Jain <sunit.jain@oracle.com>, ehabkost@redhat.com, rth@twiddle.net

On Fri, Oct 13, 2017 at 11:14:03AM -0600, Alex Williamson wrote:
> On Fri, 13 Oct 2017 18:01:44 +0100
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Prasad Singamsetty (prasad.singamsetty@oracle.com) wrote:
> > > Hi,
> > > 
> > > I am new to the alias. I have some questions on this subject
> > > and seek some clarifications from the experts in the team.
> > > I ran into a couple of issues when I tried with large configuration
> > > ( >= 1TB memory, > 255 CPUs) for x86_64 guest machine.
> > > 
> > > 1. QEMU uses the default value of 40 (TCG_PHYS_ADDR_BITS) for address
> > >    width if user has not specified phys-bits or host-phys-bits=true
> > >    property. The default value is obviously not sufficient and
> > >    causing guest kernel to crash if configured with >= 1TB
> > >    memory. Depending on the linux kernel version in the guest the
> > >    panic was in different code paths. The workaround is for the
> > >    user to specify the phys-bits property or set the property
> > >    host-phys-bits=true.
> > > 
> > >    QUESTIONS:
> ...
> > > 2. host_address_width in DMAR table structure
> > > 
> > >    In this case, the default value is set to 39
> > >    (VTD_HOST_ADDRESS_WIDTH - 1). With interrupt remapping
> > >    enabled for the intel iommu and the guest is configured
> > >    with > 255 cpus and >= 1TB memory, the guest kernel hangs
> > >    during boot up. This need to be fixed.
> > > 
> > >    QUESTION:
> > >    The question here again is can we fix this to use the
> > >    real address width from the host as the default?  
> > 
> > I don't know DMAR stuff; chatting to Alex (cc'd) it does sound
> > like that's an ommission that should be fixed.
> 
> [CC +Peter]
> 
> On physical hardware VT-d supports either 39 or 48 bit address widths
> and generally you'd expect a sufficiently capable IOMMU to be matched
> with the CPU.  Seems QEMU has only implemented a lower bit width and
> it should probably be forcing phys bits of the VM to 39 to match until
> the extended width can be implemented.  Thanks,
> 
> Alex

There were patches that tried to enable 48 bits GAW but it was
not accepted somehow:

  https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01886.html

Would this help in any way?

Thanks,

-- 
Peter Xu
