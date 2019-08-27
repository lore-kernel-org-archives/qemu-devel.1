Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613B1C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:20:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AE3D2184D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AiWHBFTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AE3D2184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2h0w-0007Le-Ak
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36440)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2h08-0006wv-Aq
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2h07-0006HI-63
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:19:32 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2h06-0006Gs-VN
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:19:31 -0400
Received: by mail-pf1-x443.google.com with SMTP id v12so22996pfn.10
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wX+Ew/6ADeCDf3wdOySKu2z0v6C12JqtX+Ts3CBD82s=;
 b=AiWHBFTmP0Lxg3v89SVjfMinhCKn9A9vooVdeDXexDkURFNzuTUH5HcaRFYeu3u/Cs
 prgukWumhZKTe+4kk3x2yBUV39Sd3WWURfENml3qqHLS7WJfnuLsDt8DKCVepK7pSyut
 VXrYbwLC+LcKJJIrLEBRkryAM+Xe3dYjhcRTC9I4ljRjqFnET5YdoMd0vznAFGNJq9/u
 dnf6dE2hPIUNvRLSGxz1pl4yGqcGLM2vByJbxqIIExa4SiJd859rJokmkWPQVQ/Rx+Lk
 Q1dKYZbYMFuQoG/AUOw9X0ReT7IiifZpBunVZKGyZ2ANTHcnvWC+qfGVK5koT0VWDzJb
 EAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wX+Ew/6ADeCDf3wdOySKu2z0v6C12JqtX+Ts3CBD82s=;
 b=ROn/SuSF/wMSmwT6ZG/mqaSoARVCXcJSojPWJVyHP/NNudl4mlEnhD7Q/ByklM0sV9
 vt8cn6Ms6I3MpUrMcp7pQw6rqeZ/lX3omqdzjtqyM0EaXniCuVteNGgzcqELdxI7wU/8
 t37JuikzrAu2flnV7x+74FtQRxbtthmpDZvb3y5YUtb1Ty8esaT6m6JVe8bfSNctHtZq
 Wd3T4glpoMq73zGvUKgmJY1aVQZ+7AnaIxR9UIwdBah3Ai2jCmFQb/kctLKj04QbBFNe
 VX6vv+ddFtr80Ju0K8GzS23ai0eP0ANKI4NESXHJ64/wpHUOEA88PbEobqxMzCNzcTDD
 qhuw==
X-Gm-Message-State: APjAAAXp2g8VRNLyg+3FQv2BYuEOsNqxZJhO+KmsLpyMxPH3HXLF/xmm
 82xRO9DE/mRmePpHk7C4i46G3g==
X-Google-Smtp-Source: APXvYqxWOugnCA3URSUPrUpR7WCPJHXdssByNCBkzsgcRdrRo42dqcQnsCo8fR3R+YGuKvSqNQxAhg==
X-Received: by 2002:a62:52d0:: with SMTP id g199mr40387pfb.32.1566933569954;
 Tue, 27 Aug 2019 12:19:29 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id t6sm147742pgu.23.2019.08.27.12.19.28
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 27 Aug 2019 12:19:29 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1566898663-25858-1-git-send-email-stefan.brankovic@rt-rk.com>
 <1566898663-25858-4-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bc4e313b-9454-62d2-de82-3887f5d59a64@linaro.org>
Date: Tue, 27 Aug 2019 12:19:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566898663-25858-4-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v6 3/3] target/ppc: Refactor emulation of
 vmrgew and vmrgow instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 2:37 AM, Stefan Brankovic wrote:
> Since I found this two instructions implemented with tcg, I refactored
> them so they are consistent with other similar implementations that
> I introduced in this patch.
> 
> Also, a new dual macro GEN_VXFORM_TRANS_DUAL is added. This macro is
> used if one instruction is realized with direct translation, and second
> one with a helper.
> 
> Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
> ---
>  target/ppc/translate/vmx-impl.inc.c | 66 +++++++++++++++++++++----------------
>  1 file changed, 37 insertions(+), 29 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

