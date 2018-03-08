Received: from eggs.gnu.org ([2001:4830:134:3::10]:38083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etyEj-0005Pe-Hh
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:17:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1etyEf-0000uO-Cu
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:17:45 -0500
Received: from indium.canonical.com ([91.189.90.7]:45022)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1etyEf-0000tm-3A
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 11:17:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1etyEc-0001WK-FK
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 16:17:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8DD2E2E82CD
	for <qemu-devel@nongnu.org>; Thu,  8 Mar 2018 16:10:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Mar 2018 16:02:19 -0000
From: Antoine <1754038@bugs.launchpad.net>
Reply-To: Bug 1754038 <1754038@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152043137992.20954.13820740787208030462.malonedeb@chaenomeles.canonical.com>
Message-Id: <152052493916.7807.12527274838357131859.malone@gac.canonical.com>
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

Ok I spent more time trying to identify the commits giving problem.

So before 8d04fb5, qemu is executing the binary as expected:

setup timer
cnt 007cccca  --        7
cnt 006998a2  --        7
cnt 00566479  --        7
cnt 0043304f  --        7
cnt 002ffc26  --        7
cnt 001cc7fd  --        7
cnt 000993d5  --        7
SysTick
cnt 00865f9c  --    10007
cnt 00732b5c  --        7
cnt 005ff733  --        7
cnt 004cc30a  --        7
[...]


Then, after this commit "tcg: drop global lock during TCG code execution":

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D8d04fb55dec381bc5105cb47f=
29d918e579e8cbd

things start to look bad (but not the same way I first ran into):

setup timer
SysTick
cnt 00000000  --    10007
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
cnt 008ff3e3  --        7
cnt 007cbfba  --        7
cnt 00698b92  --        7
cnt 00565768  --        7
cnt 0043233f  --        7
cnt 002fef16  --        7
cnt 001cbaed  --        7
cnt 000986c5  --        7
SysTick
cnt 0086528b  --    10007
cnt 00731e4c  --        7
cnt 005fea23  --        7
cnt 004cb5fa  --        7
cnt 003981d1  --        7
[...]

Then, not long after, this commit changes a little bit the prb "icount:
process QEMU_CLOCK_VIRTUAL timers in vCPU thread"

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D6b8f0187a4d7c263e356302f8=
d308655372a4b5b

Output then looks like:

setup timer
cnt 007cccca  --        7
cnt 006998a2  --        7
cnt 00566479  --        7
cnt 0043304f  --        7
cnt 002ffc26  --        7
cnt 001cc7fd  --        7
cnt 000993d5  --        7
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
cnt 00000000  --        7
SysTick
cnt 000986e0  --    10007
SysTick
cnt 00865290  --    10007
cnt 00731e51  --        7
cnt 005fea27  --        7
[...]

... and it seems this very problem has been occurring up to now.

I am here using the binary attached, with this command line:

qemu-system-arm -M lm3s6965evb -nographic -kernel hello.bin -serial
file:$(tty) -icount 4 -cpu cortex-m4

And with these build options:

./configure --target-list=3Darm-softmmu --disable-slirp --disable-blobs
--disable-docs --disable-guest-agent --disable-gnutls --disable-nettle
--disable-gcrypt --disable-sdl --disable-gtk --disable-vnc --disable-
virtfs --disable-xen --disable-brlapi --disable-curl --disable-bluez
--disable-kvm --disable-rdma --disable-vde --disable-netmap --disable-
linux-aio --disable-cap-ng --disable-attr --disable-vhost-net --disable-
spice --disable-rbd --disable-libiscsi --disable-libnfs --disable-
smartcard --disable-libusb --disable-usb-redir --disable-lzo --disable-
snappy --disable-bzip2 --disable-seccomp --disable-glusterfs --disable-
tpm --disable-libssh2 --disable-numa --disable-tcmalloc --disable-
jemalloc --disable-opengl --disable-virglrenderer --disable-xfsctl
--disable-qom-cast-debug --disable-pie --extra-cflags=3D-mtune=3Dnative

Note that, to prevent MTTCG/icount error, we must modify configure for
the arm target with:

     mttcg=3D"no"

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
