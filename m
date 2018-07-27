Received: from eggs.gnu.org ([2001:4830:134:3::10]:44729)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj0UP-0003cI-6N
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:00:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fj0UO-00031h-31
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 07:00:53 -0400
References: <3390c4bf-ffac-3744-fd85-84f4ee8193bf@ilande.co.uk>
	<9c285bce-478f-b786-76e0-f0810336ec23@redhat.com>
	<16432a45-ad8b-6c09-b50d-ab7101214912@ilande.co.uk>
	<a0593954-0e97-7317-f0ff-f54c194cb137@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <b386f9ed-42e0-ae56-e566-48fa4c181748@ilande.co.uk>
Date: Fri, 27 Jul 2018 12:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <a0593954-0e97-7317-f0ff-f54c194cb137@redhat.com>
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

On 27/07/18 11:47, Paolo Bonzini wrote:

> On 27/07/2018 12:43, Mark Cave-Ayland wrote:
>> The issue here seems to be that according to "info qtree" there is
>> *always* an ide-cd device plugged into the location equivalent to that
>> of -cdrom, and so with the above command QEMU ends up adding a second
>> ide-cd device to the ide.1 bus which confuses OpenBIOS. Is this
>> deliberate behaviour?
> 
> Yes, the default CD-ROM is always placed as secondary/master.
> 
> If you use -device ide-cd the implicit CD-ROM should go away.  However,
> -drive alone doesn't have that effect (probably for backwards
> compatibility reasons, this predates me even though by only a few months).

I see, thanks for the detailed explanation. So in that case shouldn't 
the following work?

$ ./qemu-system-ppc -drive 
id=cd,file=MacOS921-macsbug.iso,if=ide,media=cdrom -device 
ide-cd,drive=cd,bootindex=0 -nographic -prom-env 'auto-boot?=false'

qemu-system-ppc: -device ide-cd,drive=cd,bootindex=0: Drive 'cd' is 
already in use because it has been automatically connected to another 
device (did you need 'if=none' in the drive options?)

 From what I can see you must have if=ide present so that the code will 
take into account that the machine block_default_type is set to IF_IDE 
and understand it's the existing internal IDE buses that need to be 
(re)used?

> Alternatively, you can use -nodefaults of course.

For the moment I'd like to come up with equivalents to the -hda and 
-cdrom options to allow users to switch to the new syntax, and of course 
this is all a pre-cursor to adding virtio support to OpenBIOS :)

It seems to me that -nodefaults is intended more for tools like libvirt 
that want to build up a machine from scratch, although again there is 
always the issue as to how to handle internal devices i.e. the 
difference between plugging a drive into an internal IDE interface vs. 
adding one into a spare PCI slot via -device and instead plugging the 
drive into that.


ATB,

Mark.
