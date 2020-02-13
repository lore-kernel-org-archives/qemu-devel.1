Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1104C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:54:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCBB82168B
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 13:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LunB8F9S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCBB82168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2EwQ-0007wI-06
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 08:54:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51692)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j2Eve-00078K-7q
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:53:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j2Evd-0003Er-1f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:53:18 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32877
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j2Evc-0003Dn-UE
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 08:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581601996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v74zuWvJsToqbhALqcqyXmxJpMnNTkbGA769JD+fqHY=;
 b=LunB8F9SZ0TvfWu52XbPusud05UT2lZwqWQ2DuIDU7FmYv2rYHVtiE1cT6Sjydpoei+bhE
 ka4FYO6q4AGUFFz+oqSCg3nW73xfuQ2mZ1rsVvaBROcmjjVWFYf3naP7t/ihOnNJNJeOUl
 5nAg6H3CPqVTpPk+cjX2Evv2sKbfSu0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-v5WByW7JPdWS5X1kqeRKdg-1; Thu, 13 Feb 2020 08:53:14 -0500
Received: by mail-wm1-f71.google.com with SMTP id a189so2039436wme.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 05:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fd3QGAjx1cwbZudQ3kK3BytgAiXrgfi56WUJfwbT0/0=;
 b=WXQq3uIX9dOVnRnjKCHlAQvHPUaHjl3aWCfsHIYjj/XH3O+DIsFTajdKbGlrHQeNq4
 LMfJUtkEY+x+0zLs5WRHY1J50lmw4UjqM2V7c6/7TYz4t9Rad5333DPJasyBpSVlnPg8
 FjINen1ZXPYEnyNyhC6QuE2dzugBCMklCumUv3B+yVtBwVsqW3MSbhhierzQxDlgZThj
 ysN/y5Q1IFuNj9fJRmzbt/Rz6s0lHOsZesX5+tdY/Ws4svlOMoW88c9e+Ak0gGIS66M+
 XzARkK1Ki6szLTLEzgPBEDyz4OSFGvyoKLMg/NR97i5OCRCPnpLgMRpMHbPTjAe/+g4m
 s2Lw==
X-Gm-Message-State: APjAAAVmbzRsZlCtKjOeYn5EY0oD0Il5yf53ACh8PFHo/8022wv/kXiA
 CEl0HtEuuMmBix5xx+gTNJRG/GkJZR3zhv2nYydUBdpboCFVOxbaZnJZLxJJ6dqMAwAuFGu/Byj
 mKbcG8T4xwVS0djI=
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr20883500wrq.232.1581601993298; 
 Thu, 13 Feb 2020 05:53:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqyu3+XAGEr7Fx8LemATYPJlVFI6E//z8+8oKgPmPEkOk6jwSxTEI8WZbMiRU/Oz1ehW5Lc/aw==
X-Received: by 2002:a5d:4a91:: with SMTP id o17mr20883461wrq.232.1581601992930; 
 Thu, 13 Feb 2020 05:53:12 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id o4sm2916430wrx.25.2020.02.13.05.53.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2020 05:53:12 -0800 (PST)
Subject: Re: [PATCH v3 03/13] hw/arm/raspi: Extract the version from the board
 revision
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200208165645.15657-1-f4bug@amsat.org>
 <20200208165645.15657-4-f4bug@amsat.org>
 <CAFEAcA8raRKW5OYJzO1kHs263_uJ_LucCa9tKgg70iX0jGqcGQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8570a6c6-9fd2-2e65-3c12-b4fb04fa9f80@redhat.com>
Date: Thu, 13 Feb 2020 14:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8raRKW5OYJzO1kHs263_uJ_LucCa9tKgg70iX0jGqcGQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: v5WByW7JPdWS5X1kqeRKdg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Joaquin de Andres <me@xcancerberox.com.ar>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/13/20 2:40 PM, Peter Maydell wrote:
> On Sat, 8 Feb 2020 at 16:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>>
>> The board revision encode the board version. Add a helper
>> to extract the version, and use it.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   hw/arm/raspi.c | 31 +++++++++++++++++++++++++++----
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 818146fdbb..f285e2988f 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -16,6 +16,7 @@
>>   #include "qapi/error.h"
>>   #include "cpu.h"
>>   #include "hw/arm/bcm2836.h"
>> +#include "hw/registerfields.h"
>>   #include "qemu/error-report.h"
>>   #include "hw/boards.h"
>>   #include "hw/loader.h"
>> @@ -37,6 +38,28 @@ typedef struct RasPiState {
>>       MemoryRegion ram;
>>   } RasPiState;
>>
>> +/*
>> + * Board revision codes:
>> + * www.raspberrypi.org/documentation/hardware/raspberrypi/revision-code=
s/
>> + */
>> +FIELD(REV_CODE, REVISION,           0, 4);
>> +FIELD(REV_CODE, TYPE,               4, 8);
>> +FIELD(REV_CODE, PROCESSOR,         12, 4);
>> +FIELD(REV_CODE, MANUFACTURER,      16, 4);
>> +FIELD(REV_CODE, MEMORY_SIZE,       20, 3);
>> +FIELD(REV_CODE, STYLE,             23, 1);
>> +
>> +static int board_processor_id(uint32_t board_rev)
>> +{
>> +    assert(FIELD_EX32(board_rev, REV_CODE, STYLE)); /* Only new style *=
/
>> +    return FIELD_EX32(board_rev, REV_CODE, PROCESSOR);
>> +}
>> +
>> +static int board_version(uint32_t board_rev)
>> +{
>> +    return board_processor_id(board_rev) + 1;
>=20
> This uses the 'processor' field, which basically means the SoC
> (0 for BCM2835, 1 for BCM2836, 2 for BCMM2837, 3 for BCM2711).
> We use 'version' for a wider range of things in our code here:
>   * do we need SMP setup?
>   * which address does the firmware image go?
>   * do we need to set up SMC vectors so no-op SMC works?
>   * as well as "which SoC do we instantiate"?
>=20
> We think of 'version' as basically "raspi 2 or 3?", but
> according to the table in your url you can get a version of
> the raspi 2b with a BCM2837 SoC, which confuses this idea.
>=20
> Anyway, since what we have in this patch works OK for the set
> of board models we support, I'm happy to leave the patch as-is,
> but maybe worth checking and considering what in our code we
> should really be making conditional on "actually the SoC type"
> and what on something else...

Yes you are right, version =3D (2, 3) was too simple, I replaced the=20
'version' check by 'processor_id' in the series introducing the raspi4=20
(with other cleanups).
Eventually this file will only use the board_rev fields directly.


