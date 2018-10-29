Received: from eggs.gnu.org ([2001:4830:134:3::10]:41984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1gH9f6-0001fx-SY
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1gH9f1-0007Fn-8c
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:41:03 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49880
	helo=foss.arm.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marc.zyngier@arm.com>) id 1gH9ez-0006zt-4b
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:40:58 -0400
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-5-richard.henderson@linaro.org>
	<CAFEAcA_WJ7hRd8RfM2OTQBPcryUVDOJkFbRzb69xWTM-yNBLmA@mail.gmail.com>
	<CAFEAcA_zK8n0Bkwn-4x8M-CFduOviCmUGS-uSfw45SzRriE9Rg@mail.gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Message-ID: <cebd5ce7-f33e-454c-0796-82b10515362d@arm.com>
Date: Mon, 29 Oct 2018 15:40:34 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_zK8n0Bkwn-4x8M-CFduOviCmUGS-uSfw45SzRriE9Rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/5] target/arm: Fill in ARMISARegisters
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@arm.com>

On 29/10/18 15:21, Peter Maydell wrote:
> On 29 October 2018 at 15:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 24 October 2018 at 12:37, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>  target/arm/kvm32.c | 33 ++++++++++++++++++++++++++++-----
>>>  1 file changed, 28 insertions(+), 5 deletions(-)
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>
>>> +    /*
>>> +     * FIXME: There is not yet a way to read MVFR2.
>>> +     * Fortunately there is not yet anything in there that affects migration.
>>> +     */
>>
>> We should bring that up with the KVM folks (cc'd)...
>>
>> Presumably KVM_REG_ARM_VFP_MVFR2 should be 0x1005 and the code
>> in the kernel for handling this bit of the get/set-one-reg
>> ioctls needs to have code for it (including returning 0
>> for v7 CPUs, where this VMRS register encoding was UNPREDICTABLE).
> 
> There's an argument for "fail the ioctl on v7 CPUs" rather than
> "return 0"; I don't think I have a strong opinion, since in
> practice userspace needs to handle the "doesn't exist" case
> when it's running on an older kernel anyway.

My temptation would be not to expose it at all when running on a v7
core, and return an error rather than zero.

The other issue is that we currently don't support running 32bit KVM on
any ARMv8 platform, as we strictly check the CPUs we want to run on (A7
and A15). I remember seeing patches that would allow any host core to be
used (similar to what we have on the 64bit side), but that never made it
in the tree.

If there is interest, I can revive this effort.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
