Received: from eggs.gnu.org ([2001:4830:134:3::10]:53387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e33LR-0004dB-En
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 13:01:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1e33LL-0000so-CK
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 13:01:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:8530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1e33LL-0000sE-2l
	for qemu-devel@nongnu.org; Fri, 13 Oct 2017 13:01:51 -0400
Date: Fri, 13 Oct 2017 18:01:44 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171013170143.GB3370@work-vm>
References: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a41b88a6-4882-1abc-b6e2-e42acf03c198@oracle.com>
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
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, alex.williamson@redhat.com, Sunit Jain <sunit.jain@oracle.com>, ehabkost@redhat.com, rth@twiddle.net

* Prasad Singamsetty (prasad.singamsetty@oracle.com) wrote:
> Hi,
> 
> I am new to the alias. I have some questions on this subject
> and seek some clarifications from the experts in the team.
> I ran into a couple of issues when I tried with large configuration
> ( >= 1TB memory, > 255 CPUs) for x86_64 guest machine.
> 
> 1. QEMU uses the default value of 40 (TCG_PHYS_ADDR_BITS) for address
>    width if user has not specified phys-bits or host-phys-bits=true
>    property. The default value is obviously not sufficient and
>    causing guest kernel to crash if configured with >= 1TB
>    memory. Depending on the linux kernel version in the guest the
>    panic was in different code paths. The workaround is for the
>    user to specify the phys-bits property or set the property
>    host-phys-bits=true.
> 
>    QUESTIONS:
>    1) Could we change the default value to same as the host physcial
>       address for x86_64 machines?  Are there any side effects on this?

That's what we do in the RH downstream packages.

If you did that you wouldn't want to break existing machine-types,
so you'd have to tie it to a new machine type.

There's some fun with MTRRs that have bits set based on the address
size, and if you migrate between hosts with different physical address sizes; e.g. between
a non-Xeon (or I think a Xeon-E3) and the bigger boxes you have
to be careful.  See fcc35e7 and commits around that;  tbh I can't
remember the details.

>    2) Adding a check to fail to boot the guest if phys-bits is not
>       sufficient for the specified maxmem or if it is more than
>       the host phys bits value. Do you have any objections if I
>       add a patch for this?

It's a little more complicated, but good in principal.  You need
to take account of the allocated address space for hotplug
and I think the PCI address space;  I can't remember if we
ever figured out a good way of finding that out.
I think it might also depend if you're on SeaBIOS or OVMF
about what they're defaults are for things like where PCI
gets allocated.

> 2. host_address_width in DMAR table structure
> 
>    In this case, the default value is set to 39
>    (VTD_HOST_ADDRESS_WIDTH - 1). With interrupt remapping
>    enabled for the intel iommu and the guest is configured
>    with > 255 cpus and >= 1TB memory, the guest kernel hangs
>    during boot up. This need to be fixed.
> 
>    QUESTION:
>    The question here again is can we fix this to use the
>    real address width from the host as the default?

I don't know DMAR stuff; chatting to Alex (cc'd) it does sound
like that's an ommission that should be fixed.

> Please let me know if you have some suggestions in fixing these
> two problem cases for supporting large config guests. Also, please
> let me know if there are any other known limitations in the current
> implementation.

Dave

> 
> Thanks.
> --Prasad
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
