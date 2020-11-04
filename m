Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B993C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:12:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8BCE2224E
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a/cYWKoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8BCE2224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaFmR-0006w5-DK
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:12:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38436)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaFlp-0006X8-7S
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kaFln-0000zW-6f
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604484718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8KCHNBWlxhJ21A8v9hyJ93To5a/M5D3OV6qZxZaUh40=;
 b=a/cYWKoARgnABv3LBGwLHxXQbTcF1FTQxj2ZEN7z6RU93drwsxAN5DGmNZI1ebJuFSp/Cg
 7+89l+AG92ekJ5xqMySmA6StfBLSysBR8TumqBIgTLLmJRAuBQqV9HExrJaIuTQilIrzgI
 LNomHJk8tgb3lgzEgFGbwpnvLUkagG4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-g-6I7qAyNXuRW6dQlzq86A-1; Wed, 04 Nov 2020 05:11:56 -0500
X-MC-Unique: g-6I7qAyNXuRW6dQlzq86A-1
Received: by mail-wr1-f69.google.com with SMTP id t14so9126383wrs.2
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 02:11:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8KCHNBWlxhJ21A8v9hyJ93To5a/M5D3OV6qZxZaUh40=;
 b=Kj/oMnIoc54PxYDUiTLQF6kr6rTTXErp5eu9TOtRZ1aHBi0uHcCdHPGsIaCxiXKJi/
 DzWSZP0uo9JnY7eTHuPcalt9R4IA3bygG8IxG2crwCy/dnTGd3cgTurHjXwTGt8NXVzp
 XSwAmnc0b4/KdMT2p+6Qnnf1djEJtKEvor8KeDDCY0kt1wTpftjiWSShmUKkMCHlA1k1
 0sCmzF9UsFq423tT0OcE9SuSpwjgQX9KEM5MZfDpN6boZ7zhjuCs17pTDrki4WFRgCe8
 66wR3HyC7eyrT8A76sAbaDSKC6bTdjXFubkUZw8LiCwea8ANf8hMGK+Zg7nhiai8+3y4
 /IyQ==
X-Gm-Message-State: AOAM532/tGudj7UO+49kLlIIb+3ZBAfH30yUSRy4b2meTtdPe3+4Wi54
 lz6ydM2XvTq4RV1wry+EP0uxWt0QKJ5Bf29elf0uCRb4UgHoby7C2lafRc8Z0y6FtSFQbDsMHB+
 kbu7n/tUHo8UkxOE=
X-Received: by 2002:adf:f90f:: with SMTP id b15mr31477336wrr.343.1604484714991; 
 Wed, 04 Nov 2020 02:11:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMW8vKzYB8rti/vOtzHTte0uBl5pMtlxmwU+D5xgB316sEBtBUD4riisIpuiqizidWI0q6NA==
X-Received: by 2002:adf:f90f:: with SMTP id b15mr31477311wrr.343.1604484714815; 
 Wed, 04 Nov 2020 02:11:54 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id r3sm1870767wrm.51.2020.11.04.02.11.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2020 02:11:54 -0800 (PST)
Subject: Re: [PULL 48/48] hw/timer/armv7m_systick: Rewrite to use ptimers
To: Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20201027114438.17662-1-peter.maydell@linaro.org>
 <20201027114438.17662-49-peter.maydell@linaro.org>
 <20201104100357.7t4nnwqot6ahprrh@kamzik.brq.redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b68320e2-d0bc-3d17-c188-f68fb8136f46@redhat.com>
Date: Wed, 4 Nov 2020 11:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201104100357.7t4nnwqot6ahprrh@kamzik.brq.redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/4/20 11:03 AM, Andrew Jones wrote:
> On Tue, Oct 27, 2020 at 11:44:38AM +0000, Peter Maydell wrote:
>> The armv7m systick timer is a 24-bit decrementing, wrap-on-zero,
>> clear-on-write counter. Our current implementation has various
>> bugs and dubious workarounds in it (for instance see
>> https://bugs.launchpad.net/qemu/+bug/1872237).
>>
>> We have an implementation of a simple decrementing counter
>> and we put a lot of effort into making sure it handles the
>> interesting corner cases (like "spend a cycle at 0 before
>> reloading") -- ptimer.
>>
>> Rewrite the systick timer to use a ptimer rather than
>> a raw QEMU timer.
>>
>> Unfortunately this is a migration compatibility break,
>> which will affect all M-profile boards.
>>
>> Among other bugs, this fixes
>> https://bugs.launchpad.net/qemu/+bug/1872237 :
>> now writes to SYST_CVR when the timer is enabled correctly
>> do nothing; when the timer is enabled via SYST_CSR.ENABLE,
>> the ptimer code will (because of POLICY_NO_IMMEDIATE_RELOAD)
>> arrange that after one timer tick the counter is reloaded
>> from SYST_RVR and then counts down from there, as the
>> architecture requires.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> Reviewed-by: Philippe Mathieu-DaudÃƒÆ’Ã‚Â© <f4bug@amsat.org>
>> Message-id: 20201015151829.14656-3-peter.maydell@linaro.org
>> ---
>>  include/hw/timer/armv7m_systick.h |   3 +-
>>  hw/timer/armv7m_systick.c         | 124 +++++++++++++-----------------
>>  2 files changed, 54 insertions(+), 73 deletions(-)
>>
> 
> Do we also need something like the diff below now?
> 
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index fdf4464b9484..7d5d89e1acf9 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -291,6 +291,7 @@ config ZYNQ
>  
>  config ARM_V7M
>      bool
> +    select PTIMER

Oops yes indeed.

>  
>  config ALLWINNER_A10
>      bool
> 
> 
> Thanks,
> drew
> 
> 


