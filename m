Received: from eggs.gnu.org ([2001:4830:134:3::10]:51935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eGj8A-0006Od-5C
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:16:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1eGj82-0000po-O1
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:16:46 -0500
References: <20171120091520.86128-1-borntraeger@de.ibm.com>
	<5a4be37f-29b5-1d0d-91ab-9cb15c93e088@suse.de>
	<08cec003-1291-8302-1280-d53cba5c7538@de.ibm.com>
	<5a6cd622-3064-a920-8f72-bc820aa13203@suse.de>
	<ca89eb6e-4565-c789-02f4-98ea6ab05b2f@de.ibm.com>
From: Alexander Graf <agraf@suse.de>
Message-ID: <7c64f444-d9b7-f2d0-0717-717365efa268@suse.de>
Date: Mon, 20 Nov 2017 11:16:37 +0100
MIME-Version: 1.0
In-Reply-To: <ca89eb6e-4565-c789-02f4-98ea6ab05b2f@de.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] pc-bios/s390-ccw: build s390 bios with
 -fno-zero-initialized-in-bss
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>

On 11/20/2017 11:02 AM, Christian Borntraeger wrote:
>
> On 11/20/2017 10:29 AM, Alexander Graf wrote:
>> On 11/20/2017 10:27 AM, Christian Borntraeger wrote:
>>> On 11/20/2017 10:19 AM, Alexander Graf wrote:
>>>> On 11/20/2017 10:15 AM, Christian Borntraeger wrote:
>>>>> The QEMU ELF loader does not initialize the bss segment. This has
>>>>> triggered several bugs in the past, e.g. see commit 5d739a4787a5
>>>>> ("s390-ccw.img: Fix sporadic errors with ccw boot image - initialize
>>>>> css").
>>>>>
>>>>> Instead of fixing these things one-by-one we can build the BIOS
>>>>> with -fno-zero-initialized-in-bss. This will move the zero variables
>>>>> also into the data segment, which is then part of a LOAD section.
>>>> Doesn't this bloat the firmware? Why don't we just manually clear bss in the firmware itself? It's what all other firmwares do :)
>>> Yes the proper fix is to initialize bss in the bios itself.
>>> I was trying to come up with something for 2.11, but since the patch does not solve the original issues, lets drop it.
>>
>> Initializing bss is quite simple. You can probably even do it from C. Just set two variables before and after .bss in the linker script and memset(0) from start to end :).
> Yes, I know but then we have to change the build process to use a linker script.(we rely on the default
> linker script right now).


I'm not sure how common generic linker scripts are, but in our default 
script we have existing markers for bss and end. You can look at the 
default linker script using gcc <c file> -Wl,-verbose. This simple 
source worked for me:


#include <stdio.h>

extern char __bss_start[];
extern char _end[];

int main(void)
{
     printf("BSS size: %lx\n", (long)_end - (long)__bss_start);
     return 0;
}



Alex
