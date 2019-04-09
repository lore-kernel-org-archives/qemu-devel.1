Received: from eggs.gnu.org ([209.51.188.92]:51293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDmbH-0000u6-L2
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDmbG-0006SR-7t
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:27 -0400
Received: from mail-eopbgr790111.outbound.protection.outlook.com
	([40.107.79.111]:39119
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hDmbF-0006QH-Pj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 04:59:26 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 9 Apr 2019 08:59:20 +0000
Message-ID: <BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>,
	<87mukziv48.fsf@dusky.pond.sub.org>
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Lidong Chen <lidong.chen@oracle.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "darren.kenny@oracle.com" <darren.kenny@oracle.com>, "f4bug@amsat.org" <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>

>
> Lidong Chen <lidong.chen@oracle.com> writes:
>
> > Due to an off-by-one error, the assert statements allow an
> > out-of-bounds array access.
> >
> > Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
> > ---
> >  hw/sd/sd.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> > index aaab15f..818f86c 100644
> > --- a/hw/sd/sd.c
> > +++ b/hw/sd/sd.c
> > @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates =
state)
> >      if (state =3D=3D sd_inactive_state) {
> >          return "inactive";
> >      }
> > -    assert(state <=3D ARRAY_SIZE(state_name));
> > +    assert(state < ARRAY_SIZE(state_name));
> >      return state_name[state];
> >  }
> >
> > @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t r=
sp)
> >      if (rsp =3D=3D sd_r1b) {
> >          rsp =3D sd_r1;
> >      }
> > -    assert(rsp <=3D ARRAY_SIZE(response_name));
> > +    assert(rsp < ARRAY_SIZE(response_name));
> >      return response_name[rsp];
> >  }
>
> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:
>
> $ git-grep '<=3D ARRAY_SIZE'
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0=
]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0=
]));
> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SIZE(s-=
>tx_fifo)) {
> hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_fifo);
> hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
> hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));

> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARR=
AY_SIZE (multiple_regs)) {

The last four items are OK as they are. The variable multiple_regs is, in f=
act,
an array of 9 int constants:

static const int multiple_regs[] =3D { 16, 17, 18, 19, 20, 21, 22, 23, 30 }=
;

ARRAY_SIZE (multiple_regs) will always be equal to 9.

The variable base_reglist (that is checked to be > 0 and <=3D9) is used
in succeeding lines like this:

        for (i =3D 0; i < base_reglist; i++) {
            do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
                  GETPC());
            addr +=3D 4;
        }

Therefore, the array multiple_regs will always be accessed within its bound=
s.

> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D AR=
RAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));
>
> Lidong Chen, would you like to have a look at these?
>
> Cc'ing maintainers to help with further investigation.
>

Thank you for bringing this to our attention, Markus. And thanks to Lidong =
too.

Aleksandar

P. S. Shouldn't perhaps our macro ARRAY_SIZE() be renamed to
NUMBER_OF_ELEMENTS()?

________________________________________
From: Markus Armbruster <armbru@redhat.com>
Sent: Tuesday, April 9, 2019 7:51:51 AM
To: Lidong Chen
Cc: qemu-devel@nongnu.org; darren.kenny@oracle.com; f4bug@amsat.org; Peter =
Maydell; Jason Wang; Andrzej Zaborowski; Gerd Hoffmann; Aurelien Jarno; Ale=
ksandar Markovic; Aleksandar Rikalo; David Gibson; Richard Henderson; Paolo=
 Bonzini
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions

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
> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates st=
ate)
>      if (state =3D=3D sd_inactive_state) {
>          return "inactive";
>      }
> -    assert(state <=3D ARRAY_SIZE(state_name));
> +    assert(state < ARRAY_SIZE(state_name));
>      return state_name[state];
>  }
>
> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp=
)
>      if (rsp =3D=3D sd_r1b) {
>          rsp =3D sd_r1;
>      }
> -    assert(rsp <=3D ARRAY_SIZE(response_name));
> +    assert(rsp < ARRAY_SIZE(response_name));
>      return response_name[rsp];
>  }

This is the second fix for this bug pattern in a fortnight.  Where's
one, there are more:

$ git-grep '<=3D ARRAY_SIZE'
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0])=
);
hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr[0])=
);
hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SIZE(s->t=
x_fifo)) {
hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_fifo);
hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D ARRAY=
_SIZE (multiple_regs)) {
target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D ARRA=
Y_SIZE(dbg->arch.bp));
tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));

Lidong Chen, would you like to have a look at these?

Cc'ing maintainers to help with further investigation.
