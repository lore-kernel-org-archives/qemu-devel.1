Received: from eggs.gnu.org ([2001:4830:134:3::10]:47293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bZA-0003Uh-M3
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1bZ4-0003eo-HK
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:10:08 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:52589)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1bZ4-0003dP-9s
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 13:10:02 -0400
Received: by mail-wm0-x22c.google.com with SMTP id k4so25361820wmc.1
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 10:10:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqGy5xaqf4sVT34fv=cRDTDhpi2Vfx01SA2+cvdYqiArPA@mail.gmail.com>
References: <20170918195100.17593-1-andrew.smirnov@gmail.com>
	<20170918195100.17593-17-andrew.smirnov@gmail.com>
	<CAFEAcA_a_YLw4u5SwCF-L_n630iiJJwyphbKc2M-orvFs7dERg@mail.gmail.com>
	<CAHQ1cqGy5xaqf4sVT34fv=cRDTDhpi2Vfx01SA2+cvdYqiArPA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 18:09:40 +0100
Message-ID: <CAFEAcA-MyTaffU7mEV3XH95NOvFmaKm2a=VkFbDU6n6dwTpuRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 16/17] i.MX: Add i.MX7 SOC implementation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 9 October 2017 at 17:18, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> On Fri, Oct 6, 2017 at 7:38 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 18 September 2017 at 20:50, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>>> +static void fsl_imx7_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +    FslIMX7State *s = FSL_IMX7(dev);
>>> +    Object *o;
>>> +    int i;
>>> +    qemu_irq irq;
>>> +
>>> +    for_each_cpu(i) {
>>> +       o = OBJECT(&s->cpu[i]);
>>> +
>>> +        object_property_set_int(o, QEMU_PSCI_CONDUIT_SMC,
>>> +                                "psci-conduit", &error_abort);
>>> +
>>> +        object_property_set_bool(o, false, "has_el3", &error_abort);
>>
>> Does this SoC's CPU really not have EL3?
>>
>
> The SoC support TrustZone, so I thing it does have EL3. This setting
> however was breaking SMP support(I can't remember more details) and
> that's why I added the code setting it to "false".

The idea is that for new boards (where we start from "no guest
code works") we try to model the hardware correctly from the
start, ie figure out why SMP doesn't work if you say you have
EL3 (probably because either you need to provide boot code
for the other CPUs or implement a power controller, depending
on how SMP secondary CPU start works on this hardware).
Existing board models that were added before we got EL3 working
tend to set has_el3 to false even though the h/w we're modelling
has EL3, because they're maintaining backwards compatibility with
previous released versions of QEMU where we didn't implement EL3.
New boards don't have that back-compat requirement, so if it's
not too hard to get it working from the start that's preferable.

thanks
-- PMM
