Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2D6C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6DA720708
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 07:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DtmbHexV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6DA720708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY3h1-0005o6-Gd
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 02:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iY3fb-0004cY-9k
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:48:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iY3fa-0002Th-5h
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:47:59 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54470)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iY3fZ-0002TP-Ua
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 02:47:58 -0500
Received: by mail-wm1-x343.google.com with SMTP id x26so6081492wmk.4
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 23:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kLftJxci98D67X6Hh1CZFu3Ha7kNLOHftQ7H9kWm/yA=;
 b=DtmbHexVIpWWVtMP+pldy+bSyNDrSKMvDXw30gVTAtWWFij5NoiXK2VNhVd6AbKfhZ
 3VvrzdF8pLCvlHFA09MxL3ylsB55YLtkrigWz4wqnXzSfRO96J0KL5CSl1PyqQXEKN7l
 pCqgKEeZ2lJ4OPPmfXTBYz7npGdU+P0BN0aAy5qGNmu7PwOT4vYrsPOSMCoRkIO5Oqjg
 x3fjoveGxnl5G2hYk7fN3x4Mqn7JZELkOU/qFX6qodjC3AIoCbCYvp6r+cmT/ya53CKO
 M+PJMPbKmn3D+ePLeoEiMbUnMoQG//T1rDl2ETuKunEHNZPGP9X2QK3s9UvFz4Ik1ehJ
 W25A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kLftJxci98D67X6Hh1CZFu3Ha7kNLOHftQ7H9kWm/yA=;
 b=HGqY4z+2uYnynQBQ0srybh9A8bgzE/05vhz6psV8XBpsEhYPsIehtDZt/Clq+1Sv3Z
 ohoUzUkY+UEKvRDD8aDlllHOu/42ThlDqF2FSaI38CsXgy2tyEVC+N8iwKaie3QLCflj
 e1xRJ+zlQj8kQgRrNGoHN0Bll9pB0NRsmT5b7850l0z1HCZV4kQWCPk0HAq0pS545FkP
 J8oMisZ3uUV6TsD8hfCwRImY3ExROxzvRD97m/v7RolLajRY7ipI15GEJaLrEracgxi5
 ee8dzbif/DYgJhzLKk6lsoWeAUmcCtxjA9EyR91gIOm+uox2lma7WlASOFUNKvHfIWZN
 1UHQ==
X-Gm-Message-State: APjAAAW8r+fm+8BvHWE8iJCtWFDVgBNaX4XGVbJ2BaAKiRFjeAYQ8oEz
 LqeZybz3Kvl26ldMijFvE8FTJg==
X-Google-Smtp-Source: APXvYqzglU4aI0J9de0YrtqNWnG7Pam+/Oc9LMT6skjyygTQ2b0qMPfd1ARemfJrJ8JL/TUM3OVxuw==
X-Received: by 2002:a1c:5f46:: with SMTP id t67mr14037483wmb.23.1574408876690; 
 Thu, 21 Nov 2019 23:47:56 -0800 (PST)
Received: from ?IPv6:2a00:23c5:4e1b:3700:8d83:30a1:2751:30ec?
 ([2a00:23c5:4e1b:3700:8d83:30a1:2751:30ec])
 by smtp.gmail.com with ESMTPSA id j67sm2642092wmb.43.2019.11.21.23.47.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 23:47:55 -0800 (PST)
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 'Aleksandar Markovic' <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?=27Philippe_Mathieu-Daud=c3=a9=27?= <philmd@redhat.com>
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
 <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
 <000701d5a0f6$60e1fe00$22a5fa00$@ru>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e3ac8050-8634-c77b-9d14-e78f129834d3@linaro.org>
Date: Fri, 22 Nov 2019 08:47:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <000701d5a0f6$60e1fe00$22a5fa00$@ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: 'Thomas Huth' <thuth@redhat.com>, 'Sarah Harris' <S.E.Harris@kent.ac.uk>,
 'Joaquin de Andres' <me@xcancerberox.com.ar>,
 'QEMU Developers' <qemu-devel@nongnu.org>,
 'Michael Rolnik' <mrolnik@gmail.com>, 'Igor Mammedov' <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 6:33 AM, Pavel Dovgalyuk wrote:
>> From: Aleksandar Markovic [mailto:aleksandar.m.mail@gmail.com]
>>> Why not implement the dump_ASM code? This is very useful...
>>>
>>
>> ... and time-consuming to implement, unless Michael have some
>> ready off-shelf code.
> 
> We already did this by taking the disassembly code from binutils:
> https://github.com/Dovgalyuk/qemu/blob/avr8/disas/avr.c
> 
> But I'm not sure about license compatibility.

This one is GPLv3, and is incompatible, sadly.


r~

