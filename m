Received: from eggs.gnu.org ([2001:4830:134:3::10]:44883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fknt3-00087N-Dj
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fknt2-0000py-JT
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:57:45 -0400
Received: from mail-it0-x244.google.com ([2607:f8b0:4001:c0b::244]:38186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fknt2-0000oS-DS
	for qemu-devel@nongnu.org; Wed, 01 Aug 2018 05:57:44 -0400
Received: by mail-it0-x244.google.com with SMTP id v71-v6so8513648itb.3
	for <qemu-devel@nongnu.org>; Wed, 01 Aug 2018 02:57:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-v+tOzub5V1_3stzNYX9M7hHX0c__jhSWM-q14QdtoTA@mail.gmail.com>
References: <1532496652-26364-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-v+tOzub5V1_3stzNYX9M7hHX0c__jhSWM-q14QdtoTA@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 1 Aug 2018 17:57:42 +0800
Message-ID: <CAHmQWvACMacPDzLgwHX4GRhHOX_0CmaHb0KEkE-F63_faN3zew@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] hw/arm: check fw_cfg return value
 before using it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>

On 31 July 2018 at 02:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 July 2018 at 06:30, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> The fw_cfg value returned from fw_cfg_find() may be NULL, so check it
>> before using.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>> ---
>>  hw/arm/boot.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
>> index e09201c..43b217f 100644
>> --- a/hw/arm/boot.c
>> +++ b/hw/arm/boot.c
>> @@ -930,6 +930,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>>      hwaddr entry;
>>      static const ARMInsnFixup *primary_loader;
>>      AddressSpace *as = arm_boot_address_space(cpu, info);
>> +    FWCfgState *fw_cfg;
>>
>>      /* CPU objects (unlike devices) are not automatically reset on system
>>       * reset, so we must always register a handler to do so. If we're
>> @@ -960,11 +961,10 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
>>              info->dtb_start = info->loader_start;
>>          }
>>
>> -        if (info->kernel_filename) {
>> -            FWCfgState *fw_cfg;
>> +        fw_cfg = fw_cfg_find();
>> +        if (info->kernel_filename && fw_cfg) {
>>              bool try_decompressing_kernel;
>
> This can only happen if:
>  * the user provided a firmware blob
>  * the user provided a -kernel option
>  * the board does not have a fw_cfg so we can't pass the kernel to
>    the firmware blob
> right?
>
Yes.

> I think in this situation we should exit with a helpful error
> message to the user (telling them that this board model does
> not support using the -kernel option when a guest firmware image
> is being booted), rather than silently ignoring the option.
>
The suggestion sounds better.
Thanks.

> thanks
> -- PMM
