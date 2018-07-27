Received: from eggs.gnu.org ([2001:4830:134:3::10]:41064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj0De-0006gY-W7
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 06:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj0De-0002XS-2j
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 06:43:35 -0400
References: <3390c4bf-ffac-3744-fd85-84f4ee8193bf@ilande.co.uk>
	<9c285bce-478f-b786-76e0-f0810336ec23@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <16432a45-ad8b-6c09-b50d-ab7101214912@ilande.co.uk>
Date: Fri, 27 Jul 2018 11:43:09 +0100
MIME-Version: 1.0
In-Reply-To: <9c285bce-478f-b786-76e0-f0810336ec23@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] How to generate custom fw paths for
 IDE devices?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, marcel@redhat.com, Laszlo Ersek <lersek@redhat.com>, armbru@redhat.com, qemu-block@nongnu.org

On 25/07/18 14:03, Paolo Bonzini wrote:

> It's possible as long as you don't add any members.  You can add a new
> const char* argument to ide_bus_new, and call it from cmd646.
> 
> However, another possibility is to implement the FWPathProvider
> interface in the sun4u machine type.  See hw/ppc/spapr.c for an example.

The FWPathProvider approach seems to be working much better, however I'm 
still a bit stuck trying to set the bootindex for the in-built IDE 
interface. Normally I would use -hda for the internal IDE hd and -cdrom 
for the CDROM, but to support bootindex then I need to use -drive.

On PPC macio has 2 IDE interfaces at 0x20000 and 0x21000 and from 
reading the manual I can see that the following works as expected for 
index between 0 and 2:

$ ./qemu-system-ppc -drive 
id=cd,file=MacOS921-macsbug.iso,if=ide,index=0 -nographic -prom-env 
'auto-boot?=false'

Setting index=3 does something a little more strange compared to using 
plain -cdrom:

$ ./qemu-system-ppc -drive 
id=cd,file=MacOS921-macsbug.iso,if=ide,media=cdrom,index=3 -nographic 
-prom-env 'auto-boot?=false'

0 > show-devs

fff8990c /pci@80000000/mac-io@3/ata-3@20000 (ata)
fff89c98 /pci@80000000/mac-io@3/ata-3@21000 (ata)
fff8a024 /pci@80000000/mac-io@3/ata-3@21000/cdrom@0 (block)
fff8a4fc /pci@80000000/mac-io@3/ata-3@21000/cdrom@0/disk@1 (block)

The issue here seems to be that according to "info qtree" there is 
*always* an ide-cd device plugged into the location equivalent to that 
of -cdrom, and so with the above command QEMU ends up adding a second 
ide-cd device to the ide.1 bus which confuses OpenBIOS. Is this 
deliberate behaviour?

Finally it seems I can't set bootindex with if=ide:

$ ./qemu-system-ppc -drive 
id=cd,file=MacOS921-macsbug.iso,if=ide,index=0  -device 
ide-cd,drive=cd,bootindex=0 -nographic -prom-env 'auto-boot?=false'

qemu-system-ppc: -device ide-cd,drive=cd,bootindex=0: Drive 'cd' is 
already in use because it has been automatically connected to another 
device (did you need 'if=none' in the drive options?)

And if I try if=none as suggested then according to "info qtree" the 
drive never gets attached to the in-built ide.0 bus in the first place:

$ ./qemu-system-ppc -drive 
id=cd,file=MacOS921-macsbug.iso,if=none,index=0  -device 
ide-cd,drive=cd,bootindex=0 -nographic -prom-env 'auto-boot?=false'

I'm sure that I'm missing something really obvious here related to 
in-built devices but I can't quite see it at the moment...


ATB,

Mark.
