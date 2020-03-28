Return-Path: <SRS0=dICq=5N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA8CAC43331
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 16:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A275206DB
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Mar 2020 16:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UAXrOIYV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A275206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIE5j-0008Vw-Lf
	for qemu-devel@archiver.kernel.org; Sat, 28 Mar 2020 12:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jIE4l-00085k-Cl
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jIE4k-0002Xy-3r
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:12:46 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43056)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jIE4j-0002XK-Pu
 for qemu-devel@nongnu.org; Sat, 28 Mar 2020 12:12:46 -0400
Received: by mail-pl1-x641.google.com with SMTP id v23so4714122ply.10
 for <qemu-devel@nongnu.org>; Sat, 28 Mar 2020 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BFBYqfl5mOpw2gJNNjenxIqgocMZELC8ho+AYDOU/Lc=;
 b=UAXrOIYVQ4pd/Xa35juGobm0Fl9e1AdVJWK7om187c1YyIESH861AnU6NzcuWVPla2
 Re332fVKvyXWFTZmZrGRoonN3CTICIc53m2P+VSPMs85hLd22oGzLOoxZpEMgC92fOW3
 +EbQF/clIAOM7ARyn/niBO+ADznwDyly8DDojGhyQE3T7TmVyK4o9X6jEunRUZ05tNxy
 6HP51ag4fR47WUy2os/0XADp6pqVxwkISDodMDJcBatW3HTU15mnPnih95MoQ6o1Q2KT
 8/FaCbWnxblLQFo22gEeu2puBg6CYqKpiHkRaMt3lgCkSvXNngwmfsi5ArlvrXcDg1d8
 lJTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BFBYqfl5mOpw2gJNNjenxIqgocMZELC8ho+AYDOU/Lc=;
 b=G5gNpvYC+44TGjsKC9O9Kbn2GzY1Fv0bGC/CAvxVz7p2CbOShyUjZctV+PQIuyRpKO
 NiHMxmcWZfMoWoB9a/mgCXRvoUDMIVp2w6DzItWznz9NTGjCr0DuXdQLIskSJoNvjYyp
 zuea82dG5HnlnFXggTngxl4SuGZv5DnwYrhUJ4zcJ+n4Dn6EE/p10o0rFlQT1q3xCPhF
 suU8d72bDwzJGcjyjF0dHFI2KKiDEzkjOggrPzNMjUvsd3a7lFYLgNo0I4jNQWWiqzis
 9F9e0GwE+Q5iTVwgJqeKa9iZoDgpyUxYipJmNhhIdvgeyKW8RBFKSlUWUb0p7cmjroR+
 ZWaQ==
X-Gm-Message-State: ANhLgQ0m/zMp5Bz/lu3PA5GvMSxF0qlGojwNH1TGggr3rUBGEVuSVDqF
 C589K+Hc1X/AmCnOtKv7unEJsRuTryE=
X-Google-Smtp-Source: ADFU+vsVj6tZqQ587azynyGNjksz+XiRQCsOnU09zfYVzi3Hi+46a1T2nkEm3zLr3UQxX7zzNzHCKg==
X-Received: by 2002:a17:90a:3349:: with SMTP id
 m67mr5539392pjb.175.1585411963684; 
 Sat, 28 Mar 2020 09:12:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id w127sm6483158pfb.70.2020.03.28.09.12.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Mar 2020 09:12:42 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Replaced locks with lock guard macros
To: Daniel Brodsky <dnbrdsky@gmail.com>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <158471180295.15515.1369533827289907154@39012742ff91>
 <20200323132556.GG261260@stefanha-x1.localdomain>
 <CA+ZmoZUFojqmMxNQ1bhGMzjML7OFgDt1GNbogGTw5rte5LD4iw@mail.gmail.com>
 <1b0fa063-6fe4-ad40-06b2-9c3f2f955a06@linaro.org>
 <04a411d6-72e7-d2d2-15f9-895f6a765d22@redhat.com>
 <CA+ZmoZXfrGh3+jnN4K-cfZitR+DVPL=ieZpTZGzH3cYSxko=eA@mail.gmail.com>
 <CAFXwXrkkOzuS=4Gfqm9XtkL5kc5m_5-9WmuziGgTfhFdm8VD0A@mail.gmail.com>
 <CA+ZmoZXvQ0iduKP_zWA0wTnpVSjjx=M6d5knWV-cayVuSQ2usA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9072334f-e4a9-cc6d-7c72-b97110e74cbc@linaro.org>
Date: Sat, 28 Mar 2020 09:12:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CA+ZmoZXvQ0iduKP_zWA0wTnpVSjjx=M6d5knWV-cayVuSQ2usA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/27/20 11:38 PM, Daniel Brodsky wrote:
> On Thu, Mar 26, 2020 at 11:01 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> My preference is to add -Wno-tautological-type-limit-compare in
>> configure, so we don't have to work around this same issue elsewhere
>> in the code base.
>>
>> r~
> 
> What do you think would be the best way to add this? I could change
> all additions of the `-m32` flag to instead use `-m32
> -Wno-tautological-type-limit-compare` or add the flag if qemu is being
> compiled with clang and `-m32` already enabled.

I was going to add it unconditionally, with all of the other warning flags.

Except that it doesn't work -- clang-9 *still* warns.  Clearly a clang bug, but
there doesn't seem to be any workaround at all except --disable-werror.


r~

