Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FD6C4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D3592070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 18:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2PP0qjp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D3592070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEzfH-0001gs-DQ
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 14:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEzeP-0001H3-SW
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:12:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEzeO-0004qW-W6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:12:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29312)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEzeO-0004qC-Sh
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 14:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584641532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLtCg7EpWsRV+BnFdgr2QQ3eTxIjeWCmwmQs21tT2No=;
 b=i2PP0qjpGHTJJ9h2WifaVN9qqe6lnPSG5BYkJkb4WHwJYfc8FO6MBtpWjafVyQkBRzoguA
 KvT1Nny9MUUU42pUjTLa/5z8mD42dGg70akUC72+s/6DBSbV5YtxPdf7f9DJNLmQLL5k/7
 +jcENyYuoGClIVzLYAeXWS8GvDuSGkw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-n5pq276OPtO9cZLpgW5wfw-1; Thu, 19 Mar 2020 14:12:09 -0400
X-MC-Unique: n5pq276OPtO9cZLpgW5wfw-1
Received: by mail-wr1-f69.google.com with SMTP id b12so1422270wro.4
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 11:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vLtCg7EpWsRV+BnFdgr2QQ3eTxIjeWCmwmQs21tT2No=;
 b=Qt4IeQGUvYS36Uyp1uo3ENPcjeQRq9VQBcUloAJTMtJJvuqcavZUa549vor1EoiiZx
 5IVZcl4bJ110NPrWupXurWcaBIOR4sOMNVSFuzBIILUXoR8q8+MeYynXIfMgoQY4wDIp
 U35s7G5gPP3MHAsj3EEEJAm1hu7DwrUvX6LEfeMgTDb6JhzZosJN6fiH90Z65GvNYU8V
 n/BCOUPJVnLYqg0cqa6SG6vlDhPwb7B9CCPnfqmas1K6WLAl/X8JzsJ7st6dLnjs4ztX
 DBQ2Six9DyAcyWR90uDazf/6lLCQ/JF5RSkUdGDwOct9LYAL9Rtr8+iTqaf+KmgFx0n7
 6H+w==
X-Gm-Message-State: ANhLgQ030fMCVN7edHbdtPxZM8BO6vmnyYK89VhnYxAUKOSqWhgGE9fO
 6XKhxS34Jc94AagWH6wqzenEOBgZeyg9ZiWWexQzkOSLpCtXk2hqGx4jMhj5uICKP3jDYpeAAJp
 goqT0W2Rg3q+gXV4=
X-Received: by 2002:a1c:f615:: with SMTP id w21mr5088745wmc.152.1584641527088; 
 Thu, 19 Mar 2020 11:12:07 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtIVNyd1qwUy+dbnCwGgb78f8WbzwCi+Ke2jx5BZOuYpFImljvU8yXIPRKTdpUwqjYqDSaEAQ==
X-Received: by 2002:a1c:f615:: with SMTP id w21mr5088706wmc.152.1584641526792; 
 Thu, 19 Mar 2020 11:12:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id l83sm4131203wmf.43.2020.03.19.11.12.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 11:12:06 -0700 (PDT)
Subject: Re: [PATCH v3] MAINTAINERS: Add an entry for the HVF accelerator
To: Roman Bolshakov <r.bolshakov@yadro.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20200319135520.80901-1-r.bolshakov@yadro.com>
 <70dac67d-8cb1-466f-fe1f-6be4af7c8aca@redhat.com>
 <20200319180748.GC77771@SPB-NB-133.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f50beaaf-ad35-d504-cef8-fd2e029a65ed@redhat.com>
Date: Thu, 19 Mar 2020 19:12:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319180748.GC77771@SPB-NB-133.local>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 Nikita Leshenko <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 19:07, Roman Bolshakov wrote:
>> From the other thread discussions, I'd keep you at least listed as
>> designated reviewer:
>>
>> R: Roman Bolshakov <r.bolshakov@yadro.com>
>>
> Sounds good to me, thanks.

I'll add you back.  Anyway as long as it's me sending pull requests, M
vs. R doesn't change much.

Thanks,

Paolo


