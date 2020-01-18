Return-Path: <SRS0=bgql=3H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E84C33CB1
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4895B24699
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2020 15:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSIYitJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4895B24699
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isqCb-0000ri-6X
	for qemu-devel@archiver.kernel.org; Sat, 18 Jan 2020 10:39:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57738)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1isqBx-0000Iz-FM
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:39:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1isqBw-0008N7-Fx
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:39:17 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20807
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1isqBw-0008Mr-Ct
 for qemu-devel@nongnu.org; Sat, 18 Jan 2020 10:39:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579361955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KkAm8xMOu305hVVU8Iq9Llxt8o9rYmI6atVtTp/Bxyc=;
 b=KSIYitJtdPzaMujh8yG0uPmF4F6i0tuVQLc7VCfbWJjt2z4qaGq5+ecxf4gBotSWXfW7Nb
 s6bBtkgMas0+F998/os6r5dZDTCaqCwRh7MB+Qi1WCwObKe9wn8E2/W5yKg5XRxk1JZ2f0
 NRs6wpNQjlNc2tCy34tqDc3d1GJ8604=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-DMsbaITcML6mszoMcBZkVg-1; Sat, 18 Jan 2020 10:39:12 -0500
Received: by mail-wr1-f70.google.com with SMTP id z15so11912356wrw.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2020 07:39:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KBhmithM/eVBvOeOZkqqwHiOAaxsa0FQBJXrl4Mnl/A=;
 b=btNuakUCXiBMaoRgxcZLIsJgncIrcZOhbCON+UBbKFYJZXibwQe35GVhmnBMVXUITy
 ybySV1frXSOYIyb7beuS/nM79oan67HHEBXCXCow1tgzbgJ5Nw3jTW7gfQd4tVf1nEUP
 MG/9dCT3LY1vbdkDSh6XfAlMvxc6c1f/yLwtahCDhPleyNPm/axdtBTmO1ewe0ohEiV2
 aA2Hxh6goFqJxVR8rEdp8Bz6B050cP+3403AM/oEhCiNc+yUoA3XGecfeltxooQfUhE8
 9tvwrNOEhpe0q/xp6RrQHlAb+uO9soknx/zirND/m49VtP/BUvg0v38SslVN16AE8huc
 oGgA==
X-Gm-Message-State: APjAAAXDRrUkLEV084NE9AREN0aJ872mpoAuHBSlVZI+PDcZr0b5pHer
 4UmOX5NNz/tY5sZNjL+6EnkK4oGzvBo+9SDlfmcVTqMvRGe7TLRZWu62H7LVq8KELcoJU3ofAFM
 51kPG32bD1DtX36E=
X-Received: by 2002:adf:f78e:: with SMTP id q14mr8648500wrp.186.1579361951206; 
 Sat, 18 Jan 2020 07:39:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcGIkzVGrHCipqHIk25A4Gah0a4e9vjD3yaNZBUMgXID4nJeTFKOq1lX4RS42BpXG+HV9cnw==
X-Received: by 2002:adf:f78e:: with SMTP id q14mr8648491wrp.186.1579361951025; 
 Sat, 18 Jan 2020 07:39:11 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id x7sm38106032wrq.41.2020.01.18.07.39.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jan 2020 07:39:10 -0800 (PST)
Subject: Re: [PATCH v3 08/17] hw/arm/allwinner: add SD/MMC host controller
To: Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-devel@nongnu.org
References: <20200108200020.4745-1-nieklinnenbank@gmail.com>
 <20200108200020.4745-9-nieklinnenbank@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6f25acc0-eb0b-085d-9479-144dca324dee@redhat.com>
Date: Sat, 18 Jan 2020 16:39:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200108200020.4745-9-nieklinnenbank@gmail.com>
Content-Language: en-US
X-MC-Unique: DMsbaITcML6mszoMcBZkVg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/8/20 9:00 PM, Niek Linnenbank wrote:
> The Allwinner System on Chip families sun4i and above contain
> an integrated storage controller for Secure Digital (SD) and
> Multi Media Card (MMC) interfaces. This commit adds support
> for the Allwinner SD/MMC storage controller with the following
> emulated features:
>=20
>   * DMA transfers
>   * Direct FIFO I/O
>   * Short/Long format command responses
>   * Auto-Stop command (CMD12)
>   * Insert & remove card detection
>=20
> The following boards are extended with the SD host controller:
>=20
>   * Cubieboard (hw/arm/cubieboard.c)
>   * Orange Pi PC (hw/arm/orangepi.c)
>=20
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> ---
>   include/hw/arm/allwinner-a10.h   |   4 +-
>   include/hw/arm/allwinner-h3.h    |   3 +
>   include/hw/sd/allwinner-sdhost.h | 136 +++++
>   hw/arm/allwinner-a10.c           |  10 +
>   hw/arm/allwinner-h3.c            |  15 +-
>   hw/arm/cubieboard.c              |  15 +
>   hw/arm/orangepi.c                |  16 +
>   hw/sd/allwinner-sdhost.c         | 848 +++++++++++++++++++++++++++++++
>   hw/sd/Makefile.objs              |   1 +
>   hw/sd/trace-events               |   7 +
>   10 files changed, 1053 insertions(+), 2 deletions(-)
>   create mode 100644 include/hw/sd/allwinner-sdhost.h
>   create mode 100644 hw/sd/allwinner-sdhost.c

So far:
Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>


