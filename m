Received: from eggs.gnu.org ([2001:4830:134:3::10]:35243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f34lp-0006Gw-Ni
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 15:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f34lm-0008Fg-Iv
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 15:05:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:38725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f34lm-0008F5-8t
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 15:05:30 -0400
References: <20180320090813.852-1-laurent@vivier.eu>
	<d409453e-21c4-c989-c40c-442dcb8f2636@landley.net>
	<7cac14a3-c097-572e-4b61-8960209f6bd9@vivier.eu>
	<67f4fb22-9ad5-7f41-371a-001d1346fc4f@landley.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e95756ac-f3e8-dc5c-31db-c88fbb37756d@vivier.eu>
Date: Mon, 2 Apr 2018 21:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <67f4fb22-9ad5-7f41-371a-001d1346fc4f@landley.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/2] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org
Cc: Finn Thain <fthain@telegraphics.com.au>

Le 02/04/2018 à 20:13, Rob Landley a écrit :
> On 03/30/2018 12:00 PM, Laurent Vivier wrote:
>> Le 30/03/2018 à 18:54, Rob Landley a écrit :
>>> On 03/20/2018 04:08 AM, Laurent Vivier wrote:> This series of patches is needed
>>> to fix a problem
>>>> in the m68k translator that can crash QEMU when translation
>>>> cache has too many instructions:
>>>>
>>>>   qemu-m68k: tcg/tcg.c:883: tcg_temp_alloc: Assertion `n < 512' failed.
>>>>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>>>>
>>>> I have reproduced it in linux user mode, with "ghc", and in
>>>> system mode with the debian-installer for unstable distro
>>>> from debian-ports.
>>>
>>> If someone wanted to follow along with your "boot linux on qemu-system-m68k"
>>> work on https://github.com/vivier/qemu-m68k, which of the 51 branches should
>>> qemu-system-m68k with like -M q800 or whatever you had working be built from?
>>
>> The branch to use is q800-dev
> 
> There isn't any m68k support in musl-libc yet, so I grabbed my old
> https://github.com/landley/aboriginal project, did a "./build.sh m68k", built
> your q800-dev branch, added the m68k-softmmu from that to the start of the
> $PATH, and ran "more/dev-environment-from-build.sh m68k".
> 
> It booted Linux to a shell prompt, I could wget a file from the internet, and
> /home had the 2 gigabyte ext3 mount from the virtual block device.
> 
> I.E. it works for me. Why is it still out of tree?

Remaining patches need some cleanup before being submitted.

I have to submit some enhancements in the FPU emulation, but as they
modify fpu/softfloat.c, I don't want to put them as is in an m68k pull-req:

	target/m68k: manage FPU exceptions
	softfloat: define floatx80_is_any_nan for m68k
	softfloat: disable floatx80_invalid_encoding() for m68k

I have to add some specific m68k hardware emulation:

	m68k: add via support
	m68k: add video card
	q800: Apple Sound Chip (ASC) emulation
	q800: add Nubus support
	q800: add a dummy SWIM floppy controller
	m68k: define Macintosh Quadra 800

but via support should be rewritten as Mark has introduced a new generic
mos6522 VIA device.

I have to update some existing hardware emulation:

	ESP: add pseudo-DMA as used by Macintosh
	escc: introduce a selector for the register bit
	dp8393x: fix receiving buffer exhaustion
	dp8393x: put DMA temp buffer in the state, not in the stack
	dp8393x: manage big endian bus
	dp8393x: fix dp8393x_receive

So, this only needs some work and time. I hope q800 will be available in
QEMU 2.13.

Thanks,
Laurent
