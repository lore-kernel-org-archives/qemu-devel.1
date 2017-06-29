Received: from eggs.gnu.org ([2001:4830:134:3::10]:42629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrX-0003yv-6x
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrU-0006ty-3X
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:15 -0400
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:33724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dQNrT-0006tm-UD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 21:03:12 -0400
Received: by mail-qt0-x230.google.com with SMTP id r30so63401922qtc.0
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 18:03:11 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 28 Jun 2017 22:02:52 -0300
Message-Id: <20170629010300.2848-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/8] removal of tci (tcg interpreter)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

There have been some comments on the ML about the usefulness of tci.

https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04551.html

  Peter Maydell> I'd prefer we just got rid of it.

https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg04296.html

  Richard Henderson> Is it time to remove it? I'm pretty sure the only hosts
                     for which it will work have proper backends...

Richard quotes are way clearer than me trying to paraphrase what he told me:
- it doesn't use libffi, and as such the way it makes calls to helpers doesn't work for many hosts.
- we already cover almost everthing that debian does. if debian or gentoo doesn't support it, one can confidently say there's little interest.
- if someone *does* want to run qemu on something else, it isn't difficult to port tcg.

I figured out MAINTAINERS was unsync, so added patches 1-4, they are not really
tci-related.

Patches 5,6 are trivial fixes to let the codebase quite sane if there is future
need to revert/reimport tci.

Patches 7,8 are the removal, marked RFC... let's debate!

Regards,

Phil.

PS: How to have fun with TCI and MTTCG:

$ wget -q https://github.com/raspberrypi/firmware/raw/master/boot/kernel7.img
$ ./configure --enable-tcg-interpreter && make subdir-arm-softmmu

$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
Segmentation fault (core dumped)

-

$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
qemu-system-arm: Trying to execute code outside RAM or ROM at 0xef661ad0
This usually means one of the following happened:

(1) You told QEMU to execute a kernel for the wrong machine type, and it crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb QEMU machine)
(2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU executed a ROM full of no-op instructions until it fell off the end
(3) Your guest kernel has a bug and crashed by jumping off into nowhere

This is almost always one of the first two, so check your command line and that you are using the right type of kernel for this machine.
If you think option (3) is likely then you can try debugging your guest with the -d debug options; in particular -d guest_errors will cause the log to include a dump of the guest register state at this point.

Execution cannot continue; stopping here.

Segmentation fault (core dumped)

-

$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
qemu-system-arm: Trying to execute code outside RAM or ROM at 0xe28fe004
This usually means one of the following happened:

(1) You told QEMU to execute a kernel for the wrong machine type, and it crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb QEMU machine)
(2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU executed a ROM full of no-op instructions until it fell off the end
(3) Your guest kernel has a bug and crashed by jumping off into nowhere

This is almost always one of the first two, so check your command line and that you are using the right type of kernel for this machine.
If you think option (3) is likely then you can try debugging your guest with the -d debug options; in particular -d guest_errors will cause the log to include a dump of the guest register state at this point.

Execution cannot continue; stopping here.

qemu-system-arm: qemu/accel/tcg/cpu-exec.c:599: cpu_loop_exec_tb: Assertion `use_icount' failed.
Aborted (core dumped)

-

$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
qemu/tcg/tcg.c:480: temp_idx: Assertion `n >= 0 && n < s->nb_temps' failed.
Aborted (core dumped)

-
$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
write access to unsupported AArch32 system register cp:15 opc1:4 crn:12 crm:0 opc2:0 (non-secure)
Segmentation fault (core dumped)

-

$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
qemu-system-arm: Trying to execute code outside RAM or ROM at 0xe59f5014
This usually means one of the following happened:

(1) You told QEMU to execute a kernel for the wrong machine type, and it crashed on startup (eg trying to run a raspberry pi kernel on a versatilepb QEMU machine)
(2) You didn't give QEMU a kernel or BIOS filename at all, and QEMU executed a ROM full of no-op instructions until it fell off the end
(3) Your guest kernel has a bug and crashed by jumping off into nowhere

This is almost always one of the first two, so check your command line and that you are using the right type of kernel for this machine.
If you think option (3) is likely then you can try debugging your guest with the -d debug options; in particular -d guest_errors will cause the log to include a dump of the guest register state at this point.

Execution cannot continue; stopping here.

qemu: fatal: Trying to execute code outside RAM or ROM at 0xe59f5014
R00=00000031 R01=00000308 R02=00000000 R03=e59f5014
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=00000000 R14=00000308 R15=e59f5014
PSR=a00001d3 N-C- A NS svc32
s00=00000000 s01=00000000 d00=0000000000000000
s02=00000000 s03=00000000 d01=0000000000000000
s04=00000000 s05=00000000 d02=0000000000000000
s06=00000000 s07=00000000 d03=0000000000000000
s08=00000000 s09=00000000 d04=0000000000000000
s10=00000000 s11=00000000 d05=0000000000000000
s12=00000000 s13=00000000 d06=0000000000000000
s14=00000000 s15=00000000 d07=0000000000000000
s16=00000000 s17=00000000 d08=0000000000000000
s18=00000000 s19=00000000 d09=0000000000000000
s20=00000000 s21=00000000 d10=0000000000000000
s22=00000000 s23=00000000 d11=0000000000000000
s24=00000000 s25=00000000 d12=0000000000000000
s26=00000000 s27=00000000 d13=0000000000000000
s28=00000000 s29=00000000 d14=0000000000000000
s30=00000000 s31=00000000 d15=0000000000000000
s32=00000000 s33=00000000 d16=0000000000000000
s34=00000000 s35=00000000 d17=0000000000000000
s36=00000000 s37=00000000 d18=0000000000000000
s38=00000000 s39=00000000 d19=0000000000000000
s40=00000000 s41=00000000 d20=0000000000000000
s42=00000000 s43=00000000 d21=0000000000000000
s44=00000000 s45=00000000 d22=0000000000000000
s46=00000000 s47=00000000 d23=0000000000000000
s48=00000000 s49=00000000 d24=0000000000000000
s50=00000000 s51=00000000 d25=0000000000000000
s52=00000000 s53=00000000 d26=0000000000000000
s54=00000000 s55=00000000 d27=0000000000000000
s56=00000000 s57=00000000 d28=0000000000000000
s58=00000000 s59=00000000 d29=0000000000000000
s60=00000000 s61=00000000 d30=0000000000000000
s62=00000000 s63=00000000 d31=0000000000000000
FPSCR: 00000000

-

$ arm-softmmu/qemu-system-arm -machine raspi2 -cpu cortex-a7 -smp 4 -accel tcg,thread=multi -kernel kernel7.img
qemu-system-arm: Guest expects a stronger memory ordering than the host provides
This may cause strange/hard to debug errors
read access to unsupported AArch32 64 bit system register cp:13 opc1: 13 crm:0 (non-secure)
qemu: fatal: Unhandled exception 0x0

R00=00000002 R01=00000308 R02=00000000 R03=08000000
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=00000000 R14=00000308 R15=08000000
PSR=200001d3 --C- A NS svc32
s00=00000000 s01=00000000 d00=0000000000000000
s02=00000000 s03=00000000 d01=0000000000000000
s04=00000000 s05=00000000 d02=0000000000000000
s06=00000000 s07=00000000 d03=0000000000000000
s08=00000000 s09=00000000 d04=0000000000000000
s10=00000000 s11=00000000 d05=0000000000000000
s12=00000000 s13=00000000 d06=0000000000000000
s14=00000000 s15=00000000 d07=0000000000000000
s16=00000000 s17=00000000 d08=0000000000000000
s18=00000000 s19=00000000 d09=0000000000000000
s20=00000000 s21=00000000 d10=0000000000000000
s22=00000000 s23=00000000 d11=0000000000000000
s24=00000000 s25=00000000 d12=0000000000000000
s26=00000000 s27=00000000 d13=0000000000000000
s28=00000000 s29=00000000 d14=0000000000000000
s30=00000000 s31=00000000 d15=0000000000000000
s32=00000000 s33=00000000 d16=0000000000000000
s34=00000000 s35=00000000 d17=0000000000000000
s36=00000000 s37=00000000 d18=0000000000000000
s38=00000000 s39=00000000 d19=0000000000000000
s40=00000000 s41=00000000 d20=0000000000000000
s42=00000000 s43=00000000 d21=0000000000000000
s44=00000000 s45=00000000 d22=0000000000000000
s46=00000000 s47=00000000 d23=0000000000000000
s48=00000000 s49=00000000 d24=0000000000000000
s50=00000000 s51=00000000 d25=0000000000000000
s52=00000000 s53=00000000 d26=0000000000000000
s54=00000000 s55=00000000 d27=0000000000000000
s56=00000000 s57=00000000 d28=0000000000000000
s58=00000000 s59=00000000 d29=0000000000000000
s60=00000000 s61=00000000 d30=0000000000000000
s62=00000000 s63=00000000 d31=0000000000000000
FPSCR: 00000000

:)

Philippe Mathieu-Daudé (8):
  MAINTAINERS: update tcg entries
  MAINTAINERS: update kvm entries
  MAINTAINERS: update xen entries
  MAINTAINERS: update tci entry
  tcg/tci: enable bswap16_i64
  tcg/tci: disable MTTCG if TCI is enabled
  tcg/tci: time to remove it :(
  travis: remove tcg/tci job

 .travis.yml              |    3 -
 MAINTAINERS              |   16 +-
 Makefile.target          |    2 -
 configure                |   31 +-
 disas.c                  |    5 +-
 disas/Makefile.objs      |    4 -
 disas/tci.c              |   61 ---
 include/disas/bfd.h      |    1 -
 include/exec/exec-all.h  |   16 +-
 tcg/tcg-common.c         |    4 -
 tcg/tcg.c                |    6 +-
 tcg/tci.c                | 1251 ----------------------------------------------
 tcg/tci/README           |  130 -----
 tcg/tci/tcg-target.h     |  195 --------
 tcg/tci/tcg-target.inc.c |  897 ---------------------------------
 15 files changed, 14 insertions(+), 2608 deletions(-)
 delete mode 100644 disas/tci.c
 delete mode 100644 tcg/tci.c
 delete mode 100644 tcg/tci/README
 delete mode 100644 tcg/tci/tcg-target.h
 delete mode 100644 tcg/tci/tcg-target.inc.c

-- 
2.13.1
