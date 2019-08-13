Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FC2C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40B5520840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 13:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9MNlc0o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B5520840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxWff-0001Yx-Es
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 09:17:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58018)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWeG-0000Ee-Gb
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxWeF-00035h-52
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxWeE-00034x-Ue
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 09:15:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id g17so107713085wrr.5
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qz49cDa87kkHh58Yc3n6STCzcOry+vnZiQQodvwlyuA=;
 b=q9MNlc0omy48bgjSnhIk4kY5uqnuR/Ii/WmJ5DRPelRsZEJUA5xyrXcEdkFdmJVyV5
 klshJJip90Ad4MH/AwcOW536YwuyxvKmLE+9WHWUW0t6/mTPtrxu8AMKqiKbIVuZTFqJ
 54VPylUNN7lc4WnnGrYTUaIeNXS2SuRI6z+nusIXGVSNaVGT8mDRbGe1ZI2jWyGN3/kX
 VhHtzJfRwSetEJlkNcROYT2ak54mSES8alkLnPPG2yMQQ+SyBuB4A2hTHAs1VERPf2c2
 9SxMLW+nSjLQriM+Q2h7lhhVYivqnDGV6KZmakRp5A44PTn7KOq58sZJJBnwYpamaZSm
 N7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Qz49cDa87kkHh58Yc3n6STCzcOry+vnZiQQodvwlyuA=;
 b=XY4r/u+Y5J7fg86ZwGWmNORGtxSZ3mbMRK39MdkbSEav7ZLhpzAzFroYCT2NF+G2EQ
 oQG0tmx7gnBvesB0Nf0wNMDuBmmqTjYUMdOVDkCQ5zzeR7ZYFgXj3g4EZr+XUhh1K0eY
 ERkSAZyGjLUpQh3eaPkybbFCd3K4RKeEowei0l4bvWHRDhNvZGeeBny1/OENUZLfC1Fk
 egVOPy++4lQI8c8N4Ty89YWcps+QA8XDwh/c9TNvtDF7h+ZR0RoyqItfp69CXoDE3qGz
 7ZI1o8ugC4Mb1N/SSZI/UQmTMooYW+WBHOo92i/pzsXIV11alIkQuXYw7Q6bU0Wm9jpU
 YWHg==
X-Gm-Message-State: APjAAAXBQ26xtH2XM2hbLKHgKsElIhZJsIwOzcnSNx+yXlvEdBpDTcgC
 XRWCRwF/zcIpkAa3LwPQ86cnXQ==
X-Google-Smtp-Source: APXvYqxXQYdg9/cTGTOrPkuDX9+gkFRfpv57H96kEs+WNL5NIHCNX4JoX54u/Dpx42PA31KoDAuAHw==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr46159401wro.133.1565702133935; 
 Tue, 13 Aug 2019 06:15:33 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id j2sm1183423wmh.43.2019.08.13.06.15.32
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 13 Aug 2019 06:15:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190813124946.25322-1-alex.bennee@linaro.org>
 <20190813124946.25322-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <91aa57d1-6f28-c8cc-6764-a027403ff45a@linaro.org>
Date: Tue, 13 Aug 2019 14:15:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813124946.25322-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v3 06/13] target/m68k: replace LIT64 with
 UINT64_C macros
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
Cc: armbru@redhat.com, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/19 1:49 PM, Alex Bennée wrote:
> In our quest to eliminate the home rolled LIT64 macro we fixup usage
> inside for m68k's many constants.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/m68k/softfloat.c | 98 ++++++++++++++++++++---------------------
>  1 file changed, 49 insertions(+), 49 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


