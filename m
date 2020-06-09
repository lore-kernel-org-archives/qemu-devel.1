Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E4DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4F9207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 07:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OHFY8Agc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4F9207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiYa0-0005HU-5C
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 03:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYZA-0004qT-MJ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:21:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33888)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiYZ9-0005VN-Kd
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 03:21:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id u26so1603814wmn.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 00:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mooauaCkxYbpYiT3Jz+Z0tUFnRaDR0BNn5klygf1zSk=;
 b=OHFY8Agc9gEEcf5sKCAgkLNdORkO/eUa30LLWqVOv7bViPMmEET5osTvABYBlhB57E
 OyQ6eLB4KBVo7Wv4Lr4ebBQp6qPUd7WP7emRs1oTGy/DClUi2Wsj32KKOB5kIu2obZdD
 NnlZkZHQzj4Ev5L157xlkZ2u1pkb2VDIIuo001883CY5wy3RTBtsqYrm6N4JJN7ubap7
 ts62Fj93Qv28lfRYaIWkJ+OVvu9+MUeAGye4Rfa5Z11Ma3QWcGj6tTuRd3/4W3NAo4T6
 09DN1hUgqCdhQJo7t1SBVDbIUWH+SGYGIe50IUmcN4Su7cOoUAYQbsIzsm7WggBG7S69
 qa2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=mooauaCkxYbpYiT3Jz+Z0tUFnRaDR0BNn5klygf1zSk=;
 b=E1cMxraf9Mrhkq2qKsHmiRwFZGY+nrgRUPt86y47RhFdskJNBMtSwAQ7Q9q0G/ru2n
 aN59w0VDqQzvOZvBsAOAO/zQn8oYIZVK/pwm1DKzD8ht4m2N+UpzRP1j5bE00rQ8lScw
 S8gm5/O32ub3GD7VC0+vpkq6WGMaDMxvOrcoAgdxcPSv9nz9rF6nQDCD5V51hH9b7jrs
 DfJiBPnmboFzkAiVhNpPo8RSaiXbkLx91qj1rdNMD3sK0sOmphEv4Ek0TJwJrsoMVUUB
 gHhS/wUWN4lEKBk7Pixt6mOma5nU9+525XXnmgnnab02/0LIOy5i4zOnqL6skCZ/9wjC
 es3g==
X-Gm-Message-State: AOAM533NonHCKosB7JQCMnHmKKEKPDPaa4th/gBwIfPVxmtcMvzm9vDm
 sFboeqAaG4ap3Z4hTxA2W8Q=
X-Google-Smtp-Source: ABdhPJyBDxXcAvJ1qxNumS9iwv5T5vUkDp1ELh4Jxy1ixTm4Ggo7P1CzEm+rTv/mioFxgnr6hEAHNw==
X-Received: by 2002:a7b:cf06:: with SMTP id l6mr2541060wmg.63.1591687257545;
 Tue, 09 Jun 2020 00:20:57 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id v6sm2337753wrf.61.2020.06.09.00.20.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jun 2020 00:20:56 -0700 (PDT)
Subject: Re: [PATCH v2 21/24] sparc/leon3: Fix to put grlib,* devices on sysbus
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200528110444.20456-1-armbru@redhat.com>
 <20200528110444.20456-22-armbru@redhat.com>
 <378a35f0-8d21-a08c-c661-c13d06918249@amsat.org>
Autocrypt: addr=f4bug@amsat.org; keydata=
 mQINBDU8rLoBEADb5b5dyglKgWF9uDbIjFXU4gDtcwiga9wJ/wX6xdhBqU8tlQ4BroH7AeRl
 u4zXP0QnBDAG7EetxlQzcfYbPmxFISWjckDBFvDbFsojrZmwF2/LkFSzlvKiN5KLghzzJhLO
 HhjGlF8deEZz/d/G8qzO9mIw8GIBS8uuWh6SIcG/qq7+y+2+aifaj92EdwU79apZepT/U3vN
 YrfcAuo1Ycy7/u0hJ7rlaFUn2Fu5KIgV2O++hHYtCCQfdPBg/+ujTL+U+sCDawCyq+9M5+LJ
 ojCzP9rViLZDd/gS6jX8T48hhidtbtsFRj/e9QpdZgDZfowRMVsRx+TB9yzjFdMO0YaYybXp
 dg/wCUepX5xmDBrle6cZ8VEe00+UQCAU1TY5Hs7QFfBbjgR3k9pgJzVXNUKcJ9DYQP0OBH9P
 ZbZvM0Ut2Bk6bLBO5iCVDOco0alrPkX7iJul2QWBy3Iy9j02GnA5jZ1Xtjr9kpCqQT+sRXso
 Vpm5TPGWaWljIeLWy/qL8drX1eyJzwTB3A36Ck4r3YmjMjfmvltSZB1uAdo1elHTlFEULpU/
 HiwvvqXQ9koB15U154VCuguvx/Qnboz8GFb9Uw8VyawzVxYVNME7xw7CQF8FYxzj6eI7rBf2
 Dj/II6wxWPgDEy3oUzuNOxTB7sT3b/Ym76yOJzWX5BylXQIJ5wARAQABtDFQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoRjRCVUcpIDxmNGJ1Z0BhbXNhdC5vcmc+iQJVBBMBCAA/AhsPBgsJ
 CAcDAgYVCAIJCgsEFgIDAQIeAQIXgBYhBPqr514SkXIh3P1rsuPjLCzercDeBQJd660aBQks
 klzgAAoJEOPjLCzercDe2iMP+gMG2dUf+qHz2uG8nTBGMjgK0aEJrKVPodFA+iedQ5Kp3BMo
 jrTg3/DG1HMYdcvQu/NFLYwamUfUasyor1k+3dB23hY09O4xOsYJBWdilkBGsJTKErUmkUO2
 3J/kawosvYtJJSHUpw3N6mwz/iWnjkT8BPp7fFXSujV63aZWZINueTbK7Y8skFHI0zpype9s
 loU8xc4JBrieGccy3n4E/kogGrTG5jcMTNHZ106DsQkhFnjhWETp6g9xOKrzZQbETeRBOe4P
 sRsY9YSG2Sj+ZqmZePvO8LyzGRjYU7T6Z80S1xV0lH6KTMvq7vvz5rd92f3pL4YrXq+e//HZ
 JsiLen8LH/FRhTsWRgBtNYkOsd5F9NvfJtSM0qbX32cSXMAStDVnS4U+H2vCVCWnfNug2TdY
 7v4NtdpaCi4CBBa3ZtqYVOU05IoLnlx0miKTBMqmI05kpgX98pi2QUPJBYi/+yNu3fjjcuS9
 K5WmpNFTNi6yiBbNjJA5E2qUKbIT/RwQFQvhrxBUcRCuK4x/5uOZrysjFvhtR8YGm08h+8vS
 n0JCnJD5aBhiVdkohEFAz7e5YNrAg6kOA5IVRHB44lTBOatLqz7ntwdGD0rteKuHaUuXpTYy
 CRqCVAKqFJtxhvJvaX0vLS1Z2dwtDwhjfIdgPiKEGOgCNGH7R8l+aaM4OPOd
Message-ID: <ebc8f6dc-5734-8890-ddd7-da6c8e4d4a77@amsat.org>
Date: Tue, 9 Jun 2020 09:20:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <378a35f0-8d21-a08c-c661-c13d06918249@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: berrange@redhat.com, ehabkost@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, pbonzini@redhat.com,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/9/20 7:15 AM, Philippe Mathieu-Daudé wrote:
> On 5/28/20 1:04 PM, Markus Armbruster wrote:
>> leon3_generic_hw_init() creates a "grlib,ahbpnp" and a "grlib,apbpnp"
>> sysbus device in a way that leaves them unplugged.
>>
>> Create them the common way that puts them into the main system bus.
>> Affects machine leon3_generic.  Visible in "info qtree":
>>
>>      bus: main-system-bus
>>        type System
>>     +  dev: grlib,ahbpnp, id ""
>>     +    mmio 00000000fffff000/0000000000001000
>>     +  dev: grlib,apbpnp, id ""
>>     +    mmio 00000000800ff000/0000000000001000
>>        dev: grlib,irqmp, id ""
>>
>> Cc: Fabien Chouteau <chouteau@adacore.com>
>> Cc: KONRAD Frederic <frederic.konrad@adacore.com>
>> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Reviewed-by: KONRAD Frederic <frederic.konrad@adacore.com>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/sparc/leon3.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
>> index 8f024dab7b..3facb8c2ae 100644
>> --- a/hw/sparc/leon3.c
>> +++ b/hw/sparc/leon3.c
>> @@ -213,14 +213,14 @@ static void leon3_generic_hw_init(MachineState *machine)
>>      reset_info->sp    = LEON3_RAM_OFFSET + ram_size;
>>      qemu_register_reset(main_cpu_reset, reset_info);
>>  
>> -    ahb_pnp = GRLIB_AHB_PNP(object_new(TYPE_GRLIB_AHB_PNP));
>> +    ahb_pnp = GRLIB_AHB_PNP(qdev_create(NULL, TYPE_GRLIB_AHB_PNP));
>>      object_property_set_bool(OBJECT(ahb_pnp), true, "realized", &error_fatal);
>>      sysbus_mmio_map(SYS_BUS_DEVICE(ahb_pnp), 0, LEON3_AHB_PNP_OFFSET);
>>      grlib_ahb_pnp_add_entry(ahb_pnp, 0, 0, GRLIB_VENDOR_GAISLER,
>>                              GRLIB_LEON3_DEV, GRLIB_AHB_MASTER,
>>                              GRLIB_CPU_AREA);
>>  
>> -    apb_pnp = GRLIB_APB_PNP(object_new(TYPE_GRLIB_APB_PNP));
>> +    apb_pnp = GRLIB_APB_PNP(qdev_create(NULL, TYPE_GRLIB_APB_PNP));
>>      object_property_set_bool(OBJECT(apb_pnp), true, "realized", &error_fatal);
>>      sysbus_mmio_map(SYS_BUS_DEVICE(apb_pnp), 0, LEON3_APB_PNP_OFFSET);
>>      grlib_ahb_pnp_add_entry(ahb_pnp, LEON3_APB_PNP_OFFSET, 0xFFF,
>>
> 
> Thanks, patch applied to for the next (temporary) sparc-next pull request.

As suggested on IRC, dropping this patch, since it is part of an omnibus
cleanup.

