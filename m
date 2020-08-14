Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BC0C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:16:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3952C20768
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 16:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NntJVDfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3952C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6cNZ-0007Ni-EY
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 12:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41006)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6cMt-0006rh-Ut
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:15:47 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029]:33801)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6cMr-0007sb-Sj
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 12:15:47 -0400
Received: by mail-pj1-x1029.google.com with SMTP id c10so5802892pjn.1
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Tc++8Na5cDnfChJBn04qcGXcsQWdWKCUlmR4LLPi5go=;
 b=NntJVDfuMMP+tlDBU/2Xk0KCpZnvSXRrcNwAj/Y3F99sbr5dkHteld7rEFrJaj4sfJ
 kzeFWHivBTkXumAOXRvPV4L+GvfYmjGhbmc40aV3nK76SCLUuLXBeNPvWJaTd+t9Ht9h
 uR3ZZUJb7h/z/nfI28svy0+ReJ8+IgysSobOuEFIJHZ4TGdngmPyIhG/wAyPNelLuYi9
 FkEJnyt3DAEqCGCKiOooBJl2wYv9mh19fPumZR8zUwHKD9A4oJurTUqLmCi9k7bjKxL5
 WnFmgevCg03CAv2YMcDYbtCVW6sf19Xj09fs8w0r8a0BkrlrFL7i32dUW3JdOtYH1LIi
 yCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Tc++8Na5cDnfChJBn04qcGXcsQWdWKCUlmR4LLPi5go=;
 b=DZ3QAR2IuQ665knIkwmgvMnIEbISEDveBar5HAW+9qUq7+w6q1AQFkEInBWsLD7Rv9
 J11/uJfi89enW3fE9sWT+OsZHdFbRL30I8ZAZiYSSTdbxPsGbZ1w3bDqvPtto/J+oZR3
 QdtEzU1BT2qRcXl4ry+nN/4x+3ipzrSSDh8nreVfmngQKRgPs7vsH9BmnG7mowpZMwlJ
 5Gox19P9Mu1IeDvb57Jg9FUEfUyOJk1zp3rNvSzpLC7JCQhdGvY/axVSvDFStG9L9qJr
 CMqtUWUL7RJZoAEB+teXfpYjDNhNUGZJ6j8n6cE/unSrBY2gKW7nM65nPK3cvsdi3yPG
 Dnpg==
X-Gm-Message-State: AOAM532d+XLU4zIIUVw5yvqedvltRgopkHU7O5FbAaShK2wXIfx2/ud2
 4+NhQZSS/s4WfYF00AU3bo/zWw==
X-Google-Smtp-Source: ABdhPJzr9Fvt6iRRs2WWLp+wxHzys0A+TmFqw026KJSTcW26PJBmkHm1i+mfilgi8elDv3g4dt6NtQ==
X-Received: by 2002:a17:90a:fd82:: with SMTP id
 cx2mr2984914pjb.67.1597421742816; 
 Fri, 14 Aug 2020 09:15:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g5sm9770896pfh.168.2020.08.14.09.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 09:15:42 -0700 (PDT)
Subject: Re: [PATCH 2/3] softfloat: add APIs to handle alternative sNaN
 propagation
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
 <1596102747-20226-3-git-send-email-chihmin.chao@sifive.com>
 <aa334be5-e325-8d96-a3ee-00c82cfe2c4d@linaro.org>
 <CAEiOBXXOj5TcseHqpCaB-vR=3wFquP2ScjKGSrPXombesyD1jg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bd0acee8-1786-a3ff-99bb-4d8e317abcde@linaro.org>
Date: Fri, 14 Aug 2020 09:15:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAEiOBXXOj5TcseHqpCaB-vR=3wFquP2ScjKGSrPXombesyD1jg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:59 AM, Chih-Min Chao wrote:
> By the way,  the other patches have been queued in softfloat-next. 
> Do I need to resend the other two patches in the next version or just this one ?

Just this one.  Thanks.


r~

