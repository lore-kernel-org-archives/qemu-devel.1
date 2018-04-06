Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f4Q1M-0001lz-IU
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:59:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1f4Q1J-0006vn-HA
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:59:08 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:23923)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1f4Q1J-0006ul-5U
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:59:05 -0400
Date: Fri, 6 Apr 2018 13:59:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <95d8655f-9956-6d7b-1419-efae9893784f@msgid.tls.msk.ru>
Message-ID: <alpine.BSF.2.21.1804061352030.50304@zero.eik.bme.hu>
References: <6c7ac1ff-b375-f1f7-094e-7fb603c5e40b@msgid.tls.msk.ru>
	<alpine.BSF.2.21.1804021607010.6023@zero.eik.bme.hu>
	<95d8655f-9956-6d7b-1419-efae9893784f@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Subject: Re: [Qemu-devel] some ROMs questions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

On Fri, 6 Apr 2018, Michael Tokarev wrote:
> 02.04.2018 17:30, BALATON Zoltan wrote:
>> On Mon, 2 Apr 2018, Michael Tokarev wrote:
>>> roms/u-boot-sam460ex/tools/updater/stubs.c -
>>> it is some strange symlink pointing to a strange place, probably should be removed?
>>
>> This does not seem to matter for building the rom image but this can be fixed by converting it to a relative path. I've done that and will send a patch to update the submodule as well to use the QEMU repo now that we have a mirror there. Thanks for finding this.
>
> Hmm, I've no idea how to pull a submodule change.. :)

git submodule update? But it's not in master yet only in 
David's ppc-for-2.12 branch I think.

> But I've one more question about this rom.  When I'm trying to build it,
> the build fails:
>
> roms/u-boot-sam460ex$ make Sam460ex_config CROSS_COMPILE=powerpc64-linux-gnu-
> Generating include/autoconf.mk
> cc1: error: -mcall not supported in this configuration
> cc1: error: -mrelocatable not supported in this configuration
> cc1: error: -meabi not supported in this configuration
> cc1: error: -m64 requires a PowerPC64 cpu
> Generating include/autoconf.mk.dep
> cc1: error: -mcall not supported in this configuration
> cc1: error: -mrelocatable not supported in this configuration
> cc1: error: -meabi not supported in this configuration
> cc1: error: -m64 requires a PowerPC64 cpu
> Configuring for Sam460ex board...
>
> roms/u-boot-sam460ex$ make CROSS_COMPILE=powerpc64-linux-gnu-
> ...
> make -C arch/powerpc/cpu/ppc4xx start.o
> make[1]: Entering directory '/build/qemu/debian-qemu/roms/u-boot-sam460ex/arch/powerpc/cpu/ppc4xx'
> powerpc64-linux-gnu-gcc   -D__ASSEMBLY__ -g  -Os   -mrelocatable -fPIC -meabi -ffunction-sections -fdata-sections -D__KERNEL__ -DTEXT_BASE=0xFFF80000 -I/build/qemu/debian-qemu/roms/u-boot-sam460ex/include -fno-builtin -ffreestanding -nostdinc -isystem /usr/lib/gcc-cross/powerpc64-linux-gnu/6/include -pipe  -DCONFIG_PPC -D__powerpc__ -DCONFIG_4xx -ffixed-r2 -mstring -msoft-float -Wa,-m440 -mcpu=440 -DCONFIG_440=1 -I../bios_emulator/scitech/include -I../bios_emulator/scitech/src/x86emu -Dprintk=printf   \
>        -o start.o start.S -c
> start.S:1:0: error: -mcall not supported in this configuration
> /*
>
> start.S:1:0: error: -mrelocatable not supported in this configuration
> start.S:1:0: error: -meabi not supported in this configuration
> start.S:1:0: error: -m64 requires a PowerPC64 cpu
> /build/qemu/debian-qemu/roms/u-boot-sam460ex/config.mk:249: recipe for target 'start.o' failed
> make[1]: *** [start.o] Error 1
> make[1]: Leaving directory '/build/qemu/debian-qemu/roms/u-boot-sam460ex/arch/powerpc/cpu/ppc4xx'
> Makefile:353: recipe for target 'arch/powerpc/cpu/ppc4xx/start.o' failed
> make: *** [arch/powerpc/cpu/ppc4xx/start.o] Error 2
>
> What I'm doing wrong?
>
> $ powerpc64-linux-gnu-gcc --version
> powerpc64-linux-gnu-gcc (Debian 6.3.0-18) 6.3.0 20170516

Note sure, maybe building it with ppc64 compiler or a too new one? This 
board is 32bit and the source is from 2011 so I'm not sure what it does 
with recent compilers. I have powerpc-elf-gcc 4.9.3 which works.

Regards,
BALATON Zoltan
