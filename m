Received: from eggs.gnu.org ([2001:4830:134:3::10]:46150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHoRC-0002d6-R2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eHoR8-0004eA-1c
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 05:08:54 -0500
Date: Thu, 23 Nov 2017 11:08:44 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171123110844.4649f3b1.cohuck@redhat.com>
In-Reply-To: <a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
References: <1511388334-16347-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1511388334-16347-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<3acc6fdb-5638-97b2-2dc7-bce34d22cd1f@redhat.com>
	<20171123104903.24424b40.cohuck@redhat.com>
	<a3655016-0e6b-b80f-2282-f6efbff9e1f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/7] s390x/pci: factor out endianess
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, agraf@suse.de, Qemu-s390x list <qemu-s390x@nongnu.org>

On Thu, 23 Nov 2017 11:01:23 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 23.11.2017 10:49, Cornelia Huck wrote:
> > On Thu, 23 Nov 2017 09:48:41 +0100
> > Thomas Huth <thuth@redhat.com> wrote:
> >   
> >> On 22.11.2017 23:05, Pierre Morel wrote:  
> >>> There are two places where the same endianness conversion
> >>> is done.
> >>> Let's factor this out into a static function.
> >>>
> >>> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >>> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >>> ---
> >>>  hw/s390x/s390-pci-inst.c | 59 +++++++++++++++++++++++++++---------------------
> >>>  1 file changed, 33 insertions(+), 26 deletions(-)
> >>>
> >>> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >>> index 8e088f3..3e1f1a0 100644
> >>> --- a/hw/s390x/s390-pci-inst.c
> >>> +++ b/hw/s390x/s390-pci-inst.c
> >>> @@ -314,6 +314,36 @@ out:
> >>>      return 0;
> >>>  }
> >>>  
> >>> +/**
> >>> + * Swap data contained in s390x big endian registers to little endian
> >>> + * PCI bars.
> >>> + *
> >>> + * @ptr: a pointer to a uint64_t data field
> >>> + * @len: the length of the valid data, must be 1,2,4 or 8
> >>> + */
> >>> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
> >>> +{
> >>> +    uint64_t data = *ptr;
> >>> +
> >>> +    switch (len) {
> >>> +    case 1:
> >>> +        break;
> >>> +    case 2:
> >>> +        data = bswap16(data);
> >>> +        break;
> >>> +    case 4:
> >>> +        data = bswap32(data);
> >>> +        break;
> >>> +    case 8:
> >>> +        data = bswap64(data);
> >>> +        break;
> >>> +    default:
> >>> +        return -EINVAL;
> >>> +    }
> >>> +    *ptr = data;
> >>> +    return 0;
> >>> +}    
> >>
> >> While you're at it, I think that should rather be leXX_to_cpu() instead
> >> of bswapXX() here,  
> > 
> > I don't think that's correct, as this is supposed to swap BE registers
> > to LE PCI bars.  
> 
> Yes, but for the CPU emulation, the registers are stored in the host's
> endianness in the CPUS390XState structure. Or why do we byte-swap them
> again with cpu_to_be64() during s390_store_status(), for example?

Gah, endian conversion is eating my brain...

So, is the content we get BE or not? I thought in our last discussion
we came to the conclusion that it is.

[I really need to continue working on wiring up zpci in tcg, but I keep
getting sidetracked.]
