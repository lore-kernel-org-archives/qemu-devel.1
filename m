Received: from eggs.gnu.org ([2001:4830:134:3::10]:52447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGmRv-0004BI-Re
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:49:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eGmRs-0008Oj-02
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:49:23 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40437)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eGmRr-0008OF-Pg
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 08:49:19 -0500
Received: by mail-wm0-x242.google.com with SMTP id b189so18721438wmd.5
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 05:49:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKONK8R_bB1PqtEtDoDRGs6ZRPh97TCrw+ne0D91Mbr=Ww@mail.gmail.com>
References: <1510846183-756-1-git-send-email-thuth@redhat.com>
	<CAKmqyKONK8R_bB1PqtEtDoDRGs6ZRPh97TCrw+ne0D91Mbr=Ww@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Nov 2017 13:48:58 +0000
Message-ID: <CAFEAcA_p-xA0oW=CVH2AT-tafqgDO0wT7i1xbYw98KP44d5Nrw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm: Silence xlnx-ep108 deprecation
 warning during tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Thomas Huth <thuth@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, "Emilio G. Cota" <cota@braap.org>

On 16 November 2017 at 17:09, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> On Thu, Nov 16, 2017 at 7:29 AM, Thomas Huth <thuth@redhat.com> wrote:
>> The new deprecation warning for the xlnx-ep108 machine also pops up
>> during "make check" which is kind of confusing. Silence it if testing
>> mode is enabled.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Note: I slightly shortened the message so that the code still fits
>>  into the 80-columns limit.
>>
>>  hw/arm/xlnx-zcu102.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
>> index 9631a53..bbe7d04 100644
>> --- a/hw/arm/xlnx-zcu102.c
>> +++ b/hw/arm/xlnx-zcu102.c
>> @@ -24,6 +24,7 @@
>>  #include "qemu/error-report.h"
>>  #include "exec/address-spaces.h"
>>  #include "qemu/log.h"
>> +#include "sysemu/qtest.h"
>>
>>  typedef struct XlnxZCU102 {
>>      MachineState parent_obj;
>> @@ -164,8 +165,10 @@ static void xlnx_ep108_init(MachineState *machine)
>>  {
>>      XlnxZCU102 *s = EP108_MACHINE(machine);
>>
>> -    info_report("The Xilinx EP108 machine is deprecated, please use the "
>> -                "ZCU102 machine instead. It has the same features supported.");
>> +    if (!qtest_enabled()) {
>> +        info_report("The Xilinx EP108 machine is deprecated, please use the "
>> +                    "ZCU102 machine (which has the same features) instead.");
>> +    }
>
> Looks good to me.
>
> In future maybe it makes sense to never print info_report() when running qtest.
>
> Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks; applied to target-arm.next.

-- PMM
