Received: from eggs.gnu.org ([2001:4830:134:3::10]:40162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL8re-0005rh-Er
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dL8rZ-0008FE-M6
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:42 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:33799)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dL8rZ-0008Ek-EQ
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 10:01:37 -0400
Received: by mail-wr0-x22c.google.com with SMTP id 77so2069847wrb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 07:01:37 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Jun 2017 15:02:06 +0100
Message-Id: <20170614140209.29847-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/3] Fixes for TCG hangs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, pbonzini@redhat.com, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

This is an alternative approach to fixing the hang that Emilio zeroed
in on with:

  https://lists.nongnu.org/archive/html/qemu-devel/2017-06/msg03224.html

Instead of forcing the front-end to treat any MSRs differently we
shortcut the lookup_tb_ptr by checking for icount_decr and
cpu->interrupt_request conditions.

Fundamentally the problem was that an interrupt was pending
(interrupt_request was set) but the "msr daifclr" operations when the
kernel did local_irq/fiq_enable() never got handled because the
cpu_idle loop was being very efficiently chained. As a result we never
got around to exiting the TCG code and calling arm_cpu_do_interrupt
which would then raise the IRQ to move things on.

Emilio's fix is also correct - we should exit the loop whenever the
IRQ conditions may have changed. However by checking in the lookup_ptr
function we avoid churn in figuring out all the other cases in the
front ends. This may have a potential cost for code with lots of
calculated jumps although I would argue its fairly minimal given we've
already sucked up the cost of a helper function and I don't think the
difference between the helper function and a full exit is that
marginal.

I've also included Thomas's thread fix as it has yet to be merged.

I humbly submit my patches to the TCG gods to decide which is the best
approach ;-)

Alex Bennée (2):
  tcg-runtime: light re-factor of lookup_tb_ptr
  tcg-runtime: short-circuit lookup_tb_ptr on IRQs

Thomas Huth (1):
  vl: Fix broken thread=xxx option of the --accel parameter

 tcg-runtime.c | 52 +++++++++++++++++++++++++++++++---------------------
 vl.c          | 13 +++++--------
 2 files changed, 36 insertions(+), 29 deletions(-)

-- 
2.13.0
