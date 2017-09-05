Received: from eggs.gnu.org ([2001:4830:134:3::10]:49102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGgs-00046Q-QF
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:27:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dpGgo-0005MC-4L
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:27:06 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:38198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dpGgn-0005LJ-TY
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 12:27:02 -0400
Received: by mail-wm0-x231.google.com with SMTP id 187so21414041wmn.1
	for <qemu-devel@nongnu.org>; Tue, 05 Sep 2017 09:27:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <b59d3474-15e4-7f01-d4d7-8ca0fcfef6b5@linaro.org>
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-11-git-send-email-peter.maydell@linaro.org>
	<b59d3474-15e4-7f01-d4d7-8ca0fcfef6b5@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Sep 2017 17:26:40 +0100
Message-ID: <CAFEAcA_F-oRO0vT4d62G1vat9o0o9exPKfEXw_BykXnXZJEYgQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/20] nvic: Add NS alias SCS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 29 August 2017 at 17:00, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 08/22/2017 08:08 AM, Peter Maydell wrote:
>> +    regionlen = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? 0x21000 : 0x1000;
>> +    memory_region_init(&s->container, OBJECT(s), "nvic", regionlen);
>>      /* The system register region goes at the bottom of the priority
>>       * stack as it covers the whole page.
>>       */
>> @@ -1185,6 +1242,13 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>>                                          sysbus_mmio_get_region(systick_sbd, 0),
>>                                          1);
>>
>> +    if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
>> +        memory_region_init_io(&s->sysreg_ns_mem, OBJECT(s),
>> +                              &nvic_sysreg_ns_ops, s,
>> +                              "nvic_sysregs_ns", 0x1000);
>> +        memory_region_add_subregion(&s->container, 0x20000, &s->sysreg_ns_mem);
>
> There's a whole in between the two regions, which you are leaving mapped.  Why
> create a sub-region instead of two separate top-level regions for which you can
> leave the whole unmapped?

We don't map the hole. The container is 0x21000 in size, the normal
nvic_sysregs region is 0x1000 at offset 0x0 (which will be 0xe000e000
in the system address space), and the NS alias region
is 0x1000 at offset 0x20000 (0xe002e000 in the system address space).
There's nothing mapped in the hole in the container, so accesses
there will busfault, as they will for other PPB accesses before or
after the SCSes.

thanks
-- PMM
