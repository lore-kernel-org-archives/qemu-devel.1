Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E95C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:41:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF3A2070E
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 11:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6B4ehb0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BF3A2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionF6-0001QH-G5
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 06:41:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39283)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iomxR-0006DG-Qb
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iomxQ-00060c-No
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:33 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39077
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iomxQ-00060S-KO
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:23:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578396212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MhglGdzOEEfZlij3tsY3tJOTtOdu/FPAdIn/yPTr4p4=;
 b=E6B4ehb0llL3sfdZ6kyB9HH8a92fSvE/1U0ilwmP6JZtbW8QQKBOYp2xy6eSC+VmuSo30b
 lFFVBYP2JwAa96bZqe9U7tqzMUsRs1VgNMS2XCmLGd3jHfNoJ9/NBbIRLPtfru2lRVn96C
 5euxt4rZQJj/FtHan9Xqdb2MbAbBCqg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-mHkDpQnnPTuRZoxk9a697Q-1; Tue, 07 Jan 2020 06:23:30 -0500
Received: by mail-wm1-f71.google.com with SMTP id t16so3974601wmt.4
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 03:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=u7q6w0UluuHzlzHeSCXnffyffA2o36zwTBsvKISPtx4=;
 b=Cn9FKxvMabGlB98ursXeeyRe2bish6fnorhAYrrSbPF3IaPy7ePAKu5wReKrpZws2G
 bS4zvpshx/cRR/QAHmrhVwDlnFBjp1DXucNI4E2GBm5aAch0zpKxYrExrslWYYa+suNp
 ga2/AlzUZGVwrS3ODZfxHeOYRJfUIPq4K6ISVowz4s0DlSLj8DUmTB5BETKlXv5NPTfw
 jHKv59TXpNoJlLDpfq+77Y6MQM2fqMZicOMfrM/obNP7y2prTuUk8LIXUrKYOjFLHlfi
 kWNLcN4gr9aJi5h+IaOKokihSfihNOHTpEtwiMqHIT/YmNFquZlf5iRQI8mW3EXG5IQa
 15jA==
X-Gm-Message-State: APjAAAXTA65Ww4paw+wEYl1IsajuL11bru+63T2IBonGN3/esw/CDOZl
 9cFaS5JCMSBPqLboK5iGBNEVd+BjYAObY2rdvQZry6N2hNBSIFsa6M8lF11FLs7DuvbDz8ZDmhn
 IbTjbyk3x02GUOxY=
X-Received: by 2002:a7b:c957:: with SMTP id i23mr39978655wml.49.1578396209700; 
 Tue, 07 Jan 2020 03:23:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqwxU7UqyGDgZFFBkfcfAMRAke9F9gGZInj7tfKdb+1Q8tC6cxr8/CAOQKpc8F9iHj6wicoIUA==
X-Received: by 2002:a7b:c957:: with SMTP id i23mr39978643wml.49.1578396209506; 
 Tue, 07 Jan 2020 03:23:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c6d:4079:b74c:e329?
 ([2001:b07:6468:f312:c6d:4079:b74c:e329])
 by smtp.gmail.com with ESMTPSA id w8sm26734145wmm.0.2020.01.07.03.23.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 03:23:29 -0800 (PST)
Subject: Re: [PATCH] hw/rtc/mc146818: Add missing dependency on ISA Bus
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191224111628.3551-1-philmd@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <969f8d6d-b54c-cdb7-9011-c825b403a4d0@redhat.com>
Date: Tue, 7 Jan 2020 12:23:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191224111628.3551-1-philmd@redhat.com>
Content-Language: en-US
X-MC-Unique: mHkDpQnnPTuRZoxk9a697Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/12/19 12:16, Philippe Mathieu-Daud=C3=A9 wrote:
> The MC146818 sits on an ISA bus. Since it can not be used
> without it, select ISA in the Kconfig.
>=20
> Fixes: 82f5181777e
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  hw/rtc/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
> index 45daa8d655..3dc2dd6888 100644
> --- a/hw/rtc/Kconfig
> +++ b/hw/rtc/Kconfig
> @@ -17,6 +17,7 @@ config TWL92230
>      depends on I2C
> =20
>  config MC146818RTC
> +    depends on ISA_BUS
>      bool
> =20
>  config SUN4V_RTC
>=20

Queued, thanks.

Paolo


