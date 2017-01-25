Received: from eggs.gnu.org ([2001:4830:134:3::10]:43452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cWMmf-0007yV-1S
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shorne@gmail.com>) id 1cWMma-0001Dc-0n
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:34:41 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:35139)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shorne@gmail.com>) id 1cWMmZ-0001D6-Ol
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 07:34:35 -0500
Received: by mail-pg0-x244.google.com with SMTP id 204so19621832pge.2
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 04:34:34 -0800 (PST)
Date: Wed, 25 Jan 2017 21:34:30 +0900
From: Stafford Horne <shorne@gmail.com>
Message-ID: <20170125123430.GG7836@lianli.shorne-pla.net>
References: <20170113215720.29598-1-shorne@gmail.com>
	<20170113220252.GE25986@lianli.shorne-pla.net>
	<CAJBMM-sX4fGckYy-eNRdZ9dKamOoJoK2fQ4TLS80T5n6jCkpFg@mail.gmail.com>
	<20170114080435.GF25986@lianli.shorne-pla.net>
	<20170120163918.GD7836@lianli.shorne-pla.net>
	<d27b7c60-a9fe-e92e-a937-d2d13b78f290@twiddle.net>
	<20170124102625.GF7836@lianli.shorne-pla.net>
	<01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <01f7a18d-f4f5-18f3-0932-b32c06ad0b0c@twiddle.net>
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
To: Richard Henderson <rth@twiddle.net>
Cc: Jia Liu <proljc@gmail.com>, qemu-devel@nongnu.org, openrisc@lists.librecores.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 24, 2017 at 10:32:03AM -0800, Richard Henderson wrote:
> On 01/24/2017 02:26 AM, Stafford Horne wrote:
> > If you are having problems booting, both mainline (4.10-rc5) and
> > linux-next (i.e. next-201701124) should be able to boot. i.e.
> > 
> >   export ARCH=openrisc
> >   make defconfig   # defconfig works fine on qemu
> > 
> >   # make any updates to CONFIG_CROSS_COMPILE needed
> >   make
> > 
> >   # start qemu
> >   qemu-system-or32  -cpu or1200 -M or32-sim -kernel $LINUX/vmlinux \
> >    -serial stdio -nographic -monitor none
> > 
> > I just ran those commands with linu-next and my qemu patches and the
> > kernel can boot, but note fails to find init due to config missing
> > initramfs, which I figure you know thats expected.
> > 
> > Let me know what you tried and what problem you are having.
> 
> I've tried booting linux-next and mainline, both from yesterday.
> 
> According to the trace from qemu (-D z -d in_asm,exec), I execute
> 
> ./or32-softmmu/qemu-system-or32 -cpu or1200 -M or32-sim \
>     -kernel ~/work/linux/bld-or/vmlinux -append console=ttyS0 \
>     -serial stdio -nographic -monitor none \
>     -D z -d in_asm,exec,int,op_opt
> 
> ...
> Trace 0x7f501130a880 [0: c036c650] setup_cpuinfo
> Trace 0x7f501130a990 [0: c036c65c] setup_cpuinfo
> Trace 0x7f501130aaa0 [0: c0069774] panic
> ...
> Trace 0x7f5011312b70 [0: 000001fc]
> Trace 0x7f5011312b70 [0: 000001fc]
> 
> That last block repeats forever.
> 
> The qemu I'm using is
> 
>   git://github.com/rth7680/qemu.git tgt-or1k-2
> 
> which has your patch, l.lwa/swa, and a cleanup to the disassembly trace.
> 
> Looking at the kernel source I would hazard a guess that it's
> 
> >         cpu = of_find_compatible_node(NULL, NULL, "opencores,or1200-rtlsvn481");
> >         if (!cpu)
> >                 panic("No compatible CPU found in device tree...\n");
> 
> which suggests some large configuration error.

Hmm, I just tried your qemu branch and mine:

  git@github.com:stffrdhrn/qemu.git or1k-fix-sigill

Both of them were able to boot fine.

The opencores,or1200-rtlsvn481 cpu node is in the or1ksim device tree
definition.  Are you sure your kernel config has this in it?

  CONFIG_OPENRISC_BUILTIN_DTB="or1ksim"

Could you send your kernel config?

I have attached mine, just in case.  For next-20170124

-Stafford

--jI8keyz6grp/JLjh
Content-Type: application/gzip
Content-Disposition: attachment; filename="config.or1k-next-20170124.gz"
Content-Transfer-Encoding: base64

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

--jI8keyz6grp/JLjh--
