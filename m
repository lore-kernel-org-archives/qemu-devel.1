Received: from eggs.gnu.org ([2001:4830:134:3::10]:52569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgAKi-0000Mx-F1
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:50:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dgAKf-0000I5-4j
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:50:36 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:34536)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dgAKe-0000HK-SX
	for qemu-devel@nongnu.org; Fri, 11 Aug 2017 09:50:33 -0400
Received: by mail-pg0-x232.google.com with SMTP id u185so15881141pgb.1
	for <qemu-devel@nongnu.org>; Fri, 11 Aug 2017 06:50:32 -0700 (PDT)
References: <1502116754-18867-1-git-send-email-peter.maydell@linaro.org>
	<1502116754-18867-2-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fda3a773-3bec-6de5-1e78-cc55f0e22843@linaro.org>
Date: Fri, 11 Aug 2017 06:50:28 -0700
MIME-Version: 1.0
In-Reply-To: <1502116754-18867-2-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] loader: Handle ELF files with
 overlapping zero-initialized data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Hua Yanghao <huayanghao@gmail.com>, Richard Henderson <rth@twiddle.net>, patches@linaro.org

On 08/07/2017 07:39 AM, Peter Maydell wrote:
> For embedded systems, notably ARM, one common use of ELF
> file segments is that the 'physical addresses' represent load addresses
> and the 'virtual addresses' execution addresses, such that
> the load addresses are packed into ROM or flash, and the
> relocation and zero-initialization of data is done at runtime.
> This means that the 'memsz' in the segment header represents
> the runtime size of the segment, but the size that needs to
> be loaded is only the 'filesz'. In particular, paddr+memsz
> may overlap with the next segment to be loaded, as in this
> example:
> 
> 0x70000001 off    0x00007f68 vaddr 0x00008150 paddr 0x00008150 align 2**2
>          filesz 0x00000008 memsz 0x00000008 flags r--
>     LOAD off    0x000000f4 vaddr 0x00000000 paddr 0x00000000 align 2**2
>          filesz 0x00000124 memsz 0x00000124 flags r--
>     LOAD off    0x00000218 vaddr 0x00000400 paddr 0x00000400 align 2**3
>          filesz 0x00007d58 memsz 0x00007d58 flags r-x
>     LOAD off    0x00007f70 vaddr 0x20000140 paddr 0x00008158 align 2**3
>          filesz 0x00000a80 memsz 0x000022f8 flags rw-
>     LOAD off    0x000089f0 vaddr 0x20002438 paddr 0x00008bd8 align 2**0
>          filesz 0x00000000 memsz 0x00004000 flags rw-
>     LOAD off    0x000089f0 vaddr 0x20000000 paddr 0x20000000 align 2**0
>          filesz 0x00000000 memsz 0x00000140 flags rw-
> 
> where the segment at paddr 0x8158 has a memsz of 0x2258 and
> would overlap with the segment at paddr 0x8bd8 if QEMU's loader
> tried to honour it. (At runtime the segments will not overlap
> since their vaddrs are more widely spaced than their paddrs.)
> 
> Currently if you try to load an ELF file like this with QEMU then
> it will fail with an error "rom: requested regions overlap",
> because we create a ROM image for each segment using the memsz
> as the size.
> 
> Support ELF files using this scheme, by truncating the
> zero-initialized part of the segment if it would overlap another
> segment. This will retain the existing loader behaviour for
> all ELF files we currently accept, and also accept ELF files
> which only need 'filesz' bytes to be loaded.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/elf_ops.h | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
