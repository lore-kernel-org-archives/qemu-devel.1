Received: from eggs.gnu.org ([2001:4830:134:3::10]:57342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiw8-0003r1-EO
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:00:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dmiw4-0007RU-JQ
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:00:20 -0400
Received: from mail-pf0-x231.google.com ([2607:f8b0:400e:c00::231]:34734)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dmiw4-0007QN-Bv
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:00:16 -0400
Received: by mail-pf0-x231.google.com with SMTP id l87so1609711pfj.1
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 09:00:16 -0700 (PDT)
References: <1503414539-28762-1-git-send-email-peter.maydell@linaro.org>
	<1503414539-28762-11-git-send-email-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b59d3474-15e4-7f01-d4d7-8ca0fcfef6b5@linaro.org>
Date: Tue, 29 Aug 2017 09:00:12 -0700
MIME-Version: 1.0
In-Reply-To: <1503414539-28762-11-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/20] nvic: Add NS alias SCS region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/22/2017 08:08 AM, Peter Maydell wrote:
> +    regionlen = arm_feature(&s->cpu->env, ARM_FEATURE_V8) ? 0x21000 : 0x1000;
> +    memory_region_init(&s->container, OBJECT(s), "nvic", regionlen);
>      /* The system register region goes at the bottom of the priority
>       * stack as it covers the whole page.
>       */
> @@ -1185,6 +1242,13 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>                                          sysbus_mmio_get_region(systick_sbd, 0),
>                                          1);
>  
> +    if (arm_feature(&s->cpu->env, ARM_FEATURE_V8)) {
> +        memory_region_init_io(&s->sysreg_ns_mem, OBJECT(s),
> +                              &nvic_sysreg_ns_ops, s,
> +                              "nvic_sysregs_ns", 0x1000);
> +        memory_region_add_subregion(&s->container, 0x20000, &s->sysreg_ns_mem);

There's a whole in between the two regions, which you are leaving mapped.  Why
create a sub-region instead of two separate top-level regions for which you can
leave the whole unmapped?


r~
