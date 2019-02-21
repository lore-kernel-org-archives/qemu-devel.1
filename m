Received: from eggs.gnu.org ([209.51.188.92]:50011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpYt-0002au-2Q
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:42:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gwpYs-0004Ll-2D
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:42:55 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:35317)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gwpYr-0004L2-Q1
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 09:42:54 -0500
Received: by mail-wr1-x42a.google.com with SMTP id t18so30762725wrx.2
	for <qemu-devel@nongnu.org>; Thu, 21 Feb 2019 06:42:53 -0800 (PST)
References: <20190214190603.25030-1-peter.maydell@linaro.org>
	<20190214190603.25030-12-peter.maydell@linaro.org>
	<72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <72c526bd-6c30-5e7a-4ff0-da8473348d0a@redhat.com>
Date: Thu, 21 Feb 2019 14:42:51 +0000
Message-ID: <87ftsh42z8.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 11/27] arm: Allow system registers for KVM
 guests to be changed by QEMU code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org


Auger Eric <eric.auger@redhat.com> writes:

> Hi Peter, Alex,
> On 2/14/19 8:05 PM, Peter Maydell wrote:
>> At the moment the Arm implementations of kvm_arch_{get,put}_registers()
>> don't support having QEMU change the values of system registers
>> (aka coprocessor registers for AArch32). This is because although
>> kvm_arch_get_registers() calls write_list_to_cpustate() to
>> update the CPU state struct fields (so QEMU code can read the
>> values in the usual way), kvm_arch_put_registers() does not
>> call write_cpustate_to_list(), meaning that any changes to
>> the CPU state struct fields will not be passed back to KVM.
>>
>> The rationale for this design is documented in a comment in the
>> AArch32 kvm_arch_put_registers() -- writing the values in the
>> cpregs list into the CPU state struct is "lossy" because the
>> write of a register might not succeed, and so if we blindly
>> copy the CPU state values back again we will incorrectly
>> change register values for the guest. The assumption was that
>> no QEMU code would need to write to the registers.
>>
>> However, when we implemented debug support for KVM guests, we
>> broke that assumption: the code to handle "set the guest up
>> to take a breakpoint exception" does so by updating various
>> guest registers including ESR_EL1.
>>
>> Support this by making kvm_arch_put_registers() synchronize
>> CPU state back into the list. We sync only those registers
>> where the initial write succeeds, which should be sufficient.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Tested-by: Dongjiu Geng <gengdongjiu@huawei.com>
> This commit introduces a regression when running with EDK2 FW:
>
> I get the following traces:
>
> error: kvm run failed Function not implemented
>  PC=3D000000013f5a6208 X00=3D00000000404003c4 X01=3D000000000000003a

Any chance of attaching to the gdbstub and an x/10i around that PC?

--
Alex Benn=C3=A9e
