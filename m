Received: from eggs.gnu.org ([209.51.188.92]:59592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDnEw-0002lT-TN
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:40:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <amarkovic@wavecomp.com>) id 1hDnEv-0007nr-MV
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:40:26 -0400
Received: from mail-eopbgr780109.outbound.protection.outlook.com
	([40.107.78.109]:15296
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <amarkovic@wavecomp.com>)
	id 1hDnEu-0007i1-Oj
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:40:25 -0400
From: Aleksandar Markovic <amarkovic@wavecomp.com>
Date: Tue, 9 Apr 2019 09:40:18 +0000
Message-ID: <BN6PR2201MB1251E6696D83A98F4A1334F6C62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>,
	<87mukziv48.fsf@dusky.pond.sub.org>
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "darren.kenny@oracle.com" <darren.kenny@oracle.com>, "f4bug@amsat.org" <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Andrzej Zaborowski <balrogg@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@wavecomp.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>"f4bug@amsat.org" <f4bug@amsat.org>, "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>Andrzej Zaborowski <balrogg@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>

Markus wrote:

> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:
>=20
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
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D AR=
RAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));

There could be even more:

$ git grep '> ARRAY_SIZE'
hw/display/ssd0323.c:    if (s->cmd_len > ARRAY_SIZE(s->cmd_data)) {
hw/display/vmware_vga.c:                || SVGA_BITMAP_SIZE(x, y) > ARRAY_S=
IZE(cursor.mask)
hw/display/vmware_vga.c:                    > ARRAY_SIZE(cursor.image)) {
hw/dma/xlnx-zdma.c:        len =3D src_size > ARRAY_SIZE(s->buf) ? ARRAY_SI=
ZE(s->buf) : src_size;
hw/net/stellaris_enet.c:    if (s->np > ARRAY_SIZE(s->rx)) {
hw/net/stellaris_enet.c:        if (s->rx[i].len > ARRAY_SIZE(s->rx[i].data=
)) {
hw/net/stellaris_enet.c:    if (s->rx_fifo_offset > ARRAY_SIZE(s->rx[0].dat=
a) - 4) {
hw/net/stellaris_enet.c:    if (s->tx_fifo_len > ARRAY_SIZE(s->tx_fifo)) {
hw/scsi/mptsas.c:    ((s)->name##_head > ARRAY_SIZE((s)->name) ||         \
hw/scsi/mptsas.c:     (s)->name##_tail > ARRAY_SIZE((s)->name))
hw/scsi/mptsas.c:        s->doorbell_cnt > ARRAY_SIZE(s->doorbell_msg) ||
hw/scsi/mptsas.c:        s->doorbell_reply_size > ARRAY_SIZE(s->doorbell_re=
ply) ||
hw/sd/ssi-sd.c:        (!s->stopping && s->arglen > ARRAY_SIZE(s->response)=
))) {
hw/usb/dev-mtp.c:            if (cmd.argc > ARRAY_SIZE(cmd.argv)) {
linux-user/syscall.c:    if (nargs[num] > ARRAY_SIZE(a)) {
target/sh4/translate.c:    if (max_insns > ARRAY_SIZE(insns)) {

CC-ing additional maintainers.

Aleksandar=
