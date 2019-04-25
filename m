Received: from eggs.gnu.org ([209.51.188.92]:37271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJcou-00040G-O0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hJcos-0000Sy-W6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:45:40 -0400
Received: from indium.canonical.com ([91.189.90.7]:46848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hJcos-0000Mq-Pd
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 07:45:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hJcor-0005RL-Nu
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 11:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B200E2E80C8
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 11:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Apr 2019 11:37:02 -0000
From: Waldemar Kozaczuk <1826393@bugs.launchpad.net>
Reply-To: Bug 1826393 <1826393@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <155619222209.13917.4120344041326080857.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1826393] [NEW] QEMU 3.1.0 stuck waiting for 800ms
 (5 times slower) in pre-bios phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and that
way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have noticed
that everytime I start QEMU to run OSv, QEMU seems to hand noticably
longer (~1 second) before showing SeaBIOS output. I have tried all kind
of combinations to get rid of that pause and nothing helped.

Here is my start command:
time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
 -device virtio-blk-pci,id=3Dblk0,bootindex=3D0,drive=3Dhd0,scsi=3Doff \
 -drive file=3Dusr.img,if=3Dnone,id=3Dhd0,cache=3Dnone,aio=3Dthre\
 -enable-kvm \
 -cpu host,+x2apic -chardev stdio,mux=3Don,id=3Dstdio,signal=3Doff \
 -mon chardev=3Dstdio,mode=3Dreadline -device isa-serial,chardev=3Dstdio

It looks like qemu process starts, waits almost a second for something
and then print SeaBIOS splashscreen and continues boot:

--> waits here
SeaBIOS (version 1.12.0-1)
Booting from Hard Disk..OSv v0.53.0-6-gc8395118
	disk read (real mode): 27.25ms, (+27.25ms)
	uncompress lzloader.elf: 46.22ms, (+18.97ms)
	TLS initialization: 46.79ms, (+0.57ms)
	.init functions: 47.82ms, (+1.03ms)
	SMP launched: 48.08ms, (+0.26ms)
	VFS initialized: 49.25ms, (+1.17ms)
	Network initialized: 49.48ms, (+0.24ms)
	pvpanic done: 49.57ms, (+0.08ms)
	pci enumerated: 52.42ms, (+2.85ms)
	drivers probe: 52.42ms, (+0.00ms)
	drivers loaded: 55.33ms, (+2.90ms)
	ROFS mounted: 56.37ms, (+1.04ms)
	Total time: 56.37ms, (+0.00ms)
Found optarg
dev  etc  hello  libenviron.so	libvdso.so  proc  tmp  tools  usr

real	0m0.935s
user	0m0.426s
sys	0m0.490s

With version 2.12.0 I used to see real below 200ms. So it seems qemu
slowed down 5 times.

I ran strace -tt against it and I have noticed a pause here:
...
07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) =3D 0
07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) =3D 1
07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) =3D 0
07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) =3D 1
07:31:41.848747 getpid()                =3D 5162
07:31:41.848769 tgkill(5162, 5166, SIGUSR1) =3D 0
07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) =3D 1
07:31:41.848837 getpid()                =3D 5162
07:31:41.848858 tgkill(5162, 5166, SIGUSR1) =3D 0
07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) =3D 8
07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
07:31:41.848943 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLIN}=
, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

{fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D0}, NULL, 8) =3D 1 ([=
{fd=3D8, revents=3DPOLLIN}], left {tv_sec=3D0, tv_nsec=3D0
})
07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1 E=
AGAIN (Resource temporarily unavailable)
07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) =3D 8
07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
07:31:41.849086 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLIN}=
, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

{fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D984624000}, NULL, 8) =
=3D 1 ([{fd=3D7, revents=3DPOLLIN}], left {tv_sec=3D0, t
v_nsec=3D190532609})

--> waits for almost 800ms

07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D 0
07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) =3D 8
07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
07:31:42.643646 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLIN}=
, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

{fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D190066000}, NULL, 8) =
=3D 2 ([{fd=3D4, revents=3DPOLLIN}, {fd=3D8, revents=3DPOL
LIN}], left {tv_sec=3D0, tv_nsec=3D189909632})
07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1 E=
AGAIN (Resource temporarily unavailable)
07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) =3D 8
07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1

...

when I run same command using qemu 3.0.5 that I still happen to have on
the same machine that I built directly from source I see total boot time
at around 200ms. It seems like a regression.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1826393

Title:
  QEMU 3.1.0 stuck waiting for 800ms (5 times slower) in pre-bios phase

Status in QEMU:
  New

Bug description:
  Yesterday I have upgraded my laptop from Ubuntu 18.10 to 19.04 and
  that way got newer QEMU 3.1.0 along vs QEMU 2.12.0 before. I have
  noticed that everytime I start QEMU to run OSv, QEMU seems to hand
  noticably longer (~1 second) before showing SeaBIOS output. I have
  tried all kind of combinations to get rid of that pause and nothing
  helped.

  Here is my start command:
  time qemu-system-x86_64 -m 256M -smp 1 -nographic -nodefaults \
   -device virtio-blk-pci,id=3Dblk0,bootindex=3D0,drive=3Dhd0,scsi=3Doff \
   -drive file=3Dusr.img,if=3Dnone,id=3Dhd0,cache=3Dnone,aio=3Dthre\
   -enable-kvm \
   -cpu host,+x2apic -chardev stdio,mux=3Don,id=3Dstdio,signal=3Doff \
   -mon chardev=3Dstdio,mode=3Dreadline -device isa-serial,chardev=3Dstdio

  It looks like qemu process starts, waits almost a second for something
  and then print SeaBIOS splashscreen and continues boot:

  --> waits here
  SeaBIOS (version 1.12.0-1)
  Booting from Hard Disk..OSv v0.53.0-6-gc8395118
  	disk read (real mode): 27.25ms, (+27.25ms)
  	uncompress lzloader.elf: 46.22ms, (+18.97ms)
  	TLS initialization: 46.79ms, (+0.57ms)
  	.init functions: 47.82ms, (+1.03ms)
  	SMP launched: 48.08ms, (+0.26ms)
  	VFS initialized: 49.25ms, (+1.17ms)
  	Network initialized: 49.48ms, (+0.24ms)
  	pvpanic done: 49.57ms, (+0.08ms)
  	pci enumerated: 52.42ms, (+2.85ms)
  	drivers probe: 52.42ms, (+0.00ms)
  	drivers loaded: 55.33ms, (+2.90ms)
  	ROFS mounted: 56.37ms, (+1.04ms)
  	Total time: 56.37ms, (+0.00ms)
  Found optarg
  dev  etc  hello  libenviron.so	libvdso.so  proc  tmp  tools  usr

  real	0m0.935s
  user	0m0.426s
  sys	0m0.490s

  With version 2.12.0 I used to see real below 200ms. So it seems qemu
  slowed down 5 times.

  I ran strace -tt against it and I have noticed a pause here:
  ...
  07:31:41.848579 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
  07:31:41.848604 futex(0x55c4a2ff6308, FUTEX_WAIT_PRIVATE, 0, NULL) =3D 0
  07:31:41.848649 ioctl(10, KVM_SET_PIT2, 0x7ffdd272d1f0) =3D 0
  07:31:41.848674 ioctl(9, KVM_CHECK_EXTENSION, KVM_CAP_KVMCLOCK_CTRL) =3D 1
  07:31:41.848699 ioctl(10, KVM_SET_CLOCK, 0x7ffdd272d230) =3D 0
  07:31:41.848724 futex(0x55c4a49a9a9c, FUTEX_WAKE_PRIVATE, 2147483647) =3D=
 1
  07:31:41.848747 getpid()                =3D 5162
  07:31:41.848769 tgkill(5162, 5166, SIGUSR1) =3D 0
  07:31:41.848791 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
  07:31:41.848814 futex(0x55c4a49a9a98, FUTEX_WAKE_PRIVATE, 2147483647) =3D=
 1
  07:31:41.848837 getpid()                =3D 5162
  07:31:41.848858 tgkill(5162, 5166, SIGUSR1) =3D 0
  07:31:41.848889 write(8, "\1\0\0\0\0\0\0\0", 8) =3D 8
  07:31:41.848919 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
  07:31:41.848943 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

  {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D0}, NULL, 8) =3D 1 =
([{fd=3D8, revents=3DPOLLIN}], left {tv_sec=3D0, tv_nsec=3D0
  })
  07:31:41.849003 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1=
 EAGAIN (Resource temporarily unavailable)
  07:31:41.849031 read(8, "\5\0\0\0\0\0\0\0", 16) =3D 8
  07:31:41.849064 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 0
  07:31:41.849086 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

  {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D984624000}, NULL, 8=
) =3D 1 ([{fd=3D7, revents=3DPOLLIN}], left {tv_sec=3D0, t
  v_nsec=3D190532609})

  --> waits for almost 800ms

  07:31:42.643272 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D 0
  07:31:42.643522 read(7, "\1\0\0\0\0\0\0\0", 512) =3D 8
  07:31:42.643625 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1
  07:31:42.643646 ppoll([{fd=3D0, events=3DPOLLIN}, {fd=3D4, events=3DPOLLI=
N}, {fd=3D5, events=3DPOLLIN}, {fd=3D7, events=3DPOLLIN}, =

  {fd=3D8, events=3DPOLLIN}], 5, {tv_sec=3D0, tv_nsec=3D190066000}, NULL, 8=
) =3D 2 ([{fd=3D4, revents=3DPOLLIN}, {fd=3D8, revents=3DPOL
  LIN}], left {tv_sec=3D0, tv_nsec=3D189909632})
  07:31:42.643836 futex(0x55c4a2fd34c0, FUTEX_WAIT_PRIVATE, 2, NULL) =3D -1=
 EAGAIN (Resource temporarily unavailable)
  07:31:42.643859 read(8, "\2\0\0\0\0\0\0\0", 16) =3D 8
  07:31:42.643880 futex(0x55c4a2fd34c0, FUTEX_WAKE_PRIVATE, 1) =3D 1

  ...

  when I run same command using qemu 3.0.5 that I still happen to have
  on the same machine that I built directly from source I see total boot
  time at around 200ms. It seems like a regression.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1826393/+subscriptions
