Received: from eggs.gnu.org ([2001:4830:134:3::10]:57447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e7dZM-0005Sq-UP
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e7dZJ-0006Xl-RT
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:31:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e7dZJ-0006XK-IT
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 04:31:13 -0400
Date: Thu, 26 Oct 2017 16:30:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171026083057.GB6526@pxdev.xzpeter.org>
References: <20171013170143.GB3370@work-vm>
	<20171013111403.293919fe@t450s.home>
	<20171015035318.GA22780@pxdev.xzpeter.org>
	<c4d07be9-7d9b-71fa-e84c-e393138f7a84@oracle.com>
	<20171017035604.GJ4166@pxdev.xzpeter.org>
	<2c478fc6-bb9a-3ac3-1f5d-c853b13dc8a1@oracle.com>
	<20171019033359.GR4166@pxdev.xzpeter.org>
	<a5eb5b41-a490-11dc-450c-86983460cd5b@oracle.com>
	<20171023063759.GE3990@pxdev.xzpeter.org>
	<d2b2e250-9493-5e08-16a8-f410e51d2bf0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2b2e250-9493-5e08-16a8-f410e51d2bf0@oracle.com>
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
To: Prasad Singamsetty <prasad.singamsetty@oracle.com>
Cc: ehabkost@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Sunit Jain <sunit.jain@oracle.com>, pbonzini@redhat.com, rth@twiddle.net, "Michael S. Tsirkin" <mst@redhat.com>

On Mon, Oct 23, 2017 at 10:23:43AM -0700, Prasad Singamsetty wrote:

[...]

> >>Proposal:
> >>
> >>We can simply change the VTD_HOST_ADDRESS_WIDTH to 48 bits
> >>with out any other changes to the code. The current set of
> >>features in the intel iommu emulator code works for q35
> >>machine type and it doesn't have any other side effect.
> >>Since the remapping tables are allocated by the guest kernel
> >>they are always within the phys-bits range and as long
> >>as the same range supported by intel iommu code in QEMU
> >>it works fine. For the current q35 machine type, all the
> >>supported cpus have <= 48 bits as the physical address
> >>width. For short term, just changing the VTD_HOST_ADDRESS_WIDTH
> >>to 48 should work fine for q35. I tried this and it seems
> >>to work fine.
> >
> >I'm fine to change that macro, but IMHO only changing that line may
> >break backward compatibility of old guests (at least it'll change the
> >max address width reported in ACPI).  So I am not sure that's good.
> 
> Could you refer to any specifics on compatibility issues with old
> guests?  The guest linux kernel doesn't seem to report any problem
> with address width in DMAR reported doesn't match with what is
> supported in the host cpu. I would like to better understand the gaps
> we have here.

I mean for example when an old vIOMMU-enabled QEMU migrates to this
new QEMU.  When the guest first probes the DMAR device using the old
QEMU it should have seen 39 bits GAW, but after the migration to your
new QEMU instance it'll become 48 bits.  This can confuse the guest in
some way.  I'm not sure whether that would be a real problem but I
would rather just introduce the new property for 48 bits to avoid that
problem.

> 
> What other machine types intel iommu is supported with the current
> implementation? Is there any test suite that can test intel iommu
> functionality on supported guest types?

I don't think there are lots of tests on VT-d emulation.  There are a
few in kvm-unit-tests for the simplest DMAR and IR tests though, but I
don't think they are checking against compatibility problems.

Thanks,

> 
> >
> >I would prefer still using the new property ("x-aw-bits", or change
> >the name as you prefer) when people really want the 48 bits address
> >width, or even bigger ones in the future.  It makes sure that 39 bits
> >are still the default.
> >
> >CCing Michael who maintains VT-d emulation codes.
> 
> Thanks.
> --Prasad
> 
> >
> >>
> >>For long term, the VTD_HOST_ADDRESS_WIDTH has to match with
> >>host cpu address width. If necessary we may need to define
> >>a new machine type to keep VTD_HOST_ADDRESS_WIDTH value to
> >>match with the host cpu.
> >>
> >>Please let me know if you have any comments or suggestions
> >>on this.
> >
> >Thanks,
> >

-- 
Peter Xu
