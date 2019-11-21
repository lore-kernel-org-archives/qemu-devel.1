Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D32C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:56:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F7D720855
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 08:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1Cq+ZhA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7D720855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXiGj-000514-DB
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 03:56:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iXiFs-0004YU-J4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iXiFr-0001Qj-Br
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:56:00 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iXiFr-0001PZ-3g
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 03:55:59 -0500
Received: by mail-wm1-x343.google.com with SMTP id g206so2509356wme.1
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 00:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=onJUMHIh65dINff6x1X4/vVpVKOJLhf8CalCdya3n00=;
 b=k1Cq+ZhAWcghDa2267OIv2F34P+fEkMSQ6Dc8OOQYhJyseEwWjJGI+5Qq/+IY0bLfy
 vZJsUahQYIWyC/pMWoa6zZqxizc40Uw5jh7wMvl9fx2jlYB/akk1qa+1elY3yK4l3zHH
 lQ52AF8N/K/JodJJywTkm0Zr/lcxoUNprgIV3FTA2GbZrKQ+v8mU+EBSUBEU3z8Ib/gK
 2tBwmO7uioxLH3flCMHDMUetwnX0fRnDa3WWk+qmN8hxeDA/bBzLIlN9ifHDbWFczYu+
 vLo/crZrQ7S8zXF8dxTT08NOjqTTgYbh91esNGmXEp24ZXkEI23S3wwpim8G5d6feTQI
 Zw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=onJUMHIh65dINff6x1X4/vVpVKOJLhf8CalCdya3n00=;
 b=Q04Henun1E8+e1OEvqZEkmo8XhQnMhpq7aoNaW0Fo+tcSI7Ks969CsYu11E9e00ZIU
 VXKmmvbe9BXSdH2Bc8T2ieAt7kIMNejxduqtCmCte4bS7VOWrENGuj/cm4rYMcg1GCEP
 Dg700GaoOcHtyCLis9ihoaFjOfxmCKzy/vq+x3UjFgn6SyEyd0N9AENmR30cuQ53JzQN
 nhAlNY2mGU+G+ovpNb+2XJcQHH5F3icBB41CCldowIhNc+zOyhReUw153BWR6KYa8dDJ
 WV543025FKNnHDjDEsDPA765Ra9wyvX0QJHMJSta/uA7EtndKnD6ab6+i4kZtdqRMN4L
 giOw==
X-Gm-Message-State: APjAAAUYjqGqA3AYcwBG/qXrffVYXRetaVoHw5MTOia9decwpUzUrm5T
 jNeqOcl/xVmj2/6B+HDAYAezbt/6+y0Acw==
X-Google-Smtp-Source: APXvYqyRJWnweQgDqtPuT5f5iI8ZX1LrHmM2E/NWx11+OmrxN3hpVY4AVyiFN5sUb2NEtP7PxrxYQQ==
X-Received: by 2002:a1c:a406:: with SMTP id n6mr8815371wme.90.1574326557218;
 Thu, 21 Nov 2019 00:55:57 -0800 (PST)
Received: from [172.16.205.140] ([195.235.52.108])
 by smtp.gmail.com with ESMTPSA id w4sm2493906wrs.1.2019.11.21.00.55.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 21 Nov 2019 00:55:56 -0800 (PST)
Subject: Re: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <82dfa44e-0a27-080e-2653-b004c27fc3d1@linaro.org>
 <CAL1e-=gmLywnyUoySxuDPS1FQRx=WiH1kYrqEJDGAAcO5vDg4A@mail.gmail.com>
 <59c88efa-999b-9edf-7e34-f283ac8c802e@linaro.org>
 <CAL1e-=ihiBw-4beEUEUqbFNUZGrG7DsLgKe6y4Sc1h3W4Ze=Vw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a7b5d3f7-4b01-b9c1-be09-dadfd9cdb768@linaro.org>
Date: Thu, 21 Nov 2019 09:55:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=ihiBw-4beEUEUqbFNUZGrG7DsLgKe6y4Sc1h3W4Ze=Vw@mail.gmail.com>
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
Cc: Taylor Simpson <tsimpson@quicinc.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/21/19 7:01 AM, Aleksandar Markovic wrote:
> On Wed, Nov 20, 2019 at 8:49 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
> 
>> How's that?  He has been asked to split the linux-user stuff from the target
>> skeleton stuff.
> 
> ...
> 
>> This argument would make more sense if there were more present here than a
>> skeleton.
> 
> Speaking about anatomy, I am opposed to upstreaming any "skeletons".
> The other month, another community was dead serious wanting to
> upstream code based on "proposal of the draft" (or was it "draft of
> the proposal"), and now we want to upstream "skeletons"??
> 
> And even that "skeleton" can't be regularly built stage by stage, but
> must resort to "enable configure at the end" cheap tricks?
> 
> What happened to QEMU upstream?

You are over reacting.

We're also talking about *2* patches before the "cheap trick" of enable at the
end.  The only alternative to the "cheap trick" is *1* patch, which no one
wants.  There really is a minimum amount of code that is required before
*anything* will compile.

We're not talking about applying anything at this stage.  We're talking about
patch review, and making the pieces small enough to actually review.

I assume that Taylor and the revng guys are coordinating the actual meat of the
port.  I assume those will be presented in reviewable chunks, each of which
will compile.  Only when we see all of those will the whole thing be applied.


r~

