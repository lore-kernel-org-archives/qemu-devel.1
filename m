Received: from eggs.gnu.org ([2001:4830:134:3::10]:51910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW5t3-0002Ki-SU
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:32:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cW5t3-0000vP-2i
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:32:09 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35532)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cW5t2-0000uu-UO
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 13:32:09 -0500
Received: by mail-qt0-x243.google.com with SMTP id f4so27184659qte.2
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 10:32:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
Date: Tue, 24 Jan 2017 10:32:03 -0800
MIME-Version: 1.0
In-Reply-To: <20170124102625.GF7836@lianli.shorne-pla.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target-openrisc: Fix exception handling
 status registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stafford Horne <shorne@gmail.com>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org

On 01/24/2017 02:26 AM, Stafford Horne wrote:
> If you are having problems booting, both mainline (4.10-rc5) and
> linux-next (i.e. next-201701124) should be able to boot. i.e.
> 
>   export ARCH=openrisc
>   make defconfig   # defconfig works fine on qemu
> 
>   # make any updates to CONFIG_CROSS_COMPILE needed
>   make
> 
>   # start qemu
>   qemu-system-or32  -cpu or1200 -M or32-sim -kernel $LINUX/vmlinux \
>    -serial stdio -nographic -monitor none
> 
> I just ran those commands with linu-next and my qemu patches and the
> kernel can boot, but note fails to find init due to config missing
> initramfs, which I figure you know thats expected.
> 
> Let me know what you tried and what problem you are having.

I've tried booting linux-next and mainline, both from yesterday.

According to the trace from qemu (-D z -d in_asm,exec), I execute

./or32-softmmu/qemu-system-or32 -cpu or1200 -M or32-sim \
    -kernel ~/work/linux/bld-or/vmlinux -append console=ttyS0 \
    -serial stdio -nographic -monitor none \
    -D z -d in_asm,exec,int,op_opt

...
Trace 0x7f501130a880 [0: c036c650] setup_cpuinfo
Trace 0x7f501130a990 [0: c036c65c] setup_cpuinfo
Trace 0x7f501130aaa0 [0: c0069774] panic
...
Trace 0x7f5011312b70 [0: 000001fc]
Trace 0x7f5011312b70 [0: 000001fc]

That last block repeats forever.

The qemu I'm using is

  git://github.com/rth7680/qemu.git tgt-or1k-2

which has your patch, l.lwa/swa, and a cleanup to the disassembly trace.

Looking at the kernel source I would hazard a guess that it's

>         cpu = of_find_compatible_node(NULL, NULL, "opencores,or1200-rtlsvn481");
>         if (!cpu)
>                 panic("No compatible CPU found in device tree...\n");

which suggests some large configuration error.


r~
