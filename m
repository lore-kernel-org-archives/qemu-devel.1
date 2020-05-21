Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E916AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:10:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD1402072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5PfsRJS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD1402072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmqO-00055N-Tp
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:10:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbmpW-0003mJ-Vk
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:09:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41350
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jbmpW-0007o9-65
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590073793;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4C2rlTA9x8STJ/ou3J/Z32EJLvR3kTYr7pxFIXxvcMY=;
 b=f5PfsRJSfbw+/gC2kGZaijMkHiuMinpf+dwtnYuD/11SlRmjRxwOTkSPMfRebJR1vdnilI
 HhRxmG7yvzkOchkR5ZWFIgRrq54m6B8M78pejx5pWDpbWIkCFR2hzQfr4vvJRFanOKT1eJ
 FKX/oiImLKyUJy2lRrXi5voCMomesus=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Xi6VOycDPLif0fkZLyiRDg-1; Thu, 21 May 2020 11:09:49 -0400
X-MC-Unique: Xi6VOycDPLif0fkZLyiRDg-1
Received: by mail-wm1-f70.google.com with SMTP id g10so2810864wme.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4C2rlTA9x8STJ/ou3J/Z32EJLvR3kTYr7pxFIXxvcMY=;
 b=hwSSuvJG4TbH010E+sSmLQ6WKDUu25/2EcRyPgZEFMEXPkTI40eBq62AlqimfXIuhj
 MVTj28CQ4jGacpL9Rx3+Xu7fK3yjDFgjNfx6/SeS87MFW8BQDhXTCTkkxhIrePb4UrXG
 ra8PRb1CBlYCT/kUt3bPCX//EikzuwJYsJelis/qqFIx7d8+qrRaEXtJtt/8RQObXJdo
 P0nWb8jJROtJkbwqo3BR35L36Y7daEtm9xV/RRhio6xhBv85xewQGe01b0zdCzYDb/lj
 W1mUC+lDj0UxW+8vJ47q8SiTqe71FrJJBQu7MruzL+FqlfFXngO4k5y/0EgAud+C5HLl
 LIWw==
X-Gm-Message-State: AOAM531ThuADSNRHMB0EExoI5EIVO3aN7AkCPQqxI+nsA2YDW4j71TkE
 cAVuO6/e7PwKUJ0jGG8WRuHU3Pgx6+/ggYejeulJu1RwhwknkvtIUiFjWNh5xxmbDsG2JQ1YQah
 5jsV3GPRo1R8a3CQ=
X-Received: by 2002:adf:b354:: with SMTP id k20mr879805wrd.412.1590073788247; 
 Thu, 21 May 2020 08:09:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwrfDLXn+6XrRCUoPeU6I2fY7mEd8+5G0g5arflPv0KSsLCGkHzbz8ggPrzuH/ZdsKzxBLO8g==
X-Received: by 2002:adf:b354:: with SMTP id k20mr879775wrd.412.1590073787981; 
 Thu, 21 May 2020 08:09:47 -0700 (PDT)
Received: from [192.168.1.40] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id b65sm7154112wmc.30.2020.05.21.08.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:09:47 -0700 (PDT)
Subject: Re: [PATCH v2 02/10] MAINTAINERS: Add an 'overall' entry for
 accelerators
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200515170804.5707-1-philmd@redhat.com>
 <20200515170804.5707-3-philmd@redhat.com>
 <528c5bbd-7bf4-4dc8-c69e-5d5b6fa30493@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8853e7ba-aceb-fbe0-2eb4-b9e18111d81d@redhat.com>
Date: Thu, 21 May 2020 17:09:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <528c5bbd-7bf4-4dc8-c69e-5d5b6fa30493@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:44:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-riscv@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Palmer Dabbelt <palmer@dabbelt.com>, Michael Walle <michael@walle.cc>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/20 7:26 PM, Thomas Huth wrote:
> On 15/05/2020 19.07, Philippe Mathieu-Daudé wrote:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   MAINTAINERS | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index fd88a3de49..659092eb43 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -415,6 +415,15 @@ S: Supported
>>   F: target/i386/kvm.c
>>   F: scripts/kvm/vmxcap
>>   
>> +Guest CPU Cores (other accelerators)
> 
> Maybe s/other accelerators/accelerators generic code/ ?

But then we have HVF and WHPX listed there...

> 
>> +------------------------------------
>> +Overall
>> +M: Richard Henderson <rth@twiddle.net>
>> +R: Paolo Bonzini <pbonzini@redhat.com>
>> +S: Maintained
>> +F: include/sysemu/accel.h
>> +F: accel/stubs/Makefile.objs
> 
> What about accel/accel.c and accel/Makefile.objs ? Should they also be
> in the list here?

OK.

> 
>   Thomas
> 


