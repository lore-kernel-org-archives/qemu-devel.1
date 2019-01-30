Received: from eggs.gnu.org ([209.51.188.92]:46240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gosDH-00064t-Lb
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:55:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gosDG-000710-90
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:55:43 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:45892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gosDF-0006se-4t
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 10:55:42 -0500
Date: Wed, 30 Jan 2019 16:55:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20190130125526.GC3384@yangzhon-Virtual>
Message-ID: <alpine.BSF.2.21.9999.1901301644150.17768@zero.eik.bme.hu>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
	<1548410831-19553-3-git-send-email-pbonzini@redhat.com>
	<f4208837-83e7-a090-91d5-fc978490da9c@redhat.com>
	<a56cfb65-55a6-5c0d-8e86-d2e71d233d78@redhat.com>
	<20190130125526.GC3384@yangzhon-Virtual>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH 02/52] ide: split ioport registration to a
 separate file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>

On Wed, 30 Jan 2019, Yang Zhong wrote:
> On Wed, Jan 30, 2019 at 01:20:42PM +0100, Paolo Bonzini wrote:
>> On 30/01/19 13:07, Thomas Huth wrote:
>>> I think adding ioport.o to IDE_PCI and IDE_VIA is wrong. The
>>> ide_init_ioport() function is only used by isa.c and piix.c, so it
>>> should only be added for IDE_ISA and IDE_PIIX here.
>>
>> Good idea, another one for Yang. :)
>>
>  Yes, for ioport.o, i will add as below:
>
>  +common-obj-$(CONFIG_IDE_ISA) += isa.o ioport.o
>  +common-obj-$(CONFIG_IDE_PIIX) += piix.o ioport.o
>
>  The newest hw/ide/via.c has removed ide_init_ioport() call.

This was my change. I've changed via.c to implement PCI IDE instead of ISA 
legacy mode that it used to do before (as that's what clients use more). 
However it still needs isa_get_irq() and thus ISA. This IDE controller is 
usually part of VIA superio chips (such as VT82C686 and similar) that have 
ISA and the IRQ seems to be wired to that. This could probably be 
separated further but since device has a register to set IRQ number it 
probably does not worth the added complexity. So it's still not completely 
independent of ISA. (But don't make it dependent on vt82c686 either 
because I'll add another such chip which will also use it later. The 
vt82c686 should depend on via-ide.)

Regards,
BALATON Zoltan
