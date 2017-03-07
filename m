Received: from eggs.gnu.org ([2001:4830:134:3::10]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHO0-0002PH-0t
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1clHNw-0005if-T7
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:52 -0500
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:38509)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1clHNw-0005iR-Lt
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:50:48 -0500
Received: by mail-wm0-x22d.google.com with SMTP id t189so8501849wmt.1
	for <qemu-devel@nongnu.org>; Tue, 07 Mar 2017 07:50:48 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Mar 2017 15:50:43 +0000
Message-Id: <20170307155054.5833-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/11] MTTCG fix-ups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is the latest iteration of fixes for problems introduced by
MTTCG. Aside from the usual slew of addressing review comments and
applying tags I've also pulled in Yongbok Kim's MIPS patch (to replace
mine) and Paolo's VMEXIT fix for the problem reported by Alexander
Boettcher.

Unless anyone shouts I'll wrap these up into a pull request for Peter
tomorrow.

I'm hoping the relative quite on the list is because other
architectures have so far been un-affected by the changes ;-)

However it is a timely reminder with the 2.9 rc0 coming up that now is
the time for target maintainers to check everything is still working
as expected.

The next thing on my list it to look at the icount problems and review
Paolo's fixes for it. However those fixes should go in a separate
series and I assume via Paolo's tree.

Thanks,

Alex.

Alex Bennée (9):
  vl/cpus: be smarter with icount and MTTCG
  target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
  cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
  sparc/sparc64: grab BQL before calling cpu_check_irqs
  s390x/misc_helper.c: wrap IO instructions in BQL
  target/xtensa: hold BQL for interrupt processing
  translate-all: exit cpu_restore_state early if translating
  target/arm/helper: make it clear the EC field is also in hex
  hw/intc/arm_gic: modernise the DPRINTF

Paolo Bonzini (1):
  target-i386: defer VMEXIT to do_interrupt

Yongbok Kim (1):
  target/mips: hold BQL for timer interrupts

 cpus.c                      | 11 +++++++----
 hw/intc/arm_gic.c           | 13 +++++++++----
 hw/sparc/sun4m.c            |  3 +++
 hw/sparc64/sparc64.c        |  3 +++
 target/arm/helper.c         |  2 +-
 target/i386/cpu.h           |  5 +++++
 target/i386/seg_helper.c    | 20 +++++++++++---------
 target/i386/svm_helper.c    | 22 +++++++++++++---------
 target/mips/op_helper.c     | 21 ++++++++++++++++++---
 target/s390x/misc_helper.c  | 21 +++++++++++++++++++++
 target/sparc/int64_helper.c |  3 +++
 target/sparc/win_helper.c   | 13 +++++++++++++
 target/xtensa/helper.c      |  1 +
 target/xtensa/op_helper.c   |  7 +++++++
 translate-all.c             | 13 +++++++++++++
 vl.c                        |  7 ++-----
 16 files changed, 130 insertions(+), 35 deletions(-)

-- 
2.11.0
