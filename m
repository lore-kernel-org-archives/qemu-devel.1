Received: from eggs.gnu.org ([2001:4830:134:3::10]:55921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etcan-0007sX-ND
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:11:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etcak-0001MP-HX
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:11:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:46828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1etcak-0001Kx-7J
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 12:11:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1etcai-000334-BD
	for <qemu-devel@nongnu.org>; Wed, 07 Mar 2018 17:11:00 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 53CA42E80CE
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 17:11:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Mar 2018 17:05:01 -0000
From: Antoine <1754038@bugs.launchpad.net>
Reply-To: Bug 1754038 <1754038@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152043137992.20954.13820740787208030462.malonedeb@chaenomeles.canonical.com>
Message-Id: <152044230131.20543.14861676936688828642.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1754038] Re: ARM M: Systick first wrap delayed
 (qemu-timers/icount prb?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I tried to insert an ISB in the loop but I get more or less the same
result.

However, I guess from your response that I did not explain the problem
well enough. I understand that qemu will not be cycle accurate, however,
here, we are not even "one million cycles accurate"! The counter would
have the time to wrap twice before qemu is taking into account the first
ISR... and if we check the following ISR time, we have a good accuracy,
so I still think this is a bug.

Morever, as said above, if I test with qemu 2.5.0 from Ubuntu package I
get an accurate behavior:

setup timer
cnt 00799997  --        7
cnt 0063323b  --        7
cnt 004ccade  --        7
cnt 00366383  --        7
cnt 001ffc26  --        7
cnt 000994ca  --        7
SysTick
cnt 00832d5e  --    10007
cnt 006cc5eb  --        7
cnt 00565e8f  --        7
cnt 003ff733  --        7
cnt 00298fd7  --        7
cnt 0013287b  --        7
SysTick
cnt 008cc108  --    10007
cnt 00765996  --        7
cnt 005ff239  --        7
cnt 00498add  --        7
cnt 00332381  --        7
cnt 001cbc24  --        7
cnt 000654c8  --        7
SysTick
cnt 007fed5c  --    10007
cnt 006985ea  --        7
cnt 00531e8d  --        7
cnt 003cb731  --        7
cnt 00264fd5  --        7
cnt 000fe879  --        7
SysTick
cnt 0089810c  --    10007
cnt 0073199a  --        7
cnt 005cb23d  --        7
[...]

So here I would suspect either a regression in the code or a wrong
combination of options when I compile it myself. I am trying to
recompile version 2.5 myself to sort this out but I am running in other
errors.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1754038

Title:
  ARM M: Systick first wrap delayed (qemu-timers/icount prb?)

Status in QEMU:
  New

Bug description:
  When running this kind of code with qemu:

  static void SysTickISR(void)
  {
  	printf("SysTick\n");
  }

  void main()
  {
  	volatile int i, j;
  	printf("setup timer\n");
  	*(uint32_t*) 0xE000E014 =3D 0x8FFFFF; //reload value
  	*(uint32_t*) 0xE000E018 =3D 0;        //force reload
  	*(uint32_t*) 0xE000E010 =3D 7;        //cpu clk + ISR + enable =


  	for (j =3D 0; j < 0x100; j++) {
  		for (i =3D 0; i < 0x100000; i++)
  			;
  		printf("cnt %08x  -- %8x\n", *(uint32_t*) 0xE000E018, *(uint32_t*)0xE00=
0E010);
  	}
  }

  I get the following output (comments added after '#'):

  setup timer
  cnt 007cccca  --        7
  cnt 006998a2  --        7
  cnt 00566479  --        7
  cnt 0043304f  --        7
  cnt 002ffc26  --        7
  cnt 001cc7fd  --        7
  cnt 000993d5  --        7
  cnt 00000000  --        7  <--- problem here, systick should wrap and rai=
se isr
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  cnt 00000000  --        7
  SysTick                     <--- delayed isr occuring here
  cnt 000986e0  --    10007
  SysTick
  cnt 00865290  --    10007   <---- then running fine as long as regs not m=
odified
  cnt 00731e51  --        7
  cnt 005fea27  --        7
  cnt 004cb5ff  --        7
  cnt 003981d6  --        7
  cnt 00264dad  --        7
  cnt 00131984  --        7
  SysTick
  cnt 008fe545  --    10007
  cnt 007cb106  --        7
  cnt 00697cdd  --        7
  cnt 005648b4  --        7
  cnt 0043148b  --        7
  cnt 002fe061  --        7
  cnt 001cac38  --        7
  cnt 00097810  --        7
  SysTick
  cnt 008643d6  --    10007
  cnt 00730f97  --        7
  cnt 005fdb6d  --        7
  cnt 004ca745  --        7
  cnt 0039731c  --        7
  cnt 00263ef3  --        7
  cnt 00130aca  --        7
  SysTick
  cnt 008fd68b  --    10007
  cnt 007ca24c  --        7
  cnt 00696e23  --        7
  cnt 005639fa  --        7
  cnt 004305d1  --        7
  cnt 002fd1a8  --        7
  cnt 001c9d7f  --        7
  cnt 00096956  --        7
  SysTick
  cnt 0086351d  --    10007
  cnt 007300dd  --        7
  cnt 005fccb4  --        7
  cnt 004c988c  --        7
  cnt 00396463  --        7
  cnt 00263039  --        7
  cnt 0012fc10  --        7
  [...]

  Command line and version:
  qemu-system-arm -M lm3s6965evb -nographic -kernel hello.bin -monitor stdi=
o -serial file:/dev/pts/6 -icount 4 -cpu cortex-m4
  QEMU 2.11.50

  I am compiling from git repo, head is:
  commit f32408f3b472a088467474ab152be3b6285b2d7b
  Author: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
  Date:   Tue Mar 6 13:43:17 2018 +0000

  Config options:
  ./configure --target-list=3Darm-softmmu --enable-debug --disable-slirp --=
enable-tcg-interpreter --disable-blobs --disable-docs --disable-guest-agent=
 --disable-gnutls --disable-nettle --disable-gcrypt --disable-sdl --disable=
-gtk --disable-vnc --disable-virtfs --disable-mpath --disable-xen --disable=
-brlapi --disable-curl --disable-bluez --disable-kvm --disable-hax --disabl=
e-hvf --disable-whpx --disable-rdma --disable-vde --disable-netmap --disabl=
e-linux-aio --disable-cap-ng --disable-attr --disable-vhost-net --disable-s=
pice --disable-rbd --disable-libiscsi --disable-libnfs --disable-smartcard =
--disable-libusb --disable-live-block-migration --disable-usb-redir --disab=
le-lzo --disable-snappy --disable-bzip2 --disable-seccomp --disable-gluster=
fs --disable-tpm --disable-libssh2 --disable-numa --disable-libxml2 --disab=
le-tcmalloc --disable-jemalloc --disable-replication --disable-vhost-vsock =
--disable-opengl --disable-virglrenderer --disable-xfsctl --disable-qom-cas=
t-debug --disable-vxhs --disable-crypto-afalg --disable-vhost-user --disabl=
e-capstone --disable-pie --extra-cflags=3D-mtune=3Dnative

  =

  Not working with git tag 2.10.0 (almost same config)

  Working with stock qemu-arm 2.5.0 from Ubuntu 16.04.

  I started investigating, though I am not familiar with qemu code and I
  could see that the execution is not geting out of
  qemu_tcg_rr_cpu_thread_fn() 'while' loop and timers are not triggered
  because the values in cpu->icount_extra or cpu->icount_budget are not
  to modified accordingly after the timer is set (host side) when the
  systick register is written (target side).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1754038/+subscriptions
