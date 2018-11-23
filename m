Received: from eggs.gnu.org ([2001:4830:134:3::10]:59198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQEX0-0003Rz-IM
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:42:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gQEWy-0000Jh-K8
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:42:14 -0500
Date: Fri, 23 Nov 2018 17:41:47 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181123164147.GL1148@toto>
References: <e8dae726-8853-4e44-1eb8-b9cfb0bc44f2@mentor.com>
	<CAFEAcA_EM39P8HFoC=B=XP3Ax8NgNSotn=wMJJsG05P8Ywdruw@mail.gmail.com>
	<abd7b108-4d21-9c1c-16d3-6d31d47f74eb@mentor.com>
	<20181123132017.GJ1148@toto>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123132017.GJ1148@toto>
Subject: Re: [Qemu-devel] [Qemu-discuss] How to select specific qemu net
 'nic' device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mbilal <muhammad_bilal@mentor.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-discuss <qemu-discuss@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>, jasowang@redhat.com

On Fri, Nov 23, 2018 at 02:20:17PM +0100, Edgar E. Iglesias wrote:
> On Fri, Nov 23, 2018 at 02:59:32PM +0500, mbilal wrote:
> > Hi,
> > 
> > Thanks for reply.
> > 
> > According to your suggestion I've tested with 3.1 rc2 release and problem is
> > still exist in this release also.
> > 
> > Here is my reproducible scenario.
> 
> 
> Thanks,
> 
> I've had a look and the assert looks bogus to me.
> We shouldn't be asserting on RX descriptor setups when the receiver is disabled.
> 
> I'll send a patch in a moment.
> 
> Best regards,
> Edgar

+ Jason

Hi,

I've sent a patch to fix te GEM model.
The assert in the GEM model was wrong IMO but I also think the net layer
is behaving a bit suspicious in this case. The qemu_flush_or_purge_queued_packets()
path is delivering queued packets to a net model without checking can_receive().
Without digging too much into the details my gut feeling is that the net layer
shouldn't be doing this. I may be missing something though.

Here's the backtrace:
(gdb) bt
#0  0x00007ffff39e0e97 in raise () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00007ffff39e2801 in abort () from /lib/x86_64-linux-gnu/libc.so.6
#2  0x00007ffff39d239a in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#3  0x00007ffff39d2412 in __assert_fail () from /lib/x86_64-linux-gnu/libc.so.6
#4  0x0000555555b47de6 in gem_receive (nc=<optimized out>, 
    buf=<optimized out>, size=346)
    at /home/edgar/src/c/qemu/qemu/hw/net/cadence_gem.c:982
#5  0x0000555555bf033d in nc_sendv_compat (flags=<optimized out>, iovcnt=1, 
    iov=0x7fffffffd620, nc=0x555556edd360)
    at /home/edgar/src/c/qemu/qemu/net/net.c:701
#6  qemu_deliver_packet_iov (sender=<optimized out>, flags=<optimized out>, 
    iov=0x7fffffffd620, iovcnt=1, opaque=0x555556edd360)
    at /home/edgar/src/c/qemu/qemu/net/net.c:733
#7  0x0000555555bf2a85 in qemu_net_queue_deliver (size=<optimized out>, 
    data=<optimized out>, flags=<optimized out>, sender=<optimized out>, 
    queue=0x555556edd4e0) at /home/edgar/src/c/qemu/qemu/net/queue.c:164
#8  qemu_net_queue_flush (queue=0x555556edd4e0)
    at /home/edgar/src/c/qemu/qemu/net/queue.c:261
#9  0x0000555555bf0d3c in qemu_flush_or_purge_queued_packets (
    nc=0x555556edd360, purge=<optimized out>)
    at /home/edgar/src/c/qemu/qemu/net/net.c:607
#10 0x0000555555bf0dd9 in net_vm_change_state_handler (opaque=<optimized out>, 
    running=0, state=<optimized out>)
    at /home/edgar/src/c/qemu/qemu/net/net.c:1423
#11 0x0000555555a641c7 in vm_state_notify (running=running@entry=0, 
    state=state@entry=RUN_STATE_SHUTDOWN)
    at /home/edgar/src/c/qemu/qemu/vl.c:1562
#12 0x0000555555889b0a in do_vm_stop (state=RUN_STATE_SHUTDOWN, 
    send_stop=<optimized out>) at /home/edgar/src/c/qemu/qemu/cpus.c:1074
#13 0x0000555555844200 in main (argc=<optimized out>, argv=<optimized out>, 
    envp=<optimized out>) at /home/edgar/src/c/qemu/qemu/vl.c:4648
(gdb) q


Cheers,
Edgar


> 
> 
> 
> > 
> > QEMU launching
> > --------------
> > 
> > ./qemu-system-aarch64 -M xlnx-zcu102 -m 1G -kernel /dev/null -S -s  -net nic
> > -net nic -net nic -net nic -net user,hostfwd=tcp::8080-:8080 -smp 1 -serial
> > stdio -serial /dev/null
> > 
> > gdb session
> > ------------
> > 
> > (gdb) file zcu102_net_uni.out
> > Reading symbols from zcu102_net_uni.out...done.
> > (gdb) tar rem :1234
> > Remote debugging using :1234
> > _ld_text_start () at os/arch/armv8/common/arch_asm.S:381
> > 381	    MOV     X14, X0
> > (gdb) load
> > Loading section .text, size 0x59c0c lma 0x0
> > Loading section .rodata, size 0x2bbc lma 0x59c0c
> > Loading section .rtl.data, size 0x770 lma 0x5c7c8
> > Loading section .data, size 0x4dc lma 0x5cf54
> > Start address 0x0, load size 381972
> > Transfer rate: 23313 KB/sec, 2021 bytes/write.
> > (gdb) c
> > Continuing.
> > ^C
> > 
> > 
> > So any breakpoint or Ctrl-C asserts the QEMU.
> > 
> > qemu-system-aarch64: qemu-3.1.0-rc2/hw/net/cadence_gem.c:982: gem_receive:
> > Assertion `!first_desc' failed.
> > 
> > 
> > Our networking demo application running fine unless you interrupt the GDB
> > (either with breakpoints or interrupt signal).
> > You can see following message on QEMU console which is the indication of
> > demo is fine (it also well tested on actual hardware)
> > 
> > Open the following Nucleus node address in your web browser:
> >     http://127.0.0.1:8080/
> > 
> > 
> > I'm attaching demo application binary.
> > 
> > 
> > 
> > 
> > Thanks for care about this issue,
> > -Bilal
> > 
> > 
> > 
> > On 11/23/2018 01:59 PM, Peter Maydell wrote:
> > > On 23 November 2018 at 04:13, mbilal <muhammad_bilal@mentor.com> wrote:
> > > > Hi,
> > > > 
> > > > I'm using qemu emulation for xilinx zcu102 platform, this board have four
> > > > networking GEM0, GEM1, GEM2 and GEM3 devices.
> > > > 
> > > > To run network demo on this board *only* require GEM3 device to be configure
> > > > while other GEM devices don't need to be configure, that's why u-boot and
> > > > other RTOS only configure GEM3 device.
> > > > 
> > > > 
> > > > QEMU is enabling these GEM devices  with networking '-net nic' option and
> > > > QEMU consider first '-net nic' option for GEM0 and second '-net nic' option
> > > > for GEM1 and so on. that's why if need to enable GEM3 network device we must
> > > > need to give following full command line options
> > > > 
> > > > -net nic -net nic -net nic -net nic -net user, ...
> > > > 
> > > > In this way all four GEM devices would be enable but first three GEM0-GEM2
> > > > devices are un-configured and useless. In our case QEMU is being *crashed*
> > > > due to trying to use these un-configured GEM devices to o send/receive GDB
> > > > breakoint/interrupt cause. IIUC QEMU uses first device in the -nic loop
> > > > i.e
> > > > 
> > > > qemu-system-aarch64: hw/net/cadence_gem.c:921: gem_receive: Assertion
> > > > `!first_desc' failed.
> > > 
> > > If QEMU asserts like this, this is a bug in QEMU. I've cc'd
> > > the maintainers of the Xilinx board.
> > > 
> > > Could you provide a complete set of instructions to reproduce
> > > this bug, please ? (full command line, guest image, etc)
> > > 
> > > Could you also tell us which version of QEMU you are using?
> > > If possible, try with the current git master or
> > > with the 3.1 rc2 release candidate we've just put out, to
> > > see if it's already been fixed.
> > > 
> > > thanks
> > > -- PMM
> > > 
> 
> 
