Received: from eggs.gnu.org ([2001:4830:134:3::10]:56880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqEBZ-00066P-CH
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:03:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqEBY-0002rT-L0
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:03:17 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqEBY-0002rD-Du
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:03:16 -0400
Received: by mail-oi0-x244.google.com with SMTP id v8-v6so6773961oie.5
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 02:03:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <669fdbe5-4cac-7866-e227-300e55eb1285@greensocs.com>
References: <20180814124254.5229-1-peter.maydell@linaro.org>
	<20180814124254.5229-6-peter.maydell@linaro.org>
	<669fdbe5-4cac-7866-e227-300e55eb1285@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Aug 2018 10:02:55 +0100
Message-ID: <CAFEAcA9ZysRpEqWbd8Vzth22nwohWtwqL12hxXJ1j1AaC9DnCQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 05/10] target/arm: Implement AArch32 HCR
 and HCR2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Edgar Iglesias <edgari@xilinx.com>

On 16 August 2018 at 09:55, Luc Michel <luc.michel@greensocs.com> wrote:
> On 8/14/18 2:42 PM, Peter Maydell wrote:
>> The AArch32 HCR and HCR2 registers alias HCR_EL2
>> bits [31:0] and [63:32]; implement them.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>  target/arm/helper.c | 39 +++++++++++++++++++++++++++++++++++----
>>  1 file changed, 35 insertions(+), 4 deletions(-)
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index b6412fe9d1f..9701e413859 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -3754,11 +3754,15 @@ static const ARMCPRegInfo el3_no_el2_cp_reginfo[] = {
>>        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 0, .opc2 = 0,
>>        .access = PL2_RW,
>>        .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
>> -    { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
>> +    { .name = "HCR_EL2", .state = ARM_CP_STATE_BOTH,
>>        .type = ARM_CP_NO_RAW,
>>        .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 0,
>>        .access = PL2_RW,
>> -      .readfn = arm_cp_read_zero, .writefn = arm_cp_write_ignore },
>> +      .type = ARM_CP_CONST, .resetvalue = 0 },
>> +    { .name = "HCR2", .state = ARM_CP_STATE_AA32,
>> +      .cp = 15, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 4,
>> +      .access = PL2_RW,
>> +      .type = ARM_CP_CONST, .resetvalue = 0 },
> As for HACTLR2, shouldn't we avoid defining HCR2 for ARMv7?

Yes. I was working off the v8 register list and should have
cross-checked what was present in v7.

thanks
-- PMM
