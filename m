Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64EF6C35254
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33015217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IlB+qxmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33015217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKZF-0000h1-Dj
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59374)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1izKY5-0008Ao-37
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:17:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1izKY2-0002K9-Q5
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:16:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31972
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1izKY1-0002De-FC
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580908612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RRhinE4RLFzWxI7x4IYuLBphVcWBq07tOLW6Rgd3WEw=;
 b=IlB+qxmZxM+/XfpYKxEjjO9meRQVFbRqlOWI/gPj2ValXcnST3k0vihweM3UknV6Y0ynOO
 jXyjtndsc2rY0zTSZohwirsdun+Y+/yrVYA1NT+vRPkXTz2iB+NmlG8P9rJ3z+MxKUtsCh
 nZ7LMI45L5VxD+2y+VA+5QzO/hFu17U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Ak0oDwgRN6uw7CB6WjumRw-1; Wed, 05 Feb 2020 08:16:44 -0500
Received: by mail-wm1-f70.google.com with SMTP id t17so976303wmi.7
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2020 05:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RRhinE4RLFzWxI7x4IYuLBphVcWBq07tOLW6Rgd3WEw=;
 b=bOHRC/OY1aLkvrChFNaf+pvMP9oKsTYfMlk0J0GxtAn7EitrUp4rKyDaUXY7ScRb3w
 9C9i2LeB3+CMluVz9e1Yo12fIOjAdE/087zzILwN1hZE1e+n9r3/Q095pkFTXqIt5rNy
 XgVww9+lkgxeI9yL9wU9lECzyTzKVWBs2Bcmhm4gB+k5krub0is63P0Bkb2NZvbrak2+
 c0o2nIG421AkGI5ZoRFbSnURJ1V5x7Cl5y6a5IaoTKkP7Kp29aIqJhThqhbbEJGwD2i4
 RosRUgvccuYjRpa9aGHr3PWq7VxY7ZSej8o7rXiKTEWox5u4Gq7e2A1lJmlZiaTbqcXW
 BRsw==
X-Gm-Message-State: APjAAAUHfUeTmf4eLQ4NbsbiP7KbldTpl23rsloz8JS8XVLZ1813KwKb
 zSe7aJjunD4MReGrkVBylkBeKv41KAnPMYZ+qATVzIm+J/ek0gDzNaMrUBiuXD9BhAeHSsPVDb2
 UxLXtSdpG4y2IvEg=
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr5719457wmd.101.1580908603231; 
 Wed, 05 Feb 2020 05:16:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqw6BMqMY6be6YHh4FEn7UB3S2opcpOvQyRTiPt6Pfvr1KsjdA+RVW/SmCHReEwTpNbT/s0uQQ==
X-Received: by 2002:a05:600c:295d:: with SMTP id
 n29mr5719436wmd.101.1580908602997; 
 Wed, 05 Feb 2020 05:16:42 -0800 (PST)
Received: from [192.168.1.35] (162.red-83-52-55.dynamicip.rima-tde.net.
 [83.52.55.162])
 by smtp.gmail.com with ESMTPSA id y6sm34356386wrl.17.2020.02.05.05.16.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Feb 2020 05:16:42 -0800 (PST)
Subject: Re: [PATCH 0/3] delay timer_new to avoid memleaks
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200205070659.22488-1-pannengyuan@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ef35a825-b1c8-84cf-a72a-3c4877b5ad98@redhat.com>
Date: Wed, 5 Feb 2020 14:16:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200205070659.22488-1-pannengyuan@huawei.com>
Content-Language: en-US
X-MC-Unique: Ak0oDwgRN6uw7CB6WjumRw-1
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
Cc: zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/5/20 8:06 AM, pannengyuan@huawei.com wrote:
> From: Pan Nengyuan <pannengyuan@huawei.com>
> 
> This series delay timer_new into realize() to fix some memleaks when we call 'device-list-properties'.
> 
> Pan Nengyuan (3):
>    armv7m_systick: delay timer_new to avoid memleaks
>    stm32f2xx_timer: delay timer_new to avoid memleaks
>    stellaris: delay timer_new to avoid memleaks
> 
>   hw/arm/stellaris.c         | 7 ++++++-
>   hw/timer/armv7m_systick.c  | 6 ++++++
>   hw/timer/stm32f2xx_timer.c | 5 +++++
>   3 files changed, 17 insertions(+), 1 deletion(-)

You might want to look at Coccinelle [*] and write a spatch script to 
check/fix all the codebase at once. You can find some examples in 
scripts/coccinelle/.

[*] http://coccinelle.lip6.fr/


