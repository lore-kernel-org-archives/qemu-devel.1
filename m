Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4D1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:12:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC52F21835
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 14:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxMjco2Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC52F21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itXnH-0002Zi-TO
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 09:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1itXmE-0001kd-Ko
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:11:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1itXmA-0006KQ-U0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:11:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38558
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1itXmA-0006K9-RB
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 09:11:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579529494;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDGAV3QhU/eE1Y7cuVyRbz2nXej2CCA9CZvlP9eg7jc=;
 b=bxMjco2QnNt1qk8vbInmpE+XoAEMEYTRx3M8iHta0b6o0D7ni1Tx7qlt52LMLB6oBacnNi
 Oc9zV8ez2rNo6rfkI8i1GXRW7zVj9xjDZ22TXec+ZUhhNBoJ7dHyvWH9FwquzrWC02hfR7
 hB0MG+2mUCxhejjSR3IizI1188kWzTI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-YQxESkmmPdSsFzRPtMSojA-1; Mon, 20 Jan 2020 09:11:32 -0500
Received: by mail-wr1-f69.google.com with SMTP id u12so14176116wrt.15
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 06:11:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SxnHpeVt7Kxi5Mq7w5H+O8eTfhJBUNne0/A1tG5HIpU=;
 b=K6JKNnf02lYR0KaulVcwK1mqbRr7QygugpbTr44BL/Wm+GZr/OElQzxuDCVqHPh+u7
 UazNoAnqpSwBQksmhdtsIyI6PpFm60iaSvcj2D+tIYmKBCmw83pxnZ6FmFgo2B+1OYV2
 8DfJxI8AUtXOwV6RvYzGNh7uqvRdCse5Gn2GkUPYpZbT61sxRtjXDewklzNTm2hotHxu
 ZASpeRNqU8fKIRfYvgYqOP2ukeC+u7OjNCcw8Iprro7xunlEVi5OaKHgh+lwGz/gEA3d
 aCuWJPnZo5Dqg7nGA4bOPFPNUh9bjG4elSUY6oSYP7MKFGjggordvgwjn06Th7/Cgzk0
 BtJg==
X-Gm-Message-State: APjAAAVnABy/cdBzo0WZTnJawBELO1q5LcYXBkjF5MkLFtISy66VlLH2
 BoPxnR/AjnMpmX4lOyrpRVepWHp4TiRqTbinwxVHBPqAhGVk6H08g0AimwHaXeI33XIomCSJnut
 FgeBDh2dhDQCJ2gg=
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr17916650wrs.287.1579529489355; 
 Mon, 20 Jan 2020 06:11:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxulsO8hg0ySyTHIMouXGb9C/7GgV29Qac301GeahUAPeO+fB4twHd1YL+25sPLnhjnAXgK/w==
X-Received: by 2002:a5d:46d0:: with SMTP id g16mr17916620wrs.287.1579529488979; 
 Mon, 20 Jan 2020 06:11:28 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id n10sm46877943wrt.14.2020.01.20.06.11.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jan 2020 06:11:28 -0800 (PST)
Subject: Re: [PATCH v2 2/2] MAINTAINERS: Move the OMAP section inside the ARM
 Machines one
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200118085509.30182-1-philmd@redhat.com>
 <20200118085509.30182-3-philmd@redhat.com>
 <CAFEAcA92AOY1m9yUew4WtwKfJ63kSF-xwnaYNjmxY33rJEhzJg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1c978771-a622-f0ca-3fa4-d3e27c416391@redhat.com>
Date: Mon, 20 Jan 2020 15:11:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA92AOY1m9yUew4WtwKfJ63kSF-xwnaYNjmxY33rJEhzJg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: YQxESkmmPdSsFzRPtMSojA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/20/20 2:24 PM, Peter Maydell wrote:
> On Sat, 18 Jan 2020 at 08:55, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> Add the Siemens SX1 (OMAP310) machines with the other ARM machines.
>=20
>> +OMAP
>> +M: Peter Maydell <peter.maydell@linaro.org>
>> +L: qemu-arm@nongnu.org
>> +S: Maintained
>> +F: hw/*/omap*
>> +F: include/hw/arm/omap.h
>=20
> This is the block that covers the various devices
> and SoC objects for all the OMAP boards. I'm not clear
> why the commit message calls out the SX1 in particular ?

I missed that indeed, thanks.


