Received: from eggs.gnu.org ([209.51.188.92]:38233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjfr-0000F5-Nq
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hDjfq-0006wM-Mp
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:51:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hDjfq-0006v4-Ck
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 01:51:58 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
Date: Tue, 09 Apr 2019 07:51:51 +0200
In-Reply-To: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	(Lidong Chen's message of "Mon, 8 Apr 2019 15:04:36 -0400")
Message-ID: <87mukziv48.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lidong Chen <lidong.chen@oracle.com>
Cc: qemu-devel@nongnu.org, darren.kenny@oracle.com, f4bug@amsat.org, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

Lidong Chen <lidong.chen@oracle.com> writes:

> Due to an off-by-one error, the assert statements allow an
> out-of-bounds array access.
>
> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> ---
>  hw/sd/sd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index aaab15f..818f86c 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>      if (state == sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <= ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>  
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>      if (rsp == sd_r1b) {
>          rsp = sd_r1;
>      }
> -    assert(rsp <= ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }

This is the second fix for this bug pattern in a fortnight.  Where's
one, there are more:

$ git-grep '<= ARRAY_SIZE'
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {
hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));
hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));
tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));

Lidong Chen, would you like to have a look at these?

Cc'ing maintainers to help with further investigation.
