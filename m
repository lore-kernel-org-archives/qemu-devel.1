Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1656BC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:16:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD202206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 06:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tj+jod58"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD202206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkiQP-0008R1-1y
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 02:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkiPK-0007Uz-RJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:15:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58121
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jkiPI-0001HT-UN
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 02:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592201743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=z16WxP2brCQGyQHeFxv3WxnjUhvRvpl5KCcESwvVBK4=;
 b=Tj+jod58tqWDp2S3/At3gsrT+0qaVBSAdTV/ZMxugzill52yJpbcTpth/xCF9Y6gLFPR+R
 9lKclSOUlTCgciKkNMKFhMYIcuy30qJi5vi9zxCME3u9HyFGYlVq6YzBBzXGzYyri66Psb
 ne0NfgVzWEB9Xa2OJl7KNTKskCF7Isg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-MGDDkIH0P3WBbEvPPLynqQ-1; Mon, 15 Jun 2020 02:15:40 -0400
X-MC-Unique: MGDDkIH0P3WBbEvPPLynqQ-1
Received: by mail-wr1-f72.google.com with SMTP id s7so6610513wrm.16
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 23:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=z16WxP2brCQGyQHeFxv3WxnjUhvRvpl5KCcESwvVBK4=;
 b=t+BLR4HPlzRKoPHzpg24myw8IayNjuYjT4wzhbZRudFrayAbfFwsESZ3VmVlvE3jDc
 o0H3NsPUbbdiiYA6DJbi7vxYx5r5v53+P3VMzqY9cpVe8psBX0+P3AG8Kj948gs8F0rj
 Ch06HM7KuuJw68BmMoQWTZfJK75vSHcsRKTcLcJWj7nXfFGKNZcDGT7klIiwXAkwBi0y
 S7BI4vle2LbSL52CcPiXPLt4++i2IHVkVWSp63uCpKaehOX/VBYQWi64vTVdTKWSI5z8
 V0fR5TwX5ina5vkMH25rwlf1BNdHjwSSlv+QnahKIKRQysC0TaJCqGX6jtR+nZEVJfUl
 4KtA==
X-Gm-Message-State: AOAM532BRlO6/teSAEbJ8VVePu7A3zZZ7xlma8CZkXR91AFSLvwQShsn
 JbP/YAtIhfTTLZOMA5XK1V/ECkdo27n+w048J48aNiSDmOwB7R2vzO2zp+ILHEXGkiuCxlunqoX
 yd7WTXMyjRgt68qY=
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr11146653wma.148.1592201739119; 
 Sun, 14 Jun 2020 23:15:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSKENjBp0FB8KzNumdtC+z985NwJHx8Sq6QEcxEFY2J3vJD130lZdCUKEiSas35M/ESWTYgw==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr11146631wma.148.1592201738788; 
 Sun, 14 Jun 2020 23:15:38 -0700 (PDT)
Received: from [192.168.1.40] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id f185sm21856633wmf.43.2020.06.14.23.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jun 2020 23:15:38 -0700 (PDT)
Subject: Re: [PATCH v3 09/24] macio: Fix to realize "mos6522-cuda" and
 "mos6522-pmu" devices
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200609122339.937862-1-armbru@redhat.com>
 <20200609122339.937862-10-armbru@redhat.com>
 <871rmgdhmx.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <30c35741-b620-c19f-9487-cd7dc410315c@redhat.com>
Date: Mon, 15 Jun 2020 08:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <871rmgdhmx.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 01:17:36
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com, berrange@redhat.com,
 Laurent Vivier <laurent@vivier.eu>, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/15/20 7:26 AM, Markus Armbruster wrote:
> Peter, forgot to cc: you.  May I have your blessings for this version?

This file is maintained by Mark:

./scripts/get_maintainer.pl -f hw/misc/macio/cuda.c
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (odd fixer:Old World
(g3beige))
David Gibson <david@gibson.dropbear.id.au> (reviewer:Old World (g3beige))
qemu-ppc@nongnu.org (open list:Old World (g3beige))

Mark only check qemu-devel during week-end. Too bad you forgot
to Cc him, has he did a review pass over the last WE.

> 
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> cuda_init() creates a "mos6522-cuda" device, but it's never realized.
>> Affects machines mac99 with via=cuda (default) and g3beige.
>>
>> pmu_init() creates a "mos6522-pmu" device, but it's never realized.
>> Affects machine mac99 with via=pmu and via=pmu-adb,
>>
>> In theory, a device becomes real only on realize.  In practice, the
>> transition from unreal to real is a fuzzy one.  The work to make a
>> device real can be spread between realize methods (fine),
>> instance_init methods (wrong), and board code wiring up the device
>> (fine as long as it effectively happens on realize).  Depending on
>> what exactly is done where, a device can work even when we neglect
>> to realize it.
>>
>> These two appear to work.  Nevertheless, it's a clear misuse of the
>> interface.  Even when it works today (more or less by chance), it can
>> break tomorrow.
>>
>> Fix by realizing them in cuda_realize() and pmu_realize(),
>> respectively.
>>
>> Fixes: 6dca62a0000f95e0b7020aa00d0ca9b2c421f341
>> Cc: Laurent Vivier <laurent@vivier.eu>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>> ---
>>  hw/misc/macio/cuda.c | 15 ++++++++++-----
>>  hw/misc/macio/pmu.c  | 15 ++++++++++-----
>>  2 files changed, 20 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
>> index e0cc0aac5d..3cb10c743c 100644
>> --- a/hw/misc/macio/cuda.c
>> +++ b/hw/misc/macio/cuda.c
>> @@ -33,6 +33,7 @@
>>  #include "hw/misc/macio/cuda.h"
>>  #include "qemu/timer.h"
>>  #include "sysemu/runstate.h"
>> +#include "qapi/error.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/log.h"
>>  #include "qemu/module.h"
>> @@ -522,16 +523,20 @@ static void cuda_reset(DeviceState *dev)
>>  static void cuda_realize(DeviceState *dev, Error **errp)
>>  {
>>      CUDAState *s = CUDA(dev);
>> +    Error *err = NULL;
>>      SysBusDevice *sbd;
>> -    MOS6522State *ms;
>> -    DeviceState *d;
>>      struct tm tm;
>>  
>> +    object_property_set_bool(OBJECT(&s->mos6522_cuda), true, "realized",
>> +                             &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>>      /* Pass IRQ from 6522 */
>> -    d = DEVICE(&s->mos6522_cuda);
>> -    ms = MOS6522(d);
>>      sbd = SYS_BUS_DEVICE(s);
>> -    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
>> +    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->mos6522_cuda));
>>  
>>      qemu_get_timedate(&tm, 0);
>>      s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
>> diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
>> index 9a9cd427e1..0895b78b59 100644
>> --- a/hw/misc/macio/pmu.c
>> +++ b/hw/misc/macio/pmu.c
>> @@ -40,6 +40,7 @@
>>  #include "hw/misc/macio/pmu.h"
>>  #include "qemu/timer.h"
>>  #include "sysemu/runstate.h"
>> +#include "qapi/error.h"
>>  #include "qemu/cutils.h"
>>  #include "qemu/log.h"
>>  #include "qemu/module.h"
>> @@ -739,16 +740,20 @@ static void pmu_reset(DeviceState *dev)
>>  static void pmu_realize(DeviceState *dev, Error **errp)
>>  {
>>      PMUState *s = VIA_PMU(dev);
>> +    Error *err = NULL;
>>      SysBusDevice *sbd;
>> -    MOS6522State *ms;
>> -    DeviceState *d;
>>      struct tm tm;
>>  
>> +    object_property_set_bool(OBJECT(&s->mos6522_pmu), true, "realized",
>> +                             &err);
>> +    if (err) {
>> +        error_propagate(errp, err);
>> +        return;
>> +    }
>> +
>>      /* Pass IRQ from 6522 */
>> -    d = DEVICE(&s->mos6522_pmu);
>> -    ms = MOS6522(d);
>>      sbd = SYS_BUS_DEVICE(s);
>> -    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(ms));
>> +    sysbus_pass_irq(sbd, SYS_BUS_DEVICE(&s->mos6522_pmu));
>>  
>>      qemu_get_timedate(&tm, 0);
>>      s->tick_offset = (uint32_t)mktimegm(&tm) + RTC_OFFSET;
> 
> 


