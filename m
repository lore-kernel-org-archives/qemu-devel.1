Received: from eggs.gnu.org ([2001:4830:134:3::10]:41984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBg06-0005tp-6C
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:55:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBg02-0001ka-6U
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:55:34 -0500
Received: from indium.canonical.com ([91.189.90.7]:38400)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBg01-0001k3-Vw
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 06:55:30 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBfzz-0000fY-R6
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 11:55:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CC0CE2E80C3
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 11:55:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 11:40:28 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 696094 <696094@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20101231203043.711.86363.malonedeb@potassium.ubuntu.com>
Message-Id: <150996842889.4347.104938770780402945.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 696094] Re: TI Stellaris lm3s811evb (ARM
 Cortex-M3) : Systick interrupt not working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Tags added: arm

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/696094

Title:
  TI Stellaris lm3s811evb (ARM Cortex-M3) : Systick interrupt not
  working

Status in QEMU:
  New

Bug description:
  I've tried to create a small project that uses the CMSIS as base library.
  The problem is that the SysTick_interrupt_handler() doesn't get executed =
when the systick event is detected in QEMU. Furthermore, it seems asif QEMU=
 gets stuck in an endless loop. QEMU doesn't respond to Ctrl-C on the comma=
nd line and the GDB session also stalls. 'kill -9' is the only way to stop =
QEMU.

  It seems asif the initialisation of the NVIC works fine. I've traced the =
function calls in QEMU as follows:
  stellaris.c: stellaris_init() - Perform generic armv7 init: armv7m_init()
     armv7m.c: armv7m_init() - Create and init the nvic:
                                 nvic =3D qdev_create(NULL, "armv7m_nvic");
                                 env->nvic =3D nvic;
                                 qdev_init_nofail(nvic);
                             - Configure the programmable interrupt control=
ler:
                                 Call: arm_pic_init_cpu() =

                                          qemu_allocate_irqs(arm_pic_cpu_ha=
ndler)
                             - Initialise 64 interrupt structures.

  The following call sequence is observed when the systick event occur:
  armv7m_nvic.c: systick_timer_tick(): set pending interrupt
  armv7m_nvic.c: armv7m_nvic_set_pending() for irq:15
    arm_gic.c: gic_set_pending_private(): GIC_SET_PENDING(15,)
      arm_gic.c: gic_update() - Raise IRQ with qemu_set_irq()
         irq.c: eqmu_set_irq() - Call the irq->handler =

                                 -- I assume the irq handler is 'arm_pic_cp=
u_handler()',
                                    since that was passed as the parameter =
when
                                    qemu_allocate_irqs() was called in ...
            arm_pic.c: arm_pic_cpu_handler() - After evaluation, call cpu_i=
nterrupt()
               exec.c: cpu_interrupt() is called.     =


  The tools that were used during the testing of this project:
    GCC: Codesourcery ARM eabi 2010q3
    QEMU: Checked out on 31/12/2010 - Last commit: 0fcec41eec0432c77645b4a4=
07d3a3e030c4abc4
  The project files are attached, for reproducing of the errors.
     Note: The CMSIS wants to perform byte accesses to the NVIC. For the Co=
rtex-M3, unaligned 8 bit and 16 bit accesses are allowed. The current QEMU =
implementation doesn't yet cater for it. As a work around, updated versions=
 of
  arm_gic.c armv7m_nvic.h armv7m_nvic.c is also included.

  Launch project with: go_gdb.sh
  Attach debugger with: arm-none-eabi-gdbtui --command=3DgdbCommands_tui
  (s =3D step, n =3D next, c =3D continue, Ctrl-C =3D stop, print <variable=
> to look at variable contents)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/696094/+subscriptions
