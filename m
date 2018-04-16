Received: from eggs.gnu.org ([2001:4830:134:3::10]:35597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f864g-0001oZ-43
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f864f-0005PK-5M
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:29:46 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:37123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f864f-0005Ow-0u
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 11:29:45 -0400
Received: by mail-oi0-x241.google.com with SMTP id f63-v6so14902477oic.4
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 08:29:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ad56487b-5afe-1420-9903-d5d849f97231@siemens.com>
References: <267f42a5-b7ce-379e-ffd1-f2611393d2ff@web.de>
	<ad56487b-5afe-1420-9903-d5d849f97231@siemens.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 16:29:23 +0100
Message-ID: <CAFEAcA9V9nFMVixeYjfBj54OT3zhRCVHM495AZHDzxVryh4JFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] e1000e: Do not auto-clear ICR bits which
 aren't set in EIAC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-devel <qemu-devel@nongnu.org>

On 16 April 2018 at 16:25, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> On 2018-04-01 23:17, Jan Kiszka wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> The spec does not justify clearing of any E1000_ICR_OTHER_CAUSES when
>> E1000_ICR_OTHER is set in EIAC. In fact, removing this code fixes the
>> issue the Linux driver runs into since 4aea7a5c5e94 ("e1000e: Avoid
>> receiver overrun interrupt bursts") and was worked around by
>> 745d0bd3af99 ("e1000e: Remove Other from EIAC").
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>
>> This resolves the issue I reported on February 18 ("e1000e: MSI-X
>> problem with recent Linux drivers").
>>
>>  hw/net/e1000e_core.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
>> index ecf9b15555..d38f025c0f 100644
>> --- a/hw/net/e1000e_core.c
>> +++ b/hw/net/e1000e_core.c
>> @@ -2022,10 +2022,6 @@ e1000e_msix_notify_one(E1000ECore *core, uint32_t cause, uint32_t int_cfg)
>>
>>      effective_eiac = core->mac[EIAC] & cause;
>>
>> -    if (effective_eiac == E1000_ICR_OTHER) {
>> -        effective_eiac |= E1000_ICR_OTHER_CAUSES;
>> -    }
>> -
>>      core->mac[ICR] &= ~effective_eiac;
>>
>>      if (!(core->mac[CTRL_EXT] & E1000_CTRL_EXT_IAME)) {
>>
>
> Ping for this - as well as https://patchwork.ozlabs.org/patch/895476.
>
> Given that q35 uses e1000e by default and many Linux kernel versions no
> longer work, this should likely go into upcoming and stable versions

I'd rather not put it into 2.12 at this point in the release
cycle unless it's a regression from 2.11, I think.

thanks
-- PMM
