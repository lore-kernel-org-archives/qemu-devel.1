Received: from eggs.gnu.org ([2001:4830:134:3::10]:56778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e51b3-0008Lt-GW
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 23:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1e51az-0002gC-CM
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 23:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1e51az-0002fk-2I
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 23:34:09 -0400
Date: Thu, 19 Oct 2017 11:33:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171019033359.GR4166@pxdev.xzpeter.org>
References: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
	<20171013170143.GB3370@work-vm>
	<20171013111403.293919fe@t450s.home>
	<20171015035318.GA22780@pxdev.xzpeter.org>
	<c4d07be9-7d9b-71fa-e84c-e393138f7a84@oracle.com>
	<20171017035604.GJ4166@pxdev.xzpeter.org>
	<2c478fc6-bb9a-3ac3-1f5d-c853b13dc8a1@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c478fc6-bb9a-3ac3-1f5d-c853b13dc8a1@oracle.com>
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
Cc: Alex Williamson <alex.williamson@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, Sunit Jain <sunit.jain@oracle.com>, ehabkost@redhat.com, rth@twiddle.net

On Wed, Oct 18, 2017 at 10:19:31AM -0700, Prasad Singamsetty wrote:
> 
> 
> On 10/16/2017 8:56 PM, Peter Xu wrote:
> >On Mon, Oct 16, 2017 at 10:02:25AM -0700, Prasad Singamsetty wrote:
> >>
> >>
> >>On 10/14/2017 8:53 PM, Peter Xu wrote:
> >>>On Fri, Oct 13, 2017 at 11:14:03AM -0600, Alex Williamson wrote:
> >>>>On Fri, 13 Oct 2017 18:01:44 +0100
> >>>>"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> >>>>
> >>>>>* Prasad Singamsetty (prasad.singamsetty@oracle.com) wrote:
> >>>>>>Hi,
> >>>>>>
> >>>>>>I am new to the alias. I have some questions on this subject
> >>>>>>and seek some clarifications from the experts in the team.
> >>>>>>I ran into a couple of issues when I tried with large configuration
> >>>>>>( >= 1TB memory, > 255 CPUs) for x86_64 guest machine.
> >>>>>>
> >>>>>>1. QEMU uses the default value of 40 (TCG_PHYS_ADDR_BITS) for address
> >>>>>>    width if user has not specified phys-bits or host-phys-bits=true
> >>>>>>    property. The default value is obviously not sufficient and
> >>>>>>    causing guest kernel to crash if configured with >= 1TB
> >>>>>>    memory. Depending on the linux kernel version in the guest the
> >>>>>>    panic was in different code paths. The workaround is for the
> >>>>>>    user to specify the phys-bits property or set the property
> >>>>>>    host-phys-bits=true.
> >>>>>>
> >>>>>>    QUESTIONS:
> >>>>...
> >>>>>>2. host_address_width in DMAR table structure
> >>>>>>
> >>>>>>    In this case, the default value is set to 39
> >>>>>>    (VTD_HOST_ADDRESS_WIDTH - 1). With interrupt remapping
> >>>>>>    enabled for the intel iommu and the guest is configured
> >>>>>>    with > 255 cpus and >= 1TB memory, the guest kernel hangs
> >>>>>>    during boot up. This need to be fixed.
> >>>>>>
> >>>>>>    QUESTION:
> >>>>>>    The question here again is can we fix this to use the
> >>>>>>    real address width from the host as the default?
> >>>>>
> >>>>>I don't know DMAR stuff; chatting to Alex (cc'd) it does sound
> >>>>>like that's an ommission that should be fixed.
> >>>>
> >>>>[CC +Peter]
> >>>>
> >>>>On physical hardware VT-d supports either 39 or 48 bit address widths
> >>>>and generally you'd expect a sufficiently capable IOMMU to be matched
> >>>>with the CPU.  Seems QEMU has only implemented a lower bit width and
> >>>>it should probably be forcing phys bits of the VM to 39 to match until
> >>>>the extended width can be implemented.  Thanks,
> >>>>
> >>>>Alex
> >>>
> >>>There were patches that tried to enable 48 bits GAW but it was
> >>>not accepted somehow:
> >>>
> >>>   https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg01886.html
> >>>
> >>>Would this help in any way?
> >>>
> >>
> >>Thanks Alex for the patch info. Just curious why the patch was not
> >>accepted. Any way, I will try it.
> >
> >I don't sure I know the reason.  Anyway, it originated from one of
> >Fam's request for some NVMe tests.  If it can really help for your use
> >case as well, please feel free to revive those patches, or let me know
> >so that I can respin.  Thanks,
> >
> 
> Thanks Peter. I will start with your patch and see if I can get
> it to work first.
> 
> A quick question. Looking at the code, it doesn't look like there
> is a way to disable dma remapping. User may have a case where he
> is interested only in interrupt remapping (for > 255 cpus) and
> not DMA remapping. Is that scenario considered before?

It can be done in the guest if the guest doesn't want DMAR.

Note that there are two isolated kernel tunables for the VT-d device:

- intel_iommu: "on" to turn on DMAR, "off" to turn off DMAR
- intremap:    "on" to turn on IR, "off" to turn off IR

So even if guest has "intel_iommu=off" in its boot parameter, IR will
still be on by default (or specify it explicitly using "intremap=on").

Thanks,

-- 
Peter Xu
