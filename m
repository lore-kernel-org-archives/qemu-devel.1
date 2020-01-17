Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A250BC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:08:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E1DD206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 13:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjfmDGhy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E1DD206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isRMW-0007Af-J3
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 08:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isRLp-0006Y0-8f
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:07:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isRLl-0000g8-SY
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:07:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53317
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isRLl-0000fh-Oh
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 08:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579266465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=146OOkWpkacaps27rv8fN6FCDTAn5cxxczZuAMRntV8=;
 b=AjfmDGhy7R+kiIC02lTXnv4M0UzP//gvzkIyvcGX2A+v2nzgMrkfCNgNT6bzYgW/FKt1do
 UShbydZjRTXOXXd63dAdycn17dLhZemV8CP618Rw/GBejKcF3ZyBImBNZiTU14VD9yzSFc
 /yMIQ5BQTbXzbpDXQ+09OpoP8DgfP0Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-7TbbzVbwMPiKiefUMVPlOA-1; Fri, 17 Jan 2020 08:07:41 -0500
Received: by mail-wm1-f69.google.com with SMTP id p2so2251194wma.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 05:07:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G6HLqVPHHaxyzj153UpuxS6ANVUElNpE304p19yqgEE=;
 b=DBTjxDj9CDDntHg3CJbp2LpStkQhg6zU6Gdj0XKscRcmrPgbaNrlsk6ANPYMpJx/Es
 /W2TrwAGQHq+SgukYTeVIJiFEllPydQou+eL+3X4C++3HvT/yIZ+lQbStZZWgBirkDrm
 ocsOHYRSfaWd/NLRP0ZBbLUjOv4Kg/E7InOcaZg0WWCZOL4mOFlrOu5qyBM3gG5Kf0aA
 1SfwgoXPRolooBOmEcWp+/qr4hqVC3zkaQiBZ0o6o05po+Sj135O7bnBgPGbHpw9r7Bt
 gwSGtH+7gNDxlVpVrElrPWYpvYp3h17WHMbK/PVCesO3WXYAQ0UVPsoONyS+cYzgpev2
 rSUA==
X-Gm-Message-State: APjAAAUrI2CetBI/hhVi++0Hma4o4wErDEWqaLkvef2RK0W3cPFXyqCV
 KfFlJBcHyPNjnpDY/qMgWtUzpa4hg0+Z8XG9qVH+dzMMuyW8PaQtgBu3m4nlW7OfE+CfNSsTElP
 eY3mhl8SpVUw7OMw=
X-Received: by 2002:adf:e550:: with SMTP id z16mr2918625wrm.315.1579266460010; 
 Fri, 17 Jan 2020 05:07:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwokMxMGjwhFISkvKgNXh2OTv2zfwk2sW5ybNyUVsCrA05gWkoXKpk5m8Fp7pHuWA/C8HmRBA==
X-Received: by 2002:adf:e550:: with SMTP id z16mr2918609wrm.315.1579266459796; 
 Fri, 17 Jan 2020 05:07:39 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x10sm33845194wrp.58.2020.01.17.05.07.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jan 2020 05:07:38 -0800 (PST)
Subject: Re: [PATCH v3 18/86] arm:kzm: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>
References: <87sgkgv6dh.wl-Peter.Chubb@data61.csiro.au>
 <1579195564-95459-1-git-send-email-imammedo@redhat.com>
 <dc8d8594-0bf8-e6c2-9ce8-94bf5361bca3@redhat.com>
 <20200117105033.6801593a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <02ebfedd-854c-5500-f167-91918850435f@redhat.com>
Date: Fri, 17 Jan 2020 14:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200117105033.6801593a@redhat.com>
Content-Language: en-US
X-MC-Unique: 7TbbzVbwMPiKiefUMVPlOA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter.Chubb@data61.csiro.au, peter.maydell@linaro.org, qemu-arm@nongnu.org,
 peter.chubb@nicta.com.au, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 10:50 AM, Igor Mammedov wrote:
> On Thu, 16 Jan 2020 19:22:08 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>=20
>> On 1/16/20 6:26 PM, Igor Mammedov wrote:
>>> If the user provided too large a RAM size, the code used to
>>> complain and trim it to the max size.  Now tht RAM is allocated by
>>> generic code, that's no longer possible, so generate an error and
>>> exit instead.
>>>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> v3:
>>>    * rephrase commit message in nicer way
>>>      ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro=
.au>)
>>>    * reword error message and use size_to_str() to pretty print suggest=
ed size
>>>      ("Chubb, Peter (Data61, Kensington NSW)" <Peter.Chubb@data61.csiro=
.au>)
>>>
>>> CC: peter.chubb@nicta.com.au
>>> CC: peter.maydell@linaro.org
>>> CC: qemu-arm@nongnu.org
>>> ---
>>>    hw/arm/kzm.c | 9 +++++----
>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
>>> index 1d5ef28..94cbac1 100644
>>> --- a/hw/arm/kzm.c
>>> +++ b/hw/arm/kzm.c
>>> @@ -25,6 +25,7 @@
>>>    #include "hw/char/serial.h"
>>>    #include "sysemu/qtest.h"
>>>    #include "sysemu/sysemu.h"
>>> +#include "qemu/cutils.h"
>>>   =20
>>>    /* Memory map for Kzm Emulation Baseboard:
>>>     * 0x00000000-0x7fffffff See i.MX31 SOC for support
>>> @@ -78,10 +79,10 @@ static void kzm_init(MachineState *machine)
>>>   =20
>>>        /* Check the amount of memory is compatible with the SOC */
>>>        if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM=
1_SIZE)) {
>>> -        warn_report("RAM size " RAM_ADDR_FMT " above max supported, "
>>> -                    "reduced to %x", machine->ram_size,
>>> -                    FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE);
>>> -        machine->ram_size =3D FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1=
_SIZE;
>>> +        char *sz =3D size_to_str(FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDR=
AM1_SIZE);
>>> +        error_report("RAM size more than %s is not supported", sz);
>>
>> Yay! Can you use this pattern the other patches too?
>=20
> I plan to, as it's much neater and I can avoid adding RAM_ADDR_FMT
>=20
> Would your acks still stand or should I drop your Reviewed-bys
> on changed in such way patches?

Yes please keep my Reviewed-by tag in the other patches too.

>> You might want to add:
>>
>> #define FSL_IMX31_SDRAM_SIZE_MAX \
>>     (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)
>>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>
>>> +        g_free(sz);
>>> +        exit(EXIT_FAILURE);
>>>        }
>>>   =20
>>>        memory_region_allocate_system_memory(&s->ram, NULL, "kzm.ram",
>>>   =20
>>
>=20


