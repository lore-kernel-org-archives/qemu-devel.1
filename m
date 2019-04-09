Received: from eggs.gnu.org ([209.51.188.92]:50330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1hDoBE-0005cp-JB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1hDoBD-0003Mj-Gg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:59918)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1hDoB9-0003IW-OY
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 06:40:37 -0400
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <ea798b5f-d48a-c05f-a8cb-d2eb1f6a5a23@oracle.com>
Date: Tue, 9 Apr 2019 11:39:45 +0100
MIME-Version: 1.0
In-Reply-To: <87mukziv48.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, f4bug@amsat.org, darren.kenny@oracle.com, Gerd Hoffmann <kraxel@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, liam.merwick@oracle.comDarren Kenny <darren.kenny@oracle.com>

On 09/04/2019 06:51, Markus Armbruster wrote:
> Lidong Chen <lidong.chen@oracle.com> writes:
>
>> Due to an off-by-one error, the assert statements allow an
>> out-of-bounds array access.
>>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>


Reviewed-by: Liam Merwick <liam.merwick@oracle.com>


>> ---
>>   hw/sd/sd.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index aaab15f..818f86c 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates=
 state)
>>       if (state =3D=3D sd_inactive_state) {
>>           return "inactive";
>>       }
>> -    assert(state <=3D ARRAY_SIZE(state_name));
>> +    assert(state < ARRAY_SIZE(state_name));
>>       return state_name[state];
>>   }
>>  =20
>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t =
rsp)
>>       if (rsp =3D=3D sd_r1b) {
>>           rsp =3D sd_r1;
>>       }
>> -    assert(rsp <=3D ARRAY_SIZE(response_name));
>> +    assert(rsp < ARRAY_SIZE(response_name));
>>       return response_name[rsp];
>>   }
> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:


As Lidong mentioned, an internal static analysis tool (Parfait) was used=20
to catch these. Not every arch/board is compiled but I had eyeballed the=20
code of most interest to me and they seemed fine (e.g. for array=20
accesses, the subsequent loops used a less-than check)

However, this WIN32 code in util/main-loop.c seems wrong.

425=C2=A0=C2=A0=C2=A0=C2=A0 g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds)=
);
426
427=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < w->num; i++) {
428=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_fds[n_poll_fds +=
 i].fd =3D (DWORD_PTR)w->events[i];
429=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll_fds[n_poll_fds +=
 i].events =3D G_IO_IN;
430=C2=A0=C2=A0=C2=A0=C2=A0 }

Seems like this should be:

g_assert(n_poll_fds + w->num <=3D ARRAY_SIZE(poll_fds));

Otherwise, the rest seem fine.

Regards,

Liam


>
> $ git-grep '<=3D ARRAY_SIZE'
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr=
[0]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <=3D ARRAY_SIZE(cs->ich_apr=
[0]));
> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <=3D ARRAY_SIZE(=
s->tx_fifo)) {
> hw/sd/pxa2xx_mmci.c:        && s->tx_len <=3D ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <=3D ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <=3D ARRAY_SIZE(s->resp_fifo=
);
> hw/sd/sd.c:    assert(state <=3D ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <=3D ARRAY_SIZE(response_name));
> hw/usb/hcd-xhci.c:    assert(n <=3D ARRAY_SIZE(tmp));
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <=3D A=
RRAY_SIZE (multiple_regs)) {
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <=3D ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <=3D =
ARRAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <=3D ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <=3D ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <=3D ARRAY_SIZE(dirs));
>
> Lidong Chen, would you like to have a look at these?
>
> Cc'ing maintainers to help with further investigation.
>
