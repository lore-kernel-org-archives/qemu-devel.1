Received: from eggs.gnu.org ([2001:4830:134:3::10]:49553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYGb4-0006e9-Pb
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:59:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fYGb1-0000OD-Nw
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:59:22 -0400
Received: from chuckie.co.uk ([82.165.15.123]:54017
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fYGb1-0000FZ-G2
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 15:59:19 -0400
References: <20180623085028.29553-1-mark.cave-ayland@ilande.co.uk>
	<20180623085028.29553-2-mark.cave-ayland@ilande.co.uk>
	<7ac656b2-374a-8591-08a6-8303aae1eba1@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <bde3e16f-e9e1-ace5-f324-83ef2042bc48@ilande.co.uk>
Date: Wed, 27 Jun 2018 20:59:04 +0100
MIME-Version: 1.0
In-Reply-To: <7ac656b2-374a-8591-08a6-8303aae1eba1@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] sysbus: always allow
 explicit_ofw_unit_address() to override address generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, marcel@redhat.com, armbru@redhat.com, mst@redhat.com

On 25/06/18 08:32, Laszlo Ersek wrote:

Hi Laszlo,

>> As any class defining explicit_ofw_unit_address() has explicitly requested a
>> specialised behaviour then it should be used in preference to the default
>> implementation rather than being used as a fallback.
> 
> I disagree about the last paragraph, when put like this. I don't
> disagree with the *goal* of the patch, however the original
> justification for explicit_ofw_unit_address() was different.
> 
> It was meant as a fallback for distinguishing sysbus devices when those
> sysbus devices had neither MMIO nor PIO resources. The issue wasn't that
> MMIO/PIO-based identification was not "right", the issue was that unique
> identification was impossible in the absence of such resources. Please
> see commit 0b336b3b98d8 ("hw/core: explicit OFW unit address callback
> for SysBusDeviceClass", 2015-06-23).
> 
> I don't have anything against repurposing explicit_ofw_unit_address()
> like this -- as long as you check that it doesn't change behavior for
> existing devices -- it's just that we shouldn't justify the new purpose
> with the original intent. The original intent was different.
> 
> I suggest stating, "we can have explicit_ofw_unit_address() take
> priority in a backwards-compatible manner, because no sysbus device
> currently has both explicit_ofw_unit_address() and MMIO/PIO resources".

Thanks for the feedback, I'm more than happy to update the commit 
message to better describe the original intent of the patch. How does 
the following sound to you?


Some SysBusDevices either use sysbus_init_mmio() without 
sysbus_mmio_map() or the first MMIO memory region doesn't represent the 
bus address, causing a firmware device path with an invalid address to 
be generated.

SysBusDeviceClass does provide a virtual explicit_ofw_unit_address() 
method that can be used to override this process, but it is only 
considered as a fallback option meaning that any existing MMIO memory 
regions still take priority whilst determining the firmware device address.

There is currently only one user of explicit_ofw_unit_address() and that 
is the PCI expander bridge (PXB) device which has no MMIO/PIO resources 
defined. This enables us to allow explicit_ofw_unit_address() to take 
priority without affecting backwards compatibility, allowing the address 
to be customised as required.

> (Obviously checking the validity of this statement is up to you; I'm
> just suggesting what I'd see as one more precise explanation.)
  Yes, it seems correct to me - grep tells me the PXB device is the only 
user of explicit_ofw_unit_address() in the whole code base, and there 
are no sysbus_init_*() functions anywhere within pci_expander_bridge.c.


ATB,

Mark.
