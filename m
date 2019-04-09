Received: from eggs.gnu.org ([209.51.188.92]:33304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDnNH-0006lE-Sr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:49:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDnNG-0003bh-Rr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:49:03 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41124)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDnNG-0003b8-HU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:49:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id v7so13006863oie.8
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 10:48:50 +0100
Message-ID: <CAFEAcA9LYR4RnvxX=YB6LgmHMbFsUxm1wjTRq_9JFVwJzZw=kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Lidong Chen <lidong.chen@oracle.com>, QEMU Developers <qemu-devel@nongnu.org>, darren.kenny@oracle.com, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 9 Apr 2019 at 06:51, Markus Armbruster <armbru@redhat.com> wrote:
> $ git-grep '<= ARRAY_SIZE'

Almost all of these are OK because they're the pattern of
checking a loop upper bound before doing a loop.

> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));

These are OK -- we're checking that the upper bound of
a loop (i = 0; i < aprmax; i++) is not greater than the worst
possible upper bound imposed by the array size.

> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {

This is OK, because we're checking that we can
store to the 4 entries starting at s->tx_fifo[s->tx_fifo_len].

> hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);

These are OK beacuse they're checking the number of bytes
held in the array, not an index.

> hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));

These are bugs, as Philippe says.

> hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));

This is another check of a loop upper bound, so it's OK.

> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {

OK, as Aleksandar has said.

> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));

Loop upper bound check, OK.

> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));

Ditto.

> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));

Ditto.

> tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));

This is doing a check after a series of "op->args[pi++]" actions,
so the sense of the test is correct and the question is just
whether it would be better to do the assert before every
array access (which would be pretty expensive and in any
case wouldn't affect production systems where tcg_debug_assert()
is a no-op.)

> util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));

This one seems to be doing an incorrect check, because
we are about to do accesses to poll_fds[n_poll_fds + i]
for i in [0, w->num), so the assert should be checking
"n_poll_fds + w->num <= ARRAY_SIZE(poll_fds)" I think.

> util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));

Loop upper bound check, OK.

thanks
-- PMM
