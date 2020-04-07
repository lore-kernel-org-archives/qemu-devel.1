Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3587DC2BA1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:37:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD1220768
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 18:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b96ZQiyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD1220768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLt6B-0007je-3v
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 14:37:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41246)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jLt5O-00074p-B4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jLt5N-0007To-0z
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:36:33 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:51244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jLt5M-0007Sv-IU
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 14:36:32 -0400
Received: by mail-pj1-x102b.google.com with SMTP id n4so124431pjp.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 11:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OO+d6Vrr3JcqFZxc8Udb4B+tXcoZQoLKySelinVWra0=;
 b=b96ZQiyOw2YK/XJ3yR7v1662dlNGJgCS0bi2EFjf3Wxg6x0pdx3D+oud+Qxuzw21OE
 5nvjfAAQkgv3QVlWUlvDqX0dPaGCrzUic+KeBmUtAw6usatGg0hwcN/8vFC3DOuxgpLm
 qgVSE8iU3jUvLD1xsMi7GtwwLAcKSa0HHQvQf02XJ1x1b80wP+/RB4Pi6tOrX5Us9FGb
 GrJQoreVKyAF5eS6v55W0XUqMXV8j6YDjRU/LWUu4M+7q89INlMUjfHr/bEf0AcDrBuH
 a9HkHuPxlvkCYBDW74bNU8ojtJ+t0WsYXe75uOm0PaCGzIG5KRYRAVADOzYfSCyy0QQ6
 dmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OO+d6Vrr3JcqFZxc8Udb4B+tXcoZQoLKySelinVWra0=;
 b=NU7ig2HG7dE9+iwVx4QbALXj+YTg27uqqfIhWYBOdap82XjprH0RMQqZRcL7Wriwn3
 IzadAWFquE2SwohokzDUhZQ+YR4lTspA2Xwf6HpWpEUO7D9NrQUUazAxHqdt4xLtUqOD
 MJWzj4EyY6wmm3paNIO6EO7x/A47g86edF8aV/h7ULaA20lAr3xaicyRl9zWtkfcBHhx
 rA3s/KGJo7tGxfkNuSlfwikEpz8+RCHJOJz7GMxHBbF+DsC+DNJbw3cVshXN92Fc6PHO
 pJ/zWoV2X1EZCJ2uBiHqy+4Aw7SoERvYxuhdDrLYMeZayqY9aXmT5dHtaxG9Xr4P1D1O
 ba0g==
X-Gm-Message-State: AGi0PuaEPCUVl+k0XEkVrWQ9HVBgtxfqPliHdtSscBRgv0bLIsFE01l/
 HK6zwnGBaFgmMNbf4oQOG2e/og==
X-Google-Smtp-Source: APiQypJ9M/E+jROjWKs2qNjbqySAnl672a7i9Qru/y/qQsxoTdyCpbicOFsu8m5Y6wbcuOGYWdooIA==
X-Received: by 2002:a17:90a:272d:: with SMTP id
 o42mr741084pje.194.1586284590908; 
 Tue, 07 Apr 2020 11:36:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id s62sm13826297pgb.94.2020.04.07.11.36.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2020 11:36:30 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 53/54] hw/mips/mips_malta: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-54-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fc1ef46a-ea1d-02ff-7ca7-dd26821f34c7@linaro.org>
Date: Tue, 7 Apr 2020 11:36:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200406174743.16956-54-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102b
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/6/20 10:47 AM, Philippe Mathieu-Daudé wrote:
> Running the coccinelle script produced:
> 
>   $ spatch \
>     --macro-file scripts/cocci-macro-file.h --include-headers \
>     --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
>     --keep-comments --smpl-spacing --dir .
>   HANDLING: ./hw/mips/mips_malta.c
>   [[manual check required: error_propagate() might be missing in object_property_set_int() ./hw/mips/mips_malta.c:1193:4]]
>   [[manual check required: error_propagate() might be missing in object_property_set_str() ./hw/mips/mips_malta.c:1192:4]]
> 
> Add the missing error_propagate() after review by adding
> a Error* parameter to create_cps().
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/mips/mips_malta.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index e4c4de1b4e..8d43cfd41b 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1183,18 +1183,27 @@ static void create_cpu_without_cps(MachineState *ms,
>  }
>  
>  static void create_cps(MachineState *ms, MaltaState *s,
> -                       qemu_irq *cbus_irq, qemu_irq *i8259_irq)
> +                       qemu_irq *cbus_irq, qemu_irq *i8259_irq,
> +                       Error **errp)
>  {
>      Error *err = NULL;
>  
>      sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
>                            TYPE_MIPS_CPS);
>      object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
> +    }
>      object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
> -    if (err != NULL) {
> -        error_report("%s", error_get_pretty(err));
> -        exit(1);
> +    if (err) {
> +        error_propagate(errp, err);
> +        return;
>      }
>  
>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
> @@ -1207,7 +1216,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
>                              qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>  {
>      if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
> -        create_cps(ms, s, cbus_irq, i8259_irq);
> +        create_cps(ms, s, cbus_irq, i8259_irq, &error_fatal);

Are you going to replace this with something else later?
Otherwise it doesn't seem useful to add the argument here, as opposed to using
error_fatal in create_cpus()


r~

