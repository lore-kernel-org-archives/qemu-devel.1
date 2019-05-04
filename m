Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7EDC43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:23:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDAE206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 13:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDAE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56598 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMud8-0004bW-KW
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 09:23:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44337)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <S.E.Harris@kent.ac.uk>) id 1hMqDO-0007Wf-HY
	for qemu-devel@nongnu.org; Sat, 04 May 2019 04:40:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <S.E.Harris@kent.ac.uk>) id 1hMqDM-0002w0-S0
	for qemu-devel@nongnu.org; Sat, 04 May 2019 04:40:14 -0400
Received: from mx0.kent.ac.uk ([129.12.21.32]:52437)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
	id 1hMqDM-0002uW-LQ
	for qemu-devel@nongnu.org; Sat, 04 May 2019 04:40:12 -0400
Received: from banach.kent.ac.uk ([129.12.41.70])
	by mx0.kent.ac.uk with esmtpsa
	(TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.91)
	(envelope-from <S.E.Harris@kent.ac.uk>)
	id 1hMqDJ-000Jin-4j; Sat, 04 May 2019 09:40:09 +0100
From: Sarah Harris <S.E.Harris@kent.ac.uk>
To: qemu-devel@nongnu.org
Date: Sat,  4 May 2019 09:36:30 +0100
Message-Id: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 129.12.21.32
X-Mailman-Approved-At: Sat, 04 May 2019 09:20:02 -0400
Subject: [Qemu-devel] [PATCH v1 0/8] DRAFT AVR Patches
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: S.E.Harris@kent.ac.uk, mrolnik@gmail.com, A.M.King@kent.ac.uk,
	E.J.C.Robbins@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190504083630._T8tK9rVEDJ4scipZmt6-HlwIUKPdzudhGQJD22XLVc@z>

This series of patches adds support for 8 bit Atmel (Microchip) AVR microcontrollers.
All documented instructions except DES, SPM, and WDR are implemented.
These patches include very incomplete peripheral emulation, and only a single example board definition.

All instructions except LAC, LAS, LAT, XCH, BREAK, and SLEEP have been tested by comparing their behaviours against hardware.
The test programs used were designed specifically to exercise as many instruction variants as possible.
More details, source code, and results are available here: https://github.com/seharris/qemu-avr-tests/tree/master/instruction-tests

Additionally, it has been confirmed that this emulation can run FreeRTOS (an open source realtime operating system).
AVRs don't have memory management hardware and typically only have a few kilobytes of RAM so booting something more standard, e.g. Linux, wasn't feasible.
Two peripherals were needed (USART and 16 bit timer) for this test and are included in these patches.
The implementations are somewhat limited, mostly because QEMU doesn't seem to have much in the way of facilities to handle low-level electrical interfaces like GPIO pins.
A simple LED indicator peripheral was also used, but is not included because it isn't likely to be generally useful.
The FreeRTOS build and LED patch are available here: https://github.com/seharris/qemu-avr-tests/tree/master/free-rtos

These patches are based on work by Michael Rolnik, last discussed here in 2017: https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg02290.html
This series is derived from the version found in this repository: https://github.com/michaelrolnik/qemu-avr
Changes from that version:
- rebase onto current master
- fixes for some accumulated bitrot (including a crash at startup)
- minor improvements to sample board firmware loading
- fixes for bugs in instruction translations (POP, ASR, LSR, ROR, FMUL, FMULS, FMULSU, MUL, MULS, MULSU, OR, SBC, SBCI)
- new instruction decoder to avoid some awkward dependencies
- general cleanup (style fixes, fixing unclear comments, making code easier to follow)

On a personal note, I'm unfamiliar with this style of submission so I hope I haven't broken anything!

Sarah Harris (8):
  target/avr: Add instruction decoder
  target/avr: Add mechanism to check for active debugger connection
  target/avr: Add outward facing interfaces and core CPU logic
  target/avr: Add instruction helpers
  target/avr: Add instruction translation
  target/avr: Add limited support for USART and 16 bit timer peripherals
  target/avr: Add example board configuration
  target/avr: Register AVR support with the rest of QEMU, the build
    system, and the MAINTAINERS file

 MAINTAINERS                     |    6 +
 arch_init.c                     |    2 +
 configure                       |    6 +
 default-configs/avr-softmmu.mak |    5 +
 gdbstub.c                       |    5 +
 hw/Kconfig                      |    1 +
 hw/avr/Kconfig                  |    4 +
 hw/avr/Makefile.objs            |    1 +
 hw/avr/sample.c                 |  177 ++
 hw/char/Kconfig                 |    3 +
 hw/char/Makefile.objs           |    1 +
 hw/char/avr_usart.c             |  316 ++++
 hw/timer/Kconfig                |    3 +
 hw/timer/Makefile.objs          |    1 +
 hw/timer/avr_timer16.c          |  587 ++++++
 include/disas/dis-asm.h         |    6 +
 include/exec/gdbstub.h          |    4 +
 include/hw/char/avr_usart.h     |   99 +
 include/hw/timer/avr_timer16.h  |   99 +
 include/sysemu/arch_init.h      |    1 +
 qapi/common.json                |    2 +-
 target/avr/Makefile.objs        |   23 +
 target/avr/cpu-qom.h            |   83 +
 target/avr/cpu.c                |  570 ++++++
 target/avr/cpu.h                |  238 +++
 target/avr/decode.c             |  441 +++++
 target/avr/decode.h             |   68 +
 target/avr/gdbstub.c            |   85 +
 target/avr/helper.c             |  343 ++++
 target/avr/helper.h             |   28 +
 target/avr/machine.c            |  122 ++
 target/avr/translate-inst.h     |  695 +++++++
 target/avr/translate.c          | 3013 +++++++++++++++++++++++++++++++
 tests/machine-none-test.c       |    1 +
 34 files changed, 7038 insertions(+), 1 deletion(-)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 hw/avr/Kconfig
 create mode 100644 hw/avr/Makefile.objs
 create mode 100644 hw/avr/sample.c
 create mode 100644 hw/char/avr_usart.c
 create mode 100644 hw/timer/avr_timer16.c
 create mode 100644 include/hw/char/avr_usart.h
 create mode 100644 include/hw/timer/avr_timer16.h
 create mode 100644 target/avr/Makefile.objs
 create mode 100644 target/avr/cpu-qom.h
 create mode 100644 target/avr/cpu.c
 create mode 100644 target/avr/cpu.h
 create mode 100644 target/avr/decode.c
 create mode 100644 target/avr/decode.h
 create mode 100644 target/avr/gdbstub.c
 create mode 100644 target/avr/helper.c
 create mode 100644 target/avr/helper.h
 create mode 100644 target/avr/machine.c
 create mode 100644 target/avr/translate-inst.h
 create mode 100644 target/avr/translate.c

-- 
2.21.0


