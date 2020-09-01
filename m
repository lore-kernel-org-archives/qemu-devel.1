Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38527C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:43:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A3A206FA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xu9ZVsCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A3A206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDAJw-0000em-3M
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAIE-0007O6-HZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:42:02 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:34577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAIC-0001gO-VL
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:42:02 -0400
Received: by mail-pj1-x1042.google.com with SMTP id n3so934032pjq.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=hCf0yxbAZJ1tMhvMk+HpxYIQ+07s9g0FNk9TbnNwc38=;
 b=Xu9ZVsCjF/I24xAsoA3jkWaA2kjoxmz2ZXylCgt0d5RlFu2FZiEB4InA5tIf64Dcla
 PbWPWunia8XHrmNIN/HxI+RzCHYnYEfEEH6Sl2EcMSyZxNdwYJPyMwtVbDC+rBmKFJZF
 76d+QTOe3fgfjjErO9JHox/qOTjBJCXuixFWVY/eBarNhrK9CBbki3Hf61KTSkeFNvvF
 sL7W3xA8NavekPfiG50pPDqeZTJr+41x1K7G0zxXe46ULBCQgmp0n4OSoFR957YvQRbk
 rllm22yS16+DH/ng5nU+s+jkPnpiVK2QdNxOBH3FumbEfJ32jS1Nk5b5io+5eceyD/1i
 HaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hCf0yxbAZJ1tMhvMk+HpxYIQ+07s9g0FNk9TbnNwc38=;
 b=r6MFcma2kL5S7osJ66H0Qbj2Li3ODFzCokzfIv2oa9CsBEGWwzLAubzEiLwBEOvS4o
 vr14VxKDijFOTTVgvtk0W6RzHIG1tYybpohottxW+Ww4ktc0bFKdmYVbBvS3kccnoE3E
 UzCRe0l+fQCz6lTO6JwG2xNm/zTP/3FcRgGkXt67Ihr2zIYSK8zARfOwy1ymPMRGwGAG
 iyTzp8SguSDBjQM0f5IGYMVrSFZ+3MqKNjetZOq+m+p5sRcorbudQzUidjyN/f0WY0Mw
 1uzYrYfCfQlbp+FERWAiOvONKesAZQRfeSgqGy0hZxYFAue2JF+mWJ7zEjNcc1Hl/M42
 JaRg==
X-Gm-Message-State: AOAM530yquQA1KZHFenVZ27irGhKhC0ccJ5N8UmvCzz49revXOphUmZj
 0nvfitn6Xq1IoMMwQTpHGmLeAQ==
X-Google-Smtp-Source: ABdhPJxDSeDp/EOubOuq6TzxziQVoMPW6kMKDKUwalDOKDh7kGQ7PYARCnFR/BA9drKqS79jLvcn8w==
X-Received: by 2002:a17:90a:8a04:: with SMTP id
 w4mr2602295pjn.72.1598982119325; 
 Tue, 01 Sep 2020 10:41:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id a5sm2880650pgb.23.2020.09.01.10.41.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:41:58 -0700 (PDT)
Subject: Re: [PATCH v6 12/16] cpus: add handle_interrupt to the CpusAccel
 interface
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-13-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9fa9dda0-edf7-8144-b10d-d7016315d81f@linaro.org>
Date: Tue, 1 Sep 2020 10:41:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072201.7133-13-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
> kvm: uses the generic handler
> qtest: uses the generic handler
> whpx: changed to use the generic handler (identical implementation)
> hax: changed to use the generic handler (identical implementation)
> hvf: changed to use the generic handler (identical implementation)
> tcg: adapt tcg-cpus to point to the tcg-specific handler
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/tcg/tcg-all.c    | 26 --------------------------
>  accel/tcg/tcg-cpus.c   | 28 ++++++++++++++++++++++++++++
>  hw/core/cpu.c          | 13 -------------
>  include/hw/core/cpu.h  | 14 --------------
>  include/sysemu/cpus.h  |  2 ++
>  softmmu/cpus.c         | 18 ++++++++++++++++++
>  target/i386/hax-all.c  | 10 ----------
>  target/i386/hvf/hvf.c  |  9 ---------
>  target/i386/whpx-all.c | 10 ----------
>  9 files changed, 48 insertions(+), 82 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



