Received: from eggs.gnu.org ([209.51.188.92]:36617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gu5jW-0005Qb-1V
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 20:22:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gu5YF-0002Ys-H5
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 20:10:56 -0500
References: <20181206151401.13455-1-peter.maydell@linaro.org>
	<87ftsrird3.fsf@zen.linaroharston>
	<CAFEAcA_GPW0B9bMOia_aB=H0PV8DwUNWBARz+uNbRk2565a+4w@mail.gmail.com>
	<87bm3figs9.fsf@zen.linaroharston>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <9ac389c6-fa1b-70ca-d3f9-254e11bf5ce1@huawei.com>
Date: Thu, 14 Feb 2019 09:10:22 +0800
MIME-Version: 1.0
In-Reply-To: <87bm3figs9.fsf@zen.linaroharston>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

I think Peter's patch is good, I will resubmit my series patches based on=
 this.

On 2019/2/14 4:18, Alex Benn=C3=A9e wrote:
>=20
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Wed, 13 Feb 2019 at 16:29, Alex Benn=C3=A9e <alex.bennee@linaro.org=
> wrote:
>>>
>>>
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> At the moment the Arm implementations of kvm_arch_{get,put}_register=
s()
>>>> don't support having QEMU change the values of system registers
>>>> (aka coprocessor registers for AArch32). This is because although
>>>> kvm_arch_get_registers() calls write_list_to_cpustate() to
>>>> update the CPU state struct fields (so QEMU code can read the
>>>> values in the usual way), kvm_arch_put_registers() does not
>>>> call write_cpustate_to_list(), meaning that any changes to
>>>> the CPU state struct fields will not be passed back to KVM.
>>>>
>>>> The rationale for this design is documented in a comment in the
>>>> AArch32 kvm_arch_put_registers() -- writing the values in the
>>>> cpregs list into the CPU state struct is "lossy" because the
>>>> write of a register might not succeed, and so if we blindly
>>>> copy the CPU state values back again we will incorrectly
>>>> change register values for the guest. The assumption was that
>>>> no QEMU code would need to write to the registers.
>>>>
>>>> However, when we implemented debug support for KVM guests, we
>>>> broke that assumption: the code to handle "set the guest up
>>>> to take a breakpoint exception" does so by updating various
>>>> guest registers including ESR_EL1.
>>>>
>>>> Support this by making kvm_arch_put_registers() synchronize
>>>> CPU state back into the list. We sync only those registers
>>>> where the initial write succeeds, which should be sufficient.
>>
>>> [snip a long test setup that I didn't really understand]
>=20
> Sorry that was just making sure I'd documented the exact steps of the
> manual test for posterity.
>=20
>>
>> I'm confused -- I'm not sure if the things you're saying
>> didn't work:
>>  (a) didn't work before this patch and still don't
>>  (b) used to work and are broken by this patch
>>  (c) used to not work and are fixed by this patch
>=20
> option (c) - this patch has made things better hence the t-b and r-b
> tags. I might send you a follow up if we can also have single-step
> working as well but that requires me to test a kernel patch (and remove
> the error leg for guest single step in kvm64).
>=20
>>
>> More generally:
>>  * this patch claims to fix the code path where QEMU sets
>>    up the guest to take a breakpoint exception (specifically
>>    making our change of ESR_EL1 actually take effect) -- so does
>>    it do that? Or is it impossible for that code path in QEMU
>>    to be used (if so, can we just remove it) ?
>=20
> No it's needed - I'm observing exceptions coming through the path and
> then being delivered to the guest while the host is debugging - modulo
> the you can't have active HW breakpoints in both guest and host at the
> same time.
>=20
> Even here now we are sure the guest state is correctly reflected we
> could make the debug code smarter and try it's best to preserve guest
> debug regs while using it's own entirely in userspace. But I suspect
> that is a bit niche.
>=20
>>
>> thanks
>> -- PMM
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
> .
>=20
