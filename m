Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A994C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:05:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 353E7206A5
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 13:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dupsu2O3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353E7206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igq3Y-0004Qb-87
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 08:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1igq2e-0003eH-Po
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1igq2b-0002MG-I2
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:04:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48626
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1igq2b-0002Lu-DB
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 08:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576501440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycNJVlpeKBG3huxdA7o07iOUJ3mnVsthkN4USpcvP9g=;
 b=Dupsu2O3FDkPB6aH1iKkr6IKw56ocY4nDkDvZdzsR2yIXgapPoF+jxYeKQqpUhzj4w6JaQ
 O9NYO2pGg9ao4YE16ADHWctIVFZlZfQk6+GnJlepDuIpfhzEBFWWgKONvwUmV1v3Jk0iYO
 2nARqrrM4aoMuTEiUO1UVkKhQFk7p8s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144--ejA2iBFPoiE4DQWawPqFQ-1; Mon, 16 Dec 2019 08:03:59 -0500
Received: by mail-wm1-f70.google.com with SMTP id y125so1045903wmg.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 05:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ycNJVlpeKBG3huxdA7o07iOUJ3mnVsthkN4USpcvP9g=;
 b=jiGdrRfIE7eHJq5A9cDZlsMQCtX41Z3NhVf+O7J41U7cC0ytioICShlNR2sgxUvw77
 M8s4CGpWn15dgdkOUefUb5JPbj/iELNnk4bL60lM+xpI6r+OfMhKe+XaFpZ40FLymwYK
 Nye8xxjaJiRctCVzfVNbqES2nWJ/SyOiFxqmnOxp346ambw3N0WGYta7eyt7tO8vk0Hw
 XOMz4HSSpPbAK190Ajlf5y3ZzK9r7d72Up5FXhw7VBvtLP3fK9DqV86V1htCVJh+klVh
 ZttrGgKz70YQXYYkPWd7fXr4gAnjvdtcZ3z69iu/RgjUA8LVS+r8++kDyuaU/0Qr4rlA
 KWlg==
X-Gm-Message-State: APjAAAXF91V9IRqqYE8Hiwh4NFH/GyQFaiqDL5tmhhy8JowFrOcqSyQB
 5mMk2FrK+Ae/JLGmuqFcgMGHglgthm+4Ekv+b/lVDnl+fz7FWEOHJqojSjlp/KcUfdGcUz0fPp7
 pkX2dSgelJOWSMrw=
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr28498675wrv.368.1576501438049; 
 Mon, 16 Dec 2019 05:03:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqysWhvVMejCKhbmdN1NBtEkkGBF9rdhZZw2AfBTQjuxs0lZvKS04Omshql8yFWPBVX50xVzGQ==
X-Received: by 2002:a5d:52c4:: with SMTP id r4mr28498653wrv.368.1576501437823; 
 Mon, 16 Dec 2019 05:03:57 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id 25sm19613769wmi.32.2019.12.16.05.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2019 05:03:57 -0800 (PST)
Subject: Re: [Bug 1856549] Re: qemu-4.2.0/hw/misc/mac_via.c: 2 * bad test ?
To: Bug 1856549 <1856549@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <157649490094.7480.17075229014510714852.malonedeb@soybean.canonical.com>
 <157649752475.4226.12810383033052233683.malone@chaenomeles.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <47476c59-c7a1-b65e-bb20-79dad784cdde@redhat.com>
Date: Mon, 16 Dec 2019 14:03:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <157649752475.4226.12810383033052233683.malone@chaenomeles.canonical.com>
Content-Language: en-US
X-MC-Unique: -ejA2iBFPoiE4DQWawPqFQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/16/19 12:58 PM, dcb wrote:
> gcc compiler flag -Wduplicated-cond will catch this kind of problem.

Interesting, thanks for sharing!

> 
> You might want to switch it on in your builds. It has been available for
> over a year.
> 


