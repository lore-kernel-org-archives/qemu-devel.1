Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F4C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA2BA206BE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 06:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E8sTFR53"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA2BA206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDNDa-0007kr-2Z
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 02:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNCP-0007Hf-Fb
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDNCO-0001oR-Af
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:56:37 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:36176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDNCO-0001lY-32
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 02:56:36 -0400
Received: by mail-pj1-x1044.google.com with SMTP id nu11so3388668pjb.1
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 23:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q6gUzbcUAkPYbQB1X66IHSvQ+fx9qkm/75/MoxR0Wg4=;
 b=E8sTFR53GQuLoef2Xc049xgDdNfWLA5CGqej6e7MEgKGK/PlbOUef2rsGheO5pnYDe
 dsvozg/TVFZ/umNV7Nd6tCfifGUGqKWNNoovnpMUu+Vo6XZDzmUpy8RE2hBgruE6wyGg
 s9cOWiOxWPbl9JPxwqME9Ka5GUYSnUiBOauWuUPWbHQ2LIp9tqmntXyMjNv066S6fBR+
 EHFB31gHBqd8mI40Kier7RNP3TygZBN2tdj+7QwARSUebt89uSjrDX4tKtv+XRXchBIS
 ESItHZG8hTX/aXmiRk9tXHzzPpRqUowCike3He6jNEe7ThEAVweZYWtAZKf0A4QJdlmr
 SQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q6gUzbcUAkPYbQB1X66IHSvQ+fx9qkm/75/MoxR0Wg4=;
 b=ey21Mdqzqf7nP9/hnrIdUNcbzaIWAtrwrGRlnoqBVBlXVeLJDRL1ARwZvrNNeFq36q
 wh/Qy3kGJ1D+wv7ulr8EywWdLgW6ILbl5XluoXNbgK6U02omXD6EtM9mzaKc4GOe8bGO
 SoBIgmkpdE5KTtGGV2iMAN0pot+4smOYoZJdQ75gbXbQ2P7fUSIdXnbXif0jTvVJa4ip
 9qdwXOqhpS4iWR+9zEKxPktZPscr5ugtGsMY+PDI+J1x/sB5nPlhKDwJMLqipXiBeN2s
 F/jJJ0yx6wHQHVb/XPuQu3bMTysa0y4E73CspgL8uxGaIIQWtSbgld/a4WAdGUup9A+b
 zNXQ==
X-Gm-Message-State: ANhLgQ2hDwj9pEpUM5iwNJXFUU6Dy3LT8BnHVQr3ImlrtCMOzbSbR7/n
 fTGStg9jNVp18aTvNjAljxahVQ==
X-Google-Smtp-Source: ADFU+vtDl8dJt9ehQU6bIAZ05mt++Ht5HYdOf8y7glTIJAO+hx6Xr3bSoEOgDgFEAk/Ps7YNAWQD7g==
X-Received: by 2002:a17:90a:34c6:: with SMTP id
 m6mr19105123pjf.13.1584255394878; 
 Sat, 14 Mar 2020 23:56:34 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 d6sm16251761pjz.39.2020.03.14.23.56.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 23:56:34 -0700 (PDT)
Subject: Re: [PATCH v5 57/60] target/riscv: vector slide instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-58-zhiwei_liu@c-sky.com>
 <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
 <67e2c762-8ae5-3bd3-a16a-5b763cd7832e@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d5630c35-8d6a-7a37-c3fe-1e0caac4720a@linaro.org>
Date: Sat, 14 Mar 2020 23:56:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <67e2c762-8ae5-3bd3-a16a-5b763cd7832e@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1044
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/14/20 11:49 PM, LIU Zhiwei wrote:
>>> +    if (offset > vl) {                                                    \
>>> +        offset = vl;                                                      \
>>> +    }                                                                     \
>> This isn't right.
> That's to process a corner case.  As you can see the behavior of vslideup.vx
> from Section 17.4.1
> 
> 0 < i < max(vstart, OFFSET) 	  unchanged
> max(vstart, OFFSET) <= i < vl 	  vd[i] = vs2[i-OFFSET] if mask enabled,
> unchanged if not
> vl <= i < VLMAX   
> 	  tail elements, vd[i] = 0
> 
> 
> The spec v0.7.1 or v0.8 does not specified when OFFSET > vl.

Certainly it does, right there:

   offset <= i < vl.

If offset >= vl, then that range is empty of elements.

> Should The elements (vl <=  i  < OFFSET) be seen as tail elements, or unchanged?

Tail elements.

> Here (vl <=  i  < OFFSET) elements are seen as tail elements.

Exactly.

>> Again, eliminate vl == 0 first.  In fact, why don't we make that a global
>> request for all of the patches for the next revision. 
> I don't get it.
> 
> Check vl == 0 first for all patches. Is it right?

Yes.


r~

