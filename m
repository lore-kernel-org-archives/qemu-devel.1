Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19888C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA33F2469A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DulL2ANq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA33F2469A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ispjk-0000PG-Pu
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 10:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1ispiZ-0007n3-38
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1ispiX-0006Y1-Uf
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:08:54 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:35346)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1ispiX-0006Xa-Oj; Sat, 18 Jan 2020 10:08:53 -0500
Received: by mail-yw1-xc41.google.com with SMTP id i190so15809012ywc.2;
 Sat, 18 Jan 2020 07:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Duv41/U78PGZeqaPdAVdG4xEAkbZpch4xkpLqskRtRg=;
 b=DulL2ANqr02RrHigS7G4o3CCCogLf+cn/JDgulqiJL4oqA5e5/QS+CRjVlec12FbwI
 2qtQKuHCrw91b0TGTEiKibkdawUAGH2T/cpmQpzKTB/Kfc6DI1nCz2725EBV2NCYKpQ7
 MYVQgaoqLxh5Co6TJRtOfOISFStGUD2xnrON1q3zlwcZ6HPfvGhYc3FS+yoDj/3BSrJw
 MGk4WYWX42Zx6h791nljBvi1CLeLuIm4KDj0fgFyj+8BD2rydGdeSrLWsn4WSo8Hxo4L
 muFwPEPH5Qp9lrLRbpfolgGpgSDJuyeCbQKtHm4hSX+Y5Uq3eEmun9a3F1O+LNM3HlXE
 GhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Duv41/U78PGZeqaPdAVdG4xEAkbZpch4xkpLqskRtRg=;
 b=pyG1qhMwln3wtnncXx6IFZvrjx8bxCX0fO1JB9rsR0E3OACB2esk0rQK14nOscAqyD
 VChR5nFZbgRYEvMdJuyYm32Dw2B8nOCOd+9EfYXD99P/T64677ZHy2YBm/nUKcZ4odcc
 /B+m7TMItgRSntwXqZBJ5BZLvur4mMI8iBH1SfYFgT9zaCX42ITLeP9nLAPXekWX4Wyp
 cFsH/STTPYPfkIPUTpgshbEtBI0IUuuWyqGXhjnDQNy0WVvgSIdbcgvjo5gM5RVR6rgf
 eO4tkq/OMuVU1voMGczckFQS5UzTd3i3rMyN7OdtEB0DXiyv820YIbzFh7J+B2GIPr1P
 D8+w==
X-Gm-Message-State: APjAAAXpwAwYrICknYKl2lh3iUMe0d/t6eofwhLsjYP0oT4Lq6/1NKQ8
 DPGZvsOGmSWs+BxAnFimLBqjUmdP
X-Google-Smtp-Source: APXvYqyyN2BhkDXE03m/Uv2IIkFBv7En8BymXCnEUuCL88TWOr3C2YW23Fo5PDXHGC2mTICEchyMBA==
X-Received: by 2002:a81:8393:: with SMTP id
 t141mr34527176ywf.196.1579360132736; 
 Sat, 18 Jan 2020 07:08:52 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 o69sm12949597ywd.38.2020.01.18.07.08.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 07:08:51 -0800 (PST)
Subject: Re: [PATCH 6/6] hw/arm/exynos4210: Connect serial port DMA busy
 signals with pl330
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200110203942.5745-1-linux@roeck-us.net>
 <20200110203942.5745-7-linux@roeck-us.net>
 <CAFEAcA_v98GcR06PWfm+=VnteQN_Q7iKK4wobAg6NrVSP1AyDg@mail.gmail.com>
 <20200117182939.GC13396@roeck-us.net>
 <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <7a9967c6-a370-9137-10fd-095113dd9852@roeck-us.net>
Date: Sat, 18 Jan 2020 07:08:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9zWeW1k-K7qVzCSOA70BmOCa9onT2z_QUQK-=0AJ+NjQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c41
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
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/17/20 10:44 AM, Peter Maydell wrote:
> On Fri, 17 Jan 2020 at 18:29, Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
>>> Rather than having the uart and pl330 pointers be locals,
>>> they should be fields in Exynos4210State. (Otherwise technically
>>> we leak them, though this is unnoticeable in practice because there's
>>> no way to destroy an Exynos4210State.)
>>>
>> Out of curiosity: Is that a new leak because they are now tied together,
>> or is it an existing leak ? I don't find many DeviceState entries
>> in xxxState structures, so find it difficult to determine if/when/why
>> there is such a leak.
> 
> Yes, it's an existing leak, though it's more of a conceptual leak

Do only the pointers have to be in Exynos4210State, or the entire
data structures ? In the armsse code it looks like it is the complete
data structures.

Also, it seems to me that this means that not only pl330 and uart states
are affected, but everything created with qdev_create(). If so, the entire
file needs a serious rework, not just its pl330 / uart initialization.
Am I missing something ?

Thanks,
Guenter

