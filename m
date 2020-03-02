Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D96C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:55:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55D3E2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 17:55:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX8U/lhP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55D3E2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8pIL-0005gb-Iz
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 12:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8pHW-000554-Cp
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8pHV-0005lV-3h
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:55:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20229
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8pHU-0005lJ-W0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 12:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583171704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qV/n+9E+KvPiSQBkYJToe7Cqz4DZjwM9HXO4lcmyJCA=;
 b=EX8U/lhP8XKymovv055hdh79o4AiwHlYsmuqXUliViOPTUXHlg+Xbiu+V6mO/qXu3u08B6
 Q/D1gtNumWo/iG7jvHz1e3EJ12hbVduWsUpbNznKUm+2Lh/OPL4Msz6Tnk5JbBcHqCOv3J
 bmIyZAU1xnUkVteqkwBVpwBvRjjgu3Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63--jmLszlDOPSdgQU9h7T58Q-1; Mon, 02 Mar 2020 12:55:00 -0500
X-MC-Unique: -jmLszlDOPSdgQU9h7T58Q-1
Received: by mail-wr1-f72.google.com with SMTP id m18so22221wro.22
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 09:55:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qV/n+9E+KvPiSQBkYJToe7Cqz4DZjwM9HXO4lcmyJCA=;
 b=mFdQHB7OXJ2O/IOOQfhnv7XcxXCpg0b2EJyW4xG5uWsJXGdIsvnNQBrCRk/jbole3U
 ZGf3xdrAO3ZaUmkwHr+vQAdjXeTf6hgwliL4gfzQVqJDII5dcMYPxG81Hf9yBsinv5t3
 n3OszQ2PGkmzPwUv0DRIIFbq3HW+Lgj6P1lrOfBTfVINoN93uda2pEf3hL3iPRRPz6zr
 vLNxpq91TPClizcqk4BrqttxR6c6hGNF6Ix42vwt5UMifMwBKnZelUhhdzVPqNqxDrcF
 7EwL/tk9t0wJJC8A9peVu3yNpO60yzcwPKnfgLM2J6TBSI17xUT8LhC1plEHY2NRXTzi
 9PBw==
X-Gm-Message-State: ANhLgQ3/UB+lK6DhzqtsY2KXJdOAPDAj+FO+tnhVbFtwNIgJvE1HYfF5
 67ONNjx9tX/Rpg3FKbWHCnUrvwRiaqgd5xScDbcP89P0bwbYCMRJTlqu0MDgkG/T/dgq3SDkY0n
 kYbyLr/Rn2TIcDXg=
X-Received: by 2002:adf:a50b:: with SMTP id i11mr833080wrb.60.1583171698549;
 Mon, 02 Mar 2020 09:54:58 -0800 (PST)
X-Google-Smtp-Source: ADFU+vv0GhJiZVIuslmEeR1zBl+EIFFFHpF00BBakr8oXnlIaoHIb8k8yCCYU4W7J2mTwVthob8wjA==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr833063wrb.60.1583171698324;
 Mon, 02 Mar 2020 09:54:58 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id e22sm168991wme.45.2020.03.02.09.54.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 09:54:57 -0800 (PST)
Subject: Re: [PATCH v1 1/4] hw/arm/cubieboard: use ARM Cortex-A8 as the
 default CPU in machine definition
To: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200227220149.6845-1-nieklinnenbank@gmail.com>
 <20200227220149.6845-2-nieklinnenbank@gmail.com>
 <CAFEAcA_xB_dMfcALk6sirmRJyJ0rw7_JPK6aqBoZMxh=wH+d-g@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3ad40e56-6afc-6dc2-7e73-41dadb2b7c6b@redhat.com>
Date: Mon, 2 Mar 2020 18:54:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_xB_dMfcALk6sirmRJyJ0rw7_JPK6aqBoZMxh=wH+d-g@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 4:32 PM, Peter Maydell wrote:
> On Thu, 27 Feb 2020 at 22:01, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>>
>> The Cubieboard is a singleboard computer with an Allwinner A10 System-on-Chip [1].
>> As documented in the Allwinner A10 User Manual V1.5 [2], the SoC has an ARM
>> Cortex-A8 processor. Currently the Cubieboard machine definition specifies the
>> ARM Cortex-A9 in its description and as the default CPU.
>>
>> This patch corrects the Cubieboard machine definition to use the ARM Cortex-A8.
>>
>>   [1] http://docs.cubieboard.org/products/start#cubieboard1
>>   [2] https://linux-sunxi.org/File:Allwinner_A10_User_manual_V1.5.pdf
>>
>> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
>> ---
>>   hw/arm/cubieboard.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
>> index 089f9a30c1..0195925c73 100644
>> --- a/hw/arm/cubieboard.c
>> +++ b/hw/arm/cubieboard.c
>> @@ -68,8 +68,8 @@ static void cubieboard_init(MachineState *machine)
>>
>>   static void cubieboard_machine_init(MachineClass *mc)
>>   {
>> -    mc->desc = "cubietech cubieboard (Cortex-A9)";
>> -    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a9");
>> +    mc->desc = "cubietech cubieboard (Cortex-A8)";
>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a8");
>>       mc->init = cubieboard_init;
>>       mc->block_default_type = IF_IDE;
>>       mc->units_per_default_bus = 1;
> 
> This is worth fixing, but I'm pretty sure it doesn't have
> any user-visible effects, because the CPU is created by
> hw/arm/allwinner-a10.c:aw_a10_init(), which always uses
> cortex-a8 regardless of what the user specified on the command
> line or what the mc->default_cpu_type is.

It is worth fixing if we continue the MachineClass code cleanup Igor 
wants (moving the ram size / cpu type checks in the machine common code).

> 
> Fixes: 8a863c8120994981a099
> 
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> if you tweak the commit message to mention that it
> wasn't a user-visible bug (but I'll do that myself if there
> isn't anything else in the series that means it needs a respin).
> 
> thanks
> -- PMM
> 


