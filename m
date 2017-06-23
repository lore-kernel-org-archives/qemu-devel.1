Received: from eggs.gnu.org ([2001:4830:134:3::10]:54237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOUAJ-0003op-Kb
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 15:22:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aurelien@aurel32.net>) id 1dOUAI-0004LA-CR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 15:22:47 -0400
Received: from hall.aurel32.net ([2001:bc8:30d7:100::1]:39558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aurelien@aurel32.net>)
	id 1dOUAI-0004Kn-6F
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 15:22:46 -0400
Date: Fri, 23 Jun 2017 21:22:43 +0200
From: Aurelien Jarno <aurelien@aurel32.net>
Message-ID: <20170623192243.eb5bnfy2qqy3dqa4@aurel32.net>
References: <CAEz5UgEp8wRBxeg4nAAd9GVeihcXQv__jfrjQtnVNT8eTNCLOw@mail.gmail.com>
	<20170513182814.ydpkjeekvvjf5rzo@aurel32.net>
	<ecb7491d-6446-a9fa-49d1-f4aaade16470@amsat.org>
	<CAEz5UgGWxLNg+3Qg02H9Mpzkpy=MwP8YFYamZ8LdxK1gMuWq=g@mail.gmail.com>
	<CAEz5UgEQ1=RM2+v8ocUsZxA88jdk5Z+A0eo-G6=iD_CGoZQ2Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEz5UgEQ1=RM2+v8ocUsZxA88jdk5Z+A0eo-G6=iD_CGoZQ2Sw@mail.gmail.com>
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
Cc: Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 2017-06-23 15:14, Vinicius Maciel wrote:
> Hi everyone,
> 
> I'm having a problem similar to the reported in this email, but now I'm
> trying to emulate a MIPS 24KEc,
> ralink RT5350F.
> 
> Assembly Code:
> 0x802006a0 <reset+672>: lui t5,0xb011
> 0x802006a4 <reset+676>: ori t5,t5,0x168
> 0x802006a8 <reset+680>: li t6,23
> 0x802006ac <reset+684>: nop
> 0x802006b0 <reset+688>: sw t6,0(t5) <---
> 
> The instruction "sw t6,0(t5)" try to write to address 0xb0110168 (0x10110168),
> but Qemu decodes
> this address to 2952790112 (0xb0000060). Is this address right?

sw is a write instruction...

> Qemu Debug:
> #0  io_readx (env=0x5555566e4a78, iotlbentry=0x5555566ec348,
> addr=2952790112,
>     retaddr=140737129226144, size=4)
>     at /home/vini/projs/emuladores/qemu-routers/cputlb.c:786
> #1  0x00005555557c9a02 in io_readl (env=0x5555566e4a78, mmu_idx=0, index=0,
>     addr=2952790112, retaddr=140737129226144)
>     at /home/vini/projs/emuladores/qemu-routers/softmmu_template.h:104
> #2  0x00005555557c9b89 in helper_le_ldul_mmu (env=0x5555566e4a78,
> addr=2952790112, <----
>     oi=32, retaddr=140737129226144)
>     at /home/vini/projs/emuladores/qemu-routers/softmmu_template.h:141
> #3  0x00007fffea982108 in code_gen_buffer ()

... while helper_le_ldul_mmu and io_readl are read functions. The
assembly code and the backtrace do not match. We can not conclude
anything.

Aurelien


-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
