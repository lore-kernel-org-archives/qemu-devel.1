Received: from eggs.gnu.org ([209.51.188.92]:36981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guFYn-0007iT-35
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:52:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1guFYm-0002je-1q
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:52:09 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1guFYl-0002iI-Jg
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 06:52:07 -0500
Received: by mail-wr1-x444.google.com with SMTP id o17so6168278wrw.3
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 03:52:07 -0800 (PST)
References: <20181206151401.13455-1-peter.maydell@linaro.org>
	<87ftsrird3.fsf@zen.linaroharston>
	<CAFEAcA_GPW0B9bMOia_aB=H0PV8DwUNWBARz+uNbRk2565a+4w@mail.gmail.com>
	<87bm3figs9.fsf@zen.linaroharston>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <87bm3figs9.fsf@zen.linaroharston>
Date: Thu, 14 Feb 2019 11:52:04 +0000
Message-ID: <875ztmio4b.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] arm: Allow system registers for KVM guests
 to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Dongjiu Geng <gengdongjiu@huawei.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>


Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Wed, 13 Feb 2019 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>>
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>> > At the moment the Arm implementations of kvm_arch_{get,put}_registers=
()
>>> > don't support having QEMU change the values of system registers
>>> > (aka coprocessor registers for AArch32). This is because although
>>> > kvm_arch_get_registers() calls write_list_to_cpustate() to
>>> > update the CPU state struct fields (so QEMU code can read the
>>> > values in the usual way), kvm_arch_put_registers() does not
>>> > call write_cpustate_to_list(), meaning that any changes to
>>> > the CPU state struct fields will not be passed back to KVM.
<snip>
>
>>
>> I'm confused -- I'm not sure if the things you're saying
>> didn't work:
>>  (a) didn't work before this patch and still don't
>>  (b) used to work and are broken by this patch
>>  (c) used to not work and are fixed by this patch
>
> option (c) - this patch has made things better hence the t-b and r-b
> tags. I might send you a follow up if we can also have single-step
> working as well but that requires me to test a kernel patch (and remove
> the error leg for guest single step in kvm64).

Oh well it looks like we need to keep the suppression of SS while guest
debug is happening. Otherwise we end up looping exceptions:

first SS from guest trigger and exception at:
kvm_arm_handle_debug: @0xffffff8010083fa8 mdscr_el1:0x9001 pstate:0x400003c5

then repeats:
kvm_arm_handle_debug: @0xffffff8010082200 mdscr_el1:0x9001 pstate:0x3c5
kvm_arm_handle_debug: @0xffffff8010082200 mdscr_el1:0x9001 pstate:0x3c5
kvm_arm_handle_debug: @0xffffff8010082200 mdscr_el1:0x9001 pstate:0x3c5
kvm_arm_handle_debug: @0xffffff8010082200 mdscr_el1:0x9001 pstate:0x3c5

This all looks like it is in the kernel which is slightly confusing:

  (gdb) x/6i 0xffffff8010083fa0
     0xffffff8010083fa0 <+24>:    orr     x2, x2, #0x1
     0xffffff8010083fa4 <+28>:    msr     mdscr_el1, x2
     0xffffff8010083fa8 <ret_to_user+32>: ldp     x21, x22, [sp, #256]
     0xffffff8010083fac <ret_to_user+36>: bl      0xffffff80101f1ad8  <cont=
ext_tracking_user_enter>
     0xffffff8010083fb0 <ret_to_user+40>: ldr     x23, [sp, #248]
     0xffffff8010083fb4 <ret_to_user+44>: msr     sp_el0, x23

which is weird because we it seems the kernel is delivering a SOFTSTEP
exception to userspace on access to mdscr_el1 rather than trapping the
access and emulating it in kernel. The loop then just ends up in the
vectors table:

  (gdb) x/4i 0xffffff8010082200
=3D> 0xffffff8010082200 <vectors+512>:    sub     sp, sp, #0x140
   0xffffff8010082204 <vectors+516>:    add     sp, sp, x0
   0xffffff8010082208 <vectors+520>:    sub     x0, sp, x0
   0xffffff801008220c <vectors+524>:    tbnz    w0, #14, 0xffffff801008221c=
 <vectors+540>

Anyway that doesn't affect the viability of this patch for the
breakpoint behaviour.

>
>>
>> More generally:
>>  * this patch claims to fix the code path where QEMU sets
>>    up the guest to take a breakpoint exception (specifically
>>    making our change of ESR_EL1 actually take effect) -- so does
>>    it do that? Or is it impossible for that code path in QEMU
>>    to be used (if so, can we just remove it) ?
>
> No it's needed - I'm observing exceptions coming through the path and
> then being delivered to the guest while the host is debugging - modulo
> the you can't have active HW breakpoints in both guest and host at the
> same time.
>
> Even here now we are sure the guest state is correctly reflected we
> could make the debug code smarter and try it's best to preserve guest
> debug regs while using it's own entirely in userspace. But I suspect
> that is a bit niche.
>
>>
>> thanks
>> -- PMM


--
Alex Benn=C3=A9e
