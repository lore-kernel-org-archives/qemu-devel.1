Return-Path: <SRS0=cIHa=5F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84EC4332B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:18:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B37A220709
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2020 17:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3pmr4vZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B37A220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56679 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFLHq-0006Fm-Sl
	for qemu-devel@archiver.kernel.org; Fri, 20 Mar 2020 13:18:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLH1-0005GJ-FD
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:17:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jFLH0-0004Cl-5k
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:17:31 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:36458)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jFLGz-00048A-LH
 for qemu-devel@nongnu.org; Fri, 20 Mar 2020 13:17:30 -0400
Received: by mail-pj1-x1042.google.com with SMTP id nu11so2772467pjb.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2020 10:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7JTHRMfHywWyYBPVxQdb7LryXqakWzkxz0lvmHeCtKI=;
 b=G3pmr4vZ9KTAwUB5SJ8CZB1f9QYOs7jIKDcSU0Q5mSVe1qxnfpyNwCd63apB+KvxC2
 ZU1a1NZBOkXp6eAEpmHxO0ezDrNF35/Il8q8Q9sL2Ksri7C6mvFM8jqwuvD9XSeM8Rbh
 CxtYtexzf+L0Hb1JaKNkc65HilWJV3W6qmLsfQh8m88G6NHASo7Xbm6hcN6Vgb4c3FUZ
 PyTMPrDA6KtcDmapIRvGjzIsaGSmU21qNeD3Qpj675OqVFbIBUXUPzFkr38tbMIJn+zn
 RZfnTWTZHPbMEZAh/gb/+SZ5hkzUhvSpJGKV/+hL9/7ackDieTyCHBTXOfdSH9pCxtWB
 UxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7JTHRMfHywWyYBPVxQdb7LryXqakWzkxz0lvmHeCtKI=;
 b=KJN/ghKOsoSHktwKzrHLnKPq19bWFyD1NG4r+7rHb9XfTqWcGLKzBKTR+MG9iuz+4x
 5GOGqA7DsGvlxSHH3wSASHM/fkj+Or/bo/LVAlw1vs+JON0b93VGxE+0f+/RJCGolyWd
 spTw5lm/pS4Jbsrwq1H3ZRGzcssh6N8PAMRrzNaPvRvQ1yyRmh3ez2+rDpXNk9/DSY0+
 M0j5pwGWeewFcWOmKXe/K04x7VZYWuCjnomiNlh4IB65NQ2OgFAjlsWrk46XXh4y71NE
 uIa+42fhxPHpKgALA/Qnjqa5OjnKItUJfevQGoLlLmbu5cKsGpwH/+2urKuxRUyINBSO
 bMIw==
X-Gm-Message-State: ANhLgQ2Us1YlgU0gtiyy742xZhDQEVQpkRisWHch70j5Y+/HHaOOSr6M
 tFxKNVCSdqce1Pqif892Ii9hZg==
X-Google-Smtp-Source: ADFU+vu6ZVdLTLgrvl1y4bNK8//cMIxGFd+FEBGb+GrBvmYEOYsbd2bCw9PmQVwKftNPNmw6gPM2tg==
X-Received: by 2002:a17:902:342:: with SMTP id
 60mr9199103pld.206.1584724648106; 
 Fri, 20 Mar 2020 10:17:28 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 e30sm5815790pga.6.2020.03.20.10.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2020 10:17:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] osdep.h: Drop no-longer-needed Coverity workarounds
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200319193323.2038-1-peter.maydell@linaro.org>
 <20200319193323.2038-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <28ff6fac-c3d9-90a5-27f4-6d0d84e09633@linaro.org>
Date: Fri, 20 Mar 2020 10:17:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200319193323.2038-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/19/20 12:33 PM, Peter Maydell wrote:
> In commit a1a98357e3fd in 2018 we added some workarounds for Coverity
> not being able to handle the _Float* types introduced by recent
> glibc.  Newer versions of the Coverity scan tools have support for
> these types, and will fail with errors about duplicate typedefs if we
> have our workaround.  Remove our copy of the typedefs.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

