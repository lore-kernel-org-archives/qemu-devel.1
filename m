Received: from eggs.gnu.org ([209.51.188.92]:59038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDnCR-0001eq-5m
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:37:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hDnCP-0005Hg-L1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:37:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hDnCP-0005G1-92
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 05:37:49 -0400
Received: by mail-wr1-f68.google.com with SMTP id h4so19955034wre.7
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 02:37:47 -0700 (PDT)
References: <1554750276-19230-1-git-send-email-lidong.chen@oracle.com>
	<87mukziv48.fsf@dusky.pond.sub.org>
	<BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cd833acf-4643-0d3c-78f5-7677d224954e@redhat.com>
Date: Tue, 9 Apr 2019 11:37:44 +0200
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB125156A5AB0000731B85E76BC62D0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Lidong Chen <lidong.chen@oracle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Aleksandar Rikalo <arikalo@wavecomp.com>, Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "f4bug@amsat.org" <f4bug@amsat.org>, "darren.kenny@oracle.com" <darren.kenny@oracle.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, David Gibson <david@gibson.dropbear.id.au>, "Daniel P. Berrange" <berrange@redhat.com>

On 4/9/19 10:59 AM, Aleksandar Markovic wrote:
>>
>> Lidong Chen <lidong.chen@oracle.com> writes:
>>
>>> Due to an off-by-one error, the assert statements allow an
>>> out-of-bounds array access.
>>>
>>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>>> ---
>>>  hw/sd/sd.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index aaab15f..818f86c 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>>>      if (state == sd_inactive_state) {
>>>          return "inactive";
>>>      }
>>> -    assert(state <= ARRAY_SIZE(state_name));
>>> +    assert(state < ARRAY_SIZE(state_name));
>>>      return state_name[state];
>>>  }
>>>
>>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>>>      if (rsp == sd_r1b) {
>>>          rsp = sd_r1;
>>>      }
>>> -    assert(rsp <= ARRAY_SIZE(response_name));
>>> +    assert(rsp < ARRAY_SIZE(response_name));
>>>      return response_name[rsp];
>>>  }
>>
>> This is the second fix for this bug pattern in a fortnight.  Where's
>> one, there are more:
>>
>> $ git-grep '<= ARRAY_SIZE'
>> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
>> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
>> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {
>> hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
>> hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
>> hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
>> hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
>> hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));
>> hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));
> 
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
>> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> 
> The last four items are OK as they are. The variable multiple_regs is, in fact,
> an array of 9 int constants:
> 
> static const int multiple_regs[] = { 16, 17, 18, 19, 20, 21, 22, 23, 30 };
> 
> ARRAY_SIZE (multiple_regs) will always be equal to 9.
> 
> The variable base_reglist (that is checked to be > 0 and <=9) is used
> in succeeding lines like this:
> 
>         for (i = 0; i < base_reglist; i++) {
>             do_sw(env, addr, env->active_tc.gpr[multiple_regs[i]], mem_idx,
>                   GETPC());
>             addr += 4;
>         }
> 
> Therefore, the array multiple_regs will always be accessed within its bounds.
> 
>> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
>> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
>> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));
>> tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
>> util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
>> util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));
>>
>> Lidong Chen, would you like to have a look at these?
>>
>> Cc'ing maintainers to help with further investigation.
>>
> 
> Thank you for bringing this to our attention, Markus. And thanks to Lidong too.
> 
> Aleksandar
> 
> P. S. Shouldn't perhaps our macro ARRAY_SIZE() be renamed to
> NUMBER_OF_ELEMENTS()?

I remember this post from Daniel where he suggests sticking to GLib
G_N_ELEMENTS() (which looks similar to your suggestion):
https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg02676.html

$ git grep G_N_ELEMENTS|wc -l
125
$ git grep ARRAY_SIZE|wc -l
939

Now it is not obvious to me to understand which GLib API we are
encouraged to use and which ones we shouldn't.

> ________________________________________
> From: Markus Armbruster <armbru@redhat.com>
> Sent: Tuesday, April 9, 2019 7:51:51 AM
> To: Lidong Chen
> Cc: qemu-devel@nongnu.org; darren.kenny@oracle.com; f4bug@amsat.org; Peter Maydell; Jason Wang; Andrzej Zaborowski; Gerd Hoffmann; Aurelien Jarno; Aleksandar Markovic; Aleksandar Rikalo; David Gibson; Richard Henderson; Paolo Bonzini
> Subject: Re: [Qemu-devel] [PATCH] sd: Fix out-of-bounds assertions
> 
> Lidong Chen <lidong.chen@oracle.com> writes:
> 
>> Due to an off-by-one error, the assert statements allow an
>> out-of-bounds array access.
>>
>> Signed-off-by: Lidong Chen <lidong.chen@oracle.com>
>> ---
>>  hw/sd/sd.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index aaab15f..818f86c 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -144,7 +144,7 @@ static const char *sd_state_name(enum SDCardStates state)
>>      if (state == sd_inactive_state) {
>>          return "inactive";
>>      }
>> -    assert(state <= ARRAY_SIZE(state_name));
>> +    assert(state < ARRAY_SIZE(state_name));
>>      return state_name[state];
>>  }
>>
>> @@ -165,7 +165,7 @@ static const char *sd_response_name(sd_rsp_type_t rsp)
>>      if (rsp == sd_r1b) {
>>          rsp = sd_r1;
>>      }
>> -    assert(rsp <= ARRAY_SIZE(response_name));
>> +    assert(rsp < ARRAY_SIZE(response_name));
>>      return response_name[rsp];
>>  }
> 
> This is the second fix for this bug pattern in a fortnight.  Where's
> one, there are more:
> 
> $ git-grep '<= ARRAY_SIZE'
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
> hw/intc/arm_gicv3_cpuif.c:    assert(aprmax <= ARRAY_SIZE(cs->ich_apr[0]));
> hw/net/stellaris_enet.c:        if (s->tx_fifo_len + 4 <= ARRAY_SIZE(s->tx_fifo)) {
> hw/sd/pxa2xx_mmci.c:        && s->tx_len <= ARRAY_SIZE(s->tx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->rx_len <= ARRAY_SIZE(s->rx_fifo)
> hw/sd/pxa2xx_mmci.c:        && s->resp_len <= ARRAY_SIZE(s->resp_fifo);
> hw/sd/sd.c:    assert(state <= ARRAY_SIZE(state_name));
> hw/sd/sd.c:    assert(rsp <= ARRAY_SIZE(response_name));
> hw/usb/hcd-xhci.c:    assert(n <= ARRAY_SIZE(tmp));
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/mips/op_helper.c:    if (base_reglist > 0 && base_reglist <= ARRAY_SIZE (multiple_regs)) {
> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:           <= ARRAY_SIZE(hw_debug_points));
> target/ppc/kvm.c:    assert((nb_hw_breakpoint + nb_hw_watchpoint) <= ARRAY_SIZE(dbg->arch.bp));
> tcg/tcg.c:    tcg_debug_assert(pi <= ARRAY_SIZE(op->args));
> util/main-loop.c:    g_assert(n_poll_fds <= ARRAY_SIZE(poll_fds));
> util/module.c:    assert(n_dirs <= ARRAY_SIZE(dirs));
> 
> Lidong Chen, would you like to have a look at these?
> 
> Cc'ing maintainers to help with further investigation.
> 
