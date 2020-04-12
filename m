Return-Path: <SRS0=Byls=54=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8130CC2BB85
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B77C206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2020 22:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWmS5Q5n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B77C206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNl68-0001pO-E1
	for qemu-devel@archiver.kernel.org; Sun, 12 Apr 2020 18:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNl5U-0001Bc-IP
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:28:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNl5T-0006gs-9q
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:28:24 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNl5T-0006gL-24
 for qemu-devel@nongnu.org; Sun, 12 Apr 2020 18:28:23 -0400
Received: by mail-wr1-x441.google.com with SMTP id k11so7887338wrp.5
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2020 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3ieMQIpKlnsU3txiERVU/TubR98V1LO+HKdFgVlPsCc=;
 b=PWmS5Q5nnjm4p4HRYB/SnUva6XyyNabTTbQ9o7A+N6L/QbWC2e7Da+17tlTqXidD0g
 H5ZL8haMEpp2/GjW/jmhDXwV9JKJZWCZIy0BiWZ4NHYn+jlQTHZZLSoZzDuj0Kzf2rXl
 TpU1EBQvuW8oIxm6N+HIDsD44L14FqHNQ8IQ6X6Cf+4Oz/acUfBXNd3clpV3+clcoUZB
 WPKlBUDUueWlYc07jXj73Jln8nJeVsXZWgB0Gh3Qs7Hhqur2wB7RQBDwx+d+hzbzs0tQ
 T8vRIPzsRYyLQ/7QnbeZwMv1ow9W+7Q73zHLQ9CvcNX8ehkyn9qPHjeEacGwNeeebj2L
 kbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=3ieMQIpKlnsU3txiERVU/TubR98V1LO+HKdFgVlPsCc=;
 b=tQ0/YbAtjMDLctrkhNnMUlAzWInbnRlAuqVIBRLphwU/p2aWOuZnp681gyhkqAlKjI
 Fn0jKxZHN7BOcZM0EPO2UGvbJBd7t6aD4ggqKortKkz6Ll6H3/54Tpqqwd4V+jgK3x8Q
 9m4FjS1SNzKYBTt5g+8FCGHFZoID+E9bgGr5Db7HfKh906Qw+m3/nci11Dr0mqgmQgQE
 pcwS8MA3i8RlvlFyKYMMTaChaDTqQdecdlHEaFkcMUfD+TTaKX2qix2PKgdiMVvsLcRY
 skSgAEAIFjTTm9Spg7qP8l2LniN4ZCGF5GslJQXI4A5CjpR1HtGSZuqvsbRbXJv/sg0V
 gbvw==
X-Gm-Message-State: AGi0PuY2CrAwNbICYtb6xkX2Rq8Inw4ANC1qnvUl81sxoYBe+c74U9tW
 djmwBSueKB/U1L99hgkHyfw=
X-Google-Smtp-Source: APiQypKO0s0avsJMYkT6H+G3BiXwrJtj5z5LEg+b9LeW9x7/GIfrwp2mbRiyUQcx4DuF7QsRKBelrw==
X-Received: by 2002:adf:ff82:: with SMTP id j2mr3961160wrr.96.1586730501581;
 Sun, 12 Apr 2020 15:28:21 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id q143sm12791218wme.31.2020.04.12.15.28.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2020 15:28:20 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v2 53/54] hw/mips/mips_malta: Add missing
 error-propagation code
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
References: <20200406174743.16956-1-f4bug@amsat.org>
 <20200406174743.16956-54-f4bug@amsat.org>
 <fc1ef46a-ea1d-02ff-7ca7-dd26821f34c7@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
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
Message-ID: <4c2e41a6-86f0-9081-0b48-c9fcf30fbb1d@amsat.org>
Date: Mon, 13 Apr 2020 00:28:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <fc1ef46a-ea1d-02ff-7ca7-dd26821f34c7@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

On 4/7/20 8:36 PM, Richard Henderson wrote:
> On 4/6/20 10:47 AM, Philippe Mathieu-Daudé wrote:
>> Running the coccinelle script produced:
>>
>>   $ spatch \
>>     --macro-file scripts/cocci-macro-file.h --include-headers \
>>     --sp-file scripts/coccinelle/find-missing-error_propagate.cocci \
>>     --keep-comments --smpl-spacing --dir .
>>   HANDLING: ./hw/mips/mips_malta.c
>>   [[manual check required: error_propagate() might be missing in object_property_set_int() ./hw/mips/mips_malta.c:1193:4]]
>>   [[manual check required: error_propagate() might be missing in object_property_set_str() ./hw/mips/mips_malta.c:1192:4]]
>>
>> Add the missing error_propagate() after review by adding
>> a Error* parameter to create_cps().
>>
>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
>>  hw/mips/mips_malta.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index e4c4de1b4e..8d43cfd41b 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -1183,18 +1183,27 @@ static void create_cpu_without_cps(MachineState *ms,
>>  }
>>  
>>  static void create_cps(MachineState *ms, MaltaState *s,
>> -                       qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>> +                       qemu_irq *cbus_irq, qemu_irq *i8259_irq,
>> +                       Error **errp)
>>  {
>>      Error *err = NULL;
>>  
>>      sysbus_init_child_obj(OBJECT(s), "cps", OBJECT(&s->cps), sizeof(s->cps),
>>                            TYPE_MIPS_CPS);
>>      object_property_set_str(OBJECT(&s->cps), ms->cpu_type, "cpu-type", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>      object_property_set_int(OBJECT(&s->cps), ms->smp.cpus, "num-vp", &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>>      object_property_set_bool(OBJECT(&s->cps), true, "realized", &err);
>> -    if (err != NULL) {
>> -        error_report("%s", error_get_pretty(err));
>> -        exit(1);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>>      }
>>  
>>      sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->cps), 0, 0, 1);
>> @@ -1207,7 +1216,7 @@ static void mips_create_cpu(MachineState *ms, MaltaState *s,
>>                              qemu_irq *cbus_irq, qemu_irq *i8259_irq)
>>  {
>>      if ((ms->smp.cpus > 1) && cpu_supports_cps_smp(ms->cpu_type)) {
>> -        create_cps(ms, s, cbus_irq, i8259_irq);
>> +        create_cps(ms, s, cbus_irq, i8259_irq, &error_fatal);
> 
> Are you going to replace this with something else later?

No, indeed.

> Otherwise it doesn't seem useful to add the argument here, as opposed to using
> error_fatal in create_cpus()

Good suggestion, thanks!

