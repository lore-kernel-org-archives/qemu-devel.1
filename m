Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC3C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:36:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27AD1206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 09:36:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BaxQDpDY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27AD1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k54Du-0003zC-ES
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 05:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54DK-0003Xc-Ts
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:35:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46615)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k54DJ-0001LE-3h
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 05:35:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597052127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=InZJxLRtX7Ix9veEpC7hkhws4Ig34VNa7tlBRAp8UpE=;
 b=BaxQDpDYGXJ8NpDRNsDOS09O1zD51yNA0fJA0aotXoI4UN3uG6b8KtKRs6biUouNlWnqSu
 nWXtk4s/d0jqTf6kfde0v/iIVeCPCW58iMlOGfubPoXyewrXZns0g/OB+FYy/9jfjtgfU7
 QS23Yc6WlZe7uHtCSboJRZouKagESKI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-420-gfA7OCouPLWjp5lT4LPxyw-1; Mon, 10 Aug 2020 05:35:25 -0400
X-MC-Unique: gfA7OCouPLWjp5lT4LPxyw-1
Received: by mail-wm1-f71.google.com with SMTP id p23so2563964wmc.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 02:35:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=InZJxLRtX7Ix9veEpC7hkhws4Ig34VNa7tlBRAp8UpE=;
 b=bi+ZPwEmG+LYza16H69DtxKSTOZsmedGiZeiVQO7CTiEUOl/62EMGPRkr3I8Qvms7v
 Vw9wCLYRMchUnNgo2zdXBvXFIDmNQKwNcKMefa/uiIgJVzHs3Wpr6lYpF1vS6aQXrGKF
 WKIUJXZv5ZgRG1EAFTGaTmhQmEjhqMVQ1iM5onuJZQODzpQSbtXWuC59j7uQ3Z5Z8/L+
 nsItn8FwA+3GylkMg0jalfjvIPcOaJ3x/TKVLcOJBAx3XdeXulivxFYKdmu10fOt2zVo
 QPyzRZNTrO8zBDiOoRTDZSuhkB3jv7ZrxRHKiLos1TcWNTH1dZhdMo6EVC4pl3Fbpqfn
 OtGA==
X-Gm-Message-State: AOAM530AuUw2A5znaXdWnvKu83UI5ceYYH9jkTZ7V9sWxUN1IuVGXZqc
 GbcYwBdazkJ33VIMMEVLYiZAipbtq62GRxGXKZZGCZwMpjB7x3QGvhIEJ1vn/w1z85uPanDj54w
 DR+nSmBzxVg224sk=
X-Received: by 2002:adf:8445:: with SMTP id 63mr552429wrf.375.1597052124601;
 Mon, 10 Aug 2020 02:35:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyY4Dv3EelZRJ4b4y29W4n9zjYbEJzLe3DLdkPo6Fm7qkpQLiWBL1dh/3hdDxFlodGwic1H7A==
X-Received: by 2002:adf:8445:: with SMTP id 63mr552413wrf.375.1597052124395;
 Mon, 10 Aug 2020 02:35:24 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id g70sm21328611wmg.24.2020.08.10.02.35.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Aug 2020 02:35:23 -0700 (PDT)
Subject: Re: [PATCH] acceptance: update asset hashes for the Bionic aarch64
 installer
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20200809223741.56570-1-pbonzini@redhat.com>
 <13b3586c-4d0e-76bc-4716-b6ee88e9686a@redhat.com>
 <06ed9cc7-2204-395c-2395-d5c750c75635@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <606d1faa-1920-de51-9197-95b79466331d@redhat.com>
Date: Mon, 10 Aug 2020 11:35:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <06ed9cc7-2204-395c-2395-d5c750c75635@redhat.com>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 05:35:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/20 11:24 AM, Paolo Bonzini wrote:
> On 10/08/20 11:06, Philippe Mathieu-Daudé wrote:
>> The 'bug' is this link is using "current" which will be a problem each
>> time Ubuntu update the installer (latest update was last Wed, Aug 5).
>>
>> Acceptance tests should be stick to a particular set of binary, knew to
>> have worked once in the past. If a new set works, I'd rather see a new
>> test added (because it might have a different QEMU coverage).
> 
> That seems overkill but yeah the tests should have used
> 20101020ubuntu543.15 instead of current.  I think this should get into rc4.

As our CI is not yet gating, I don't think this justifies delaying the
release (except if there is a critical bugfix on the list).

Maybe it is acceptable to simply merge the CI test fixes before the
release tag, as no code/binary is affected...

> 
> Paolo
> 


