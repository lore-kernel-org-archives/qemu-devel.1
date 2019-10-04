Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B08C4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E396020873
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 15:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dVsUR8Dj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E396020873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGPcB-0006aO-2q
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 11:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39497)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iGPb9-00067S-KI
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iGPb7-0002Pi-2n
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:34:27 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:45564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iGPb5-0002M2-0B
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 11:34:23 -0400
Received: by mail-pl1-x644.google.com with SMTP id u12so3288932pls.12
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 08:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=roF9mjbT9RHny4rf3fagdLEYz3esmIuFFYBBbIcd7CU=;
 b=dVsUR8DjCaYr+U8yqxuWhos/VOZnIlVr3KlVLv4VR+EpiDsNaloULynZPsq8i9Ywx5
 JJXN4h/RoqP6a7dnBsNboMZxGofNNH0Fvgn3v4JPBUFgZ3H0avaiVYMmuP79+0mvRacD
 Pxt+nU87RNDcxwGJlmcaiYAMakEIf1cwyUJiUnYCNtI2ZG/ZJRLdgSl2+I4LAJYxEJxI
 qWhtD1JXNechHDQZbmWe0Pzy2kRx93mL4DvlhuWZnEKt+zn792nwSiO41NkmyQcndkCl
 KAMeu7JjsIsjubqugVm+qHYCgJ8MIgtGE7B9MdlF2c4iT2nlS9mlGr2jxaGSA3ym5m7p
 QYiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=roF9mjbT9RHny4rf3fagdLEYz3esmIuFFYBBbIcd7CU=;
 b=F0doy/XnHCq56HdNLo9VTwZLTNCcelOk57vHXMvmbp+pCcxDjW701w5qtglB43XDVg
 b/RrUhnk9K3Sqee0i+l6bHTFgG8EwtWyuZXsTPsFXP4iCNckaExVATBRO3GGk471lLt0
 7fgZO3II864+iQLrtybgAK6ZAiRIJJcfu1KFBAVl3YnAM7bYJMrWnUiTjvdFY+fSs3rn
 gsaUccEdCSTRPAHhn4Ub7Z371LpxLy/EzEw+d3ngAD4+IuuXVne7VX6Me7IMLGytC+nB
 g0m0X1jt1EVeVWVjOVkDSb/KIDA0VEvYd1LFVczPaDHkwvypoS4thJ1WmzNpE3ac/YrI
 5UuA==
X-Gm-Message-State: APjAAAU5+Sh95YseYTYMrMCD5VNxsBWrE5YGubtqiE/vOGfAv6gWNsPt
 eMksmMYq0mK0D7adhKQK2gznZg==
X-Google-Smtp-Source: APXvYqwGbgvJ+dDzWWwvkRP8USPv0zTeUvFoXrbpWtI3QEty1T3IZajHTLeOTZzy4h2zy+RtCNvu/A==
X-Received: by 2002:a17:902:6ac2:: with SMTP id
 i2mr16095338plt.148.1570203259368; 
 Fri, 04 Oct 2019 08:34:19 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u5sm8880843pfl.25.2019.10.04.08.34.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 04 Oct 2019 08:34:18 -0700 (PDT)
Subject: Re: [PATCH v2] s390x/tcg: MVCL: Exit to main loop if requested
To: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20191002082636.7739-1-david@redhat.com>
 <87zhijjwph.fsf@linaro.org> <0479ad1f-348e-ed40-c2c6-aef168afdb7e@linaro.org>
 <379c2065-adfe-0847-46f3-7f25c7650df9@linaro.org>
 <17a008ed-8ec0-2732-347d-bb04b6d832e8@redhat.com>
 <CAFEAcA97hjbh+0rhTABhn_FwhLOoGq53=_397cGv9cnZfmQRUA@mail.gmail.com>
 <8ff6a5ef-7e44-5505-8d8f-a0e5bef29479@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b658b14a-f5be-1933-3f71-976de147fca3@linaro.org>
Date: Fri, 4 Oct 2019 08:34:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8ff6a5ef-7e44-5505-8d8f-a0e5bef29479@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/4/19 5:34 AM, David Hildenbrand wrote:
> Or, as alternative, something like "cpu_shall_exit()" which only
> wraps the single check.

I would prefer this to the full cpu_loop_exit_restore.
It's harder to imagine what else might need doing for
some other user of the interface.


r~

