Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911C1CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:21:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C07120656
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yqTdf+Tx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C07120656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbMu-0000PZ-JV
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44456)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbLe-0007gF-9l
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbLd-00021X-41
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:20:02 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44745)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbLc-00020v-U6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:20:01 -0400
Received: by mail-pg1-x543.google.com with SMTP id e10so8186760pgd.11
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Wb+3zAUn+l4NlM6wLvO4abhyBQJMMb1MgopA5691n+Q=;
 b=yqTdf+TxNAiUx1/GgPX8DlGrfLQTjHLR0uKWkAfXWXuPT1P6w8QPZnvYePY3aiGQ8I
 8UtNZQOy09v0ukghctQMw87BQ8wMMwkPr/jMv0FN9ucinuEfFNv3g51hAgG5LbxFhEBg
 qWvCBuYGrIweGWvi7PNQbSEYnno0TH3X8laHvRhDrP3dPJTFPbBNjbBAORdnuku4VLfz
 f4H2BZS2x9TR15RfWb3MghYGWsuTJILQs0TP60h0TV/a92lXfmkvYzKFup3xrCMTOLZ3
 EqzXo0ErKFllbhnlo1BafpnmrjLW52N7XBocynLg/ocH0+YLbEyOoDNoNWtFqyInQrRK
 X/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Wb+3zAUn+l4NlM6wLvO4abhyBQJMMb1MgopA5691n+Q=;
 b=Upgs1qfIn7S78sLdfmfYkecO2DSheiUHObPbyZObM232tFZCVY3QueBclVCxorLQDN
 JUdK6mzDqm2B7sgRg/zVSdTWhepN1kJMhr+JxYcuY5CO1PhE0rx7nWXfZJMOO2N5+hgF
 LGQjdxKlFmMvSZM1S3p1NjY+ymK8BfLvGVaPLb4y+gSXVto67kGS8RaEuTs3fLz9z/hl
 DgIi2kppIVf4IlcWYIMdv6fowCZUS5bZ88Kv4gCHYcStEoUxMtqvRQuLPUEsry/GLDq+
 X6n7Ve9I+v+ssl8Hi1n4TsmkBboZlpSNxNT7liJAPwOL8va9TEBRuSmWHRTOQ1Vy2N24
 lgSA==
X-Gm-Message-State: APjAAAV2gXf8cJr+sUgd/u2tfq62Vctk+3InwDTrODEZ6sDQIVmaQhVB
 feoE7ddatBNzcRIY40OeGZCJVA==
X-Google-Smtp-Source: APXvYqy3ePic4q1a8DoE0ql3cm9CWAIxnOKjNOj5rNd9pG1wtqA3hn+KfLMgj2IF4ExQuTwNZKVDng==
X-Received: by 2002:a63:cc4a:: with SMTP id q10mr12951838pgi.221.1571678399127; 
 Mon, 21 Oct 2019 10:19:59 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id g4sm15567991pfo.33.2019.10.21.10.19.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:19:58 -0700 (PDT)
Subject: Re: [PATCH 11/21] hw/alpha: Let the machine be the owner of the
 system memory
From: Richard Henderson <richard.henderson@linaro.org>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-12-philmd@redhat.com>
 <ed804be1-8516-3dbc-d738-20c2b03e5309@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ad652874-452b-2c8e-b80f-b6b8b5b8a751@linaro.org>
Date: Mon, 21 Oct 2019 10:19:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ed804be1-8516-3dbc-d738-20c2b03e5309@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/19 10:14 AM, Richard Henderson wrote:
> On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>>  hw/alpha/dp264.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/alpha/dp264.c b/hw/alpha/dp264.c
>> index ddc249261c..5696b1e79b 100644
>> --- a/hw/alpha/dp264.c
>> +++ b/hw/alpha/dp264.c
>> @@ -78,7 +78,7 @@ static void clipper_init(MachineState *machine)
>>       * Main memory region, 0x00.0000.0000.  Real hardware supports 32GB,
>>       * but the address space hole reserved at this point is 8TB.
>>       */
>> -    memory_region_allocate_system_memory(&ram_region, NULL, "ram",
>> +    memory_region_allocate_system_memory(&ram_region, machine, "ram",
>>                                           ram_size);
>>      memory_region_add_subregion(get_system_memory(), 0, &ram_region);
>>  
>>
> 
> I take it this squishes into the squish of patches 7+9?

Ah, no, it was the TyphoonState that had owned the ram prior to patch 7.


r~

