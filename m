Received: from eggs.gnu.org ([2001:4830:134:3::10]:39432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9bmH-00034K-0O
	for qemu-devel@nongnu.org; Sat, 13 May 2017 14:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1d9bmF-0002bJ-Os
	for qemu-devel@nongnu.org; Sat, 13 May 2017 14:28:28 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:46768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1d9bmF-0002Mf-IO
	for qemu-devel@nongnu.org; Sat, 13 May 2017 14:28:27 -0400
Date: Sat, 13 May 2017 20:28:14 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
References: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
Subject: Re: [Qemu-devel] MIPS little endian - Bug when decoding physaddr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vinicius Maciel <viniciusfre@gmail.com>
Cc: qemu-devel@nongnu.org

On 2017-05-12 19:52, Vinicius Maciel wrote:
> Hi all,
> 
> I'm trying to emulate a MIPS 74Kc using a custom machine in order to run a
> CFE bootloader from broadcom. The CPU is Broadcom BCM5357. The problem
> happens when Qemu calculates physaddr inside io_readx(), cputlb.c:line 784
> 
> physaddr = (physaddr & TARGET_PAGE_MASK) + addr;
> 
> After run this line the the value is 0x18000000, which is clearly wrong.

I don't think it's wrong, see below:

> More informations:
> 
> BUG function: io_readx
> Assembly instruction: lw t1,0(a2)
> Machine code: 0x8cc90000 (Little endian)
> Access address: 0xb8000000
> 
> Assembly code:
> 80702f30 <board_earlyinit>:
> 80702f30: 3c06b800 lui a2,0xb800

This load 0xb8000000 in a2

> 80702f34: 24075350 li a3,21328
> 80702f38: 8cc90000 lw t1,0(a2) <----

Now this try to load a value from the virtual address 0xb8000000. This
address corresponds to kseg1 (Kernel Unmapped Uncached) and is mapped
to the physical address 0x18000000. See the MIPS32 Privileged Resource
Architecture Manual for more details how the virtual to physical mapping
works.

Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
