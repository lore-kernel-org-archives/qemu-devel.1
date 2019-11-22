Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4B7C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF1020715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dw8hFK//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF1020715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAyP-0002uH-4B
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:35:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43411)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYAxO-0001kM-R1
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:34:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYAxN-0007nj-Oa
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:34:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44812
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYAxN-0007nX-L4
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574436888;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3aAdYcU/DpgTBj1D1MB1Kf+RmmmZXkhKfjH2rk3afw4=;
 b=Dw8hFK//FWaCq7kOfYLzjegbc/LjgbrF5hEq2ZTMtae3Gm+GZPvLC2QOy2wJUiDbt/qbBV
 L/z+dDqWMyMyJujj6uETVVFdPq0YRz366qmrg15TDqLbzERQK6m9mEH0SEaq6FOvVRPWXR
 j5TT4h06hqFiKqMkLCvL9Nc7KtGUhzs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-K4VAiBpCP8mlDuDkgBmIUA-1; Fri, 22 Nov 2019 10:34:47 -0500
Received: by mail-wm1-f70.google.com with SMTP id y14so3191790wmj.9
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:34:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=L1o9pUpmewZ91EzFhu6CTxYRyhDCmevRuCylTHV2sso=;
 b=joQ7LdRJcAOw9aaifcjYIByaCaXPfXjJ8JAnwWdePDrZcEuazmcaQ1xBshI3n1y2AN
 rP6RxB/ouMFZn+n6Uf52qTWVtA3arw6D6yMkihsZ/ds6qlueWQi0nqaq7oq2iv+tAZS9
 w3KfU9PRa/dgLpCbPi3acj+OLlDOWHI0DHiKRe3xpm36PrY6Xu96uObiB+2XPRdXAlfK
 zlzMvVUAkUX91aR7dJ40Z+KJBVvOjjmBnYB5ampb4sIQhRfIhS2gvLyvhX13SeWDm0eb
 oCEUSv68AjQy9NXvOjyEt2x5f2j9ejIYjAN1vsNE/xVTvZo0utEfNOXGohQckaYaV8Cv
 pomw==
X-Gm-Message-State: APjAAAWKLelB0KX8BlqudJVLp2oFPYsJgMWwFqFXfBFpfbLxI1eL5Cyi
 31N7tSYcCLBUGuSCFXvvES35N/NvfpkXVxByiRaaZ7Y2BVZeAZl8FOKeF1+a92HXs/6MLTckbzU
 sYNbAv48Q3VrQwH0=
X-Received: by 2002:adf:f709:: with SMTP id r9mr17784981wrp.8.1574436881401;
 Fri, 22 Nov 2019 07:34:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzCEDkMj1/lU3zx1T1EXu+zdCLVq6/aSdGbbbWSWQbZDd/0YIeelbPjztZZ7eCsTFrBxqkP5A==
X-Received: by 2002:adf:cf10:: with SMTP id o16mr18560218wrj.334.1574436880120; 
 Fri, 22 Nov 2019 07:34:40 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id u18sm7934629wrp.14.2019.11.22.07.34.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 07:34:39 -0800 (PST)
Subject: Re: [PATCH] target/arm: Fix ISR_EL1 tracking when executing at EL2
To: Peter Maydell <peter.maydell@linaro.org>, Marc Zyngier <maz@kernel.org>
References: <20191122135833.28953-1-maz@kernel.org>
 <CAFEAcA-aRwc9bogn-QbT-q5FzkqieYmQOZMr6H=kK5ixMGANMg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d91a9721-1a76-7434-cfc0-493ed4d0d7e2@redhat.com>
Date: Fri, 22 Nov 2019 16:34:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-aRwc9bogn-QbT-q5FzkqieYmQOZMr6H=kK5ixMGANMg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: K4VAiBpCP8mlDuDkgBmIUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: Will Deacon <will@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvmarm@lists.cs.columbia.edu,
 Quentin Perret <qperret@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 3:16 PM, Peter Maydell wrote:
> On Fri, 22 Nov 2019 at 13:59, Marc Zyngier <maz@kernel.org> wrote:
>>
>> The ARMv8 ARM states when executing at EL2, EL3 or Secure EL1,
>> ISR_EL1 shows the pending status of the physical IRQ, FIQ, or
>> SError interrupts.
>>
>> Unfortunately, QEMU's implementation only considers the HCR_EL2
>> bits, and ignores the current exception level. This means a hypervisor
>> trying to look at its own interrupt state actually sees the guest
>> state, which is unexpected and breaks KVM as of Linux 5.3.
>>
>> Instead, check for the running EL and return the physical bits
>> if not running in a virtualized context.
>>
>> Fixes: 636540e9c40b
>> Reported-by: Quentin Perret <qperret@google.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>=20
> Congratulations on your first QEMU patch :-)

:))


