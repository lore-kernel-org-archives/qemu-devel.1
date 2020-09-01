Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8429AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:29:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515A120866
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kavZ1v2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515A120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDA5c-0006Za-Hb
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDA4x-00069N-2T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:28:19 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:52768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDA4v-0007zE-BH
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:28:18 -0400
Received: by mail-pj1-x1043.google.com with SMTP id o16so967418pjr.2
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5sRDJQakwOxBBlJAU24MNb0jpi5Efs6nvWbnBM+RRt0=;
 b=kavZ1v2X+JluNpm+37gMpYPBoaAl1q5bC2qne0Lq/FCSYnu907pXCuJPt8iCtttBx2
 YgJj0mvEkduZOXwkIs9OJAkMx23Y47Iz25tkgmeGl+DA7531cCMEAPPPN2+qFuSCjMME
 QFhd6zt3hg+KjOVrJmOiTJAY8dIoBwp426ho0CV0D/pH0MVUddy6cqaaeWpRG1KhjPJK
 mnEjJShOiKBQFtlnfY5bk5A6ktLjKXes/i85OQ5J0YKTJY2EPa6VrlhIdpjMsLf8dJQV
 BiXNveDBYNArz/8sY06a20FLLu2d0WLYPu+ULJFZPf4N/y2+ueW/B1f8UDjZkuU/0sgU
 Vqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5sRDJQakwOxBBlJAU24MNb0jpi5Efs6nvWbnBM+RRt0=;
 b=rcUXAly5dK/C3AJga2kCTx6gZJQlGOnnlpA5bEcJWwTXYtKNIyj35TpJHQ5pNPP5mj
 g+Lj5yplycCupxdc7b/OXgVqt3YmV0DQCz4J+2EPWL0Jou9G7dygk0a31+PhCj0eeKsj
 s/C1pPW1fVyHDUDkKOW/c4kOGnM357zfK3T3VuhnLYYQN8vJc0PmWXzAHhZ7rVQL88vL
 w58lGcT64NFCLCsEs3QYxpdIL/pdyM5Sr+MX4zeBa83VN8uLozGdJ8Jf+646QqAfOeWp
 OwYbRU1lTSrDJ3iktKdOHqkhLDRVrZgCDZzd7dXgkvBaNAKt+ULycytgFs/k4XgdRZMs
 +Lwg==
X-Gm-Message-State: AOAM531XE5v95Te2oihiUSpqGXCqlUFvENxcrXgo7vW6NGMo6mZxOaua
 9XgzpfggFpViRgITxLg6Cdg8ig==
X-Google-Smtp-Source: ABdhPJw+3EeRuFCjkI6vsugjbL/bnajbCJYdZHKcx/8+NJFFpmC2ff/01SofR8CTUSgE7Jb6URnMWA==
X-Received: by 2002:a17:90a:e642:: with SMTP id
 ep2mr2521233pjb.36.1598981295699; 
 Tue, 01 Sep 2020 10:28:15 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e18sm2645651pgr.53.2020.09.01.10.28.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:28:14 -0700 (PDT)
Subject: Re: [PATCH v6 01/16] cpu-timers, icount: new modules
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-2-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da3e45f1-13d9-eb32-ad28-2a388c7d322b@linaro.org>
Date: Tue, 1 Sep 2020 10:28:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072201.7133-2-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 12:21 AM, Claudio Fontana wrote:
> refactoring of cpus.c continues with cpu timer state extraction.
> 
> cpu-timers: responsible for the softmmu cpu timers state,
>             including cpu clocks and ticks.
> 
> icount: counts the TCG instructions executed. As such it is specific to
> the TCG accelerator. Therefore, it is built only under CONFIG_TCG.
> 
> One complication is due to qtest, which uses an icount field to warp time
> as part of qtest (qtest_clock_warp).
> 
> In order to solve this problem, provide a separate counter for qtest.
> 
> This requires fixing assumptions scattered in the code that
> qtest_enabled() implies icount_enabled(), checking each specific case.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


