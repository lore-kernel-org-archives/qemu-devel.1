Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C49C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D95206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haLopbUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D95206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHJo-0005BK-4O
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56267)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1idGaC-0006Ts-SE
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1idGa5-0004qY-Iw
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:35:52 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52756
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1idGZx-0004od-DY
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:35:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575650135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0qupRbolM3W2FUEthNaPkSI1sSlTOG/MJsLRancNr7k=;
 b=haLopbUbINFJmG/+n6tuh4bU6ZgOjPx/4P3z3wmX3R2WMTU5i5fBZG0aVs9UU/RP28AHL/
 bo8VOEdGcCjWWF1KRgVZTRJ1VFvH0Fnel2VQPrpoFL9/5J0VGAhrmj8zqamg6jacAINIIU
 Pp5ji+tl/JCvIGKIq1CdJLj65k8PiBQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-b_mYKIinNW6T9c2uVY9tfA-1; Fri, 06 Dec 2019 11:35:34 -0500
Received: by mail-wr1-f71.google.com with SMTP id f17so3378914wrt.19
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:35:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0qupRbolM3W2FUEthNaPkSI1sSlTOG/MJsLRancNr7k=;
 b=rA5zk7ESAYwtkOZhZMCU+pCcpejjlXXSgWuVozlr8bjiimgQ7tswoG5/WnXlMaRnyw
 q8JD77aXSLzHLpGN7X7x6oATHImDr1ClhDY40qgFo7Nac2FvXSqoCUeXwBHHOdv/B1QW
 tedqYrJQ12ZnF9bC+nfdA3mf0pBv/+18I2bAg1AvBm9mTZx4Lzd0sN9nhAGamV0xGX+V
 NJp9qe7GBU7oO7e13V8ZX1jVYQEXeJMNYpIqRmsKKEhLOPOlJ88f2Onj720voVbrydT+
 hdisx9v9Cefa+fpSKtxAMfZxf5sSI+M8sfzE/iZwq21oCv7uYfwTL7xvvmh8K0gQZnfb
 R9QQ==
X-Gm-Message-State: APjAAAWcAnpwk2vKC7pq4D+fD2s6Ky5XElPKzCFICjNzeyS4a1t7jL2B
 PQ4CnhQKUCY9uJt0cFx4wbzWgHOyw3S9tytVZ7RE3TTtr8AHQpoVYrmZzU6sncEq1XCNIbGsaSo
 D4RzRm8nzuFsW/zQ=
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr11262554wml.67.1575650132434; 
 Fri, 06 Dec 2019 08:35:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqye3BJ7XSDSd+ipN7HFSNWICXXXGVrhHnVZIrwiSh1pIiLqNxOb5lW9F9Kz7u+gnVA2G9fknA==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr11262536wml.67.1575650132233; 
 Fri, 06 Dec 2019 08:35:32 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id f1sm16986312wrp.93.2019.12.06.08.35.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Dec 2019 08:35:31 -0800 (PST)
Subject: Re: [PATCH 08/10] arm: allwinner-h3: add Security Identifier device
To: Peter Maydell <peter.maydell@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20191202210947.3603-1-nieklinnenbank@gmail.com>
 <20191202210947.3603-9-nieklinnenbank@gmail.com>
 <CAFEAcA-1Re0noxPN04uXqRYX=-g97jtiweZA=WcFo1OwXBoN5w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41ab9f5a-3318-b412-44e8-f8571a64da64@redhat.com>
Date: Fri, 6 Dec 2019 17:35:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-1Re0noxPN04uXqRYX=-g97jtiweZA=WcFo1OwXBoN5w@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: b_mYKIinNW6T9c2uVY9tfA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

On 12/6/19 3:27 PM, Peter Maydell wrote:
> On Mon, 2 Dec 2019 at 21:10, Niek Linnenbank <nieklinnenbank@gmail.com> wrote:
>>
>> The Security Identifier device in Allwinner H3 System on Chip
>> gives applications a per-board unique identifier. This commit
>> adds support for the Allwinner H3 Security Identifier using
>> randomized data as input.
> 
> If this is a fixed value in hardware, I'm not sure that
> having the QEMU model pick a random value is the best
> choice. If we just set it to a fixed value in QEMU, is
> that going to cause problems?
> 
> (Generally it's nice for QEMU to be deterministic, so it
> behaves the same way every time you run it. Also if it's
> always the same we don't need to bother migrating the
> ID value.)

Agreed. Since the identifier is 128-bit, I'd use DEFINE_PROP_UUID() or, 
to be even safer, DEFINE_PROP_UUID_NODEFAULT().
See how the ipmi-bmc-sim device checks its guid field and fails if unset.


