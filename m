Received: from eggs.gnu.org ([2001:4830:134:3::10]:40382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chK7V-0002sR-F1
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:57:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1chK7U-0000Xq-IN
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:57:29 -0500
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1chK7U-0000XU-AS
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 12:57:28 -0500
Received: by mail-wr0-x22e.google.com with SMTP id 89so17924674wrr.3
	for <qemu-devel@nongnu.org>; Fri, 24 Feb 2017 09:57:28 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <ce8aa8f7-e163-5b79-ef1e-f8132928882f@redhat.com>
References: <1487850673-26455-1-git-send-email-vijay.kilari@gmail.com>
	<1487850673-26455-3-git-send-email-vijay.kilari@gmail.com>
	<ce8aa8f7-e163-5b79-ef1e-f8132928882f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Feb 2017 17:57:06 +0000
Message-ID: <CAFEAcA_wQueyMKEdVpeW56RPhvG+deO5-a_AHZX+xHaMtCQnyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v9 2/5] hw/intc/arm_gicv3_kvm: Add
 ICC_SRE_EL1 register to vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Vijay Kilari <vijay.kilari@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Christoffer Dall <christoffer.dall@linaro.org>, Pavel Fedin <p.fedin@samsung.com>, Marc Zyngier <marc.zyngier@arm.com>, QEMU Developers <qemu-devel@nongnu.org>, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

On 24 February 2017 at 17:53, Auger Eric <eric.auger@redhat.com> wrote:
> Hi,
>
> On 23/02/2017 12:51, vijay.kilari@gmail.com wrote:
>> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>>
>> To Save and Restore ICC_SRE_EL1 register introduce vmstate
>> subsection and load only if non-zero.
> != 7
>
>> Also initialize icc_sre_el1 with to 0x7 in pre_load
>> function.
>>
>> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
>> ---
>>  hw/intc/arm_gicv3_common.c         | 36 ++++++++++++++++++++++++++++++++++++
>>  include/hw/intc/arm_gicv3_common.h |  1 +
>>  2 files changed, 37 insertions(+)
>>
>> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
>> index 16b9b0f..5b0e456 100644
>> --- a/hw/intc/arm_gicv3_common.c
>> +++ b/hw/intc/arm_gicv3_common.c
>> @@ -70,6 +70,38 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
>>      }
>>  };
>>
>> +static int icc_sre_el1_reg_pre_load(void *opaque)
>> +{
>> +    GICv3CPUState *cs = opaque;
>> +
>> +   /*
>> +    * If the sre_el1 subsection is not transferred this
>> +    * means SRE_EL1 is 0x7 (which might not be the same as
>> +    * our reset value).
>> +    */
>> +    cs->icc_sre_el1 = 0x7;
>> +    return 0;
>> +}
> As Peter asked before I don't really get why we need the pre_load
> function here.

No, it's correct. As the comment says, the reset value
of icc_sre_el1 might not be 7 (it is right now, but it's
less of a trap for future changes to not assume it).
So the way migration works is that we use pre-load on the destination
end to set the value to 0x7, then if the source end transfers the data
we get the transferred value, otherwise we end up with the default
value as set in the pre-load function.

thanks
-- PMM
