Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60309C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:22:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4C5207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 17:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8LQT3xX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4C5207EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDWSQ-00059W-4m
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 13:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDWRs-0004g1-S4
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:21:28 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40660)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDWRq-0002wp-4i
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 13:21:28 -0400
Received: by mail-pl1-x642.google.com with SMTP id z15so64403plo.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rXtvNh/VVRPc1LsYXF8THdI4f+RmTl1wGiom/mdCmaY=;
 b=I8LQT3xXB89F2id1vo5fJJAfltuNSLCOXMr6KUmIG0wiHA2vJr3MG6mtE0mHK+3GUj
 8NCMLOTJWDWK5CbXZS1CFWtR5rNMQdObwt/Esdzg+jXeyWICA2QxwX3Ab7qSPUITO0Jp
 NvZ2wiAzdKav1g5/mlc7RZCEHuulCxCfjzYL0c/gf58sdqRQn5vRuTRY/phatJ4mvdad
 6Ed1DdiwyfBPSBYFxBlbysOf+VGADTzJC2BloeD9VhT8wgz9lyMF7AHbsY3qFcz1CXEO
 h1TANQDySA26IJO34G3FEl+DVzIkf8uci7G3WQZH6d9P1HtDMEhdOOfaUe7JRThnrDqA
 j8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rXtvNh/VVRPc1LsYXF8THdI4f+RmTl1wGiom/mdCmaY=;
 b=I01G6qPctm92F9QxvQmX90+r7UQbcJwK0zy8M+SHqn5sVR+vQz5uzO+c8yi+KVLnyb
 MNAJ3FBS+kmSIcbHspkhLqxoiJK9g2KpieeU3N8G0NFxBHRdJ4ynQO18hPhWRIi9U+U4
 X62bnpfNFaX4hJ9VC2B3qIdMYwgXCC6qWFgu3m4tVr+PTGnz1NH26lFJ8c1LDRsOpW0e
 lprzoaQQ5W41oiBagpR1KnjQ37CSll6uS9+sHl8uyXGaBVbSAmb4ImP7H2Ri94Wpodph
 TdD6h5azcZrS3N5m+/nRQGIrHG3dlszgbzHOaVQWboupEq1gOr5gHC59Psd4Y/E5ZlxH
 +Qsw==
X-Gm-Message-State: AOAM5300R2JcJoX21Q8E8Es9vfIi8NbNcRTEpq2SEliqFE0OEdGQd0iK
 5xuWUzRRJ0/RErgOmGm9ljyHfw==
X-Google-Smtp-Source: ABdhPJy9KJTtK31gQWzDlOP0+l3s+NTq3tbUtXjwwbA5Qz9krAD3IGtlymnlQsBqaDfy2oW2np0orA==
X-Received: by 2002:a17:902:a50e:: with SMTP id
 s14mr2953904plq.164.1599067284586; 
 Wed, 02 Sep 2020 10:21:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q24sm54049pfs.206.2020.09.02.10.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 10:21:23 -0700 (PDT)
Subject: Re: [PATCH 4/6] tcg: Fixes dup_const link error
To: luoyonggang@gmail.com
References: <20200902170054.810-1-luoyonggang@gmail.com>
 <20200902170054.810-5-luoyonggang@gmail.com>
 <285c6d4c-6a92-53d0-37d3-e22f71b67033@linaro.org>
 <CAE2XoE9rC9qEO--fiuwXH+AsBHU_YKwsPhBqK=YjmVWEv_LS4A@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <570c343d-6b1e-151c-edc0-79fd459661cf@linaro.org>
Date: Wed, 2 Sep 2020 10:21:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9rC9qEO--fiuwXH+AsBHU_YKwsPhBqK=YjmVWEv_LS4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 10:17 AM, 罗勇刚(Yonggang Luo) wrote:
>>     This should not be required.  What compiler is this?
> Win32 gcc 10 mingw

Weird.  Ok, what symbols are present in tcg_tcg-op-gvec.c.obj without your
patch?  How has "dup_const" been mangled?


r~

