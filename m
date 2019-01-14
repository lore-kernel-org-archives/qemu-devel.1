Received: from eggs.gnu.org ([209.51.188.92]:59601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj59S-0008GI-CF
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gj59R-0000A1-3r
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:31:50 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:33805)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gj59Q-00008i-B8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:31:48 -0500
Received: by mail-oi1-x22b.google.com with SMTP id r62so18383132oie.1
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:31:47 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Jan 2019 16:31:35 +0000
Message-ID: <CAFEAcA8GE72MaUFvbfHUL7vwkBNzWh+q_0VgzbmLJ-StYhWM4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] -device foo,
 help shouldn't be allowed for devices where -device foo is forbidden
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Thomas Huth <thuth@redhat.com>

We prohibit -device foo for non-pluggable devices:
$ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257
qemu-system-x86_64: -device i8257: Parameter 'driver' expects
pluggable device type

And we suppress them from "-device help" output too.

But we still allow the user to do this:

$ ./build/all/x86_64-softmmu/qemu-system-x86_64 -device i8257,help
i8257 options:
  dshift=<int32>
  base=<int32>
  pageh-base=<int32>
  page-base=<int32>

Does anybody know how best to fix this? I guess we want to check
dc->user_creatable in qdev_device_help() and print "%s is not
a pluggable device" or something similar instead ?

(The output is particularly useless for some devices, eg

$ ./build/all/arm-softmmu/qemu-system-arm -M virt -device iotkit,help
iotkit options:
  ppc-irq-splitter-5=<child<split-irq>>
  nswatchdog=<child<cmsdk-apb-watchdog>>
  iotkit-sysinfo=<child<iotkit-sysinfo>>
  sec-resp-splitter=<child<split-irq>>
  ppc-irq-splitter-6=<child<split-irq>>
  mpc-irq-splitter-16=<child<split-irq>>
  memory=<link<qemu:memory-region>>
  mpc=<child<tz-mpc>>
  dualtimer=<child<cmsdk-apb-dualtimer>>
  ppc-irq-splitter-9=<child<split-irq>>
  ppc-irq-splitter-8=<child<split-irq>>
  ppc-irq-splitter-7=<child<split-irq>>
  mpc-irq-splitter-6=<child<split-irq>>
  ppc-irq-splitter-4=<child<split-irq>>
  iotkit-container[0]=<child<qemu:memory-region>>
  s32kwatchdog=<child<cmsdk-apb-watchdog>>
  mpc-irq-splitter-5=<child<split-irq>>
  iotkit-sysctl=<child<iotkit-sysctl>>
  EXP_NUMIRQ=<uint32>
  MAINCLK=<uint32>
  mpc-irq-orgate=<child<or-irq>>
  mpc-irq-splitter-9=<child<split-irq>>
  mpc-irq-splitter-8=<child<split-irq>>
  mpc-irq-splitter-7=<child<split-irq>>
  mpc-irq-splitter-4=<child<split-irq>>
  mpc-irq-splitter-2=<child<split-irq>>
  mpc-irq-splitter-1=<child<split-irq>>
  mpc-irq-splitter-3=<child<split-irq>>
  apb-ppc1=<child<tz-ppc>>
  apb-ppc0=<child<tz-ppc>>
  mpc-irq-splitter-0=<child<split-irq>>
  mpc-irq-splitter-15=<child<split-irq>>
  mpc-irq-splitter-14=<child<split-irq>>
  mpc-irq-splitter-13=<child<split-irq>>
  mpc-irq-splitter-12=<child<split-irq>>
  mpc-irq-splitter-11=<child<split-irq>>
  mpc-irq-splitter-10=<child<split-irq>>
  ppc-irq-splitter-3=<child<split-irq>>
  ppc-irq-splitter-2=<child<split-irq>>
  ppc-irq-splitter-1=<child<split-irq>>
  swatchdog=<child<cmsdk-apb-watchdog>>
  nmi-orgate=<child<or-irq>>
  s32ktimer=<child<cmsdk-apb-timer>>
  ppc-irq-splitter-0=<child<split-irq>>
  timer1=<child<cmsdk-apb-timer>>
  timer0=<child<cmsdk-apb-timer>>
  secctl=<child<iotkit-secctl>>
  armv7m=<child<armv7m>>
  ppc-irq-orgate=<child<or-irq>>

where the properties are all intended to be
set up by QEMU code, not by a user.)

thanks
-- PMM
